Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbeBUXlP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:41:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751459AbeBUXlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:41:12 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41A2217A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From: James Hogan <jhogan@kernel.org>
To: linux-metag@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
Subject: [PATCH 10/13] gpio: Drop TZ1090 drivers
Date: Wed, 21 Feb 2018 23:38:22 +0000
Message-Id: <20180221233825.10024-11-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180221233825.10024-1-jhogan@kernel.org>
References: <20180221233825.10024-1-jhogan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that arch/metag/ has been removed, along with TZ1090 SoC support,
remove the TZ1090 GPIO drivers. They are of no value without the
architecture and SoC platform code.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Cc: linux-metag@vger.kernel.org
---
 .../devicetree/bindings/gpio/gpio-tz1090-pdc.txt   |  45 --
 .../devicetree/bindings/gpio/gpio-tz1090.txt       |  88 ---
 drivers/gpio/Kconfig                               |  15 -
 drivers/gpio/Makefile                              |   2 -
 drivers/gpio/gpio-tz1090-pdc.c                     | 231 --------
 drivers/gpio/gpio-tz1090.c                         | 602 ---------------------
 6 files changed, 983 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-tz1090-pdc.txt
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-tz1090.txt
 delete mode 100644 drivers/gpio/gpio-tz1090-pdc.c
 delete mode 100644 drivers/gpio/gpio-tz1090.c

diff --git a/Documentation/devicetree/bindings/gpio/gpio-tz1090-pdc.txt b/Documentation/devicetree/bindings/gpio/gpio-tz1090-pdc.txt
deleted file mode 100644
index 528f5ef5a893..000000000000
diff --git a/Documentation/devicetree/bindings/gpio/gpio-tz1090.txt b/Documentation/devicetree/bindings/gpio/gpio-tz1090.txt
deleted file mode 100644
index b05a90e0ab29..000000000000
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 8dbb2280538d..8fda844de07e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -462,21 +462,6 @@ config GPIO_THUNDERX
 	  Say yes here to support the on-chip GPIO lines on the ThunderX
 	  and OCTEON-TX families of SoCs.
 
-config GPIO_TZ1090
-	bool "Toumaz Xenif TZ1090 GPIO support"
-	depends on SOC_TZ1090
-	select GENERIC_IRQ_CHIP
-	default y
-	help
-	  Say yes here to support Toumaz Xenif TZ1090 GPIOs.
-
-config GPIO_TZ1090_PDC
-	bool "Toumaz Xenif TZ1090 PDC GPIO support"
-	depends on SOC_TZ1090
-	default y
-	help
-	  Say yes here to support Toumaz Xenif TZ1090 PDC GPIOs.
-
 config GPIO_UNIPHIER
 	tristate "UniPhier GPIO support"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index cccb0d40846c..329e34d1bd2e 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -131,8 +131,6 @@ obj-$(CONFIG_GPIO_TS4900)	+= gpio-ts4900.o
 obj-$(CONFIG_GPIO_TS5500)	+= gpio-ts5500.o
 obj-$(CONFIG_GPIO_TWL4030)	+= gpio-twl4030.o
 obj-$(CONFIG_GPIO_TWL6040)	+= gpio-twl6040.o
-obj-$(CONFIG_GPIO_TZ1090)	+= gpio-tz1090.o
-obj-$(CONFIG_GPIO_TZ1090_PDC)	+= gpio-tz1090-pdc.o
 obj-$(CONFIG_GPIO_UCB1400)	+= gpio-ucb1400.o
 obj-$(CONFIG_GPIO_UNIPHIER)	+= gpio-uniphier.o
 obj-$(CONFIG_GPIO_VF610)	+= gpio-vf610.o
diff --git a/drivers/gpio/gpio-tz1090-pdc.c b/drivers/gpio/gpio-tz1090-pdc.c
deleted file mode 100644
index 5b7781741ee9..000000000000
diff --git a/drivers/gpio/gpio-tz1090.c b/drivers/gpio/gpio-tz1090.c
deleted file mode 100644
index 0bb9bb583889..000000000000
-- 
2.13.6
