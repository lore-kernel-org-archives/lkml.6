Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220B7C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC8E2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I861I/w/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PxD/4Ws9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC8E2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388857AbeG0QvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:51:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58132 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732059AbeG0QvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:51:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 178D860B11; Fri, 27 Jul 2018 15:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532705316;
        bh=F6IxRdGIUz/uMtIv7OPwXJgS2VXKumXWKuh3T9rSLu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I861I/w/7F5InWVuyCLhcScq/7sHZz7+mHJUH5BcuwRQSDqSD6iFimNhyLtYnDIAn
         ZjSATgA64Nft7LNZmbCCObrhGAq6HgCsMxTX4OTnjxEljEEoWLkVKsqFHJvAO15ptz
         cpdREZmoYZfExfex79RCCjoPxt2RgBeIZvdoDOSY=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F36D260BB2;
        Fri, 27 Jul 2018 15:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532705314;
        bh=F6IxRdGIUz/uMtIv7OPwXJgS2VXKumXWKuh3T9rSLu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PxD/4Ws9tyxzHEIRitYbQTFBGZbjCSF2ouwM4nCYmr12wyXMtEl9cEEHgsgwXswjv
         vmT1NJduvWZR8IxE+oaoKvvRl7W9DZ2Kse+0cGrDfi1LPnnC4zgAT/C8ZxgS4Jk50O
         uhFe5XVvyPvdlMSaptDLCu0x8egs1bJZxmxxsSBg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F36D260BB2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 3/4] remoteproc: qcom: q6v5-pil: Explicitly get mss_restart line
Date:   Fri, 27 Jul 2018 20:58:10 +0530
Message-Id: <20180727152811.15258-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180727152811.15258-1-sibis@codeaurora.org>
References: <20180727152811.15258-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly get mss_restart to facilitate adding PDC
restart line for modem on SDM845 SoCs

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index b1296d614b8b..d57fdb34e3dd 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -1176,8 +1176,7 @@ static int q6v5_init_clocks(struct device *dev, struct clk **clks,
 
 static int q6v5_init_reset(struct q6v5 *qproc)
 {
-	qproc->mss_restart = devm_reset_control_get_exclusive(qproc->dev,
-							      NULL);
+	qproc->mss_restart = devm_reset_control_get(qproc->dev, "mss_restart");
 	if (IS_ERR(qproc->mss_restart)) {
 		dev_err(qproc->dev, "failed to acquire mss restart\n");
 		return PTR_ERR(qproc->mss_restart);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

