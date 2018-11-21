Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D520EC04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFAE206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p90zJx/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFAE206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387498AbeKVFIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:08:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43611 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733171AbeKVFH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:07:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so6722574wrs.10;
        Wed, 21 Nov 2018 10:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uHSXzQltvdwAuoTekTwmiNXWX2hTAAPKaoS/nLIUshI=;
        b=p90zJx/j5mtnAGehfVnAHhcE2pa6j08jRh4PE0QmDcGm1xYD92h155qTfAN0W8xXDJ
         gELj/mJk/bgJFOEruPYJgdUEKjreffIBlIWnxrYVc9XWwP2EjWjzeDhFZRiJ0YN1IfY/
         Wxmhyszs4Ri2FotQaHrck37NrfvAcPpUjayJpz4XqMClyK1GVC5/d2wBiaUolv5sL2mJ
         /phk7+vXzOs+mOxd+1fd2ll2FB1W92Fva4ZhxKgpPxPXybGhlC6kzUC3dAGAD4kHTblT
         QCTbWr9erDqcxRwmgVjJzTUjtnSgEsz6P1TIYHPw5K7hBSlQZyJE8F3zNvVBioRkZpB/
         nAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uHSXzQltvdwAuoTekTwmiNXWX2hTAAPKaoS/nLIUshI=;
        b=XETPIy0hdQerD/VGB13/h3gQ4EXYSMBTOEXIySdXyGxOOGnG2fBjSuqOd8gixA+azx
         iUa54ExJudaOJrRXRtLt1BAZjqfmhp/vjCsWfevTMcrwNLjVl3CwEmHTNucr3Yvd/F43
         RlefbDHFeV7pbBdnn1I7938xJQmzif/EHzTmjikZCEGaJTTctMeANKklW4PLI0mEJePm
         2bnGiF0tAKOvzgxpkMCYBgH9r79fGOM4UkMw9XW20cPlBabt9MCW0T2xJrrmzCl4DUqX
         iQKizQCf5Bkg24Icx3PbnagqNJmf3YsC7WUa6QDgypEIzAZhfS+W/DnOs18UbQMwRswG
         u96g==
X-Gm-Message-State: AA+aEWY9A3IDpqKRUDo7m870CZdvHeREBdgeYPxeJmykCBEmBfVRjaAb
        dTIxGaXUf+n4nHRpobkori1AyFnbKE0=
X-Google-Smtp-Source: AFSGD/VUbKCpnkj3bpAOLRJO2lTBUbJ80pTuBsGEBUj8MXtveY4Zsbrdx0hT7ClkJPZ4ZOH1VfcZuA==
X-Received: by 2002:adf:ee4e:: with SMTP id w14mr7381403wro.112.1542825119130;
        Wed, 21 Nov 2018 10:31:59 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id e66-v6sm2568779wmf.40.2018.11.21.10.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 10:31:58 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: [RFC PATCH v3 09/17] pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)
Date:   Wed, 21 Nov 2018 21:30:42 +0300
Message-Id: <fc20d96f5531d7d1eb5ce3d5cf920c8bf59cad58.1542824904.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suniv F1C100s chip (several new F-series SoCs) of Allwinner has a
pin
controller like other SoCs from Allwinner.

Add support for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/pinctrl/sunxi/Kconfig                 |   4 +
 drivers/pinctrl/sunxi/Makefile                |   1 +
 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c | 417 ++++++++++++++++++++++++++
 3 files changed, 422 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 95282cd..a731fc9 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -6,6 +6,10 @@ config PINCTRL_SUNXI
 	select GENERIC_PINCONF
 	select GPIOLIB
 
+config PINCTRL_SUNIV_F1C100S
+	def_bool MACH_SUNIV
+	select PINCTRL_SUNXI
+
 config PINCTRL_SUN4I_A10
 	def_bool MACH_SUN4I || MACH_SUN7I || MACH_SUN8I
 	select PINCTRL_SUNXI
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index adb8443..fafcdae 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -3,6 +3,7 @@
 obj-y					+= pinctrl-sunxi.o
 
 # SoC Drivers
+obj-$(CONFIG_PINCTRL_SUNIV_F1C100S)	+= pinctrl-suniv-f1c100s.o
 obj-$(CONFIG_PINCTRL_SUN4I_A10)		+= pinctrl-sun4i-a10.o
 obj-$(CONFIG_PINCTRL_SUN5I)		+= pinctrl-sun5i.o
 obj-$(CONFIG_PINCTRL_SUN6I_A31)		+= pinctrl-sun6i-a31.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c b/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
