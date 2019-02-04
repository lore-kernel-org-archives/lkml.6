Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F32C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC95A2147A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="F/EZWYl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfBDJNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:13:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37073 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfBDJNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:13:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so12485463wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 01:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3UarI4+3W7mnMe4XUlsYu1e+5Y7QEWwmpbhYQfY/fuY=;
        b=F/EZWYl4NVTlc9AFWCj+7+uToXz1gI/nz3s4gbzVPZ+ZTDCjlZRTjHcgauy89ZOlaC
         vJOOLbQ+h2RsSt2H7seiEQp42f0BqjZrYlosK72tnddbS4b5PdeA6iGJExYWRRLH79IK
         h0BRKONM4s9EVdNVyXNezoCkfWA7ueZl4/tSx9CJWEutS6K9+LIXSpJ8xul1BGq24zkx
         23bxt7PB9a0ruYrQLzbLYqblN97QlqVS5hGGJmRMl2MuXdI9mVkuN4603Ze9p/nATe/z
         FtQJjVaxinrx7EC1vvfzk4QNLcLoKTGimAZrL1U1G84ytbLgrzUf+JDTSFrYKfyMIPZS
         QO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3UarI4+3W7mnMe4XUlsYu1e+5Y7QEWwmpbhYQfY/fuY=;
        b=or2PWQHM6iBjzL6QUngjdOKmQAGGFzzJhG9tx7/4KaqWsOC1ea88h9q5m0esi9fnII
         Ol5Ge8u5Spsf35ntkbTwxbc8c7AAA7Nk6r+24ZnX/kl+LiHhK8+krBhvkzBm5P7yEgav
         GJZpw/xTwa1Vsalkz+gcbAe4yh4GBjp1ANjr2J89kNsT9EJEAynFHUW4c07xuRRMy6CB
         Jb/R+DjOyyXoPQNoGzG1FldJZ4VLONpEuUaF+LduvyaUQKtDxrO7ItwwxZB7Trb+WBBZ
         y1uFXJodMRIc5a6wbVBKdEZ8ML0+Fan2wS7swk9Rj7SfJ1qgJdR8+CT5dinpeWXLdNC7
         Fu6g==
X-Gm-Message-State: AHQUAuZwqh4SDjZcmgqxKy25JqfGVMN0Jl1XWlxf4Dy114q+ECpAgrlY
        YHgreoLkDZPd2eslkCCYTJNOAA==
X-Google-Smtp-Source: AHgI3IZAccSzhVXDnohjF17hqiFlLMg02NtGY7Yukq8xNScoFub47LYt3Y+x9MSeHcVcjxV80ZSPqg==
X-Received: by 2002:a7b:c08f:: with SMTP id r15mr12751908wmh.118.1549271616569;
        Mon, 04 Feb 2019 01:13:36 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m21sm9371390wmi.43.2019.02.04.01.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Feb 2019 01:13:35 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: meson: Add G12A AO Clock + Reset Controller
Date:   Mon,  4 Feb 2019 10:13:30 +0100
Message-Id: <20190204091331.9298-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204091331.9298-1-narmstrong@baylibre.com>
References: <20190204091331.9298-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Amlogic G12A AO Clock and Reset controller driver handling
generation of Always-On clocks :
- AO Clocks and Reset for Always-On modules
- 32K Generation for USB and CEC
- SAR ADC controller clock

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig      |   2 +
 drivers/clk/meson/Makefile     |   2 +-
 drivers/clk/meson/g12a-aoclk.c | 448 +++++++++++++++++++++++++++++++++
 drivers/clk/meson/g12a-aoclk.h |  15 ++
 4 files changed, 466 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/g12a-aoclk.c
 create mode 100644 drivers/clk/meson/g12a-aoclk.h

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index b72439315340..3858747f5438 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -98,8 +98,10 @@ config COMMON_CLK_G12A
 	bool
 	depends on ARCH_MESON
 	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_DUALDIV
 	select COMMON_CLK_MESON_MPLL
 	select COMMON_CLK_MESON_PLL
+	select COMMON_CLK_MESON_AO_CLKC
 	select COMMON_CLK_MESON_EE_CLKC
 	select MFD_SYSCON
 	help
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 32d17f18541e..021fc290e749 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -16,5 +16,5 @@ obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
 obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
 obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
 obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
-obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o
+obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
diff --git a/drivers/clk/meson/g12a-aoclk.c b/drivers/clk/meson/g12a-aoclk.c
new file mode 100644
index 000000000000..3398cae86b45
--- /dev/null
+++ b/drivers/clk/meson/g12a-aoclk.c
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Amlogic Meson-AXG Clock Controller Driver
+ *
+ * Copyright (c) 2016 Baylibre SAS.
+ * Author: Michael Turquette <mturquette@baylibre.com>
+ *
+ * Copyright (c) 2019 Baylibre SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/mfd/syscon.h>
+#include "meson-aoclk.h"
+#include "g12a-aoclk.h"
+
+#include "clk-regmap.h"
+#include "clk-dualdiv.h"
+
+#define IN_PREFIX "ao-in-"
+
+/*
+ * AO Configuration Clock registers offsets
+ * Register offsets from the data sheet must be multiplied by 4.
+ */
+#define AO_RTI_STATUS_REG3	0x0C
+#define AO_RTI_PWR_CNTL_REG0	0x10
+#define AO_RTI_GEN_CNTL_REG0	0x40
+#define AO_CLK_GATE0		0x4c
+#define AO_CLK_GATE0_SP		0x50
+#define AO_OSCIN_CNTL		0x58
+#define AO_CEC_CLK_CNTL_REG0	0x74
+#define AO_CEC_CLK_CNTL_REG1	0x78
+#define AO_SAR_CLK		0x90
+#define AO_RTC_ALT_CLK_CNTL0	0x94
+#define AO_RTC_ALT_CLK_CNTL1	0x98
+
+#define AXG_AO_GATE(_name, _reg, _bit)					\
+static struct clk_regmap g12a_aoclk_##_name = {				\
+	.data = &(struct clk_regmap_gate_data) {			\
+		.offset = (_reg),					\
+		.bit_idx = (_bit),					\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name =  "g12a_ao_" #_name,				\
+		.ops = &clk_regmap_gate_ops,				\
+		.parent_names = (const char *[]){ IN_PREFIX "mpeg-clk" }, \
+		.num_parents = 1,					\
+		.flags = CLK_IGNORE_UNUSED,				\
+	},								\
+}
+
+AXG_AO_GATE(ahb, AO_CLK_GATE0, 0);
+AXG_AO_GATE(ir_in, AO_CLK_GATE0, 1);
+AXG_AO_GATE(i2c_m0, AO_CLK_GATE0, 2);
+AXG_AO_GATE(i2c_s0, AO_CLK_GATE0, 3);
+AXG_AO_GATE(uart, AO_CLK_GATE0, 4);
+AXG_AO_GATE(prod_i2c, AO_CLK_GATE0, 5);
+AXG_AO_GATE(uart2, AO_CLK_GATE0, 6);
+AXG_AO_GATE(ir_out, AO_CLK_GATE0, 7);
+AXG_AO_GATE(saradc, AO_CLK_GATE0, 8);
+AXG_AO_GATE(mailbox, AO_CLK_GATE0_SP, 0);
+AXG_AO_GATE(m3, AO_CLK_GATE0_SP, 1);
+AXG_AO_GATE(ahb_sram, AO_CLK_GATE0_SP, 2);
+AXG_AO_GATE(rti, AO_CLK_GATE0_SP, 3);
+AXG_AO_GATE(m4_fclk, AO_CLK_GATE0_SP, 4);
+AXG_AO_GATE(m4_hclk, AO_CLK_GATE0_SP, 5);
+
+static struct clk_regmap g12a_aoclk_cts_oscin = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = AO_RTI_PWR_CNTL_REG0,
+		.bit_idx = 14,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_oscin",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
+		.num_parents = 1,
+	},
+};
+
+static const struct meson_clk_dualdiv_param g12a_32k_div_table[] = {
+	{
+		.dual	= 1,
+		.n1	= 733,
+		.m1	= 8,
+		.n2	= 732,
+		.m2	= 11,
+	}, {}
+};
+
+/* 32k_by_oscin clock */
+
+static struct clk_regmap g12a_aoclk_32k_by_oscin_pre = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = AO_RTC_ALT_CLK_CNTL0,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "g12a_ao_32k_by_oscin_pre",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "cts_oscin" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap g12a_aoclk_32k_by_oscin_div = {
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
+		.table = g12a_32k_div_table,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "g12a_ao_32k_by_oscin_div",
+		.ops = &meson_clk_dualdiv_ops,
+		.parent_names = (const char *[]){ "g12a_ao_32k_by_oscin_pre" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap g12a_aoclk_32k_by_oscin_sel = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = AO_RTC_ALT_CLK_CNTL1,
+		.mask = 0x1,
+		.shift = 24,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "g12a_ao_32k_by_oscin_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "g12a_ao_32k_by_oscin_div",
+						  "g12a_ao_32k_by_oscin_pre" },
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap g12a_aoclk_32k_by_oscin = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = AO_RTC_ALT_CLK_CNTL0,
+		.bit_idx = 30,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "g12a_ao_32k_by_oscin",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "g12a_ao_32k_by_oscin_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+/* cec clock */
+
+static struct clk_regmap g12a_aoclk_cec_pre = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = AO_CEC_CLK_CNTL_REG0,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "g12a_ao_cec_pre",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "cts_oscin" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap g12a_aoclk_cec_div = {
+	.data = &(struct meson_clk_dualdiv_data){
+		.n1 = {
+			.reg_off = AO_CEC_CLK_CNTL_REG0,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.n2 = {
+			.reg_off = AO_CEC_CLK_CNTL_REG0,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.m1 = {
+			.reg_off = AO_CEC_CLK_CNTL_REG1,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.m2 = {
+			.reg_off = AO_CEC_CLK_CNTL_REG1,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.dual = {
+			.reg_off = AO_CEC_CLK_CNTL_REG0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.table = g12a_32k_div_table,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "g12a_ao_cec_div",
+		.ops = &meson_clk_dualdiv_ops,
+		.parent_names = (const char *[]){ "g12a_ao_cec_pre" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap g12a_aoclk_cec_sel = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = AO_CEC_CLK_CNTL_REG1,
+		.mask = 0x1,
+		.shift = 24,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "g12a_ao_cec_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "g12a_ao_cec_div",
+						  "g12a_ao_cec_pre" },
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap g12a_aoclk_cec = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = AO_CEC_CLK_CNTL_REG0,
+		.bit_idx = 30,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "g12a_ao_cec",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "g12a_ao_cec_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap g12a_aoclk_cts_rtc_oscin = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = AO_RTI_PWR_CNTL_REG0,
+		.mask = 0x1,
+		.shift = 10,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "g12a_ao_cts_rtc_oscin",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "g12a_ao_32k_by_oscin",
+						  IN_PREFIX "ext_32k-0" },
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap g12a_aoclk_clk81 = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = AO_RTI_PWR_CNTL_REG0,
+		.mask = 0x1,
+		.shift = 8,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "g12a_ao_clk81",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ IN_PREFIX "mpeg-clk",
+						  "g12a_ao_cts_rtc_oscin"},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap g12a_aoclk_saradc_mux = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = AO_SAR_CLK,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "g12a_ao_saradc_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ IN_PREFIX "xtal",
+						  "g12a_ao_clk81" },
+		.num_parents = 2,
+	},
+};
+
+static struct clk_regmap g12a_aoclk_saradc_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = AO_SAR_CLK,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "g12a_ao_saradc_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "g12a_ao_saradc_mux" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap g12a_aoclk_saradc_gate = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = AO_SAR_CLK,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "g12a_ao_saradc_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "g12a_ao_saradc_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const unsigned int g12a_aoclk_reset[] = {
+	[RESET_AO_IR_IN]	= 16,
+	[RESET_AO_UART]		= 17,
+	[RESET_AO_I2C_M]	= 18,
+	[RESET_AO_I2C_S]	= 19,
+	[RESET_AO_SAR_ADC]	= 20,
+	[RESET_AO_UART2]	= 22,
+	[RESET_AO_IR_OUT]	= 23,
+};
+
+static struct clk_regmap *g12a_aoclk_regmap[] = {
+	&g12a_aoclk_ahb,
+	&g12a_aoclk_ir_in,
+	&g12a_aoclk_i2c_m0,
+	&g12a_aoclk_i2c_s0,
+	&g12a_aoclk_uart,
+	&g12a_aoclk_prod_i2c,
+	&g12a_aoclk_uart2,
+	&g12a_aoclk_ir_out,
+	&g12a_aoclk_saradc,
+	&g12a_aoclk_mailbox,
+	&g12a_aoclk_m3,
+	&g12a_aoclk_ahb_sram,
+	&g12a_aoclk_rti,
+	&g12a_aoclk_m4_fclk,
+	&g12a_aoclk_m4_hclk,
+	&g12a_aoclk_cts_oscin,
+	&g12a_aoclk_32k_by_oscin_pre,
+	&g12a_aoclk_32k_by_oscin_div,
+	&g12a_aoclk_32k_by_oscin_sel,
+	&g12a_aoclk_32k_by_oscin,
+	&g12a_aoclk_cec_pre,
+	&g12a_aoclk_cec_div,
+	&g12a_aoclk_cec_sel,
+	&g12a_aoclk_cec,
+	&g12a_aoclk_cts_rtc_oscin,
+	&g12a_aoclk_clk81,
+	&g12a_aoclk_saradc_mux,
+	&g12a_aoclk_saradc_div,
+	&g12a_aoclk_saradc_gate,
+};
+
+static const struct clk_hw_onecell_data g12a_aoclk_onecell_data = {
+	.hws = {
+		[CLKID_AO_AHB]		= &g12a_aoclk_ahb.hw,
+		[CLKID_AO_IR_IN]	= &g12a_aoclk_ir_in.hw,
+		[CLKID_AO_I2C_M0]	= &g12a_aoclk_i2c_m0.hw,
+		[CLKID_AO_I2C_S0]	= &g12a_aoclk_i2c_s0.hw,
+		[CLKID_AO_UART]		= &g12a_aoclk_uart.hw,
+		[CLKID_AO_PROD_I2C]	= &g12a_aoclk_prod_i2c.hw,
+		[CLKID_AO_UART2]	= &g12a_aoclk_uart2.hw,
+		[CLKID_AO_IR_OUT]	= &g12a_aoclk_ir_out.hw,
+		[CLKID_AO_SAR_ADC]	= &g12a_aoclk_saradc.hw,
+		[CLKID_AO_MAILBOX]	= &g12a_aoclk_mailbox.hw,
+		[CLKID_AO_M3]		= &g12a_aoclk_m3.hw,
+		[CLKID_AO_AHB_SRAM]	= &g12a_aoclk_ahb_sram.hw,
+		[CLKID_AO_RTI]		= &g12a_aoclk_rti.hw,
+		[CLKID_AO_M4_FCLK]	= &g12a_aoclk_m4_fclk.hw,
+		[CLKID_AO_M4_HCLK]	= &g12a_aoclk_m4_hclk.hw,
+		[CLKID_AO_CLK81]	= &g12a_aoclk_clk81.hw,
+		[CLKID_AO_SAR_ADC_SEL]	= &g12a_aoclk_saradc_mux.hw,
+		[CLKID_AO_SAR_ADC_DIV]	= &g12a_aoclk_saradc_div.hw,
+		[CLKID_AO_SAR_ADC_CLK]	= &g12a_aoclk_saradc_gate.hw,
+		[CLKID_AO_CTS_OSCIN]	= &g12a_aoclk_cts_oscin.hw,
+		[CLKID_AO_32K_PRE]	= &g12a_aoclk_32k_by_oscin_pre.hw,
+		[CLKID_AO_32K_DIV]	= &g12a_aoclk_32k_by_oscin_div.hw,
+		[CLKID_AO_32K_SEL]	= &g12a_aoclk_32k_by_oscin_sel.hw,
+		[CLKID_AO_32K]		= &g12a_aoclk_32k_by_oscin.hw,
+		[CLKID_AO_CEC_PRE]	= &g12a_aoclk_cec_pre.hw,
+		[CLKID_AO_CEC_DIV]	= &g12a_aoclk_cec_div.hw,
+		[CLKID_AO_CEC_SEL]	= &g12a_aoclk_cec_sel.hw,
+		[CLKID_AO_CEC]		= &g12a_aoclk_cec.hw,
+		[CLKID_AO_CTS_RTC_OSCIN] = &g12a_aoclk_cts_rtc_oscin.hw,
+	},
+	.num = NR_CLKS,
+};
+
+static const struct meson_aoclk_input g12a_aoclk_inputs[] = {
+	{ .name = "xtal",	.required = true  },
+	{ .name = "mpeg-clk",	.required = true  },
+	{ .name = "ext-32k-0",	.required = false },
+};
+
+static const struct meson_aoclk_data g12a_aoclkc_data = {
+	.reset_reg	= AO_RTI_GEN_CNTL_REG0,
+	.num_reset	= ARRAY_SIZE(g12a_aoclk_reset),
+	.reset		= g12a_aoclk_reset,
+	.num_clks	= ARRAY_SIZE(g12a_aoclk_regmap),
+	.clks		= g12a_aoclk_regmap,
+	.hw_data	= &g12a_aoclk_onecell_data,
+	.inputs		= g12a_aoclk_inputs,
+	.num_inputs	= ARRAY_SIZE(g12a_aoclk_inputs),
+	.input_prefix	= IN_PREFIX,
+};
+
+static const struct of_device_id g12a_aoclkc_match_table[] = {
+	{
+		.compatible	= "amlogic,meson-g12a-aoclkc",
+		.data		= &g12a_aoclkc_data,
+	},
+	{ }
+};
+
+static struct platform_driver g12a_aoclkc_driver = {
+	.probe		= meson_aoclkc_probe,
+	.driver		= {
+		.name	= "g12a-aoclkc",
+		.of_match_table = g12a_aoclkc_match_table,
+	},
+};
+
+builtin_platform_driver(g12a_aoclkc_driver);
diff --git a/drivers/clk/meson/g12a-aoclk.h b/drivers/clk/meson/g12a-aoclk.h
new file mode 100644
index 000000000000..9ebfa25688eb
--- /dev/null
+++ b/drivers/clk/meson/g12a-aoclk.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#ifndef __G12A_AOCLKC_H
+#define __G12A_AOCLKC_H
+
+#define NR_CLKS	29
+
+#include <dt-bindings/clock/g12a-aoclkc.h>
+#include <dt-bindings/reset/g12a-aoclkc.h>
+
+#endif /* __G12A_AOCLKC_H */
-- 
2.20.1

