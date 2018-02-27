Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753599AbeB0OIf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:08:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54464 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753549AbeB0OIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:08:23 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D355660FF4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: viresh.kumar@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, robh@kernel.org, sricharan@codeaurora.org,
        linux@arm.linux.org.uk
Subject: [PATCH v8 07/15] clk: qcom: Add IPQ806X's HFPLLs
Date: Tue, 27 Feb 2018 19:36:54 +0530
Message-Id: <1519740422-3835-8-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519740422-3835-1-git-send-email-sricharan@codeaurora.org>
References: <1519740422-3835-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Describe the HFPLLs present on IPQ806X devices.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/gcc-ipq806x.c | 82 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 28eb200..d571cf8 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -30,6 +30,7 @@
 #include "clk-pll.h"
 #include "clk-rcg.h"
 #include "clk-branch.h"
+#include "clk-hfpll.h"
 #include "reset.h"
 
 static struct clk_pll pll0 = {
@@ -113,6 +114,84 @@
 	},
 };
 
+static struct hfpll_data hfpll0_data = {
+	.mode_reg = 0x3200,
+	.l_reg = 0x3208,
+	.m_reg = 0x320c,
+	.n_reg = 0x3210,
+	.config_reg = 0x3204,
+	.status_reg = 0x321c,
+	.config_val = 0x7845c665,
+	.droop_reg = 0x3214,
+	.droop_val = 0x0108c000,
+	.min_rate = 600000000UL,
+	.max_rate = 1800000000UL,
+};
+
+static struct clk_hfpll hfpll0 = {
+	.d = &hfpll0_data,
+	.clkr.hw.init = &(struct clk_init_data){
+		.parent_names = (const char *[]){ "pxo" },
+		.num_parents = 1,
+		.name = "hfpll0",
+		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
+	},
+	.lock = __SPIN_LOCK_UNLOCKED(hfpll0.lock),
+};
+
+static struct hfpll_data hfpll1_data = {
+	.mode_reg = 0x3240,
+	.l_reg = 0x3248,
+	.m_reg = 0x324c,
+	.n_reg = 0x3250,
+	.config_reg = 0x3244,
+	.status_reg = 0x325c,
+	.config_val = 0x7845c665,
+	.droop_reg = 0x3314,
+	.droop_val = 0x0108c000,
+	.min_rate = 600000000UL,
+	.max_rate = 1800000000UL,
+};
+
+static struct clk_hfpll hfpll1 = {
+	.d = &hfpll1_data,
+	.clkr.hw.init = &(struct clk_init_data){
+		.parent_names = (const char *[]){ "pxo" },
+		.num_parents = 1,
+		.name = "hfpll1",
+		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
+	},
+	.lock = __SPIN_LOCK_UNLOCKED(hfpll1.lock),
+};
+
+static struct hfpll_data hfpll_l2_data = {
+	.mode_reg = 0x3300,
+	.l_reg = 0x3308,
+	.m_reg = 0x330c,
+	.n_reg = 0x3310,
+	.config_reg = 0x3304,
+	.status_reg = 0x331c,
+	.config_val = 0x7845c665,
+	.droop_reg = 0x3314,
+	.droop_val = 0x0108c000,
+	.min_rate = 600000000UL,
+	.max_rate = 1800000000UL,
+};
+
+static struct clk_hfpll hfpll_l2 = {
+	.d = &hfpll_l2_data,
+	.clkr.hw.init = &(struct clk_init_data){
+		.parent_names = (const char *[]){ "pxo" },
+		.num_parents = 1,
+		.name = "hfpll_l2",
+		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
+	},
+	.lock = __SPIN_LOCK_UNLOCKED(hfpll_l2.lock),
+};
+
 static struct clk_pll pll14 = {
 	.l_reg = 0x31c4,
 	.m_reg = 0x31c8,
@@ -2800,6 +2879,9 @@ enum {
 	[UBI32_CORE2_CLK_SRC] = &ubi32_core2_src_clk.clkr,
 	[NSSTCM_CLK_SRC] = &nss_tcm_src.clkr,
 	[NSSTCM_CLK] = &nss_tcm_clk.clkr,
+	[PLL9] = &hfpll0.clkr,
+	[PLL10] = &hfpll1.clkr,
+	[PLL12] = &hfpll_l2.clkr,
 };
 
 static const struct qcom_reset_map gcc_ipq806x_resets[] = {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
