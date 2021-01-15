function InitializeAddon(self)
    self:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT")
	
    if(GratwurstMessage == nil)then
		GratwurstMessage="eat my shorts";
	end

	if(GuildIsEnabled == nil)then
		GuildIsEnabled = true;
	end

	if(GratwurstDelayInSeconds == nil)then
		GratwurstDelayInSeconds = 3;
	end

	SetConfigurationWindow();
end

function SetConfigurationWindow()
	local luaFrame = CreateFrame("Frame", "GratwurstPanel", InterfaceOptionsFramePanelContainer)
	
	local titleBorder = luaFrame:CreateTexture("UnneccessaryGlobalFrameNameTitleBorder")
	titleBorder:SetWidth(320)
	titleBorder:SetHeight(50)
	titleBorder:SetPoint("TOP", luaFrame, "TOP", 0, 5)
	titleBorder:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
	titleBorder:SetTexCoord(.2, .8, 0, .6)
	
	local titleString = luaFrame:CreateFontString("UnneccessaryGlobalFrameNameTitleString")
	titleString:SetFont("Fonts\\FRIZQT__.TTF", 15)
	titleString:SetWidth(320)
	titleString:SetPoint("TOP", luaFrame, "TOP", 0, -13)
	titleString:SetTextColor(1, 0.8196079, 0)
	titleString:SetShadowOffset(1, -1)
	titleString:SetShadowColor(0, 0, 0)
	titleString:SetText("Gratwurst Configuration")

	Gratwurst = {};
	Gratwurst.ui = {};
	Gratwurst.ui.panel = luaFrame
	Gratwurst.ui.panel.name = "Gratwurst";

	-- GratwurstDelayInSeconds
	local delayEditBox = CreateFrame("EditBox", "Input_GratwurstDelayInSeconds", Gratwurst.ui.panel, "InputBoxTemplate")
	delayEditBox:SetSize(25,30)
	delayEditBox:SetMultiLine(false)
    delayEditBox:ClearAllPoints()
	delayEditBox:SetPoint("TOPLEFT", 25, -100)
	delayEditBox:SetCursorPosition(0);
	delayEditBox:ClearFocus();
    delayEditBox:SetAutoFocus(false)
	delayEditBox:SetScript("OnShow", function(self,event,arg1)
		self:SetNumber(GratwurstDelayInSeconds)
		self:SetCursorPosition(0);
		self:ClearFocus();
	end)
	delayEditBox:SetScript("OnTextChanged", function(self,value)
		GratwurstDelayInSeconds = self:GetNumber()
	end)
	
	local delayEditBoxLabel = delayEditBox:CreateFontString("delayEditBoxLabel")
	delayEditBoxLabel:SetFont("Fonts\\FRIZQT__.TTF", 12)
	delayEditBoxLabel:SetWidth(120)
	delayEditBoxLabel:SetHeight(20)
	delayEditBoxLabel:SetPoint("TOPLEFT", -10, 15)
	delayEditBoxLabel:SetTextColor(1, 0.8196079, 0)
	delayEditBoxLabel:SetShadowOffset(1, -1)
	delayEditBoxLabel:SetShadowColor(0, 0, 0)
	delayEditBoxLabel:SetText("Delay in seconds")


	local backdropFrame = CreateFrame("Frame", nil, Gratwurst.ui.panel, BackdropTemplateMixin and "BackdropTemplate")
	backdropFrame:SetPoint("TOPLEFT", 20,-150)
	backdropFrame:SetSize(335, 215)
	backdropFrame:SetBackdrop( {
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\FriendsFrame\\UI-Toast-Border",
        tile = true,
        tileSize = 12,
        edgeSize = 8,
        insets = { left = 5, right = 3, top = 3, bottom = 3	},
	})


	local scrollFrame = CreateFrame("ScrollFrame", nil, backdropFrame, "UIPanelScrollFrameTemplate")
	scrollFrame:SetAlpha(0.8)
	scrollFrame:SetSize(300,200)
	scrollFrame:SetPoint("TOPLEFT", 7, -7)
	
	local editBox = CreateFrame("EditBox", "Input_GratwurstMessage", scrollFrame)
	editBox:SetMultiLine(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontNormal)
	editBox:SetScript("OnShow", function(self,event,arg1)
		self:SetText(GratwurstMessage)
	end)
	editBox:SetScript("OnTextChanged", function(self,value)
		GratwurstMessage = self:GetText()
	end)
	editBox:SetWidth(300)
	scrollFrame:SetScrollChild(editBox)

	local editBoxLabel = backdropFrame:CreateFontString("editBoxLabel")
	editBoxLabel:SetFont("Fonts\\FRIZQT__.TTF", 12)
	editBoxLabel:SetWidth(120)
	editBoxLabel:SetHeight(20)
	editBoxLabel:SetPoint("TOPLEFT", -17 ,20)
	editBoxLabel:SetTextColor(1, 0.8196079, 0)
	editBoxLabel:SetShadowOffset(1, -1)
	editBoxLabel:SetShadowColor(0, 0, 0)
	editBoxLabel:SetText("Message list")

	InterfaceOptions_AddCategory(Gratwurst.ui.panel);	
end

function OnEventRecieved(event, arg1, arg2, ...)
	if(event == "CHAT_MSG_GUILD_ACHIEVEMENT")then Log("CHAT_MSG_GUILD_ACHIEVEMENT on event");
	end	
	if(arg1 == "CHAT_MSG_GUILD_ACHIEVEMENT")then Log("CHAT_MSG_GUILD_ACHIEVEMENT on arg1");
	end	
	-- if(arg1 == "CHAT_MSG_GUILD_ACHIEVEMENT")then GuildAchievementMessageEventRecieved();
	-- end	
end

function GuildAchievementMessageEventRecieved()
	gratsStop=true
    C_Timer.After(GratwurstDelayInSeconds,function()
        if gratsStop then
			gratsStop=false
			GetRandomMessageFromList()
			-- SendChatMessage(GratwurstMessage,"GUILD")
			Log(GratwurstMessage)
        end
    end)
end

function GetRandomMessageFromList()
	-- TODO: do randomize logic here
	GratwurstMessage = "tacos1111"
end

function ToggleGuildAchievementsEnabled()
	if(GuildIsEnabled) then GuildIsEnabled = false;
	else GuildIsEnabled = true;
	end;
	Log("Toggle clicked.")
	Gratwurst.ui.guildCheckButton:SetChecked(GuildIsEnabled);
end

function Log(message)
	if(message == nil)then message = "nil";
	end
	DEFAULT_CHAT_FRAME:AddMessage(message)
end