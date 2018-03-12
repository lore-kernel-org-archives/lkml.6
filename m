Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932375AbeCLJdC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:33:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53056 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeCLJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:32:59 -0400
X-Google-Smtp-Source: AG47ELsKHXof7ptuT5R9Uz490L0KY6GQLzZWRrvMW3oYfbL5yvjh9tVh6jTdYNsz/gW2piF2FjX6Ww==
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To: mturquette@baylibre.com, sboyd@kernel.org
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3] clk: stm32: add configuration flags for each of the stm32 drivers
Date: Mon, 12 Mar 2018 10:32:48 +0100
Message-Id: <20180312093248.27512-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two configuration flags to be able to not compile all the time
stm32f and stm32h7 drivers when ARCH_STM32 is set.
That help to save some space on those small platforms.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
version 3:
- rebase on clk-next where clk-stm32mp1 branch has been merged

 drivers/clk/Kconfig  | 14 ++++++++++++++
 drivers/clk/Makefile |  4 ++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index cbb9b0c05442..a26cde051158 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -244,6 +244,20 @@ config COMMON_CLK_STM32MP157
 	---help---
 	  Support for stm32mp157 SoC family clocks
 
+config COMMON_CLK_STM32F
+	bool "Clock driver for stm32f4 and stm32f7 SoC families"
+	depends on MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746
+	help
+	---help---
+	  Support for stm32f4 and stm32f7 SoC families clocks
+
+config COMMON_CLK_STM32H7
+	bool "Clock driver for stm32h7 SoC family"
+	depends on MACH_STM32H743
+	help
+	---help---
+	  Support for stm32h7 SoC family clocks
+
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/imgtec/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 8d812c701aa6..e0c106ed9407 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -45,8 +45,8 @@ obj-$(CONFIG_COMMON_CLK_SCPI)           += clk-scpi.o
 obj-$(CONFIG_COMMON_CLK_SI5351)		+= clk-si5351.o
 obj-$(CONFIG_COMMON_CLK_SI514)		+= clk-si514.o
 obj-$(CONFIG_COMMON_CLK_SI570)		+= clk-si570.o
-obj-$(CONFIG_ARCH_STM32)		+= clk-stm32f4.o
-obj-$(CONFIG_ARCH_STM32)		+= clk-stm32h7.o
+obj-$(CONFIG_COMMON_CLK_STM32F)		+= clk-stm32f4.o
+obj-$(CONFIG_COMMON_CLK_STM32H7)	+= clk-stm32h7.o
 obj-$(CONFIG_COMMON_CLK_STM32MP157)	+= clk-stm32mp1.o
 obj-$(CONFIG_ARCH_TANGO)		+= clk-tango4.o
 obj-$(CONFIG_CLK_TWL6040)		+= clk-twl6040.o
-- 
2.15.0
