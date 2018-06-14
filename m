Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8B19FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37399208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6s01LQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37399208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965065AbeFNVzs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 17:55:48 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38818 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965026AbeFNVzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 17:55:43 -0400
Received: by mail-wr0-f193.google.com with SMTP id e18-v6so7955300wrs.5;
        Thu, 14 Jun 2018 14:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NA6D8yIX1YmkRdYhsjqPAYpG4ug++O5i6Tz0TH/uadU=;
        b=F6s01LQ4bya7W7YWgyQxW/AlN++9ap+4GjsMWMbEufrJl+bdZtVxB9MBVvhRfuTqMa
         7a2zh0fXvnUBmsPbYza/6YR/rjE5dxIdjg/ck7ONz4AgTf7R2L8y6c4Zo31XFXk0VmNM
         dU6499+iXxBl/YhEHowz8rPJR4qF97qP67FAwxrnVnV1pgIRd2y56sE5hlhnNotEtGzP
         K5uywM3NzxQU/CwnpKzXXUaZ9+s4M0ot9KJerGOmdBu7nJzUR06p1hH5UP5ijk9telcO
         6G2ZoPIpgY7T7l3QPH6GXlzmlWnC3Bv3j8+3tkZEqctFxVoEe9ApDhvXxQ6owAmy3Ysl
         IMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NA6D8yIX1YmkRdYhsjqPAYpG4ug++O5i6Tz0TH/uadU=;
        b=Xfowe3eiTrC1TUkcmB52Y8bSw+ddDSAKerwK2lyaDniCtth3bSL6TZOzqz7tBowhqW
         E/5YQZD7FqiKvikchsadv0A/9zRz+mPBEd0O7z8yCCFgsisuZJA4zc5oACSYdB4RPOI8
         YcAjdkCYkCX004GNwDj/X/0XZyVjKHLyU6smXjd13x1SEqCyVGufVgVnMmvzbeeLLqPJ
         VmZsclyx0ijdBukFwGtSXRQ32N3jjjJ90e4vr+E3to54sMUgRx3XrDYl5dGKorq5Xssi
         In+a7olomcYNMg8CKnJ6vD8EIJcnScYTXz01JmmTXp5L/UH0fb6DVGSo44PfcCQ8stjk
         QwUQ==
X-Gm-Message-State: APt69E1siN8cgV6FFfZ6V0LdHlLHEDEOshMddRJ7jd+6Mt474ejkrL0g
        wVMZ1CoZOOEBx3CvsiIY+Gw=
X-Google-Smtp-Source: ADUXVKK5wnENNaneEM4uONiCN5VyZC3i+rH8/Zp7Qvi6EM+8Vv6LK32UQzbTPFzWQJQZteY8wVMYZA==
X-Received: by 2002:adf:eb0c:: with SMTP id s12-v6mr4026105wrn.174.1529013340817;
        Thu, 14 Jun 2018 14:55:40 -0700 (PDT)
Received: from gcc67.tetaneutral.net (gcc67.tetaneutral.net. [2a03:7220:8080:c00::1])
        by smtp.gmail.com with ESMTPSA id i76-v6sm285367wmd.20.2018.06.14.14.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 14:55:40 -0700 (PDT)
From:   ilia.lin@gmail.com
To:     ilia.lin@gmail.com
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Ilia Lin <ilialin@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 7/8] clk: qcom: cpu-8996: Add support to switch below 600Mhz
Date:   Thu, 14 Jun 2018 23:53:54 +0200
Message-Id: <20180614215358.11264-8-ilia.lin@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180614215358.11264-1-ilia.lin@gmail.com>
References: <20180614215358.11264-1-ilia.lin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

The CPU clock controller's primary PLL operates on a single VCO range,
between 600MHz and 3GHz. However the CPUs do support OPPs with
frequencies between 300MHz and 600MHz. In order to support running the
CPUs at those frequencies we end up having to lock the PLL at twice the
rate and drive the CPU clk via the PLL/2 output and SMUX.

