Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pLmwGOYYHluZDQAAmS7hNA
	; Mon, 11 Jun 2018 06:38:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 53682607E4; Mon, 11 Jun 2018 06:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528699115;
	bh=iuyohPJu1iDmgcqjxWoyrmqXlOgP2uVk4WXQhjtMDdg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UlmyWOei6Gn7qdbcICbZ3E0OyR92TbfMkl+Z7uObdVrKW5Pun1G+kUf4cToH2jJVR
	 7wQcavhNzsUN70cM6HOvpd3l+G+DVSCLKnrko3I613r+nPVWvNsXkRD/jCQYgokVnS
	 ruBlVRzvtteHH9SJCGnxRdC6y1L3ERWh2iOmxu4g=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A8BC3607BB;
	Mon, 11 Jun 2018 06:38:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bQq0HCMk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j9Z8vBnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8BC3607BB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754045AbeFKGid (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:38:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753966AbeFKGib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:38:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C71C2600D0; Mon, 11 Jun 2018 06:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528699110;
        bh=iuyohPJu1iDmgcqjxWoyrmqXlOgP2uVk4WXQhjtMDdg=;
        h=From:To:Cc:Subject:Date:From;
        b=bQq0HCMktCwQAvXgk5IFq4XSyjY99z0xMJiL6lfIz0OS/0KmAuLxO16mYs0PT5rc4
         MSf5U79gc+ynVM5NXJc+aO3ooAMI1JvKGkvha15Ym7EELdtQYvqeP8QrFgZCnGUxPp
         LEbBaXqqhkVEn71tMcyUAnlNG3n2bgw6Kh8TY2Qc=
Received: from anischal-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anischal@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73A15600D0;
        Mon, 11 Jun 2018 06:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528699109;
        bh=iuyohPJu1iDmgcqjxWoyrmqXlOgP2uVk4WXQhjtMDdg=;
        h=From:To:Cc:Subject:Date:From;
        b=j9Z8vBnKkyofCfDIsGZO7z1qaMHm55HFJNv6YaYQEqFlAd3UOlnoRGw/+aGA2klfc
         vMNp70tb2STPC4nBLfGtjYKcU6gStpT+EMQkRY3x08gWTpWyG4ob8cno4BtmJ0QLBo
         3wAtF/wMq1fXlgXscEkPg/Db1Tael8hUJ0Rxw5OM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73A15600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
From: Amit Nischal <anischal@codeaurora.org>
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH v3] clk: qcom: Enable clocks which needs to be always on for SDM845
Date: Mon, 11 Jun 2018 12:08:15 +0530
Message-Id: <1528699095-17930-1-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are certain clocks which needs to be always enabled for system
operation. Add support for the same by adding 'CLK_IS_CRITICAL' flag
for such clocks.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
---

Changes in v3:
* Addressed review comments by Stephen to associate 'CLK_IS_CRITICAL'
  flag for the clocks which are required to be always ON.
* Added two gcc_cpuss* critical clocks and remove direct clock enable
  for them from gcc probe function.

Changes in v2:
* Fix target name in kernel configuration help text for SDM845 GCC
  clock driver.

[v1]: https://lkml.org/lkml/2018/5/28/171
[v2]: https://lkml.org/lkml/2018/5/29/43

 drivers/clk/qcom/gcc-sdm845.c               | 43 ++++++++++++++++++++++++++---
 include/dt-bindings/clock/qcom,gcc-sdm845.h |  2 ++
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index e78e6f5..0f694ed 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -1103,6 +1103,7 @@ enum {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_camera_ahb_clk",
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1129,6 +1130,7 @@ enum {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_camera_xo_clk",
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1270,6 +1272,7 @@ enum {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_disp_ahb_clk",
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1328,6 +1331,7 @@ enum {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_disp_xo_clk",
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1397,6 +1401,7 @@ enum {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_gpu_cfg_ahb_clk",
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2985,6 +2990,7 @@ enum {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_video_ahb_clk",
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -3011,6 +3017,7 @@ enum {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_video_xo_clk",
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -3049,6 +3056,36 @@ enum {
 	},
 };

+static struct clk_branch gcc_cpuss_dvm_bus_clk = {
+	.halt_reg = 0x48190,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x48190,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_cpuss_dvm_bus_clk",
+			.flags = CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_cpuss_gnoc_clk = {
+	.halt_reg = 0x48004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x48004,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52004,
+		.enable_mask = BIT(22),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_cpuss_gnoc_clk",
+			.flags = CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct gdsc pcie_0_gdsc = {
 	.gdscr = 0x6b004,
 	.pd = {
@@ -3344,6 +3381,8 @@ enum {
 	[GPLL0] = &gpll0.clkr,
 	[GPLL0_OUT_EVEN] = &gpll0_out_even.clkr,
 	[GPLL4] = &gpll4.clkr,
+	[GCC_CPUSS_DVM_BUS_CLK] = &gcc_cpuss_dvm_bus_clk.clkr,
+	[GCC_CPUSS_GNOC_CLK] = &gcc_cpuss_gnoc_clk.clkr,
 };

 static const struct qcom_reset_map gcc_sdm845_resets[] = {
@@ -3433,10 +3472,6 @@ static int gcc_sdm845_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x09ffc, 0x3, 0x3);
 	regmap_update_bits(regmap, 0x71028, 0x3, 0x3);

-	/* Enable CPUSS clocks */
-	regmap_update_bits(regmap, 0x48190, BIT(0), 0x1);
-	regmap_update_bits(regmap, 0x52004, BIT(22), 0x1);
-
 	return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
 }

diff --git a/include/dt-bindings/clock/qcom,gcc-sdm845.h b/include/dt-bindings/clock/qcom,gcc-sdm845.h
index aca6126..f96fc2d 100644
--- a/include/dt-bindings/clock/qcom,gcc-sdm845.h
+++ b/include/dt-bindings/clock/qcom,gcc-sdm845.h
@@ -192,6 +192,8 @@
 #define GCC_VS_CTRL_CLK_SRC					182
 #define GCC_VSENSOR_CLK_SRC					183
 #define GPLL4							184
+#define GCC_CPUSS_DVM_BUS_CLK					185
+#define GCC_CPUSS_GNOC_CLK					186

 /* GCC Resets */
 #define GCC_MMSS_BCR						0
--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
