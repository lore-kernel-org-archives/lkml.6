Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7612BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45387218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BVzAX0hb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fWoOnzbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeLZMx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 07:53:29 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41228 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeLZMx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 07:53:27 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CD119609C2; Wed, 26 Dec 2018 12:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545828806;
        bh=8Oeuk8ihqHvmR04Bd6mTtyu2QPCp3ZK2yq/bTxNoHAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BVzAX0hbs0QI/KyjoyiNod02pM2kaAHmJb8GOislk+6oERWL5velbXOjPIYPigk68
         9FrGqOrlDr1ys1oyzVGjAJg9GvnrH8YZslOe9uIOGrF5Xs3rgjRVy6pKhZAoypXUkx
         vI9OG49ALRTgrqHgstBUvElA1hctw6TmPUTdbgGI=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 079DD609B4;
        Wed, 26 Dec 2018 12:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545828803;
        bh=8Oeuk8ihqHvmR04Bd6mTtyu2QPCp3ZK2yq/bTxNoHAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fWoOnzbrh2GQuOwqrhPJ0PxRJme3MMm4dCJGjXFBy2jBNkyRT4alnlH7YipyE6ckT
         F/2epbbDyOICnqFvF3l1aZTLxIsszHMyxh+CuImf2wTGX7ouR6RL+E4uAZDigBTIE8
         Y48UZfZiXSwicqaasN1VWcJqPRcVrbqAz6HwBS/A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 079DD609B4
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
Subject: [PATCH v3 7/8] dt-bindings: remoteproc: qcom: Add power-domain bindings for Q6V5
Date:   Wed, 26 Dec 2018 18:22:28 +0530
Message-Id: <20181226125229.20149-7-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226125229.20149-1-sibis@codeaurora.org>
References: <20181226125229.20149-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power-domain bindings for Q6V5 MSS on MSM8996 and SDM845 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

v3:
  * Fixup dt-binding documentation as suggested by Doug
  * Dropping Rob's Reviewed-by due to documentation style
    change

v2:
  * Add load_state power-domain
  * List cx and mx power-domains for MSM8996

 .../bindings/remoteproc/qcom,q6v5.txt         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 65713de70be5..17ecaae5e5e0 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -106,6 +106,25 @@ For the compatible string below the following supplies are required:
 	Definition: reference to the regulators to be held on behalf of the
 		    booting of the Hexagon core
 
+- power-domains:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to power-domains that match power-domain-names
+
+- power-domain-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: The power-domains needed depend on the compatible string:
+	qcom,q6v5-pil:
+	qcom,ipq8074-wcss-pil:
+	qcom,msm8916-mss-pil:
+	qcom,msm8974-mss-pil:
+		    no power-domain names required
+	qcom,msm8996-mss-pil:
+		    must be "cx", "mx"
+	qcom,sdm845-mss-pil:
+		    must be "cx", "mx", "mss", "load_state"
+
 - qcom,smem-states:
 	Usage: required
 	Value type: <phandle>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

