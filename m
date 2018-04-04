Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AIpwx4+ai3MbXXNLDrhmQw6fGcNpdoVk/0cnd45n28qwGU06AIw3ndKFE+dNq9LA0QXV/c3CVAdN
ARC-Seal: i=1; a=rsa-sha256; t=1522838353; cv=none;
        d=google.com; s=arc-20160816;
        b=xfgfIB7llvvM2UHCY4WgR7CNSxG1C735ITINLdnIgw7O3QSagZsJ4gpo9EVyjsfuPM
         zjgoNzMn4HbjExp2+abekYSz3Z7TpSm1WEMnPVJhIaAb0iTJtowuIALxsibWm8/PuNxQ
         AYMyneqpBYxBqY2Q7a+4+LA1lziE4bouolmXwVLTSBiOTpjuCgcBrMZesJkg9z45RPBl
         o0jmweSCkydfz5IUtAv82z7qkVQ6NL9ry/ZJwBq4fgvo43moVHzM9Zy6E1QTtIe/4d4g
         ABJ55EU+BNm8UAycjHZboXPtAiAnKjk0K6zng6JdWzNmgzaTuLuCH3KUGqa5Jh/gapr1
         lRHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=8NevFyUFWyIqtCbnevquWjFBGiCg5o9I8MIh1XeiI9w=;
        b=LHRRosgHAtEKcmLjdYkl9OKLfqnFL2CwrqOOcWiB4VuSiB5n9nt6sgclrl2Q8jEdGY
         hto7whCPTtjgT+OKfxU7W/kVTrpNDS3fxTCrllZhaQx8JAD7xqeEKCLOHvB0QJaj/xBY
         ai3b9KhHVyBglUVAvNjg534aPJOHVJoO0mg9QtZv/VkFGueG/g3QNcxGveduHUVCkrQR
         fSIodiHoJVSq1Qre0vEh/aR5fy95RLJUnJi3zyGmkVYfANvsC9P/msKw69qsZdtPEosa
         Q0XWM48hZ2BkFj7J1MY991fDA+f5O24diUkuWH5iMmsX9SsLy1anKOzCva3wFkonDLgI
         SeMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 217.72.192.73 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 217.72.192.73 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [net] nvmem: disallow modular CONFIG_NVMEM
Date: Wed,  4 Apr 2018 12:38:40 +0200
Message-Id: <20180404103900.4090118-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:DCKwEpTRpFjb0G38RPIan3YlqFf/VpzSCyAdeoB6BZg6M1Xgmw4
 uFslSiGhwjBIlVn6mGPZg/nZuUUTMLHpLXuyXe3BOCaaPVxm8yQNqeXpDH8/JQbvCy5YJZj
 Z17NgJBceR4K5YjwuRL7/BOu1wAW89oPnJpvioK2AZAEz3rORy3iSdGRRChHOrNR9j53hws
 VdaheQLAfuqfqDpUhijCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nVqrTKZqhR4=:W0XKG7aiWFVmIDdTDPi3q7
 UVTz5dK7Ois1j0o28EQEIB24B8Xque1xXNqyx9iV5pMXGV1J9sh4tG/HlpCaYT0cyCFENLgAC
 LOcjR2Wq60vUUdU1kacgB4HN7B688LEq4gIUWyyOH0NCA6JR9DP6jlb/SW94TC4y5W/DfCCaZ
 DqpTLFsHCcKinLOtlmC5KHWD80ZLsr8k8EhTSV2k3dWNSKFK3t/WhchVvUh9vtVN/3y8osZFN
 hU7dWzK9D9EDv41nCWNON4p8nwDGRCL/vtcsUAiCdQjmr3RTgpTRbgGSU+O5rPG5ptgjVLtGl
 Bh75LUDGYd8ArIFo0K7L73a08AbdCgUWe6PBzSk4oMigQslwWBCrjOyoOJjQLRJ8w3n8aA8mf
 FSCawmzoULceBhBqUGmnvfSNhPi7t1yOlF1uRJk1xmaX5j0vxdzjDgQqvPppXbYMWpR1iti4F
 CkEc1f9fN6epW6EkdZ6JXRauz7ERrz1jTE0LPa7IcjFbWM/imd4JAxv+WbWd4IAKrkl71SkrZ
 F0QXhKdlJyOswQboqKMBNsGb1NgAZsyikjXT5NMjN1cRT/dQCaWqofShyswetIOC5blmdXIL9
 1w6j8LjfAqXLGXMo0evhCyqiZ8eX8xvbBcaQBdjVxGDFrxxcHVq2b8GLI6w64xbb6b3Xp/qMf
 UsqzTZF/UKL7Ro1GyuyQ8tzts2ILtO9Gqkr5l3cVgLn+gDRTTD047wssn/9i6pKiYGeeNbC//
 1EqHGk+k247us0s886WsitBNLcxCQe+8FMH3Sw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596811748893246991?=
X-GMAIL-MSGID: =?utf-8?q?1596811748893246991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The new of_get_nvmem_mac_address() helper function causes a link error
with CONFIG_NVMEM=m:

drivers/of/of_net.o: In function `of_get_nvmem_mac_address':
of_net.c:(.text+0x168): undefined reference to `of_nvmem_cell_get'
of_net.c:(.text+0x19c): undefined reference to `nvmem_cell_read'
of_net.c:(.text+0x1a8): undefined reference to `nvmem_cell_put'

I could not come up with a good solution for this, as the code is always
built-in. Using an #if IS_REACHABLE() check around it would solve the
link time issue but then stop it from working in that configuration.
Making of_nvmem_cell_get() an inline function could also solve that, but
seems a bit ugly since it's somewhat larger than most inline functions,
and it would just bring that problem into the callers.  Splitting the
function into a separate file might be an alternative.

This uses the big hammer by making CONFIG_NVMEM itself a 'bool' symbol,
which avoids the problem entirely but makes the vmlinux larger for anyone
that might use NVMEM support but doesn't need it built-in otherwise.

Fixes: 9217e566bdee ("of_net: Implement of_get_nvmem_mac_address helper")
Cc: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The problem arrived through the networking tree, but it's now in
mainline, so the fix could go through either tree
---
 drivers/nvmem/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 5f9bc787d634..1090924efdb1 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -1,5 +1,5 @@
 menuconfig NVMEM
-	tristate "NVMEM Support"
+	bool "NVMEM Support"
 	help
 	  Support for NVMEM(Non Volatile Memory) devices like EEPROM, EFUSES...
 
-- 
2.9.0
