Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58225C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235DB218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jxzcuE17";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="anrFwJtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeLZMxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 07:53:23 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41064 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeLZMxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 07:53:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3383E6085C; Wed, 26 Dec 2018 12:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545828800;
        bh=m2harrAruvoIwJgyWOU2j61qrypAn4/Kl22r5YLZg7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxzcuE17OC7iS0+SFxVqfe4LI6LrQ7n32CwHPPcAjTwtYvXDUDtjQ2mBau6e6xMvL
         r9PQkK2nPRSvD3gMyvjzUv82MU8Cmg48cCFcKNpClk46QKz+SYcx4L4VuhXKYNjH8b
         AtQ8AoBkL9uEQAeugtOamvHMaTaHf3Et97kbzJ+c=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 186DC6085C;
        Wed, 26 Dec 2018 12:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545828797;
        bh=m2harrAruvoIwJgyWOU2j61qrypAn4/Kl22r5YLZg7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anrFwJtDHGybr44iR23oBaKPKKr7rdvAyPJQ0+wrAJyfSrCJ+YCinr7ferKEsYmme
         AL2awa3Zm76Lw9Bk4BC8RvMS8GJtLOzBRJcUbtsO4uGP0kWf9FazxL04L/7UTyxNSf
         GXfKoW0H1U38faYwUPTxeH9tKmH365XHFIkyXRjY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 186DC6085C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        dianders@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        evgreen@chromium.org, briannorris@chromium.org,
        sricharan@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 6/8] remoteproc: qcom: q6v5-mss: Add missing regulator for MSM8996
Date:   Wed, 26 Dec 2018 18:22:27 +0530
Message-Id: <20181226125229.20149-6-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226125229.20149-1-sibis@codeaurora.org>
References: <20181226125229.20149-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add proxy vote for pll supply on MSM8996 SoC.

Fixes: 9f058fa2efb1 ("remoteproc: qcom: Add support for mss remoteproc
on msm8996")

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 2f12901dd1a7..f80b17b16e98 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1395,6 +1395,13 @@ static const struct rproc_hexagon_res sdm845_mss = {
 
 static const struct rproc_hexagon_res msm8996_mss = {
 	.hexagon_mba_image = "mba.mbn",
+	.proxy_supply = (struct qcom_mss_reg_res[]) {
+		{
+			.supply = "pll",
+			.uA = 100000,
+		},
+		{}
+	},
 	.proxy_clk_names = (char*[]){
 			"xo",
 			"pnoc",
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

