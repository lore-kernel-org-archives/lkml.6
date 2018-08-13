Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1ADC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5591621837
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T/bLAsuO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MLLT6J9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5591621837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeHMJOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:14:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41808 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeHMJOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:14:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6FEF960B13; Mon, 13 Aug 2018 06:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534142031;
        bh=lTdwtlG8L9Jo8xTZrH/9vmgDTD92f3AF5eJIxR8IVnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/bLAsuO4PFNPDfQjlK1iI5MfFZMC69ZysFKNH0/nGjZChSDXUcUE0cBXJeII/ers
         hHIp7IqKUjZY5ZEC0b3/wRYf/hpQjOfEZOmD9C5PbELcnoriiPqoPghjzFt4Khr1Th
         zM3DCWtX2Rz+H7hzlDTSYO+jLcLhte6PrW8Mz01k=
Received: from anischal-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anischal@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A7A91606CF;
        Mon, 13 Aug 2018 06:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534142030;
        bh=lTdwtlG8L9Jo8xTZrH/9vmgDTD92f3AF5eJIxR8IVnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLLT6J9n05CFcjlYb3izWOcaYSTH9CDqz9Ci2dk7MJn3WjRBXS+arxVV+F9o1dZGH
         iEAv3ZSPEMgIue/OwqVYmdovziPWw8+7QqJohOflTAivuz1FVoiVBAsv56QN8mM/Ia
         cu/aiEOna/2oMzxOZgrnovgO6SPKZpqofQfok+pU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A7A91606CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
From:   Amit Nischal <anischal@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH v3 2/4] clk: qcom: Add clk_rcg2_gfx3d_ops for SDM845
Date:   Mon, 13 Aug 2018 12:03:05 +0530
Message-Id: <1534141987-29601-3-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534141987-29601-1-git-send-email-anischal@codeaurora.org>
References: <1534141987-29601-1-git-send-email-anischal@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To turn on the gpu_gx_gdsc, there is a hardware requirement to
turn on the root clock (GFX3D RCG) first which would be the turn
on signal for the gdsc along with the SW_COLLAPSE. As per the
current implementation of clk_rcg2_shared_ops, it clears the
root_enable bit in the enable() clock op. But due to the above
said requirement for GFX3D shared RCG, root_enable bit would be
already set by gdsc driver and clk_rcg2_shared_enable()should
not clear the root unless the disable is called.

Add support for the same by reusing the existing clk_rcg2_shared_ops
and deriving "clk_rcg2_gfx3d_ops" clk_ops for GFX3D clock to take
care of the root set/clear requirement.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
---
 drivers/clk/qcom/clk-rcg.h  |  1 +
 drivers/clk/qcom/clk-rcg2.c | 86 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index dbd5a9e..081eca9 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -162,5 +162,6 @@ struct clk_rcg2 {
 extern const struct clk_ops clk_pixel_ops;
 extern const struct clk_ops clk_gfx3d_ops;
 extern const struct clk_ops clk_rcg2_shared_ops;
+extern const struct clk_ops clk_rcg2_gfx3d_ops;

 #endif
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 52208d4..a57ce00 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -866,7 +866,7 @@ static int clk_rcg2_shared_set_rate_and_parent(struct clk_hw *hw,
 	return clk_rcg2_shared_set_rate(hw, rate, parent_rate);
 }

-static int clk_rcg2_shared_enable(struct clk_hw *hw)
+static int __clk_rcg2_shared_enable(struct clk_hw *hw)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	int ret;
@@ -879,7 +879,14 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
 	if (ret)
 		return ret;

-	ret = update_config(rcg);
+	return update_config(rcg);
+}
+
+static int clk_rcg2_shared_enable(struct clk_hw *hw)
+{
+	int ret;
+
+	ret = __clk_rcg2_shared_enable(hw);
 	if (ret)
 		return ret;

@@ -929,3 +936,78 @@ static void clk_rcg2_shared_disable(struct clk_hw *hw)
 	.set_rate_and_parent = clk_rcg2_shared_set_rate_and_parent,
 };
 EXPORT_SYMBOL_GPL(clk_rcg2_shared_ops);
+
+static int clk_rcg2_gfx3d_enable(struct clk_hw *hw)
+{
+	return __clk_rcg2_shared_enable(hw);
+}
+
+static int clk_rcg2_gfx3d_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
+{
+	struct clk_rate_request parent_req = { };
+	struct clk_hw *p;
+	unsigned long rate = req->rate;
+	int ret;
+
+	rate = clamp(rate, req->min_rate, req->max_rate);
+
+	/* Get fixed parent - GPU_CC_PLL0_OUT_EVEN */
+	p = clk_hw_get_parent_by_index(hw, 1);
+
+	/* Parent should always run at twice of the requested rate */
+	parent_req.rate = 2 * rate;
+
+	ret = __clk_determine_rate(req->best_parent_hw, &parent_req);
+	if (ret)
+		return ret;
+
+	req->best_parent_hw = p;
+	req->best_parent_rate = parent_req.rate;
+	req->rate = parent_req.rate / 2;
+
+	return 0;
+}
+
+static int clk_rcg2_gfx3d_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	int ret;
+	u32 cfg;
+
+	/* Configure fixed SRC and DIV */
+	cfg = rcg->parent_map[1].cfg << CFG_SRC_SEL_SHIFT;
+	cfg |= 0x3 << CFG_SRC_DIV_SHIFT;
+
+	ret = regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, cfg);
+	if (ret)
+		return ret;
+
+	/*
+	 * In case clock is disabled, update the SRC and DIV only
+	 * and return without configuration update.
+	 */
+	if (!__clk_is_enabled(hw->clk))
+		return 0;
+
+	return update_config(rcg);
+}
+
+static int clk_rcg2_gfx3d_set_rate_and_parent(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate, u8 index)
+{
+	return clk_rcg2_gfx3d_set_rate(hw, rate, parent_rate);
+}
+
+const struct clk_ops clk_rcg2_gfx3d_ops = {
+	.enable = clk_rcg2_gfx3d_enable,
+	.disable = clk_rcg2_shared_disable,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+	.recalc_rate = clk_rcg2_recalc_rate,
+	.determine_rate = clk_rcg2_gfx3d_determine_rate,
+	.set_rate = clk_rcg2_gfx3d_set_rate,
+	.set_rate_and_parent = clk_rcg2_gfx3d_set_rate_and_parent,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_gfx3d_ops);
--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

