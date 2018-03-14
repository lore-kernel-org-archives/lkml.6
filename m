Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbeCNPq1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:46:27 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:52525 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbeCNPqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:46:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
Subject: [PATCH 25/47] pinctrl: remove adi2/blackfin drivers
Date: Wed, 14 Mar 2018 16:35:38 +0100
Message-Id: <20180314153603.3127932-26-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:y3YqCUftxwTtpYimMMcLPB+eATozDnkcMf5Qo3C+CUwutGgk1D9
 woiqgtOartB6XDYXejfmcWPnINs0qDRdcuwratSwG/s7stMubcRHM3OxzS7AKEZWmVTyDAT
 im73zMqJWXUScmZSfDVYPai9HJbC2mv7R0RvtI8GUQlETBsTXSrPQ4pBVH6xA1zN9mAOXTn
 0pWe91KAD9OyAAGl69ePQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wZGfhBuOWm8=:lBcSkCgcY5jdMJ2vA5QuNq
 pWsvr4FH8Cbz0MrcMqzOdes6nWRxBzhpfaW4bDwe3KzkzAlKmNvrCCsKn5IA1TUE4NTaJjC5h
 MiflchFHKyXzwe8oHGtH1fCG0zEvi5HehkHxPuMS8Q99soq9qWJAxEjRRme4C8n2Z2l1VYbUS
 HDaAnu+DFcVoXt4dil6uS5jP5WQif3h/+jgUs9+LD3KbclTrpG/lrVljdoX5lyEKfVDjWwek5
 pkKAPTUj9YqK7JlfnauMNjEx8afg30qf+glb8V9gWdyHTuMEGAp+8ipEQGV5fkBvsPUuXvxdU
 5y61c++vDmESzxgWtW1qeXi11bsP+qdgcDOLKRyby3EFJDD0kQNdUTTFKfNn+PBcFhpvr9ncx
 ASyOBf8vwd2ZwCg9yRgenvKPzZfMvCdQjBewVF8d5IzqC+1Oe6I4EouHkAlCsJEfeF6ZhRe4E
 x935jRVmyrPunYqhz5MaPizv7hsZGDG5rRXCUQwwmEIrN+jJ1gAh8g3P9TRUmUDTSIC21MffV
 vkDqBxVifxX/m2PpAdUNdVMF3ucfk1XHBJ7z5xtwjXVI0qE9+484UXiV1V53TeLnBWdV7+Qyn
 7HE2B/EWVJ0fpU8C1UhUxwsI3HHO4YCE64gqOblQrmeoDFFzlwfLi8ilIxLI7YEic0eKDcb9I
 9V1F+3kHx4NQH5GWvwZDfqfji1jxaYyxMZ/wE3CjKn5QcWlmWrCXBkyX0bUGZE8njZy6ySJBg
 BCQedemLS2dg5KIc0EfJsynKIdDu0TzUU0bmYw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blackfin architecture is getting removed, so these are
now obsolete.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/Kconfig                    |   19 -
 drivers/pinctrl/Makefile                   |    3 -
 drivers/pinctrl/pinctrl-adi2-bf54x.c       |  588 ---------------
 drivers/pinctrl/pinctrl-adi2-bf60x.c       |  517 -------------
 drivers/pinctrl/pinctrl-adi2.c             | 1114 ----------------------------
 drivers/pinctrl/pinctrl-adi2.h             |   75 --
 include/linux/platform_data/pinctrl-adi2.h |   40 -
 7 files changed, 2356 deletions(-)
 delete mode 100644 drivers/pinctrl/pinctrl-adi2-bf54x.c
 delete mode 100644 drivers/pinctrl/pinctrl-adi2-bf60x.c
 delete mode 100644 drivers/pinctrl/pinctrl-adi2.c
 delete mode 100644 drivers/pinctrl/pinctrl-adi2.h
 delete mode 100644 include/linux/platform_data/pinctrl-adi2.h

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index f5ef8201c09f..01fe8e0455a0 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -30,17 +30,6 @@ config DEBUG_PINCTRL
 	help
 	  Say Y here to add some extra checks and diagnostics to PINCTRL calls.
 
-config PINCTRL_ADI2
-	bool "ADI pin controller driver"
-	depends on (BF54x || BF60x)
-	depends on !GPIO_ADI
-	select PINMUX
-	select IRQ_DOMAIN
-	help
-	  This is the pin controller and gpio driver for ADI BF54x, BF60x and
-	  future processors. This option is selected automatically when specific
-	  machine and arch are selected to build.
-
 config PINCTRL_ARTPEC6
         bool "Axis ARTPEC-6 pin controller driver"
         depends on MACH_ARTPEC6
@@ -77,14 +66,6 @@ config PINCTRL_AXP209
 	  selected.
 	  Say yes to enable pinctrl and GPIO support for the AXP209 PMIC
 
-config PINCTRL_BF54x
-	def_bool y if BF54x
-	select PINCTRL_ADI2
-
-config PINCTRL_BF60x
-	def_bool y if BF60x
-	select PINCTRL_ADI2
-
 config PINCTRL_AT91
 	bool "AT91 pinctrl driver"
 	depends on OF
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 6255546735ff..657332b121fb 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -8,12 +8,9 @@ obj-$(CONFIG_PINMUX)		+= pinmux.o
 obj-$(CONFIG_PINCONF)		+= pinconf.o
 obj-$(CONFIG_OF)		+= devicetree.o
 obj-$(CONFIG_GENERIC_PINCONF)	+= pinconf-generic.o
-obj-$(CONFIG_PINCTRL_ADI2)	+= pinctrl-adi2.o
 obj-$(CONFIG_PINCTRL_ARTPEC6)	+= pinctrl-artpec6.o
 obj-$(CONFIG_PINCTRL_AS3722)	+= pinctrl-as3722.o
 obj-$(CONFIG_PINCTRL_AXP209)	+= pinctrl-axp209.o
-obj-$(CONFIG_PINCTRL_BF54x)	+= pinctrl-adi2-bf54x.o
-obj-$(CONFIG_PINCTRL_BF60x)	+= pinctrl-adi2-bf60x.o
 obj-$(CONFIG_PINCTRL_AT91)	+= pinctrl-at91.o
 obj-$(CONFIG_PINCTRL_AT91PIO4)	+= pinctrl-at91-pio4.o
 obj-$(CONFIG_PINCTRL_AMD)	+= pinctrl-amd.o
diff --git a/drivers/pinctrl/pinctrl-adi2-bf54x.c b/drivers/pinctrl/pinctrl-adi2-bf54x.c
deleted file mode 100644
index 008a29e92e56..000000000000
diff --git a/drivers/pinctrl/pinctrl-adi2-bf60x.c b/drivers/pinctrl/pinctrl-adi2-bf60x.c
deleted file mode 100644
index fcfa00821f12..000000000000
diff --git a/drivers/pinctrl/pinctrl-adi2.c b/drivers/pinctrl/pinctrl-adi2.c
deleted file mode 100644
index 094a451db2a2..000000000000
diff --git a/drivers/pinctrl/pinctrl-adi2.h b/drivers/pinctrl/pinctrl-adi2.h
deleted file mode 100644
index 3ca29738213f..000000000000
diff --git a/include/linux/platform_data/pinctrl-adi2.h b/include/linux/platform_data/pinctrl-adi2.h
deleted file mode 100644
index 8f91300617ec..000000000000
-- 
2.9.0
