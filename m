Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ADEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961D720874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388190AbfAKOX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:23:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34979 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388132AbfAKOX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:23:27 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiP-00054Q-7G; Fri, 11 Jan 2019 15:23:17 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC4)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiO-0002x4-8O; Fri, 11 Jan 2019 15:23:16 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     John Crispin <john@phrozen.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: [PATCH v1 08/11] MIPS: ath79: drop machfiles
Date:   Fri, 11 Jan 2019 15:22:37 +0100
Message-Id: <20190111142240.10908-9-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111142240.10908-1-o.rempel@pengutronix.de>
References: <20190111142240.10908-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=a
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

With the target now being fully OF based, we can drop the legacy mach
files. Boards can now boot fully of devicetree files.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/Kconfig              |   1 -
 arch/mips/ath79/Kconfig        |  73 ---------------
 arch/mips/ath79/Makefile       |  10 ---
 arch/mips/ath79/clock.c        |   1 -
 arch/mips/ath79/mach-ap121.c   |  92 -------------------
 arch/mips/ath79/mach-ap136.c   | 156 ---------------------------------
 arch/mips/ath79/mach-ap81.c    | 100 ---------------------
 arch/mips/ath79/mach-db120.c   | 136 ----------------------------
 arch/mips/ath79/mach-pb44.c    | 128 ---------------------------
 arch/mips/ath79/mach-ubnt-xm.c | 126 --------------------------
 arch/mips/ath79/machtypes.h    |  28 ------
 arch/mips/ath79/setup.c        |  77 ++--------------
 12 files changed, 9 insertions(+), 919 deletions(-)
 delete mode 100644 arch/mips/ath79/mach-ap121.c
 delete mode 100644 arch/mips/ath79/mach-ap136.c
 delete mode 100644 arch/mips/ath79/mach-ap81.c
 delete mode 100644 arch/mips/ath79/mach-db120.c
 delete mode 100644 arch/mips/ath79/mach-pb44.c
 delete mode 100644 arch/mips/ath79/mach-ubnt-xm.c
 delete mode 100644 arch/mips/ath79/machtypes.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 787290781b8c..2414e5072629 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -206,7 +206,6 @@ config ATH79
 	select COMMON_CLK
 	select CLKDEV_LOOKUP
 	select IRQ_MIPS_CPU
-	select MIPS_MACHINE
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 191c3910eac5..7367416642cb 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -1,79 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 if ATH79
 
-menu "Atheros AR71XX/AR724X/AR913X machine selection"
-
-config ATH79_MACH_AP121
-	bool "Atheros AP121 reference board"
-	select SOC_AR933X
-	select ATH79_DEV_GPIO_BUTTONS
-	select ATH79_DEV_LEDS_GPIO
-	select ATH79_DEV_SPI
-	select ATH79_DEV_USB
-	select ATH79_DEV_WMAC
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Atheros AP121 reference board.
-
-config ATH79_MACH_AP136
-	bool "Atheros AP136 reference board"
-	select SOC_QCA955X
-	select ATH79_DEV_GPIO_BUTTONS
-	select ATH79_DEV_LEDS_GPIO
-	select ATH79_DEV_SPI
-	select ATH79_DEV_USB
-	select ATH79_DEV_WMAC
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Atheros AP136 reference board.
-
-config ATH79_MACH_AP81
-	bool "Atheros AP81 reference board"
-	select SOC_AR913X
-	select ATH79_DEV_GPIO_BUTTONS
-	select ATH79_DEV_LEDS_GPIO
-	select ATH79_DEV_SPI
-	select ATH79_DEV_USB
-	select ATH79_DEV_WMAC
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Atheros AP81 reference board.
-
-config ATH79_MACH_DB120
-	bool "Atheros DB120 reference board"
-	select SOC_AR934X
-	select ATH79_DEV_GPIO_BUTTONS
-	select ATH79_DEV_LEDS_GPIO
-	select ATH79_DEV_SPI
-	select ATH79_DEV_USB
-	select ATH79_DEV_WMAC
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Atheros DB120 reference board.
-
-config ATH79_MACH_PB44
-	bool "Atheros PB44 reference board"
-	select SOC_AR71XX
-	select ATH79_DEV_GPIO_BUTTONS
-	select ATH79_DEV_LEDS_GPIO
-	select ATH79_DEV_SPI
-	select ATH79_DEV_USB
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Atheros PB44 reference board.
-
-config ATH79_MACH_UBNT_XM
-	bool "Ubiquiti Networks XM (rev 1.0) board"
-	select SOC_AR724X
-	select ATH79_DEV_GPIO_BUTTONS
-	select ATH79_DEV_LEDS_GPIO
-	select ATH79_DEV_SPI
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Ubiquiti Networks XM (rev 1.0) board.
-
-endmenu
-
 config SOC_AR71XX
 	select HAVE_PCI
 	def_bool n
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index d8bd9b821ac9..ab8e26fe7446 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -22,13 +22,3 @@ obj-$(CONFIG_ATH79_DEV_LEDS_GPIO)	+= dev-leds-gpio.o
 obj-$(CONFIG_ATH79_DEV_SPI)		+= dev-spi.o
 obj-$(CONFIG_ATH79_DEV_USB)		+= dev-usb.o
 obj-$(CONFIG_ATH79_DEV_WMAC)		+= dev-wmac.o