new file mode 100644
index 0000000..46d5667
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
@@ -0,0 +1,417 @@
+/*
+ * Allwinner new F-series F1C100s SoC (suniv) pinctrl driver.
+ *
+ * Copyright (C) 2018 Icenowy Zheng
+ *
+ * Icenowy Zheng <icenowy@aosc.io>
+ *
+ * Copyright (C) 2014 Jackie Hwang
+ *
+ * Jackie Hwang <huangshr@allwinnertech.com>
+ *
+ * Copyright (C) 2014 Chen-Yu Tsai
+ *
+ * Chen-Yu Tsai <wens@csie.org>
+ *
+ * Copyright (C) 2014 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-sunxi.h"
+static const struct sunxi_desc_pin suniv_f1c100s_pins[] = {
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "rtp"),		/* X1 */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* BCLK */
+		  SUNXI_FUNCTION(0x5, "uart1"),		/* RTS */
+		  SUNXI_FUNCTION(0x6, "spi1")),		/* CS */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "rtp"),		/* X2 */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* LRCK */
+		  SUNXI_FUNCTION(0x5, "uart1"),		/* CTS */
+		  SUNXI_FUNCTION(0x6, "spi1")),		/* MOSI */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "rtp"),		/* Y1 */
+		  SUNXI_FUNCTION(0x3, "pwm0"),		/* PWM0 */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* IN */
+		  SUNXI_FUNCTION(0x5, "uart1"),		/* RX */
+		  SUNXI_FUNCTION(0x6, "spi1")),		/* MOSI */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "rtp"),		/* Y2 */
+		  SUNXI_FUNCTION(0x3, "ir0"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* OUT */
+		  SUNXI_FUNCTION(0x5, "uart1"),		/* TX */
+		  SUNXI_FUNCTION(0x6, "spi1")),		/* MISO */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "dram"),		/* DQS0 */
+		  SUNXI_FUNCTION(0x3, "i2c1"),		/* SCK */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* BCLK */
+		  SUNXI_FUNCTION(0x5, "uart1"),		/* RTS */
+		  SUNXI_FUNCTION(0x6, "spi1")),		/* CS */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "dram"),		/* DQS1 */
+		  SUNXI_FUNCTION(0x3, "i2c1"),		/* SDA */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* LRCK */
+		  SUNXI_FUNCTION(0x5, "uart1"),		/* CTS */
+		  SUNXI_FUNCTION(0x6, "spi1")),		/* MOSI */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "dram"),		/* CKE */
+		  SUNXI_FUNCTION(0x3, "pwm0"),		/* PWM0 */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* IN */
+		  SUNXI_FUNCTION(0x5, "uart1"),		/* RX */
+		  SUNXI_FUNCTION(0x6, "spi1")),		/* CLK */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "dram"),		/* DDR_REF_D */
+		  SUNXI_FUNCTION(0x3, "ir0"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* OUT */
+		  SUNXI_FUNCTION(0x5, "uart1"),		/* TX */
+		  SUNXI_FUNCTION(0x6, "spi1")),		/* MISO */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "spi0"),		/* CLK */
+		  SUNXI_FUNCTION(0x3, "mmc1")),		/* CLK */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "spi0"),		/* CS */
+		  SUNXI_FUNCTION(0x3, "mmc1")),		/* CMD */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "spi0"),		/* MISO */
+		  SUNXI_FUNCTION(0x3, "mmc1")),		/* D0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "spi0"),		/* MOSI */
+		  SUNXI_FUNCTION(0x3, "uart0")),	/* TX */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D2 */
+		  SUNXI_FUNCTION(0x3, "i2c0"),		/* SDA */
+		  SUNXI_FUNCTION(0x4, "rsb"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D3 */
+		  SUNXI_FUNCTION(0x3, "uart1"),		/* RTS */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D4*/
+		  SUNXI_FUNCTION(0x3, "uart1"),		/* CTS */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D5 */
+		  SUNXI_FUNCTION(0x3, "uart1"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D6 */
+		  SUNXI_FUNCTION(0x3, "uart1"),		/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D7 */
+		  SUNXI_FUNCTION(0x3, "i2c1"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D10 */
+		  SUNXI_FUNCTION(0x3, "i2c1"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D11 */
+		  SUNXI_FUNCTION(0x3, "i2s"),		/* MCLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D12 */
+		  SUNXI_FUNCTION(0x3, "i2s"),		/* BCLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D13 */
+		  SUNXI_FUNCTION(0x3, "i2s"),		/* LRCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 9)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D14 */
+		  SUNXI_FUNCTION(0x3, "i2s"),		/* IN */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 10)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 11),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D15 */
+		  SUNXI_FUNCTION(0x3, "i2s"),		/* OUT */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 11)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 12),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D18 */
+		  SUNXI_FUNCTION(0x3, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION(0x4, "rsb"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 12)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 13),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D19 */
+		  SUNXI_FUNCTION(0x3, "uart2"),		/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 13)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 14),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D20 */
+		  SUNXI_FUNCTION(0x3, "lvds1"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 14)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 15),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D21 */
+		  SUNXI_FUNCTION(0x3, "uart2"),		/* RTS */
+		  SUNXI_FUNCTION(0x4, "i2c2"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 15)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 16),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D22 */
+		  SUNXI_FUNCTION(0x3, "uart2"),		/* CTS */
+		  SUNXI_FUNCTION(0x4, "i2c2"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 16)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 17),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D23 */
+		  SUNXI_FUNCTION(0x3, "spdif"),		/* OUT */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 17)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 18),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* CLK */
+		  SUNXI_FUNCTION(0x3, "spi0"),		/* CS */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 18)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 19),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* DE */
+		  SUNXI_FUNCTION(0x3, "spi0"),		/* MOSI */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 19)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 20),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* HYSNC */
+		  SUNXI_FUNCTION(0x3, "spi0"),		/* CLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 20)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 21),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* VSYNC */
+		  SUNXI_FUNCTION(0x3, "spi0"),		/* MISO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 21)),
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* HSYNC */
+		  SUNXI_FUNCTION(0x3, "lcd"),		/* D0 */
+		  SUNXI_FUNCTION(0x4, "i2c2"),		/* SCK */
+		  SUNXI_FUNCTION(0x5, "uart0"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 0)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* VSYNC */
+		  SUNXI_FUNCTION(0x3, "lcd"),		/* D1 */
+		  SUNXI_FUNCTION(0x4, "i2c2"),		/* SDA */
+		  SUNXI_FUNCTION(0x5, "uart0"),		/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 1)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* PCLK */
+		  SUNXI_FUNCTION(0x3, "lcd"),		/* D8 */
+		  SUNXI_FUNCTION(0x4, "clk"),		/* OUT */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 2)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D0 */
+		  SUNXI_FUNCTION(0x3, "lcd"),		/* D9 */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* BCLK */
+		  SUNXI_FUNCTION(0x5, "rsb"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 3)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D1 */
+		  SUNXI_FUNCTION(0x3, "lcd"),		/* D16 */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* LRCK */
+		  SUNXI_FUNCTION(0x5, "rsb"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 4)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D2 */
+		  SUNXI_FUNCTION(0x3, "lcd"),		/* D17 */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* IN */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 5)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D3 */
+		  SUNXI_FUNCTION(0x3, "pwm1"),		/* PWM1 */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* OUT */
+		  SUNXI_FUNCTION(0x5, "spdif"),		/* OUT */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 6)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D4 */
+		  SUNXI_FUNCTION(0x3, "uart2"),		/* TX */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* CS */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 7)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D5 */
+		  SUNXI_FUNCTION(0x3, "uart2"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* MOSI */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 8)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D6 */
+		  SUNXI_FUNCTION(0x3, "uart2"),		/* RTS */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* CLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 9)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D7 */
+		  SUNXI_FUNCTION(0x3, "uart2"),		/* CTS */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* MISO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 10)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 11),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "clk0"),		/* OUT */
+		  SUNXI_FUNCTION(0x3, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION(0x4, "ir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 11)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 12),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2s"),		/* MCLK */
+		  SUNXI_FUNCTION(0x3, "i2c0"),		/* SDA */
+		  SUNXI_FUNCTION(0x4, "pwm0"),		/* PWM0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 12)),
+
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D1 */
+		  SUNXI_FUNCTION(0x3, "jtag"),		/* MS */
+		  SUNXI_FUNCTION(0x4, "ir0"),		/* MS */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 0)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D0 */
+		  SUNXI_FUNCTION(0x3, "dgb0"),		/* DI */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 1)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* CLK */
+		  SUNXI_FUNCTION(0x3, "uart0"),		/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 2)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* CMD */
+		  SUNXI_FUNCTION(0x3, "jtag"),		/* DO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 3)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D3 */
+		  SUNXI_FUNCTION(0x3, "uart0"),		/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 4)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D2 */
+		  SUNXI_FUNCTION(0x3, "jtag"),		/* CK */
+		  SUNXI_FUNCTION(0x4, "pwm1"),		/* PWM1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 5)),
+};
+
+static const struct sunxi_pinctrl_desc suniv_f1c100s_pinctrl_data = {
+	.pins = suniv_f1c100s_pins,
+	.npins = ARRAY_SIZE(suniv_f1c100s_pins),
+	.irq_banks = 3,
+	.disable_strict_mode = true,
+};
+
+static int suniv_pinctrl_probe(struct platform_device *pdev)
+{
+	return sunxi_pinctrl_init(pdev,
+				  &suniv_f1c100s_pinctrl_data);
+}
+
+static const struct of_device_id suniv_f1c100s_pinctrl_match[] = {
+	{ .compatible = "allwinner,suniv-f1c100s-pinctrl", },
+	{}
+};
+
+static struct platform_driver suniv_f1c100s_pinctrl_driver = {
+	.probe	= suniv_pinctrl_probe,
+	.driver	= {
+		.name		= "suniv-f1c100s-pinctrl",
+		.of_match_table	= suniv_f1c100s_pinctrl_match,
+	},
+};
+builtin_platform_driver(suniv_f1c100s_pinctrl_driver);
-- 
2.7.4

