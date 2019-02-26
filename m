Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C45C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24F3218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551220501;
	bh=8sEXAxWVtHJRYKfW4ZHIF6XdnIi5LHA1UhBksLy+YK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kfg2wGyrQJzsd0teZJRqOw5kyb/3XTUodpDtwD04zZ2yn9Sh3jePAPC1oN2jd7Ayz
	 uJGaTeUj1/S4ONhL+IRDhw91p5z+co3MWtGifhdf1OdZ9gshBbmW/Y7WI+fVsLlksR
	 aSIJQtN/biyd3sRhNqEyFRVh5f6WPsfzZ6Kb09Ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfBZWes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:34:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729327AbfBZWee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:34:34 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 676E6218AC;
        Tue, 26 Feb 2019 22:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551220473;
        bh=8sEXAxWVtHJRYKfW4ZHIF6XdnIi5LHA1UhBksLy+YK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xmARyioPkAmgnNjqFNbjDu4tJ3TEdqvj0gzE8RRRSsUnnTpM5scsWPdyuC8LvBVIP
         L5r64hIaZE93oUuCr3gIVXWYvqRyLY+o0oK13BAOubAxnPETmRRKyDpAMMrt/HEAYC
         cQ9r3oyocMhDakyVNlu3usZqtOOEoTenB/aGdgwY=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 7/8] clk: qcom: gcc-sdm845: Migrate to DT parent mapping
Date:   Tue, 26 Feb 2019 14:34:28 -0800
Message-Id: <20190226223429.193873-8-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
In-Reply-To: <20190226223429.193873-1-sboyd@kernel.org>
References: <20190226223429.193873-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TODO: Fully convert driver

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 180 +++++++++++++++++-----------------
 1 file changed, 90 insertions(+), 90 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 58fa5c247af1..90ce40e25f59 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -25,6 +25,59 @@
 #include "gdsc.h"
 #include "reset.h"
 
