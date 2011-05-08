[Setup]
AppName=SproutCore
AppVersion=1.5
DefaultDirName={pf}\SproutCore
DefaultGroupName=SproutCore
Compression=lzma2
SolidCompression=yes 
; For Ruby and Gem download and expansion ~ 84MB
ExtraDiskSpaceRequired=88080384      
     
[Files]
Source: "rubyinstaller-1.9.2-p180.exe"; DestDir: "{tmp}"; DestName: "rubyinstaller.exe"    
Source: "sproutcore-1.6.0.beta-x86-mingw32.gem"; DestDir: "{tmp}"; DestName: "sproutcore.gem"                                                                
Source: "GemInstall.bat"; DestDir: "{tmp}"
Source: "SCCommand.bat"; DestDir: "{app}" 

[UninstallDelete]
Type: filesandordirs; Name: "{app}\ruby"
                              
[Icons]
Name: "{group}\SproutCore Prompt"; Filename: "{app}\SCCommand.bat"      
Name: "{group}\Uninstall SproutCore"; Filename: "{uninstallexe}"
Name: "{commondesktop}\SproutCore Prompt"; Filename: "{app}\SCCommand.bat"

[Registry]
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; ValueType: "string"; \
  ValueName: "SC_RUBY"; ValueData: "{app}\ruby"

[Run]
Filename: "{tmp}\rubyinstaller.exe"; Parameters: "/silent /nocancel /noicons /dir=""{app}/ruby"""; \
  Flags: shellexec waituntilterminated; StatusMsg: "Installing Ruby and Dependencies"; AfterInstall: InstallSCLibs

[Code]
var
  ResultCode: Integer;

procedure InstallSCLibs();
begin              
  ShellExec('', ExpandConstant('{tmp}\GemInstall'), '', ExpandConstant('{tmp}'), SW_SHOW,
     ewWaitUntilTerminated, ResultCode)

  if not (ResultCode = 0) then
  begin
    MsgBox('Unable to install SproutCore libraries. Rolling back.', mbCriticalError, MB_OK)
    ShellExec('', ExpandConstant('{uninstallexe}'), ExpandConstant('/silent /nocancel'), '', SW_SHOW,
     ewWaitUntilTerminated, ResultCode)
  end;
end;
