if application "iTerm" is frontmost then
    tell application "iTerm" -- to do script "open -a Finder ./" in first window
        tell the first terminal
            tell the last session
                -- write some text
                write text "open -a Finder ./"
                return
            end tell
        end tell
    end tell
end if

if application "Finder" is frontmost then
    if (count of windows of application "Finder") is 0 then
        return "Finder has no open windows"
    end if
    
    tell application "Finder"
        try
            set pathList to (quoted form of POSIX path of (folder of the front window as alias))
        on error
            return "The frontmost Finder window is not a valid directory"
        end try
    end tell
    
    if application "iTerm" is not running then
        tell application "iTerm" to activate
    end if
    
    tell application "iTerm"
        activate -- Bring Terminal to front
        tell the first terminal
            launch session "Default Session"
            tell the last session
                -- write some text
                write text "cd  " & pathList
                return
            end tell
        end tell
        return --Prevent "do" command from returning a value
    end tell
end if