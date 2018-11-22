Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEC4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7C920659
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Q2DJps37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7C920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407522AbeKWIVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:21:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51814 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407528AbeKWIVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:21:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id j207so3084118wmj.1;
        Thu, 22 Nov 2018 13:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rGh4QbPuYTPW3FvrsH804kl5tNx9LwtHRU+kr/q7GIM=;
        b=Q2DJps37hy7WjoEErW0XJcf4iIzGRl2uAaCE4v7UaJm/nvgLNDDR/0lgKhFNh1aG1N
         PrqRt27Ni8HT09GMoqv2cwXTERMTABvfC5gOBXVmXGr6aoIKWWd/ByF1EEQrBBtvjYbX
         rmC6miBQRwDbDHrsLbFY9SPj6l9rDBfvSly9vNQB4DiTU4C9IeuOpqzQju/RKYNQxBX4
         4TIoXlxkhoiUFcVMi3Ozi2ckUpX8wTOw+00k5dkJ4mGKnR0ctNrlbo/UsP4uFzB+pXip
         VDgTNlcKKkSCeaLOfCWhVt2D59qIfx4hanY/QgsAtRwWI+Y7VbVpSJ6mumqYhUP3B972
         Zx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rGh4QbPuYTPW3FvrsH804kl5tNx9LwtHRU+kr/q7GIM=;
        b=tDlTqIyEZDeypMuTZ4jv/UXrpiSRcuy85v/DBxw5BpAaoIC1GdhzKRGO1MRTEB4KGE
         iHB7SVDcpGRTbOMhvcN6ShM+kyCj8uZXDvGzPRFkbgumn2GQOb2oSfFpjjULvrOLmhDR
         OQnGobYBcLFgG6rkdVUoW+eRsO7zqtPltiR3Dkt5uOylWy3f49f0rLi5Qj/RoL6+ZIhC
         XKzpKmJ0BAjoP2YVfnboeSy7a5h9LtdPN/c04R2zMje9HAcIUot1Mx4xmmlBWU7VW4vp
         W1W/8Lbcn02EpsGnY+I/DDPgWnL9qS3UgBIHNGFj55/QHAydncUfehkoL5hxfm90qqC7
         q+nw==
X-Gm-Message-State: AA+aEWZ1l0+HUCycEAgQNeK9em47MCjff00FicozDi1F74CP764WzzzY
        O53smX6p3kLq+2niD8w9ZB4=
X-Google-Smtp-Source: AFSGD/VTQom2P9O2sne/gr/qWzCRne8tewG5H328nWR+8TbCKI7D2JqiIvBu05t7p7dTrVfTXXCT4g==
X-Received: by 2002:a1c:2807:: with SMTP id o7-v6mr10885369wmo.138.1542922829606;
        Thu, 22 Nov 2018 13:40:29 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD732F5007DE18DA1F72FF8D9.dip0.t-ipconnect.de. [2003:dc:d732:f500:7de1:8da1:f72f:f8d9])
        by smtp.googlemail.com with ESMTPSA id x14sm29755554wrm.65.2018.11.22.13.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 13:40:29 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 4/4] clk: meson: meson8b: add the CPU clock post divider clocks
Date:   Thu, 22 Nov 2018 22:40:17 +0100
Message-Id: <20181122214017.25643-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
References: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are four CPU clock post dividers:
- ABP
- PERIPH (used for the ARM global timer and ARM TWD timer)
- AXI
- L2 DRAM

Each of these clocks consists of two clocks:
- a mux to select between "cpu_clk" divided by 2, 3, 4, 5, 6, 7 or 8
- a "_clk_dis" gate. The public S805 datasheet states that this should
  be set to 1 to disable the clock, the default value is 0. There is
  also a hint that these are "just in case" bits which only exist in
  case the corresponding mux implementation does not allow glitch-free
  parent changes (the muxes are designed in a way that the clock can
  stay enabled when changing the mux). It's still good practise to
  describe this clock even if we're not supposed to modify it. Thus
  this uses the read-only gate ops.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson8b.c | 244 ++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/meson8b.h |  13 +-
 2 files changed, 256 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 010dccc86b5d..f906a9f0eefd 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -704,6 +704,227 @@ static struct clk_regmap meson8b_nand_clk_gate = {
 	},
 };
 
