Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E76DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31157205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XpOp2MiW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pAbUp2r8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31157205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbeH2XLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:11:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34466 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeH2XLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:11:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A6B796079C; Wed, 29 Aug 2018 19:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535569982;
        bh=KdMzCWFAWXUHZts0ANXctXm4hIGPbC/w3sThijByrAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XpOp2MiWYGSDpIcuSl5tbkmlYNmRfgZWEzR0njttpVLysN6oBeGVtRfFtEMYn7HWD
         Fz5bTz3V8zjFawGEwXGFB0DFB6rRNMaVcsLBGfQBCJrdG1Vs4vEBlzzSA2gDSOY3ar
         olR7S40KGz8lgqjC7A7W2VIjKxpyhvdSlPIBS2/g=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C50660540;
        Wed, 29 Aug 2018 19:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535569980;
        bh=KdMzCWFAWXUHZts0ANXctXm4hIGPbC/w3sThijByrAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pAbUp2r842yPBXdNBpt2A1PZEZRGzi3c2RnS3E6Y6BK+pnf+Bm8WsQlnLEmmIy30g
         3DXtVnRuqfRx9yjnlbHWTeFY33R1Yf3J4eLLDFA20+/J7fEhf/4Vb47/T5gAvGhIS6
         Afv/eyXSVu/6M3UO7TuYZd7oBosESleosNIqOMgo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C50660540
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        mka@chromium.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 5/6] remoteproc: qcom: q6v5-pil: Explicitly get mss_restart line
Date:   Thu, 30 Aug 2018 00:42:14 +0530
Message-Id: <20180829191215.10071-6-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180829191215.10071-1-sibis@codeaurora.org>
References: <20180829191215.10071-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly get mss_restart to facilitate adding PDC reset line
for modem on SDM845 SoCs

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index b1296d614b8b..968413edf0c8 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -1177,7 +1177,7 @@ static int q6v5_init_clocks(struct device *dev, struct clk **clks,
 static int q6v5_init_reset(struct q6v5 *qproc)
 {
 	qproc->mss_restart = devm_reset_control_get_exclusive(qproc->dev,
-							      NULL);
+							      "mss_restart");
 	if (IS_ERR(qproc->mss_restart)) {
 		dev_err(qproc->dev, "failed to acquire mss restart\n");
 		return PTR_ERR(qproc->mss_restart);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

