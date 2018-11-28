Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC17C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1A020832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmI3mbzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1A020832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeK2Jiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:38:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32826 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeK2Jho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:37:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so22290472wrr.0;
        Wed, 28 Nov 2018 14:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ev11KvbTIafEFzHvK/2w3PWoFb4QTPWkxQGfu8Exr1E=;
        b=FmI3mbzQOd8HON5ldY4MwgxwcTdxqQF3l+/+ewQ4ftnow4xP5vrayRG6feD9gS1/Ja
         f3bgvhFfsDTUsZJwq3l2equa6WaZkFkeM7PvwZXLmCx5R8ttuwvNHHe8NOnfxCZAO+Ca
         du2yUweaN34xsuo1+Udq7Ipf3CC4Fk4jJN72+7tpYEeh/4ny6TQUDasm7dbHQs/s37do
         NahbQQTPlGXNNIB+QOL3ucbrftmy0UPpl/hMmWCln63HdaoX77bvv37DGV0PYRtR8Wkc
         KR9UyFaN2MAB5r/O2CgSmzYLghm2LOR9T2Km4Gp+CINOsMzhUXq9KXqgm/hKkkCrSH1a
         xAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ev11KvbTIafEFzHvK/2w3PWoFb4QTPWkxQGfu8Exr1E=;
        b=jcmtIayrfFWPBrkN05iqPOTRw75xiVnleJsyg3HYmXprmixt382UDePfEWtN8xxOuv
         L8oQaiwzJpXwl8kErumbUMM7SvPUGQpey2YAxciqz7+ZXIvedBxFJyhTVfdzZ5EhBf5w
         c7XR4ftbYvQhwzakzw4uzU+2urwn5BqMULiNWG1/iWK0waWLBK0KzS7fbbg2iqx+AVy+
         FCsdBtGxitvSLGkIeA32UZ0eGH9TDsYUUACZFESKOkh4pShD2Wu8zKrbIlt/lx1ablbK
         3qU+uoCJNIsf7SXerhZu1e0dVB7O3o1IVWpAqGgwy6k5hDMjXKTJopo9V7Qw5EuZchP3
         8Yag==
X-Gm-Message-State: AA+aEWYXdxFrrsxvOBQzbV+rwqGsUwlzSBRhEeDB0XSFQdgs/Wh6SjG+
        s0kzUsFx4CQpnFGQmFHsYKGFisCCBqw=
X-Google-Smtp-Source: AFSGD/UanxJGubg60EKloM1vLScfwX9mjtgy9ohYP7owApacj6XWXbJ24ZA2ld7ftm7PzSyuYGNjfw==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr31903721wrp.242.1543444470256;
        Wed, 28 Nov 2018 14:34:30 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.239])
        by smtp.gmail.com with ESMTPSA id g198sm180244wmd.23.2018.11.28.14.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:29 -0800 (PST)
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
Subject: [PATCH v5 11/17] pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)
Date:   Thu, 29 Nov 2018 01:33:21 +0300
Message-Id: <0945dd99f857dd6cc48fda7da27c08095b1074ed.1543443475.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543443475.git.mesihkilinc@gmail.com>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suniv F1C100s chip (several new F-series SoCs) of Allwinner has a
pin
controller like other SoCs from Allwinner.

Add support for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Patch applied to the pin control tree for v4.21.
---
 drivers/pinctrl/sunxi/Kconfig                 |   4 +
 drivers/pinctrl/sunxi/Makefile                |   1 +
 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c | 416 ++++++++++++++++++++++++++
 3 files changed, 421 insertions(+)
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
index 0000000..2801ca7
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
@@ -0,0 +1,416 @@
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

