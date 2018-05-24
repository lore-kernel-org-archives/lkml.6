Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964812AbeEXGAB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 02:00:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34966 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964796AbeEXF77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:59:59 -0400
X-Google-Smtp-Source: AB8JxZqjH/2sNbGIizpXzmCZMugmuKzr6MstbimW3xmq9lWA8qHOvyaKvAAYRyH8UoP7zPGBUzo4nw==
Date: Thu, 24 May 2018 08:59:55 +0300
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: [PATCH 7/9] clk: bd71837: Build ROHM BD71837 PMIC clock driver
Message-ID: <20180524055955.GH4249@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configuration options and Makefile for BD71837 clock driver

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/Kconfig  | 9 +++++++++
 drivers/clk/Makefile | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 41492e980ef4..4b045699bb5e 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -279,6 +279,15 @@ config COMMON_CLK_STM32H7
 	---help---
 	  Support for stm32h7 SoC family clocks
 
+config COMMON_CLK_BD71837
+	tristate "Clock driver for ROHM BD71837 PMIC MFD"
+	depends on MFD_BD71837
+	depends on I2C=y
+	depends on OF
+	help
+	  This driver supports ROHM BD71837 PMIC clock.
+
+
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/imgtec/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index de6d06ac790b..8393c4af7d5a 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -21,6 +21,7 @@ endif
 obj-$(CONFIG_MACH_ASM9260)		+= clk-asm9260.o
 obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
 obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
+obj-$(CONFIG_COMMON_CLK_BD71837)	+= clk-bd71837.o
 obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
 obj-$(CONFIG_COMMON_CLK_CDCE925)	+= clk-cdce925.o
 obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
-- 
2.14.3
