onlinePlayers = {}
onlinePlayerss = {}

RegisterServerEvent('tg-showid:add-id')
AddEventHandler('tg-showid:add-id', function()
    TriggerClientEvent("tg-showid:client:add-id", source, onlinePlayers)
    TriggerClientEvent("tg-showid:client:add-id", source, onlinePlayerss)
    local Text = ".."
    local Text2 = ".."
    local identifiers = GetPlayerIdentifiers(source)
    local name = GetPlayerName(source)
    for k,v in ipairs(identifiers) do
        if string.match(v, 'steam:') then
            Text = string.sub(v, 7)
            Text2 = name
            break
        end
    end
    onlinePlayers[tostring(source)] = Text
    onlinePlayerss[tostring(source)] = Text2
    TriggerClientEvent("tg-showid:client:add-id", -1, Text, tostring(source))
    TriggerClientEvent("tg-showid:client:add-id2", -1, Text2, tostring(source))
end)

AddEventHandler('playerDropped', function(reason)
    onlinePlayers[tostring(source)] = nil
    onlinePlayerss[tostring(source)] = nil
end)

local perm = {'admin'}

RegisterServerEvent('tg-showid:admincheck')
AddEventHandler('tg-showid:admincheck', function()
	local src = source
    local perms = {}

    for k, v in pairs(perm) do
        if IsPlayerAceAllowed(src, 'showid.'..v) then
            table.insert(perms, {[v] = true})
        else
            table.insert(perms, {[v] = false})
        end
    end

    TriggerClientEvent('tg-showid:loadadmin', src, perms)
end)

