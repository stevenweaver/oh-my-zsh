# Designed in San Diego, California 
# Inspired by dieter

typeset -A host_repr

# translate hostnames into shortened, colorcoded strings
host_repr=('tourmaline' "%{$fg_bold[green]%}ws" 'tourmaline' "%{$fg_bold[blue]%}p4")

# local time, color coded by last return code
time_enabled="%(?.%{$fg[yellow]%}.%{$fg[red]%})%*%{$reset_color%}"
time_disabled="%{$fg[green]%}%*%{$reset_color%}"
time=$time_enabled

# user part, color coded by privileges
local user="%(!.%{$fg[cyan]%}.%{$fg[cyan]%})%n%{$reset_color%}"

# Hostname part.  compressed and colorcoded per host_repr array
# if not found, regular hostname in default color
local host="@${host_repr[$HOST]:-$HOST}%{$reset_color%}"

# Compacted $PWD
local pwd="%{$fg[cyan]%}%c%{$reset_color%}"

PROMPT='${time} ${user}${host} ${pwd} $(git_prompt_info)'

DISABLE_UNTRACKED_FILES_DIRTY=true;
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%} %{$fg[yellow]%}?%{$fg[green]%}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

# elaborate exitcode on the right when >0
return_code_enabled="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
return_code_disabled=
return_code=$return_code_enabled

RPS1='${return_code}'

function accept-line-or-clear-warning () {
	if [[ -z $BUFFER ]]; then
		time=$time_disabled
		return_code=$return_code_disabled
	else
		time=$time_enabled
		return_code=$return_code_enabled
	fi
	zle accept-line
}
zle -N accept-line-or-clear-warning
bindkey '^M' accept-line-or-clear-warning

zstyle ':completion:*' insert-tab false

