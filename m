Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A27C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 04:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827242148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 04:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Aqr0jnE0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fBvtl4Rt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbeL1Esx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 23:48:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41042 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbeL1Esw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 23:48:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2D48F6087D; Fri, 28 Dec 2018 04:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545972531;
        bh=DoZiyBeyco0evyQBjpq+JJZLc30K7wpfM0TP4rPAOGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aqr0jnE0zgYPYtUiEu5SPTxZTXUl7N4359g9jyhCqurEGM3XeQlBsMbE621+opPKz
         B8e2Z7hPHPM7oCKCYBz+/MyRdMB3o7tTuk2/KC64EnNGdOmqHpkWS8aC2RXdtAt7Dd
         IbwGfWmz++CZ3x/Xtho0sCft4LAumKWOOT3dviss=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E430860722;
        Fri, 28 Dec 2018 04:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545972530;
        bh=DoZiyBeyco0evyQBjpq+JJZLc30K7wpfM0TP4rPAOGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBvtl4RtH73/IUg5GpPwzLl/EpLU2j0S0jjEi8s2ntB3Yn5jtiH2d/cCJXnNx8E9u
         AWK5FhYiX5MpfswDS8U5vwZVBXkGcBvsw76Bb3S/DCVVq3x3Kf4rRV8Zbs/m/DS5a8
         6SPvlaenjr7Q+EpQ2FMO/W5yHXap13e0epLyTR3Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E430860722
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org
Cc:     briannorris@chromium.org, akdwived@codeaurora.org,
        clew@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 1/2] dt-bindings: remoteproc: qcom: Add firmware bindings for Q6V5
Date:   Fri, 28 Dec 2018 10:18:18 +0530
Message-Id: <20181228044819.5697-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181228044819.5697-1-sibis@codeaurora.org>
References: <20181228044819.5697-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional "firmware-name" bindings for Q6V5 MSS and PAS based
remoteprocs. For Q6V5 MSS/PAS the two/one relative firmware
paths/path are to be listed respectively. Fallback to the default
images for mba/modem for Q6V5 MSS or the default Hexagon image
for Q6V5 PAS if the "firmware-name" binding is not present.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt | 6 ++++++
 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
index 9c0cff3a5ed8..60ee0f73071a 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
@@ -27,6 +27,12 @@ on the Qualcomm ADSP Hexagon core.
 	Value type: <stringlist>
 	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack"
 
+- firmware-name:
+	Usage: optional
+	Value type: <string>
+	Definition: must list the relative firmware image path for the
+		    Hexagon Core.
+
 - clocks:
 	Usage: required
 	Value type: <prop-encoded-array>
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 9ff5b0309417..3a99e7379d8c 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -36,6 +36,13 @@ on the Qualcomm Hexagon core.
 	Value type: <stringlist>
 	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack"
 
+- firmware-name:
+	Usage: optional
+	Value type: <stringlist>
+	Definition: must list the relative firmware image paths for mba and
+		    modem. They are used for booting and authenticating the
+		    Hexagon core.
+
 - clocks:
 	Usage: required
 	Value type: <phandle>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

