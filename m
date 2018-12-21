Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3757EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D5C21928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jNZ6w6hk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbeLUQDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:03:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34689 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388060AbeLUQC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:02:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so14537781wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 08:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zzbm13PIonVfBVmeY6obszSgV2a/9581FnWBBbtOFLc=;
        b=jNZ6w6hkm+oei4av6eSl2KsaPY58pjfpG87YY97wtzz3HnJFGzJX7OOZwQ4m1SDUDa
         ypHBmcKa8JRvr/gPKNlPSxmTyIhHsl3eS3g0Xm9bSyQhT4nVf8wEMptfRXCUFO88MO1Z
         nnJUWtIiobDI2NcdC7IKyZBT3NAMtmq3eZcqm+ch7zZKR7BFy94eEMghWkPgi0RXnqkE
         lnAskn9/an8bXQ52lfKAe+MamurRinnRcNMSrKkPM6UduNb/9edWQlZ2BmQvNAftmmN/
         PcwaUdLuJ0fXZpsCHWHR+QSkiNBGTMRhTL7ylvxZ0BgU762cOr1/fyeev3yrB/ucCNCQ
         +ZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzbm13PIonVfBVmeY6obszSgV2a/9581FnWBBbtOFLc=;
        b=iqaH6vS//BSzvefNbkzt1l8w9r9j3bxaAPE0QKTA2Wewc5zQphVTK1FUdDdrDC+kuV
         ep+IsikL4kG5iTmmf5Sfs0T7nEVrDwqBQmo3jQUYPlwKJp/iG77//ThKjwaAUxhXT3m1
         bI2Uu6jT2oXG/TNe6xzSSBOHAlb/8aWdQaGe3xmuEcrJekWY7AtOlUuDpABvheF9noSW
         g83cYtGyCdA2p/JUWJeTd7oYBqawpVrnT0019pIzKeFu1NB3jfXYxdg8L2Kx+nR5bD8+
         0dGjGJJH7rT2G/+Y25j0ilnLREJni7MiF8LSAFsrwpaM91f5vKltRlHxmwQL23t05CXh
         3FKg==
X-Gm-Message-State: AA+aEWa/4OZ/RNU4hi/bHpgQZK+6E2jJ96xjOhlvLaCcwW3Pjo3avczI
        oKgtVgImjp/Keto9g9boI+Ul28E59rA=
X-Google-Smtp-Source: ALg8bN4E/Vq7nOco/p48AJJN8JMt6H1cx9gHRbWrdR7U9isg1NHapaQ1o6y1Kp13BGehVWg7j86gXw==
X-Received: by 2002:a1c:5dd1:: with SMTP id r200mr3487899wmb.93.1545408178072;
        Fri, 21 Dec 2018 08:02:58 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y138sm13044021wmc.16.2018.12.21.08.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 08:02:57 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 5/5] clk: meson: axg-ao: add 32k generation subtree
Date:   Fri, 21 Dec 2018 17:02:39 +0100
Message-Id: <20181221160239.26265-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221160239.26265-1-jbrunet@baylibre.com>
References: <20181221160239.26265-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock subtree generating the 32k clock in amlogic axg ao block.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-aoclk.c | 175 +++++++++++++++++++++++++++++++---
 drivers/clk/meson/axg-aoclk.h |  13 +--
 2 files changed, 163 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
index 29e088542387..5f518be144ce 100644
--- a/drivers/clk/meson/axg-aoclk.c
+++ b/drivers/clk/meson/axg-aoclk.c
@@ -12,10 +12,23 @@
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/mfd/syscon.h>
-#include "clk-regmap.h"
+#include "clkc.h"
 #include "meson-aoclk.h"
 #include "axg-aoclk.h"
 
