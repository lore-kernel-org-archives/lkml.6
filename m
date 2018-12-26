Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AE1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015AE218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JG/UYYxf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FB5QhZ3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeLZMxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 07:53:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40888 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeLZMxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 07:53:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A7F8C6095F; Wed, 26 Dec 2018 12:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545828792;
        bh=cLG1ZimMYHpTKMCrox7Z4fjGdOa82Ors1l1PLl31pLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JG/UYYxfB5C3DvZWzWsYOOTy9P+z90sXCrVSBj+mdoKZDGRkDoBfAxmtOA53j5v3I
         gVZL/Z5/meFOIhwGzzr3ugfh073NLSmRTI6eDKF5N5gDdmKbsIUCcNrDR/Jq3mBCVV
         bfcvmgphCLomvqa8+GNXKc10Yha1ghn1vs+Voxmk=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 826F860918;
        Wed, 26 Dec 2018 12:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545828791;
        bh=cLG1ZimMYHpTKMCrox7Z4fjGdOa82Ors1l1PLl31pLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FB5QhZ3bhWasf6KGsF3jqrmtYWVS3S0J1s3z7xz3CD5LV4cN7NfoRRwfAd5uCcTgV
         bP11ZXZyNY7Qp1oOUDx4YDzN3q+jUo6zqR9HxSf+wfGjoUM+fQkmsXfdptKPJioGRG
         3d3XYzvAeGgehRnDqHnWZELngO41p6Rodd/G2MH8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 826F860918
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
Subject: [PATCH v3 5/8] dt-bindings: remoteproc: qcom: Fixup regulator dependencies
Date:   Wed, 26 Dec 2018 18:22:26 +0530
Message-Id: <20181226125229.20149-5-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226125229.20149-1-sibis@codeaurora.org>
References: <20181226125229.20149-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup regulator supply dependencies for Q6V5 MSS on MSM996 SoCs.

Fixes: 9f058fa2efb1 ("remoteproc: qcom: Add support for mss remoteproc
on msm8996")

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

v3:
  * Fixup dt-binding documentation as suggested by Doug

 .../bindings/remoteproc/qcom,q6v5.txt         | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index af8788783e2b..65713de70be5 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -76,6 +76,19 @@ on the Qualcomm Hexagon core.
 		    must be "mss_restart", "pdc_reset" for the modem
 		    sub-system on SDM845 SoCs
 
+For the compatible strings below the following supplies are required:
+  "qcom,q6v5-pil"
+  "qcom,msm8916-mss-pil",
+- cx-supply:
+- mx-supply:
+- pll-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to the regulators to be held on behalf of the
+		    booting of the Hexagon core
+
+For the compatible string below the following supplies are required:
+  "qcom,msm8974-mss-pil"
 - cx-supply:
 - mss-supply:
 - mx-supply:
@@ -85,6 +98,14 @@ on the Qualcomm Hexagon core.
 	Definition: reference to the regulators to be held on behalf of the
 		    booting of the Hexagon core
 
+For the compatible string below the following supplies are required:
+  "qcom,msm8996-mss-pil"
+- pll-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to the regulators to be held on behalf of the
+		    booting of the Hexagon core
+
 - qcom,smem-states:
 	Usage: required
 	Value type: <phandle>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

