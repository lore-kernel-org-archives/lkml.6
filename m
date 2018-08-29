Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CE1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B917205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O8yS0QRS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V/J76rkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B917205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeH2XLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:11:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34308 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeH2XLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:11:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 75B4160452; Wed, 29 Aug 2018 19:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535569978;
        bh=zdhH4Z566TKAC8bXT++JQHVjJ6hypP5450lLK1KWKOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O8yS0QRSQLg8B9G/qwSq0pByhV9ZSkxw+ApyLdYntOh/Q3UZc77z1cJK2DMqG9zJQ
         LdIbS3GufHc/vehQjU+dvpUSPu/9+3jXaF/a/or8Cu6vCZdCWrB870a/+qWbn1sm/w
         f/J+WTw5hY/857dt9XNyedWkRh7yiCtmS9UTUh2I=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3C9D602AE;
        Wed, 29 Aug 2018 19:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535569976;
        bh=zdhH4Z566TKAC8bXT++JQHVjJ6hypP5450lLK1KWKOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/J76rkwORymN3mdI7J9biE58ib6SZolKi79boO9XXQuO2o2HnMT1SgKMxa91hYgi
         kjRsQzw66XfS3LzSMhs6ZAUtHx+uzXKYQKIjeceuK9IejFFQqdU4NrIqBjmG5BY5GP
         Qw0a+a1gCO3cPwKTvbm2/z2lVLp9BspYD9SPMn04=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3C9D602AE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        mka@chromium.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 4/6] dt-bindings: remoteproc: Add PDC reset binding for Q6V5 PIL
Date:   Thu, 30 Aug 2018 00:42:13 +0530
Message-Id: <20180829191215.10071-5-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180829191215.10071-1-sibis@codeaurora.org>
References: <20180829191215.10071-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional pdc_reset binding required for Q6V5 Modem PIL on
SDM845 SoCs.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 3a66cde5895a..9ff5b0309417 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -53,6 +53,8 @@ on the Qualcomm Hexagon core.
 	Definition: reference to the reset-controller for the modem sub-system
 		    reference to the list of 3 reset-controllers for the
 		    wcss sub-system
+		    reference to the list of 2 reset-controllers for the modem
+		    sub-system on SDM845 SoCs
 
 - reset-names:
 	Usage: required
@@ -60,6 +62,8 @@ on the Qualcomm Hexagon core.
 	Definition: must be "mss_restart" for the modem sub-system
 		    must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
 		    for the wcss sub-system
+		    must be "mss_restart", "pdc_reset" for the modem
+		    sub-system on SDM845 SoCs
 
 - cx-supply:
 - mss-supply:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