+/*
+ * AO Configuration Clock registers offsets
+ * Register offsets from the data sheet must be multiplied by 4.
+ */
+#define AO_RTI_PWR_CNTL_REG1	0x0C
+#define AO_RTI_PWR_CNTL_REG0	0x10
+#define AO_RTI_GEN_CNTL_REG0	0x40
+#define AO_OSCIN_CNTL		0x58
+#define AO_CRT_CLK_CNTL1	0x68
+#define AO_SAR_CLK		0x90
+#define AO_RTC_ALT_CLK_CNTL0	0x94
+#define AO_RTC_ALT_CLK_CNTL1	0x98
+
 #define AXG_AO_GATE(_name, _bit)					\
 static struct clk_regmap axg_aoclk_##_name = {				\
 	.data = &(struct clk_regmap_gate_data) {			\
@@ -39,17 +52,141 @@ AXG_AO_GATE(uart2, 5);
 AXG_AO_GATE(ir_blaster, 6);
 AXG_AO_GATE(saradc, 7);
 
+static struct clk_regmap axg_aoclk_cts_oscin = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = AO_RTI_PWR_CNTL_REG0,
+		.bit_idx = 14,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_oscin",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "xtal" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap axg_aoclk_32k_pre = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = AO_RTC_ALT_CLK_CNTL0,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "axg_ao_32k_pre",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "cts_oscin" },
+		.num_parents = 1,
+	},
+};
+
+static const struct meson_clk_dualdiv_param axg_32k_div_table[] = {
+	{
+		.dual	= 1,
+		.n1	= 733,
+		.m1	= 8,
+		.n2	= 732,
+		.m2	= 11,
+	}, {}
+};
+
+static struct clk_regmap axg_aoclk_32k_div = {
+	.data = &(struct meson_clk_dualdiv_data){
+		.n1 = {
+			.reg_off = AO_RTC_ALT_CLK_CNTL0,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.n2 = {
+			.reg_off = AO_RTC_ALT_CLK_CNTL0,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.m1 = {
+			.reg_off = AO_RTC_ALT_CLK_CNTL1,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.m2 = {
+			.reg_off = AO_RTC_ALT_CLK_CNTL1,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.dual = {
+			.reg_off = AO_RTC_ALT_CLK_CNTL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.table = axg_32k_div_table,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "axg_ao_32k_div",
+		.ops = &meson_clk_dualdiv_ops,
+		.parent_names = (const char *[]){ "axg_ao_32k_pre" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap axg_aoclk_32k_sel = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = AO_RTC_ALT_CLK_CNTL1,
+		.mask = 0x1,
+		.shift = 24,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "axg_ao_32k_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "axg_ao_32k_div",
+						  "axg_ao_32k_pre" },
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap axg_aoclk_32k = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = AO_RTC_ALT_CLK_CNTL0,
+		.bit_idx = 30,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "axg_ao_32k",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "axg_ao_32k_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap axg_aoclk_cts_rtc_oscin = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = AO_RTI_PWR_CNTL_REG0,
+		.mask = 0x1,
+		.shift = 10,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "axg_ao_cts_rtc_oscin",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "axg_ao_32k",
+						  "axg_ext_32k" },
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 static struct clk_regmap axg_aoclk_clk81 = {
 	.data = &(struct clk_regmap_mux_data) {
 		.offset = AO_RTI_PWR_CNTL_REG0,
 		.mask = 0x1,
 		.shift = 8,
+		.flags = CLK_MUX_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "axg_ao_clk81",
 		.ops = &clk_regmap_mux_ro_ops,
-		.parent_names = (const char *[]){ "clk81", "ao_alt_xtal"},
+		.parent_names = (const char *[]){ "clk81",
+						  "axg_ao_cts_rtc_oscin"},
 		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -106,17 +243,23 @@ static const unsigned int axg_aoclk_reset[] = {
 };
 
 static struct clk_regmap *axg_aoclk_regmap[] = {
-	[CLKID_AO_REMOTE]	= &axg_aoclk_remote,
-	[CLKID_AO_I2C_MASTER]	= &axg_aoclk_i2c_master,
-	[CLKID_AO_I2C_SLAVE]	= &axg_aoclk_i2c_slave,
-	[CLKID_AO_UART1]	= &axg_aoclk_uart1,
-	[CLKID_AO_UART2]	= &axg_aoclk_uart2,
-	[CLKID_AO_IR_BLASTER]	= &axg_aoclk_ir_blaster,
-	[CLKID_AO_SAR_ADC]	= &axg_aoclk_saradc,
-	[CLKID_AO_CLK81]	= &axg_aoclk_clk81,
-	[CLKID_AO_SAR_ADC_SEL]	= &axg_aoclk_saradc_mux,
-	[CLKID_AO_SAR_ADC_DIV]	= &axg_aoclk_saradc_div,
-	[CLKID_AO_SAR_ADC_CLK]	= &axg_aoclk_saradc_gate,
+	&axg_aoclk_remote,
+	&axg_aoclk_i2c_master,
+	&axg_aoclk_i2c_slave,
+	&axg_aoclk_uart1,
+	&axg_aoclk_uart2,
+	&axg_aoclk_ir_blaster,
+	&axg_aoclk_saradc,
+	&axg_aoclk_cts_oscin,
+	&axg_aoclk_32k_pre,
+	&axg_aoclk_32k_div,
+	&axg_aoclk_32k_sel,
+	&axg_aoclk_32k,
+	&axg_aoclk_cts_rtc_oscin,
+	&axg_aoclk_clk81,
+	&axg_aoclk_saradc_mux,
+	&axg_aoclk_saradc_div,
+	&axg_aoclk_saradc_gate,
 };
 
 static const struct clk_hw_onecell_data axg_aoclk_onecell_data = {
@@ -132,6 +275,12 @@ static const struct clk_hw_onecell_data axg_aoclk_onecell_data = {
 		[CLKID_AO_SAR_ADC_SEL]	= &axg_aoclk_saradc_mux.hw,
 		[CLKID_AO_SAR_ADC_DIV]	= &axg_aoclk_saradc_div.hw,
 		[CLKID_AO_SAR_ADC_CLK]	= &axg_aoclk_saradc_gate.hw,
+		[CLKID_AO_CTS_OSCIN]	= &axg_aoclk_cts_oscin.hw,
+		[CLKID_AO_32K_PRE]	= &axg_aoclk_32k_pre.hw,
+		[CLKID_AO_32K_DIV]	= &axg_aoclk_32k_div.hw,
+		[CLKID_AO_32K_SEL]	= &axg_aoclk_32k_sel.hw,
+		[CLKID_AO_32K]		= &axg_aoclk_32k.hw,
+		[CLKID_AO_CTS_RTC_OSCIN] = &axg_aoclk_cts_rtc_oscin.hw,
 	},
 	.num = NR_CLKS,
 };
diff --git a/drivers/clk/meson/axg-aoclk.h b/drivers/clk/meson/axg-aoclk.h
index 91384d8dd844..3cc27e85170f 100644
--- a/drivers/clk/meson/axg-aoclk.h
+++ b/drivers/clk/meson/axg-aoclk.h
@@ -10,18 +10,7 @@
 #ifndef __AXG_AOCLKC_H
 #define __AXG_AOCLKC_H
 
-#define NR_CLKS	11
-/* AO Configuration Clock registers offsets
- * Register offsets from the data sheet must be multiplied by 4.
- */
-#define AO_RTI_PWR_CNTL_REG1	0x0C
-#define AO_RTI_PWR_CNTL_REG0	0x10
-#define AO_RTI_GEN_CNTL_REG0	0x40
-#define AO_OSCIN_CNTL		0x58
-#define AO_CRT_CLK_CNTL1	0x68
-#define AO_SAR_CLK		0x90
-#define AO_RTC_ALT_CLK_CNTL0	0x94
-#define AO_RTC_ALT_CLK_CNTL1	0x98
+#define NR_CLKS	17
 
 #include <dt-bindings/clock/axg-aoclkc.h>
 #include <dt-bindings/reset/axg-aoclkc.h>
-- 
2.19.2