+static struct clk_fixed_factor meson8b_cpu_clk_div2 = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_div2",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "cpu_clk" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor meson8b_cpu_clk_div3 = {
+	.mult = 1,
+	.div = 3,
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_div3",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "cpu_clk" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor meson8b_cpu_clk_div4 = {
+	.mult = 1,
+	.div = 4,
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_div4",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "cpu_clk" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor meson8b_cpu_clk_div5 = {
+	.mult = 1,
+	.div = 5,
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_div5",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "cpu_clk" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor meson8b_cpu_clk_div6 = {
+	.mult = 1,
+	.div = 6,
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_div6",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "cpu_clk" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor meson8b_cpu_clk_div7 = {
+	.mult = 1,
+	.div = 7,
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_div7",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "cpu_clk" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor meson8b_cpu_clk_div8 = {
+	.mult = 1,
+	.div = 8,
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_div8",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "cpu_clk" },
+		.num_parents = 1,
+	},
+};
+
+static u32 mux_table_abp[] = { 1, 2, 3, 4, 5, 6, 7 };
+static struct clk_regmap meson8b_abp_clk_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.mask = 0x7,
+		.shift = 3,
+		.table = mux_table_abp,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "abp_clk_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "cpu_clk_div2",
+						  "cpu_clk_div3",
+						  "cpu_clk_div4",
+						  "cpu_clk_div5",
+						  "cpu_clk_div6",
+						  "cpu_clk_div7",
+						  "cpu_clk_div8", },
+		.num_parents = 7,
+	},
+};
+
+static struct clk_regmap meson8b_abp_clk_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.bit_idx = 16,
+		.flags = CLK_GATE_SET_TO_DISABLE,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "abp_clk_dis",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "abp_clk_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_periph_clk_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.mask = 0x7,
+		.shift = 6,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "periph_clk_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "cpu_clk_div2",
+						  "cpu_clk_div3",
+						  "cpu_clk_div4",
+						  "cpu_clk_div5",
+						  "cpu_clk_div6",
+						  "cpu_clk_div7",
+						  "cpu_clk_div8", },
+		.num_parents = 7,
+	},
+};
+
+static struct clk_regmap meson8b_periph_clk_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.bit_idx = 17,
+		.flags = CLK_GATE_SET_TO_DISABLE,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "periph_clk_dis",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "periph_clk_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static u32 mux_table_axi[] = { 1, 2, 3, 4, 5, 6, 7 };
+static struct clk_regmap meson8b_axi_clk_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.mask = 0x7,
+		.shift = 9,
+		.table = mux_table_axi,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "axi_clk_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "cpu_clk_div2",
+						  "cpu_clk_div3",
+						  "cpu_clk_div4",
+						  "cpu_clk_div5",
+						  "cpu_clk_div6",
+						  "cpu_clk_div7",
+						  "cpu_clk_div8", },
+		.num_parents = 7,
+	},
+};
+
+static struct clk_regmap meson8b_axi_clk_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.bit_idx = 18,
+		.flags = CLK_GATE_SET_TO_DISABLE,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "axi_clk_dis",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "axi_clk_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_l2_dram_clk_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.mask = 0x7,
+		.shift = 12,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "l2_dram_clk_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "cpu_clk_div2",
+						  "cpu_clk_div3",
+						  "cpu_clk_div4",
+						  "cpu_clk_div5",
+						  "cpu_clk_div6",
+						  "cpu_clk_div7",
+						  "cpu_clk_div8", },
+		.num_parents = 7,
+	},
+};
+
+static struct clk_regmap meson8b_l2_dram_clk_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.bit_idx = 19,
+		.flags = CLK_GATE_SET_TO_DISABLE,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "l2_dram_clk_dis",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "l2_dram_clk_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 /* Everything Else (EE) domain gates */
 
 static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
@@ -905,6 +1126,21 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_PLL_FIXED_DCO]	    = &meson8b_fixed_pll_dco.hw,
 		[CLKID_PLL_VID_DCO]	    = &meson8b_vid_pll_dco.hw,
 		[CLKID_PLL_SYS_DCO]	    = &meson8b_sys_pll_dco.hw,
+		[CLKID_CPU_CLK_DIV2]	    = &meson8b_cpu_clk_div2.hw,
+		[CLKID_CPU_CLK_DIV3]	    = &meson8b_cpu_clk_div3.hw,
+		[CLKID_CPU_CLK_DIV4]	    = &meson8b_cpu_clk_div4.hw,
+		[CLKID_CPU_CLK_DIV5]	    = &meson8b_cpu_clk_div5.hw,
+		[CLKID_CPU_CLK_DIV6]	    = &meson8b_cpu_clk_div6.hw,
+		[CLKID_CPU_CLK_DIV7]	    = &meson8b_cpu_clk_div7.hw,
+		[CLKID_CPU_CLK_DIV8]	    = &meson8b_cpu_clk_div8.hw,
+		[CLKID_ABP_SEL]		    = &meson8b_abp_clk_sel.hw,
+		[CLKID_ABP]		    = &meson8b_abp_clk_gate.hw,
+		[CLKID_PERIPH_SEL]	    = &meson8b_periph_clk_sel.hw,
+		[CLKID_PERIPH]		    = &meson8b_periph_clk_gate.hw,
+		[CLKID_AXI_SEL]		    = &meson8b_axi_clk_sel.hw,
+		[CLKID_AXI]		    = &meson8b_axi_clk_gate.hw,
+		[CLKID_L2_DRAM_SEL]	    = &meson8b_l2_dram_clk_sel.hw,
+		[CLKID_L2_DRAM]		    = &meson8b_l2_dram_clk_gate.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -1016,6 +1252,14 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_fixed_pll_dco,
 	&meson8b_vid_pll_dco,
 	&meson8b_sys_pll_dco,
+	&meson8b_abp_clk_sel,
+	&meson8b_abp_clk_gate,
+	&meson8b_periph_clk_sel,
+	&meson8b_periph_clk_gate,
+	&meson8b_axi_clk_sel,
+	&meson8b_axi_clk_gate,
+	&meson8b_l2_dram_clk_sel,
+	&meson8b_l2_dram_clk_gate,
 };
 
 static const struct meson8b_clk_reset_line {
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index 9cba34c6cb92..0abb331162ab 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -78,8 +78,19 @@
 #define CLKID_PLL_FIXED_DCO	113
 #define CLKID_PLL_VID_DCO	114
 #define CLKID_PLL_SYS_DCO	115
+#define CLKID_CPU_CLK_DIV2	116
+#define CLKID_CPU_CLK_DIV3	117
+#define CLKID_CPU_CLK_DIV4	118
+#define CLKID_CPU_CLK_DIV5	119
+#define CLKID_CPU_CLK_DIV6	120
+#define CLKID_CPU_CLK_DIV7	121
+#define CLKID_CPU_CLK_DIV8	122
+#define CLKID_ABP_SEL		123
+#define CLKID_PERIPH_SEL	125
+#define CLKID_AXI_SEL		127
+#define CLKID_L2_DRAM_SEL	129
 
-#define CLK_NR_CLKS		116
+#define CLK_NR_CLKS		131
 
 /*
  * include the CLKID and RESETID that have
-- 
2.19.1

