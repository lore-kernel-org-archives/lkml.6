Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02E0C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE11206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gbOQg2P3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jK9qJ8kl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE11206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeLEICT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:02:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57768 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeLEICS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:02:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 01D9060397; Wed,  5 Dec 2018 08:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543996938;
        bh=AOe1NMnRup7AswQew0AJMN+3caEDVm8bDKls8jNNNGY=;
        h=From:To:Cc:Subject:Date:From;
        b=gbOQg2P3pmEyxw6e6ZPnx219bmT1qyh9rpxyQBu20xwcKqC3/q+i91o7PoRUd3m90
         8ytE/ZGO+x49EuuAoYZrbEsB1uF7Ibv+l4RkRrcdJNoQCNFYqLy5KUz+vTKMeN2iWP
         YSo9T9yMMxCoq3Us2nTWOyISpvDVFvRNdZv0bk2E=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4921C60397;
        Wed,  5 Dec 2018 08:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543996937;
        bh=AOe1NMnRup7AswQew0AJMN+3caEDVm8bDKls8jNNNGY=;
        h=From:To:Cc:Subject:Date:From;
        b=jK9qJ8klmw7oiwEY7RpBuaB8oywrP0GEUnncc7iuWba2j4akNKP6186MsCBZnfmBd
         jp1Dm4Nk2rnTtbgq9vTyAU0O4Kig9ZhXfQiVM/XwQMOXnPZJX08J90yKevsQ0eo/CA
         iYv9hPB8MtPSrIijEfmuLctquryuytxOmEqJfDZ0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4921C60397
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH] clk: qcom: Remove LPASS_CC config for GCC lpass clocks
Date:   Wed,  5 Dec 2018 13:32:00 +0530
Message-Id: <1543996920-17029-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCC lpass clocks are updated as protected, so clean up the ifdefers.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index c782e62..ba8ff99 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -3153,8 +3153,6 @@ enum {
 	},
 };

-/* TODO: Remove after DTS updated to protect these */
-#ifdef CONFIG_SDM_LPASSCC_845
 static struct clk_branch gcc_lpass_q6_axi_clk = {
 	.halt_reg = 0x47000,
 	.halt_check = BRANCH_HALT,
@@ -3182,7 +3180,6 @@ enum {
 		},
 	},
 };
-#endif

 static struct gdsc pcie_0_gdsc = {
 	.gdscr = 0x6b004,
@@ -3484,10 +3481,8 @@ enum {
 	[GCC_QSPI_CORE_CLK_SRC] = &gcc_qspi_core_clk_src.clkr,
 	[GCC_QSPI_CORE_CLK] = &gcc_qspi_core_clk.clkr,
 	[GCC_QSPI_CNOC_PERIPH_AHB_CLK] = &gcc_qspi_cnoc_periph_ahb_clk.clkr,
-#ifdef CONFIG_SDM_LPASSCC_845
 	[GCC_LPASS_Q6_AXI_CLK] = &gcc_lpass_q6_axi_clk.clkr,
 	[GCC_LPASS_SWAY_CLK] = &gcc_lpass_sway_clk.clkr,
-#endif
 };

 static const struct qcom_reset_map gcc_sdm845_resets[] = {
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