-
-#
-# Machines
-#
-obj-$(CONFIG_ATH79_MACH_AP121)		+= mach-ap121.o
-obj-$(CONFIG_ATH79_MACH_AP136)		+= mach-ap136.o
-obj-$(CONFIG_ATH79_MACH_AP81)		+= mach-ap81.o
-obj-$(CONFIG_ATH79_MACH_DB120)		+= mach-db120.o
-obj-$(CONFIG_ATH79_MACH_PB44)		+= mach-pb44.o
-obj-$(CONFIG_ATH79_MACH_UBNT_XM)	+= mach-ubnt-xm.o
diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 699f00f096cb..aea9590bf353 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -26,7 +26,6 @@
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include "common.h"
-#include "machtypes.h"
 
 #define AR71XX_BASE_FREQ	40000000
 #define AR724X_BASE_FREQ	40000000
diff --git a/arch/mips/ath79/mach-ap121.c b/arch/mips/ath79/mach-ap121.c
deleted file mode 100644
index 1bf73f2a069d..000000000000
--- a/arch/mips/ath79/mach-ap121.c
+++ /dev/null
@@ -1,92 +0,0 @@
-/*
- *  Atheros AP121 board support
- *
- *  Copyright (C) 2011 Gabor Juhos <juhosg@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#include "machtypes.h"
-#include "dev-gpio-buttons.h"
-#include "dev-leds-gpio.h"
-#include "dev-spi.h"
-#include "dev-usb.h"
-#include "dev-wmac.h"
-
-#define AP121_GPIO_LED_WLAN		0
-#define AP121_GPIO_LED_USB		1
-
-#define AP121_GPIO_BTN_JUMPSTART	11
-#define AP121_GPIO_BTN_RESET		12
-
-#define AP121_KEYS_POLL_INTERVAL	20	/* msecs */
-#define AP121_KEYS_DEBOUNCE_INTERVAL	(3 * AP121_KEYS_POLL_INTERVAL)
-
-#define AP121_CAL_DATA_ADDR	0x1fff1000
-
-static struct gpio_led ap121_leds_gpio[] __initdata = {
-	{
-		.name		= "ap121:green:usb",
-		.gpio		= AP121_GPIO_LED_USB,
-		.active_low	= 0,
-	},
-	{
-		.name		= "ap121:green:wlan",
-		.gpio		= AP121_GPIO_LED_WLAN,
-		.active_low	= 0,
-	},
-};
-
-static struct gpio_keys_button ap121_gpio_keys[] __initdata = {
-	{
-		.desc		= "jumpstart button",
-		.type		= EV_KEY,
-		.code		= KEY_WPS_BUTTON,
-		.debounce_interval = AP121_KEYS_DEBOUNCE_INTERVAL,
-		.gpio		= AP121_GPIO_BTN_JUMPSTART,
-		.active_low	= 1,
-	},
-	{
-		.desc		= "reset button",
-		.type		= EV_KEY,
-		.code		= KEY_RESTART,
-		.debounce_interval = AP121_KEYS_DEBOUNCE_INTERVAL,
-		.gpio		= AP121_GPIO_BTN_RESET,
-		.active_low	= 1,
-	}
-};
-
-static struct spi_board_info ap121_spi_info[] = {
-	{
-		.bus_num	= 0,
-		.chip_select	= 0,
-		.max_speed_hz	= 25000000,
-		.modalias	= "mx25l1606e",
-	}
-};
-
-static struct ath79_spi_platform_data ap121_spi_data = {
-	.bus_num	= 0,
-	.num_chipselect = 1,
-};
-
-static void __init ap121_setup(void)
-{
-	u8 *cal_data = (u8 *) KSEG1ADDR(AP121_CAL_DATA_ADDR);
-
-	ath79_register_leds_gpio(-1, ARRAY_SIZE(ap121_leds_gpio),
-				 ap121_leds_gpio);
-	ath79_register_gpio_keys_polled(-1, AP121_KEYS_POLL_INTERVAL,
-					ARRAY_SIZE(ap121_gpio_keys),
-					ap121_gpio_keys);
-
-	ath79_register_spi(&ap121_spi_data, ap121_spi_info,
-			   ARRAY_SIZE(ap121_spi_info));
-	ath79_register_usb();
-	ath79_register_wmac(cal_data);
-}
-
-MIPS_MACHINE(ATH79_MACH_AP121, "AP121", "Atheros AP121 reference board",
-	     ap121_setup);
diff --git a/arch/mips/ath79/mach-ap136.c b/arch/mips/ath79/mach-ap136.c
deleted file mode 100644
index 07eac58c3641..000000000000
--- a/arch/mips/ath79/mach-ap136.c
+++ /dev/null
@@ -1,156 +0,0 @@
-/*
- * Qualcomm Atheros AP136 reference board support
- *
- * Copyright (c) 2012 Qualcomm Atheros
- * Copyright (c) 2012-2013 Gabor Juhos <juhosg@openwrt.org>
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- *
- */
-
-#include <linux/pci.h>
-#include <linux/ath9k_platform.h>
-
-#include "machtypes.h"
-#include "dev-gpio-buttons.h"
-#include "dev-leds-gpio.h"
-#include "dev-spi.h"
-#include "dev-usb.h"
-#include "dev-wmac.h"
-#include "pci.h"
-
-#define AP136_GPIO_LED_STATUS_RED	14
-#define AP136_GPIO_LED_STATUS_GREEN	19
-#define AP136_GPIO_LED_USB		4
-#define AP136_GPIO_LED_WLAN_2G		13
-#define AP136_GPIO_LED_WLAN_5G		12
-#define AP136_GPIO_LED_WPS_RED		15
-#define AP136_GPIO_LED_WPS_GREEN	20
-
-#define AP136_GPIO_BTN_WPS		16
-#define AP136_GPIO_BTN_RFKILL		21
-
-#define AP136_KEYS_POLL_INTERVAL	20	/* msecs */
-#define AP136_KEYS_DEBOUNCE_INTERVAL	(3 * AP136_KEYS_POLL_INTERVAL)
-
-#define AP136_WMAC_CALDATA_OFFSET 0x1000
-#define AP136_PCIE_CALDATA_OFFSET 0x5000
-
-static struct gpio_led ap136_leds_gpio[] __initdata = {
-	{
-		.name		= "qca:green:status",
-		.gpio		= AP136_GPIO_LED_STATUS_GREEN,
-		.active_low	= 1,
-	},
-	{
-		.name		= "qca:red:status",
-		.gpio		= AP136_GPIO_LED_STATUS_RED,
-		.active_low	= 1,
-	},
-	{
-		.name		= "qca:green:wps",
-		.gpio		= AP136_GPIO_LED_WPS_GREEN,
-		.active_low	= 1,
-	},
-	{
-		.name		= "qca:red:wps",
-		.gpio		= AP136_GPIO_LED_WPS_RED,
-		.active_low	= 1,
-	},
-	{
-		.name		= "qca:red:wlan-2g",
-		.gpio		= AP136_GPIO_LED_WLAN_2G,
-		.active_low	= 1,
-	},
-	{
-		.name		= "qca:red:usb",
-		.gpio		= AP136_GPIO_LED_USB,
-		.active_low	= 1,
-	}
-};
-
-static struct gpio_keys_button ap136_gpio_keys[] __initdata = {
-	{
-		.desc		= "WPS button",
-		.type		= EV_KEY,
-		.code		= KEY_WPS_BUTTON,
-		.debounce_interval = AP136_KEYS_DEBOUNCE_INTERVAL,
-		.gpio		= AP136_GPIO_BTN_WPS,
-		.active_low	= 1,
-	},
-	{
-		.desc		= "RFKILL button",
-		.type		= EV_KEY,
-		.code		= KEY_RFKILL,
-		.debounce_interval = AP136_KEYS_DEBOUNCE_INTERVAL,
-		.gpio		= AP136_GPIO_BTN_RFKILL,
-		.active_low	= 1,
-	},
-};
-
-static struct spi_board_info ap136_spi_info[] = {
-	{
-		.bus_num	= 0,
-		.chip_select	= 0,
-		.max_speed_hz	= 25000000,
-		.modalias	= "mx25l6405d",
-	}
-};
-
-static struct ath79_spi_platform_data ap136_spi_data = {
-	.bus_num	= 0,
-	.num_chipselect	= 1,
-};
-
-#ifdef CONFIG_PCI
-static struct ath9k_platform_data ap136_ath9k_data;
-
-static int ap136_pci_plat_dev_init(struct pci_dev *dev)
-{
-	if (dev->bus->number == 1 && (PCI_SLOT(dev->devfn)) == 0)
-		dev->dev.platform_data = &ap136_ath9k_data;
-
-	return 0;
-}
-
-static void __init ap136_pci_init(u8 *eeprom)
-{
-	memcpy(ap136_ath9k_data.eeprom_data, eeprom,
-	       sizeof(ap136_ath9k_data.eeprom_data));
-
-	ath79_pci_set_plat_dev_init(ap136_pci_plat_dev_init);
-	ath79_register_pci();
-}
-#else
-static inline void ap136_pci_init(u8 *eeprom) {}
-#endif /* CONFIG_PCI */
-
-static void __init ap136_setup(void)
-{
-	u8 *art = (u8 *) KSEG1ADDR(0x1fff0000);
-
-	ath79_register_leds_gpio(-1, ARRAY_SIZE(ap136_leds_gpio),
-				 ap136_leds_gpio);
-	ath79_register_gpio_keys_polled(-1, AP136_KEYS_POLL_INTERVAL,
-					ARRAY_SIZE(ap136_gpio_keys),
-					ap136_gpio_keys);
-	ath79_register_spi(&ap136_spi_data, ap136_spi_info,
-			   ARRAY_SIZE(ap136_spi_info));
-	ath79_register_usb();
-	ath79_register_wmac(art + AP136_WMAC_CALDATA_OFFSET);
-	ap136_pci_init(art + AP136_PCIE_CALDATA_OFFSET);
-}
-
-MIPS_MACHINE(ATH79_MACH_AP136_010, "AP136-010",
-	     "Atheros AP136-010 reference board",
-	     ap136_setup);
diff --git a/arch/mips/ath79/mach-ap81.c b/arch/mips/ath79/mach-ap81.c
deleted file mode 100644
index 1c78d497f930..000000000000
--- a/arch/mips/ath79/mach-ap81.c
+++ /dev/null
@@ -1,100 +0,0 @@
-/*
- *  Atheros AP81 board support
- *
- *  Copyright (C) 2009-2010 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2009 Imre Kaloz <kaloz@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#include "machtypes.h"
-#include "dev-wmac.h"
-#include "dev-gpio-buttons.h"
-#include "dev-leds-gpio.h"
-#include "dev-spi.h"
-#include "dev-usb.h"
-
-#define AP81_GPIO_LED_STATUS	1
-#define AP81_GPIO_LED_AOSS	3
-#define AP81_GPIO_LED_WLAN	6
-#define AP81_GPIO_LED_POWER	14
-
-#define AP81_GPIO_BTN_SW4	12
-#define AP81_GPIO_BTN_SW1	21
-
-#define AP81_KEYS_POLL_INTERVAL		20	/* msecs */
-#define AP81_KEYS_DEBOUNCE_INTERVAL	(3 * AP81_KEYS_POLL_INTERVAL)
-
-#define AP81_CAL_DATA_ADDR	0x1fff1000
-
-static struct gpio_led ap81_leds_gpio[] __initdata = {
-	{
-		.name		= "ap81:green:status",
-		.gpio		= AP81_GPIO_LED_STATUS,
-		.active_low	= 1,
-	}, {
-		.name		= "ap81:amber:aoss",
-		.gpio		= AP81_GPIO_LED_AOSS,
-		.active_low	= 1,
-	}, {
-		.name		= "ap81:green:wlan",
-		.gpio		= AP81_GPIO_LED_WLAN,
-		.active_low	= 1,
-	}, {
-		.name		= "ap81:green:power",
-		.gpio		= AP81_GPIO_LED_POWER,
-		.active_low	= 1,
-	}
-};
-
-static struct gpio_keys_button ap81_gpio_keys[] __initdata = {
-	{
-		.desc		= "sw1",
-		.type		= EV_KEY,
-		.code		= BTN_0,
-		.debounce_interval = AP81_KEYS_DEBOUNCE_INTERVAL,
-		.gpio		= AP81_GPIO_BTN_SW1,
-		.active_low	= 1,
-	} , {
-		.desc		= "sw4",
-		.type		= EV_KEY,
-		.code		= BTN_1,
-		.debounce_interval = AP81_KEYS_DEBOUNCE_INTERVAL,
-		.gpio		= AP81_GPIO_BTN_SW4,
-		.active_low	= 1,
-	}
-};
-
-static struct spi_board_info ap81_spi_info[] = {
-	{
-		.bus_num	= 0,
-		.chip_select	= 0,
-		.max_speed_hz	= 25000000,
-		.modalias	= "m25p64",
-	}
-};
-
-static struct ath79_spi_platform_data ap81_spi_data = {
-	.bus_num	= 0,
-	.num_chipselect = 1,
-};
-
-static void __init ap81_setup(void)
-{
-	u8 *cal_data = (u8 *) KSEG1ADDR(AP81_CAL_DATA_ADDR);
-
-	ath79_register_leds_gpio(-1, ARRAY_SIZE(ap81_leds_gpio),
-				 ap81_leds_gpio);
-	ath79_register_gpio_keys_polled(-1, AP81_KEYS_POLL_INTERVAL,
-					ARRAY_SIZE(ap81_gpio_keys),
-					ap81_gpio_keys);
-	ath79_register_spi(&ap81_spi_data, ap81_spi_info,
-			   ARRAY_SIZE(ap81_spi_info));
-	ath79_register_wmac(cal_data);
-	ath79_register_usb();
-}
-
-MIPS_MACHINE(ATH79_MACH_AP81, "AP81", "Atheros AP81 reference board",
-	     ap81_setup);
diff --git a/arch/mips/ath79/mach-db120.c b/arch/mips/ath79/mach-db120.c
deleted file mode 100644
index 9423f5aed287..000000000000
--- a/arch/mips/ath79/mach-db120.c
+++ /dev/null
@@ -1,136 +0,0 @@
-/*
- * Atheros DB120 reference board support
- *
- * Copyright (c) 2011 Qualcomm Atheros
- * Copyright (c) 2011 Gabor Juhos <juhosg@openwrt.org>
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- *
- */
-
-#include <linux/pci.h>
-#include <linux/ath9k_platform.h>
-
-#include "machtypes.h"
-#include "dev-gpio-buttons.h"
-#include "dev-leds-gpio.h"
-#include "dev-spi.h"
-#include "dev-usb.h"
-#include "dev-wmac.h"
-#include "pci.h"
-
-#define DB120_GPIO_LED_WLAN_5G		12
-#define DB120_GPIO_LED_WLAN_2G		13
-#define DB120_GPIO_LED_STATUS		14
-#define DB120_GPIO_LED_WPS		15
-
-#define DB120_GPIO_BTN_WPS		16
-
-#define DB120_KEYS_POLL_INTERVAL	20	/* msecs */
-#define DB120_KEYS_DEBOUNCE_INTERVAL	(3 * DB120_KEYS_POLL_INTERVAL)
-
-#define DB120_WMAC_CALDATA_OFFSET 0x1000
-#define DB120_PCIE_CALDATA_OFFSET 0x5000
-
-static struct gpio_led db120_leds_gpio[] __initdata = {
-	{
-		.name		= "db120:green:status",
-		.gpio		= DB120_GPIO_LED_STATUS,
-		.active_low	= 1,
-	},
-	{
-		.name		= "db120:green:wps",
-		.gpio		= DB120_GPIO_LED_WPS,
-		.active_low	= 1,
-	},
-	{
-		.name		= "db120:green:wlan-5g",
-		.gpio		= DB120_GPIO_LED_WLAN_5G,
-		.active_low	= 1,
-	},
-	{
-		.name		= "db120:green:wlan-2g",
-		.gpio		= DB120_GPIO_LED_WLAN_2G,
-		.active_low	= 1,
-	},
-};
-
-static struct gpio_keys_button db120_gpio_keys[] __initdata = {
-	{
-		.desc		= "WPS button",
-		.type		= EV_KEY,
-		.code		= KEY_WPS_BUTTON,
-		.debounce_interval = DB120_KEYS_DEBOUNCE_INTERVAL,
-		.gpio		= DB120_GPIO_BTN_WPS,
-		.active_low	= 1,
-	},
-};
-
-static struct spi_board_info db120_spi_info[] = {
-	{
-		.bus_num	= 0,
-		.chip_select	= 0,
-		.max_speed_hz	= 25000000,
-		.modalias	= "s25sl064a",
-	}
-};
-
-static struct ath79_spi_platform_data db120_spi_data = {
-	.bus_num	= 0,
-	.num_chipselect = 1,
-};
-
-#ifdef CONFIG_PCI
-static struct ath9k_platform_data db120_ath9k_data;
-
-static int db120_pci_plat_dev_init(struct pci_dev *dev)
-{
-	switch (PCI_SLOT(dev->devfn)) {
-	case 0:
-		dev->dev.platform_data = &db120_ath9k_data;
-		break;
-	}
-
-	return 0;
-}
-
-static void __init db120_pci_init(u8 *eeprom)
-{
-	memcpy(db120_ath9k_data.eeprom_data, eeprom,
-	       sizeof(db120_ath9k_data.eeprom_data));
-
-	ath79_pci_set_plat_dev_init(db120_pci_plat_dev_init);
-	ath79_register_pci();
-}
-#else
-static inline void db120_pci_init(u8 *eeprom) {}
-#endif /* CONFIG_PCI */
-
-static void __init db120_setup(void)
-{
-	u8 *art = (u8 *) KSEG1ADDR(0x1fff0000);
-
-	ath79_register_leds_gpio(-1, ARRAY_SIZE(db120_leds_gpio),
-				 db120_leds_gpio);
-	ath79_register_gpio_keys_polled(-1, DB120_KEYS_POLL_INTERVAL,
-					ARRAY_SIZE(db120_gpio_keys),
-					db120_gpio_keys);
-	ath79_register_spi(&db120_spi_data, db120_spi_info,
-			   ARRAY_SIZE(db120_spi_info));
-	ath79_register_usb();
-	ath79_register_wmac(art + DB120_WMAC_CALDATA_OFFSET);
-	db120_pci_init(art + DB120_PCIE_CALDATA_OFFSET);
-}
-
-MIPS_MACHINE(ATH79_MACH_DB120, "DB120", "Atheros DB120 reference board",
-	     db120_setup);
diff --git a/arch/mips/ath79/mach-pb44.c b/arch/mips/ath79/mach-pb44.c
deleted file mode 100644
index 75fb96ca61db..000000000000
--- a/arch/mips/ath79/mach-pb44.c
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
- *  Atheros PB44 reference board support
- *
- *  Copyright (C) 2009-2010 Gabor Juhos <juhosg@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/i2c.h>
-#include <linux/gpio/machine.h>
-#include <linux/platform_data/pcf857x.h>
-
-#include "machtypes.h"
-#include "dev-gpio-buttons.h"
-#include "dev-leds-gpio.h"
-#include "dev-spi.h"
-#include "dev-usb.h"
-#include "pci.h"
-
-#define PB44_GPIO_I2C_SCL	0
-#define PB44_GPIO_I2C_SDA	1
-
-#define PB44_GPIO_EXP_BASE	16
-#define PB44_GPIO_SW_RESET	(PB44_GPIO_EXP_BASE + 6)
-#define PB44_GPIO_SW_JUMP	(PB44_GPIO_EXP_BASE + 8)
-#define PB44_GPIO_LED_JUMP1	(PB44_GPIO_EXP_BASE + 9)
-#define PB44_GPIO_LED_JUMP2	(PB44_GPIO_EXP_BASE + 10)
-
-#define PB44_KEYS_POLL_INTERVAL		20	/* msecs */
-#define PB44_KEYS_DEBOUNCE_INTERVAL	(3 * PB44_KEYS_POLL_INTERVAL)
-
-static struct gpiod_lookup_table pb44_i2c_gpiod_table = {
-	.dev_id = "i2c-gpio.0",
-	.table = {
-		GPIO_LOOKUP_IDX("ath79-gpio", PB44_GPIO_I2C_SDA,
-				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-		GPIO_LOOKUP_IDX("ath79-gpio", PB44_GPIO_I2C_SCL,
-				NULL, 1, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-	},
-};
-
-static struct platform_device pb44_i2c_gpio_device = {
-	.name		= "i2c-gpio",
-	.id		= 0,
-	.dev = {
-		.platform_data	= NULL,
-	}
-};
-
-static struct pcf857x_platform_data pb44_pcf857x_data = {
-	.gpio_base	= PB44_GPIO_EXP_BASE,
-};
-
-static struct i2c_board_info pb44_i2c_board_info[] __initdata = {
-	{
-		I2C_BOARD_INFO("pcf8575", 0x20),
-		.platform_data	= &pb44_pcf857x_data,
-	},
-};
-
-static struct gpio_led pb44_leds_gpio[] __initdata = {
-	{
-		.name		= "pb44:amber:jump1",
-		.gpio		= PB44_GPIO_LED_JUMP1,
-		.active_low	= 1,
-	}, {
-		.name		= "pb44:green:jump2",
-		.gpio		= PB44_GPIO_LED_JUMP2,
-		.active_low	= 1,
-	},
-};
-
-static struct gpio_keys_button pb44_gpio_keys[] __initdata = {
-	{
-		.desc		= "soft_reset",
-		.type		= EV_KEY,
-		.code		= KEY_RESTART,
-		.debounce_interval = PB44_KEYS_DEBOUNCE_INTERVAL,
-		.gpio		= PB44_GPIO_SW_RESET,
-		.active_low	= 1,
-	} , {
-		.desc		= "jumpstart",
-		.type		= EV_KEY,
-		.code		= KEY_WPS_BUTTON,
-		.debounce_interval = PB44_KEYS_DEBOUNCE_INTERVAL,
-		.gpio		= PB44_GPIO_SW_JUMP,
-		.active_low	= 1,
-	}
-};
-
-static struct spi_board_info pb44_spi_info[] = {
-	{
-		.bus_num	= 0,
-		.chip_select	= 0,
-		.max_speed_hz	= 25000000,
-		.modalias	= "m25p64",
-	},
-};
-
-static struct ath79_spi_platform_data pb44_spi_data = {
-	.bus_num		= 0,
-	.num_chipselect		= 1,
-};
-
-static void __init pb44_init(void)
-{
-	gpiod_add_lookup_table(&pb44_i2c_gpiod_table);
-	i2c_register_board_info(0, pb44_i2c_board_info,
-				ARRAY_SIZE(pb44_i2c_board_info));
-	platform_device_register(&pb44_i2c_gpio_device);
-
-	ath79_register_leds_gpio(-1, ARRAY_SIZE(pb44_leds_gpio),
-				 pb44_leds_gpio);
-	ath79_register_gpio_keys_polled(-1, PB44_KEYS_POLL_INTERVAL,
-					ARRAY_SIZE(pb44_gpio_keys),
-					pb44_gpio_keys);
-	ath79_register_spi(&pb44_spi_data, pb44_spi_info,
-			   ARRAY_SIZE(pb44_spi_info));
-	ath79_register_usb();
-	ath79_register_pci();
-}
-
-MIPS_MACHINE(ATH79_MACH_PB44, "PB44", "Atheros PB44 reference board",
-	     pb44_init);
diff --git a/arch/mips/ath79/mach-ubnt-xm.c b/arch/mips/ath79/mach-ubnt-xm.c
deleted file mode 100644
index 4a3c60694c75..000000000000
--- a/arch/mips/ath79/mach-ubnt-xm.c
+++ /dev/null
@@ -1,126 +0,0 @@
-/*
- *  Ubiquiti Networks XM (rev 1.0) board support
- *
- *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
- *
- *  Derived from: mach-pb44.c
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/ath9k_platform.h>
-
-#include <asm/mach-ath79/irq.h>
-
-#include "machtypes.h"
-#include "dev-gpio-buttons.h"
-#include "dev-leds-gpio.h"
-#include "dev-spi.h"
-#include "pci.h"
-
-#define UBNT_XM_GPIO_LED_L1		0
-#define UBNT_XM_GPIO_LED_L2		1
-#define UBNT_XM_GPIO_LED_L3		11
-#define UBNT_XM_GPIO_LED_L4		7
-
-#define UBNT_XM_GPIO_BTN_RESET		12
-
-#define UBNT_XM_KEYS_POLL_INTERVAL	20
-#define UBNT_XM_KEYS_DEBOUNCE_INTERVAL	(3 * UBNT_XM_KEYS_POLL_INTERVAL)
-
-#define UBNT_XM_EEPROM_ADDR		(u8 *) KSEG1ADDR(0x1fff1000)
-
-static struct gpio_led ubnt_xm_leds_gpio[] __initdata = {
-	{
-		.name		= "ubnt-xm:red:link1",
-		.gpio		= UBNT_XM_GPIO_LED_L1,
-		.active_low	= 0,
-	}, {
-		.name		= "ubnt-xm:orange:link2",
-		.gpio		= UBNT_XM_GPIO_LED_L2,
-		.active_low	= 0,
-	}, {
-		.name		= "ubnt-xm:green:link3",
-		.gpio		= UBNT_XM_GPIO_LED_L3,
-		.active_low	= 0,
-	}, {
-		.name		= "ubnt-xm:green:link4",
-		.gpio		= UBNT_XM_GPIO_LED_L4,
-		.active_low	= 0,
-	},
-};
-
-static struct gpio_keys_button ubnt_xm_gpio_keys[] __initdata = {
-	{
-		.desc			= "reset",
-		.type			= EV_KEY,
-		.code			= KEY_RESTART,
-		.debounce_interval	= UBNT_XM_KEYS_DEBOUNCE_INTERVAL,
-		.gpio			= UBNT_XM_GPIO_BTN_RESET,
-		.active_low		= 1,
-	}
-};
-
-static struct spi_board_info ubnt_xm_spi_info[] = {
-	{
-		.bus_num	= 0,
-		.chip_select	= 0,
-		.max_speed_hz	= 25000000,
-		.modalias	= "mx25l6405d",
-	}
-};
-
-static struct ath79_spi_platform_data ubnt_xm_spi_data = {
-	.bus_num		= 0,
-	.num_chipselect		= 1,
-};
-
-#ifdef CONFIG_PCI
-static struct ath9k_platform_data ubnt_xm_eeprom_data;
-
-static int ubnt_xm_pci_plat_dev_init(struct pci_dev *dev)
-{
-	switch (PCI_SLOT(dev->devfn)) {
-	case 0:
-		dev->dev.platform_data = &ubnt_xm_eeprom_data;
-		break;
-	}
-
-	return 0;
-}
-
-static void __init ubnt_xm_pci_init(void)
-{
-	memcpy(ubnt_xm_eeprom_data.eeprom_data, UBNT_XM_EEPROM_ADDR,
-	       sizeof(ubnt_xm_eeprom_data.eeprom_data));
-
-	ath79_pci_set_plat_dev_init(ubnt_xm_pci_plat_dev_init);
-	ath79_register_pci();
-}
-#else
-static inline void ubnt_xm_pci_init(void) {}
-#endif /* CONFIG_PCI */
-
-static void __init ubnt_xm_init(void)
-{
-	ath79_register_leds_gpio(-1, ARRAY_SIZE(ubnt_xm_leds_gpio),
-				 ubnt_xm_leds_gpio);
-
-	ath79_register_gpio_keys_polled(-1, UBNT_XM_KEYS_POLL_INTERVAL,
-					ARRAY_SIZE(ubnt_xm_gpio_keys),
-					ubnt_xm_gpio_keys);
-
-	ath79_register_spi(&ubnt_xm_spi_data, ubnt_xm_spi_info,
-			   ARRAY_SIZE(ubnt_xm_spi_info));
-
-	ubnt_xm_pci_init();
-}
-
-MIPS_MACHINE(ATH79_MACH_UBNT_XM,
-	     "UBNT-XM",
-	     "Ubiquiti Networks XM (rev 1.0) board",
-	     ubnt_xm_init);
diff --git a/arch/mips/ath79/machtypes.h b/arch/mips/ath79/machtypes.h
deleted file mode 100644
index a13db3d15c8f..000000000000
--- a/arch/mips/ath79/machtypes.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- *  Atheros AR71XX/AR724X/AR913X machine type definitions
- *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#ifndef _ATH79_MACHTYPE_H
-#define _ATH79_MACHTYPE_H
-
-#include <asm/mips_machine.h>
-
-enum ath79_mach_type {
-	ATH79_MACH_GENERIC_OF = -1,	/* Device tree board */
-	ATH79_MACH_GENERIC = 0,
-	ATH79_MACH_AP121,		/* Atheros AP121 reference board */
-	ATH79_MACH_AP136_010,		/* Atheros AP136-010 reference board */
-	ATH79_MACH_AP81,		/* Atheros AP81 reference board */
-	ATH79_MACH_DB120,		/* Atheros DB120 reference board */
-	ATH79_MACH_PB44,		/* Atheros PB44 reference board */
-	ATH79_MACH_UBNT_XM,		/* Ubiquiti Networks XM board rev 1.0 */
-};
-
-#endif /* _ATH79_MACHTYPE_H */
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 48f879686935..7a9ba4464756 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -33,7 +33,6 @@
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include "common.h"
 #include "dev-common.h"
-#include "machtypes.h"
 
 #define ATH79_SYS_TYPE_LEN	64
 
@@ -236,25 +235,21 @@ void __init plat_mem_setup(void)
 	else if (fw_passed_dtb)
 		__dt_setup_arch((void *)KSEG0ADDR(fw_passed_dtb));
 
-	if (mips_machtype != ATH79_MACH_GENERIC_OF) {
-		ath79_reset_base = ioremap_nocache(AR71XX_RESET_BASE,
-						   AR71XX_RESET_SIZE);
-		ath79_pll_base = ioremap_nocache(AR71XX_PLL_BASE,
-						 AR71XX_PLL_SIZE);
-		ath79_detect_sys_type();
-		ath79_ddr_ctrl_init();
+	ath79_reset_base = ioremap_nocache(AR71XX_RESET_BASE,
+					   AR71XX_RESET_SIZE);
+	ath79_pll_base = ioremap_nocache(AR71XX_PLL_BASE,
+					 AR71XX_PLL_SIZE);
+	ath79_detect_sys_type();
+	ath79_ddr_ctrl_init();
 
-		detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
-
-		/* OF machines should use the reset driver */
-		_machine_restart = ath79_restart;
-	}
+	detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
 
+	_machine_restart = ath79_restart;
 	_machine_halt = ath79_halt;
 	pm_power_off = ath79_halt;
 }
 
-static void __init ath79_of_plat_time_init(void)
+void __init plat_time_init(void)
 {
 	struct device_node *np;
 	struct clk *clk;
@@ -284,66 +279,12 @@ static void __init ath79_of_plat_time_init(void)
 	clk_put(clk);
 }
 
-void __init plat_time_init(void)
-{
-	unsigned long cpu_clk_rate;
-	unsigned long ahb_clk_rate;
-	unsigned long ddr_clk_rate;
-	unsigned long ref_clk_rate;
-
-	if (IS_ENABLED(CONFIG_OF) && mips_machtype == ATH79_MACH_GENERIC_OF) {
-		ath79_of_plat_time_init();
-		return;
-	}
-
-	ath79_clocks_init();
-
-	cpu_clk_rate = ath79_get_sys_clk_rate("cpu");
-	ahb_clk_rate = ath79_get_sys_clk_rate("ahb");
-	ddr_clk_rate = ath79_get_sys_clk_rate("ddr");
-	ref_clk_rate = ath79_get_sys_clk_rate("ref");
-
-	pr_info("Clocks: CPU:%lu.%03luMHz, DDR:%lu.%03luMHz, AHB:%lu.%03luMHz, Ref:%lu.%03luMHz\n",
-		cpu_clk_rate / 1000000, (cpu_clk_rate / 1000) % 1000,
-		ddr_clk_rate / 1000000, (ddr_clk_rate / 1000) % 1000,
-		ahb_clk_rate / 1000000, (ahb_clk_rate / 1000) % 1000,
-		ref_clk_rate / 1000000, (ref_clk_rate / 1000) % 1000);
-
-	mips_hpt_frequency = cpu_clk_rate / 2;
-}
-
 void __init arch_init_irq(void)
 {
 	irqchip_init();
 }
 
-static int __init ath79_setup(void)
-{
-	if  (mips_machtype == ATH79_MACH_GENERIC_OF)
-		return 0;
-
-	ath79_gpio_init();
-	ath79_register_uart();
-	ath79_register_wdt();
-
-	mips_machine_setup();
-
-	return 0;
-}
-
-arch_initcall(ath79_setup);
-
 void __init device_tree_init(void)
 {
 	unflatten_and_copy_device_tree();
 }
-
-MIPS_MACHINE(ATH79_MACH_GENERIC,
-	     "Generic",
-	     "Generic AR71XX/AR724X/AR913X based board",
-	     NULL);
-
-MIPS_MACHINE(ATH79_MACH_GENERIC_OF,
-	     "DTB",
-	     "Generic AR71XX/AR724X/AR913X based board (DT)",
-	     NULL);
-- 
2.20.1

