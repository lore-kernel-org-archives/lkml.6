Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095FBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8B5218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gySDj7wz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IgSRADb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeLZMxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 07:53:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40662 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeLZMxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 07:53:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9D8806086A; Wed, 26 Dec 2018 12:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545828786;
        bh=1mZ72arEKaqVzAN3IMBbKENt28j7g662fNIfi7TjRBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gySDj7wzswNWVJ1CEQWLxNeaIPIGLtQvHkagmIm0Z8H/NHAwXYusyhFcQFzI42Nd6
         4ED4mPiOqm09PNWAPGrcUeQ6HimMRWTMF8dWb9s77zy75YBN6meSG1da8GsUGjbWiV
         12BrFC/8IgPIYribf5Xem5JbFhqonMjxR4sjV3aw=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F32B66043F;
        Wed, 26 Dec 2018 12:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545828785;
        bh=1mZ72arEKaqVzAN3IMBbKENt28j7g662fNIfi7TjRBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgSRADb9+BogW3B5ZUY1okbkgKYCdTjynXDQ4DVpFWLpRQDH9ob3i5JnM1ojYXgwX
         VL0hcy998IRHvEfr1jow2gEd+w9CZOrBxIRHAlPh1DkQtQkfANaV+Mkj4fjJtsfJXe
         tscm4G/2q05Suv0ZMC4Q1975SinVZk6Gnhg65KlU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F32B66043F
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
Subject: [PATCH v3 4/8] remoteproc: qcom: q6v5-mss: Add missing clocks for MSM8996
Date:   Wed, 26 Dec 2018 18:22:25 +0530
Message-Id: <20181226125229.20149-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226125229.20149-1-sibis@codeaurora.org>
References: <20181226125229.20149-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Proxy vote for QDSS clock and remove vote on handover interrupt
to provide MSS PBL with access to STM hardware registers during
boot. Add "snoc_axi" and "mnoc_axi" to the active clock list.

Fixes: 9f058fa2efb1 ("remoteproc: qcom: Add support for mss remoteproc
on msm8996")

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 01be7314e176..2f12901dd1a7 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1398,6 +1398,7 @@ static const struct rproc_hexagon_res msm8996_mss = {
 	.proxy_clk_names = (char*[]){
 			"xo",
 			"pnoc",
+			"qdss",
 			NULL
 	},
 	.active_clk_names = (char*[]){
@@ -1405,6 +1406,8 @@ static const struct rproc_hexagon_res msm8996_mss = {
 			"bus",
 			"mem",
 			"gpll0_mss_clk",
+			"snoc_axi",
+			"mnoc_axi",
 			NULL
 	},
 	.need_mem_protection = true,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