+static struct clk_alpha_pll gpll0 = {
+	.offset = 0x0,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpll0",
+			.parent_names = (const char *[]){ "bi_tcxo" },
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_fabia_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll gpll4 = {
+	.offset = 0x76000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(4),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpll4",
+			.parent_names = (const char *[]){ "bi_tcxo" },
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_fabia_ops,
+		},
+	},
+};
+
+static const struct clk_div_table post_div_table_fabia_even[] = {
+	{ 0x0, 1 },
+	{ 0x1, 2 },
+	{ 0x3, 4 },
+	{ 0x7, 8 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv gpll0_out_even = {
+	.offset = 0x0,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_fabia_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_fabia_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gpll0_out_even",
+		.parent_names = (const char *[]){ "gpll0" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_fabia_ops,
+	},
+};
+
 enum {
 	P_BI_TCXO,
 	P_AUD_REF_CLK,
@@ -42,11 +95,11 @@ static const struct parent_map gcc_parent_map_0[] = {
 	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
-static const char * const gcc_parent_names_0[] = {
-	"bi_tcxo",
-	"gpll0",
-	"gpll0_out_even",
-	"core_bi_pll_test_se",
+static const struct clk_parent_data gcc_parent_data_0[] = {
+	{ .fw_name = "xo", .name = "bi_tcxo" },
+	{ .hw = &gpll0.clkr.hw },
+	{ .hw = &gpll0_out_even.clkr.hw },
+	{ .fw_name = "core_bi_pll_test_se", .name = "core_bi_pll_test_se" }
 };
 
 static const struct parent_map gcc_parent_map_1[] = {
@@ -150,59 +203,6 @@ static const char * const gcc_parent_names_10[] = {
 	"core_bi_pll_test_se",
 };
 
-static struct clk_alpha_pll gpll0 = {
-	.offset = 0x0,
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
-	.clkr = {
-		.enable_reg = 0x52000,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gpll0",
-			.parent_names = (const char *[]){ "bi_tcxo" },
-			.num_parents = 1,
-			.ops = &clk_alpha_pll_fixed_fabia_ops,
-		},
-	},
-};
-
-static struct clk_alpha_pll gpll4 = {
-	.offset = 0x76000,
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
-	.clkr = {
-		.enable_reg = 0x52000,
-		.enable_mask = BIT(4),
-		.hw.init = &(struct clk_init_data){
-			.name = "gpll4",
-			.parent_names = (const char *[]){ "bi_tcxo" },
-			.num_parents = 1,
-			.ops = &clk_alpha_pll_fixed_fabia_ops,
-		},
-	},
-};
-
-static const struct clk_div_table post_div_table_fabia_even[] = {
-	{ 0x0, 1 },
-	{ 0x1, 2 },
-	{ 0x3, 4 },
-	{ 0x7, 8 },
-	{ }
-};
-
-static struct clk_alpha_pll_postdiv gpll0_out_even = {
-	.offset = 0x0,
-	.post_div_shift = 8,
-	.post_div_table = post_div_table_fabia_even,
-	.num_post_div = ARRAY_SIZE(post_div_table_fabia_even),
-	.width = 4,
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gpll0_out_even",
-		.parent_names = (const char *[]){ "gpll0" },
-		.num_parents = 1,
-		.ops = &clk_alpha_pll_postdiv_fabia_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_cpuss_ahb_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	{ }
@@ -340,7 +340,7 @@ static struct clk_rcg2 gcc_pcie_phy_refgen_clk_src = {
 	.freq_tbl = ftbl_gcc_pcie_phy_refgen_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pcie_phy_refgen_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_ops,
 	},
@@ -362,7 +362,7 @@ static struct clk_rcg2 gcc_qspi_core_clk_src = {
 	.freq_tbl = ftbl_gcc_qspi_core_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qspi_core_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_floor_ops,
 	},
@@ -383,7 +383,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
 	.freq_tbl = ftbl_gcc_pdm2_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pdm2_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_ops,
 	},
@@ -410,7 +410,7 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
 
 static struct clk_init_data gcc_qupv3_wrap0_s0_clk_init = {
 	.name = "gcc_qupv3_wrap0_s0_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -426,7 +426,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap0_s1_clk_init = {
 	.name = "gcc_qupv3_wrap0_s1_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -442,7 +442,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap0_s2_clk_init = {
 	.name = "gcc_qupv3_wrap0_s2_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -458,7 +458,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap0_s3_clk_init = {
 	.name = "gcc_qupv3_wrap0_s3_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -474,7 +474,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap0_s4_clk_init = {
 	.name = "gcc_qupv3_wrap0_s4_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -490,7 +490,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap0_s5_clk_init = {
 	.name = "gcc_qupv3_wrap0_s5_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -506,7 +506,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap0_s6_clk_init = {
 	.name = "gcc_qupv3_wrap0_s6_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -522,7 +522,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap0_s7_clk_init = {
 	.name = "gcc_qupv3_wrap0_s7_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -538,7 +538,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap1_s0_clk_init = {
 	.name = "gcc_qupv3_wrap1_s0_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -554,7 +554,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap1_s1_clk_init = {
 	.name = "gcc_qupv3_wrap1_s1_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -570,7 +570,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap1_s2_clk_init = {
 	.name = "gcc_qupv3_wrap1_s2_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -586,7 +586,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap1_s3_clk_init = {
 	.name = "gcc_qupv3_wrap1_s3_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -602,7 +602,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap1_s4_clk_init = {
 	.name = "gcc_qupv3_wrap1_s4_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -618,7 +618,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap1_s5_clk_init = {
 	.name = "gcc_qupv3_wrap1_s5_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -634,7 +634,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap1_s6_clk_init = {
 	.name = "gcc_qupv3_wrap1_s6_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -650,7 +650,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap1_s7_clk_init = {
 	.name = "gcc_qupv3_wrap1_s7_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -707,7 +707,7 @@ static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
 	.freq_tbl = ftbl_gcc_sdcc4_apps_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_sdcc4_apps_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_ops,
 	},
@@ -749,7 +749,7 @@ static struct clk_rcg2 gcc_ufs_card_axi_clk_src = {
 	.freq_tbl = ftbl_gcc_ufs_card_axi_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_axi_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_shared_ops,
 	},
@@ -771,7 +771,7 @@ static struct clk_rcg2 gcc_ufs_card_ice_core_clk_src = {
 	.freq_tbl = ftbl_gcc_ufs_card_ice_core_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_ice_core_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_shared_ops,
 	},
@@ -806,7 +806,7 @@ static struct clk_rcg2 gcc_ufs_card_unipro_core_clk_src = {
 	.freq_tbl = ftbl_gcc_ufs_card_unipro_core_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_unipro_core_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_shared_ops,
 	},
@@ -829,7 +829,7 @@ static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
 	.freq_tbl = ftbl_gcc_ufs_phy_axi_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_axi_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_shared_ops,
 	},
@@ -843,7 +843,7 @@ static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
 	.freq_tbl = ftbl_gcc_ufs_card_ice_core_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_ice_core_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_shared_ops,
 	},
@@ -871,7 +871,7 @@ static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
 	.freq_tbl = ftbl_gcc_ufs_card_unipro_core_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_unipro_core_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_shared_ops,
 	},
@@ -894,7 +894,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
 	.freq_tbl = ftbl_gcc_usb30_prim_master_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_prim_master_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_shared_ops,
 	},
@@ -916,7 +916,7 @@ static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
 	.freq_tbl = ftbl_gcc_usb30_prim_mock_utmi_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_prim_mock_utmi_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_shared_ops,
 	},
@@ -930,7 +930,7 @@ static struct clk_rcg2 gcc_usb30_sec_master_clk_src = {
 	.freq_tbl = ftbl_gcc_usb30_prim_master_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_sec_master_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_ops,
 	},
@@ -944,7 +944,7 @@ static struct clk_rcg2 gcc_usb30_sec_mock_utmi_clk_src = {
 	.freq_tbl = ftbl_gcc_usb30_prim_mock_utmi_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_sec_mock_utmi_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1036,8 +1036,8 @@ static struct clk_branch gcc_aggre_ufs_card_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_aggre_ufs_card_axi_clk",
-			.parent_names = (const char *[]){
-				"gcc_ufs_card_axi_clk_src",
+			.parent_hws = (const struct clk_hw *[]){
+				&gcc_ufs_card_axi_clk_src.clkr.hw
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
-- 
Sent by a computer through tubes

