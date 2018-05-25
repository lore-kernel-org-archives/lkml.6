Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965734AbeEYPb3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:31:29 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49471 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964823AbeEYPb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:31:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jiri Kosina <jikos@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: steam: select CONFIG_POWER_SUPPLY
Date: Fri, 25 May 2018 17:30:51 +0200
Message-Id: <20180525153118.3015806-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:LuPAzcPwrredZ4GCgi082/Fq4VdHlzMcLBnxlvCmFk1K2UasNm9
 etN+R0BIQqgbMWDWNjKgB/KYuT5A4xic93sWJ3k3TzQiRLFfMM1gjFoPetRnoijxk2BQXz3
 v9QwEeD6HiqFwZu6NrpAn5xwNMtwSzHrSEQ1VcUgqCA1hMviZt7gJJnw394CTzdZ8qf4SVX
 vtuOpYZ2SrgRN06aBAMYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vAW/VVBd6Q4=:VugT0aKXS5NrlJX+ZoT/Uj
 239IHjFUFU1yeRb1QIn8Hag/t/K9LUWzaewnfKHT6YBeT+hzTC8zO0hCQfkXieyiFB4Z2u32f
 PWR7Bdxo7vdQOjltQL3yMx2Cfjrx9Lnns/jhoLJZMXX/mZhqKsQldpzcEwCrtSlrPddL6n69Q
 EeOgNMMn8dcVWjUAbpopM/+K3jdEJnD3ucwx0vsBEq9/Z5szgNysoA/b/7giB/ZLzGmqzdL9x
 iYoDgP1sG/XlNtWxkfaSmWcK9wIlVWPVQlcFng1ZTqe8f5bumz40RRhj33aKfFUVqiLAhxImD
 XT+1gt7j61KuWOdxRP6PVIAH7OPRY4n4cQplDK3u8y6QCj7hSpJ2rBJEscZDAVQLodh5Pqvg4
 Zi/rpMVFn+SybPTRH1B743JWauGArUpdMnrHCDQM7wN1wo7w+YJUkENRQCeKFqcV2eItffrYU
 QVOEUaNn89q09hq70GdFAOD0bF8ijvFzAjfspa1ThmX6kHQJN+Dv3N9HYi2tm3FECfFJcEUxi
 Yq8VJDpWrv/vOT1cl9kEIJFT2qSkFGaEbSfvXG95AC6ytUmtP2vmePIw1oAtCvvpm+W4fWA/+
 RQod4f32P+I3Wu8sxovOHE5jvrgAydoIVaMqjCKgXtpsYlw8FjueA6zdOiJ20nVAXqTA61HMp
 xsButtKr5WpmKG0Uvns+vdFRh3GW7g9zmXqeiah2B9S34HPLzykpbWfRuURJ8q0f02A4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the power supply APIs requires selecting the appropriate
Kconfig symbol, otherwise we get this build failure:

drivers/hid/hid-steam.o: In function `steam_unregister':
hid-steam.c:(.text+0x1cc): undefined reference to `power_supply_unregister'
drivers/hid/hid-steam.o: In function `steam_battery_get_property':
hid-steam.c:(.text+0x2d2): undefined reference to `power_supply_get_drvdata'
drivers/hid/hid-steam.o: In function `steam_raw_event':
hid-steam.c:(.text+0xcba): undefined reference to `power_supply_changed'
drivers/hid/hid-steam.o: In function `steam_register':
hid-steam.c:(.text+0x13e3): undefined reference to `power_supply_register'
hid-steam.c:(.text+0x13fe): undefined reference to `power_supply_powers'

Fixes: f82719790751 ("HID: steam: add battery device.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hid/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 8a865e3ccea6..a49a10437c40 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -848,6 +848,7 @@ config HID_SPEEDLINK
 config HID_STEAM
 	tristate "Steam Controller support"
 	depends on HID
+	select POWER_SUPPLY
 	---help---
 	Say Y here if you have a Steam Controller if you want to use it
 	without running the Steam Client. It supports both the wired and
-- 
2.9.0
