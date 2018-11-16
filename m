Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24FEC07E85
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE562086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FEtBTofn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE562086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeKQHHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:07:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51984 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeKQHHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:07:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id w7-v6so23278657wmc.1;
        Fri, 16 Nov 2018 12:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HFK/Uoy8jh4hhlQgTBSBYCksX5zPCDy936YhHSkAZQ0=;
        b=FEtBTofnWGsm/2THtX2oWmkLkOx/H8TRfwP0dqGnynGSIbZsxQSjJhhkyF0jKifcTx
         TVDlSGgpq5mB68qnvHkgJ1JbLjMQglTpU1vUKV5XQL7Q65sVi14FqqTMV2fJCVA8DAut
         GMxjA+WTQBs3fqbC+xUPx5YFg3DBZO7sEBvQfS5xaZH3KWHJUxWaFv7qW+1Gg9V1ySD7
         qneeQy+DRC3YFRMIMooahK0I8kqW0enJ5uv7TqmddxDonLCSzGMB8HWNuHLKCnGLer/Y
         Z7z4iGQWpfD/fVXq7O7gafhPEJLRAAMzaSJiRf4jJDhMQW5pFpjWqEXA7E0DH44laH/0
         mrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HFK/Uoy8jh4hhlQgTBSBYCksX5zPCDy936YhHSkAZQ0=;
        b=dyLBVj9Tspqu64AkRpnPNedOJfOZVRFfacp/CTnXRwe1A9Mj+zFem69VnghPFwvq3e
         ngVUdfJ3ddaBUJTuKORIWnmapeETm9Jnzw89F3OwJjlWvYoU34c5QGTuwRAxf0Yz2bgX
         7FogvouiC8mFq0SsvU2HFz2cNAdnw79xm4krXAALgZu3KkBNrQbE36lh0JH+oqVwqsaG
         M275QS6BZr3mRkLrNh77p+vdUInwV6J1onh2yyP0tRw8v8HCSL8elV+Ocjy2TDZynMRw
         M5sgpBSdLcvcx5slyMyMX1in9Rv5+09G7zAttsPYjsuL/f3YtFy5gYijP83LkcQ8jtX0
         MNBQ==
X-Gm-Message-State: AGRZ1gILj8Y/6CCStsozOIPWUSj3MQ5nLJWfOgMrCYUNJEWyjF3cURpW
        XlGSQPaAQuZ/pXiKPXTW9vc=
X-Google-Smtp-Source: AJdET5chz3YtsxvWocjToXjic1Qh1/IvpECPAxpvgWI1zG7tLBh9cZEa30yz89Qwloa523jVLI0fNA==
X-Received: by 2002:a1c:e910:: with SMTP id q16-v6mr3714287wmc.148.1542401616683;
        Fri, 16 Nov 2018 12:53:36 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A1006D214A3B023844E6.dip0.t-ipconnect.de. [2003:dc:d717:a100:6d21:4a3b:238:44e6])
        by smtp.googlemail.com with ESMTPSA id z192-v6sm16610273wmc.37.2018.11.16.12.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 12:53:36 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/3] clk: meson: meson8b: add the CPU clock post divider clocks
Date:   Fri, 16 Nov 2018 21:53:03 +0100
Message-Id: <20181116205303.6354-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116205303.6354-1-martin.blumenstingl@googlemail.com>
References: <20181116205303.6354-1-martin.blumenstingl@googlemail.com>
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
- a "_clk_dis" gate (the public S805 datasheet states that this should
  be set to 1 to disable the clock. the default value is 0. there is
  also a hint that these are "just in case" bits which is why I set
  these clocks to CLK_IS_CRITICAL).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 248 ++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/meson8b.h |  13 +-
 2 files changed, 260 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 010dccc86b5d..1b192f823bf8 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -704,6 +704,231 @@ static struct clk_regmap meson8b_nand_clk_gate = {
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
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "abp_clk_sel" },
+		.num_parents = 1,
+		.flags = (CLK_SET_RATE_PARENT |
+			  CLK_IS_CRITICAL),
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
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "periph_clk_sel" },
+		.num_parents = 1,
+		.flags = (CLK_SET_RATE_PARENT |
+			  CLK_IS_CRITICAL),
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
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "axi_clk_sel" },
+		.num_parents = 1,
+		.flags = (CLK_SET_RATE_PARENT |
+			  CLK_IS_CRITICAL),
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
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "l2_dram_clk_sel" },
+		.num_parents = 1,
+		.flags = (CLK_SET_RATE_PARENT |
+			  CLK_IS_CRITICAL),
+	},
+};
+
 /* Everything Else (EE) domain gates */
 
 static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
@@ -905,6 +1130,21 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
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
@@ -1016,6 +1256,14 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
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

