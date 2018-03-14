Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbeCNPrH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:47:07 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:42263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbeCNPrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:47:04 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 27/47] input: keyboard: remove bf54x driver
Date: Wed, 14 Mar 2018 16:35:40 +0100
Message-Id: <20180314153603.3127932-28-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:8rlRpqSJqQZlIJ2rG5vidrpGK/YmlGWSE6WJqaRLUPdVX9mnSrv
 2qA2b29sMJB1jtcVcskwtByIuYqzT4fxkPrEH50hCbt+h/fpgi0pEjF9TSl+Zk8cbZ1Ca0j
 pJyp+6uNPR98wusqKDQTK3pnYmmT2Xom9z9ZogJYqnPzo/KjaLFDHRR7+StQriDjL+tAfz5
 BDMERNDtDdL5YhHcAkYTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nIrRd8ww+A4=:3fCk/p2j2yjlptttQteyG8
 kcCU7pD1A0UDyvVxd/pmPCuVVgRDacLcHTO4Ps4Ekbt6wEWbytPh29NlTpkkZENNZ0LNX1Tcc
 fHMSd/6Oyb7M/f74CBvKHJsdMZoPaEEWkGvwRAlBu51dU5INhTkMDpvM/cSO532SUvEbA74SI
 4OvV3d71D0sXFqoIUKxZO1MYPcmADs0Z4SY+gWuNdhfz0KigmVNU/Okpk+JZkcC/GgsCv3bQq
 NPnvGzEWkuIAJvdWMk7elxAhdJcPm6QC+KJEMfW1kXNH9awY8RqvFOdXEAO51BVPeMXHCUOjV
 UexUSLILS+tBe/URk7PCNqhL8PBYGxrbwiwZrPt7EjppYaDgx8hoxn3grmNJxCnkiFTj3DzIR
 9+oHYTgrmJYCjCw9iQZvIa6k+7QxoAJHU7VLD9k4ZasKquhDZAnKAYMDDztw2+uXa01IIKaPC
 theRiH5z9O/h97YqAgnBIVo2aV1/AJZjeeBmouHGoW6kTevcahTQVcsUTw6BVNSzJs0uXYams
 4g4bHyBpZ33s+8mrd/4M/BrtZgN/79+DbtW5boT5lN5yOfRHbp6KPhp6DqO0tmi+eJMs35Jd6
 KIpthl6m8lgJbtHj/CqYb04IYlYNL70+az7FuNDksCHY56d4LD6uYcRqKomZmyoROaxy47OJ5
 w4HwL+S1HHqK/KyXA8wb+++QIdhkirjzj1tRGfzm68N7ODECfqSKaQ1BUIWpXDg0sN4g4OuyM
 wRkRaOjPKPcT0nzsa8v/H9sS0RZr3zLH3R/w8A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blackfin architecture is getting removed, so this
driver is now obsolete.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/keyboard/Kconfig      |   9 -
 drivers/input/keyboard/Makefile     |   1 -
 drivers/input/keyboard/bf54x-keys.c | 396 ------------------------------------
 3 files changed, 406 deletions(-)
 delete mode 100644 drivers/input/keyboard/bf54x-keys.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 4c4ab1ced235..2b469cc47a78 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -157,15 +157,6 @@ config KEYBOARD_QT2160
 	  This driver can also be built as a module. If so, the module
 	  will be called qt2160.
 
-config KEYBOARD_BFIN
-	tristate "Blackfin BF54x keypad support"
-	depends on (BF54x && !BF544)
-	help
-	  Say Y here if you want to use the BF54x keypad.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called bf54x-keys.
-
 config KEYBOARD_CLPS711X
 	tristate "CLPS711X Keypad support"
 	depends on OF_GPIO && (ARCH_CLPS711X || COMPILE_TEST)
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 526e68294e6e..8fab920afa58 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -13,7 +13,6 @@ obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
 obj-$(CONFIG_KEYBOARD_ATARI)		+= atakbd.o
 obj-$(CONFIG_KEYBOARD_ATKBD)		+= atkbd.o
 obj-$(CONFIG_KEYBOARD_BCM)		+= bcm-keypad.o
-obj-$(CONFIG_KEYBOARD_BFIN)		+= bf54x-keys.o
 obj-$(CONFIG_KEYBOARD_CAP11XX)		+= cap11xx.o
 obj-$(CONFIG_KEYBOARD_CLPS711X)		+= clps711x-keypad.o
 obj-$(CONFIG_KEYBOARD_CROS_EC)		+= cros_ec_keyb.o
diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
deleted file mode 100644
index 8a07a426f88e..000000000000
-- 
2.9.0