So for frequencies above 600MHz we follow the following path
 Primary PLL --> PLL_EARLY --> PMUX(1) --> CPU clk
and for frequencies between 300MHz and 600MHz we follow
 Primary PLL --> PLL/2 --> SMUX(1) --> PMUX(0) --> CPU clk

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/clk/qcom/clk-cpu-8996.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index 620fdc2266ba..ff5c0a5740d2 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -68,6 +68,8 @@ enum _pmux_input {
 	NUM_OF_PMUX_INPUTS
 };
 
+#define DIV_2_THRESHOLD		600000000
+
 static const u8 prim_pll_regs[PLL_OFF_MAX_REGS] = {
        [PLL_OFF_L_VAL] = 0x04,
        [PLL_OFF_ALPHA_VAL] = 0x08,
@@ -95,10 +97,11 @@ static const u8 alt_pll_regs[PLL_OFF_MAX_REGS] = {
 
 static const struct alpha_pll_config hfpll_config = {
 	.l = 60,
-	.config_ctl_val = 0x200d4828,
+	.config_ctl_val = 0x200d4aa8,
 	.config_ctl_hi_val = 0x006,
 	.pre_div_mask = BIT(12),
 	.post_div_mask = 0x3 << 8,
+	.post_div_val = 0x1 << 8,
 	.main_output_mask = BIT(0),
 	.early_output_mask = BIT(3),
 };
@@ -140,7 +143,7 @@ static const struct alpha_pll_config altpll_config = {
 	.vco_mask = 0x3 << 20,
 	.config_ctl_val = 0x4001051b,
 	.post_div_mask = 0x3 << 8,
-	.post_div_val = 0x1,
+	.post_div_val = 0x1 << 8,
 	.main_output_mask = BIT(0),
 	.early_output_mask = BIT(3),
 };
@@ -181,6 +184,7 @@ struct clk_cpu_8996_mux {
 	u8	width;
 	struct notifier_block nb;
 	struct clk_hw	*pll;
+	struct clk_hw	*pll_div_2;
 	struct clk_regmap clkr;
 };
 
@@ -226,6 +230,13 @@ clk_cpu_8996_mux_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
 	struct clk_hw *parent = cpuclk->pll;
 
+	if (cpuclk->pll_div_2 && req->rate < DIV_2_THRESHOLD) {
+		if (req->rate < (DIV_2_THRESHOLD / 2))
+			return -EINVAL;
+
+		parent = cpuclk->pll_div_2;
+	}
+
 	req->best_parent_rate = clk_hw_round_rate(parent, req->rate);
 	req->best_parent_hw = parent;
 
@@ -237,13 +248,19 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 {
 	int ret;
 	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_nb(nb);
+	struct clk_notifier_data *cnd = data;
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
 		ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, ALT_INDEX);
 		break;
 	case POST_RATE_CHANGE:
-		ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, PLL_INDEX);
+		if (cnd->new_rate < DIV_2_THRESHOLD)
+			ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw,
+							  DIV_2_INDEX);
+		else
+			ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw,
+							  PLL_INDEX);
 		break;
 	default:
 		ret = 0;
@@ -295,6 +312,7 @@ static struct clk_cpu_8996_mux pwrcl_pmux = {
 	.shift = 0,
 	.width = 2,
 	.pll = &pwrcl_pll.clkr.hw,
+	.pll_div_2 = &pwrcl_smux.clkr.hw,
 	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "pwrcl_pmux",
@@ -315,6 +333,7 @@ static struct clk_cpu_8996_mux perfcl_pmux = {
 	.shift = 0,
 	.width = 2,
 	.pll = &perfcl_pll.clkr.hw,
+	.pll_div_2 = &perfcl_smux.clkr.hw,
 	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "perfcl_pmux",
-- 
2.11.0

