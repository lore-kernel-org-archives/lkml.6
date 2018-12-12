Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABC9C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27F52084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kYHW5ari";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FV4mmd10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27F52084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeLLMpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:45:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50600 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeLLMpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:45:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 007936030E; Wed, 12 Dec 2018 12:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544618718;
        bh=sOoGsr1HdPmCK/BI72TpP2z31pf3WacYdnV+Ihw1Tq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYHW5ari0jLh7duHVFsboDl0Czb/5YU6k0K+0mU7fSPEcmeG9mLI2vDqnqWBmS0Bo
         o5TUT+GphsVOIQlKNPdi18OA8HswO/YeuMGvir9/HQfMD8z2NXK/5biruh+QlUT6pz
         2+4b8E7hmDv12iYnuF4g/pkkP3naDPFFlFVp/nnI=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A219F60301;
        Wed, 12 Dec 2018 12:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544618717;
        bh=sOoGsr1HdPmCK/BI72TpP2z31pf3WacYdnV+Ihw1Tq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FV4mmd101bhL36d01AduTPqT/DwJFD/TolwVg68RMX9PfkMQrxHTS+kXa0wwYDMDg
         IhPgdvug6kCabAawB7ZXO+DPo0AsyZ5fuAqKHbEXcHwslcoEWimpS+8Z/UudaZ2epQ
         KBozbLLw2WIeE/73NABbH13ZsjvwdhjDt2l8xRXI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A219F60301
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
Subject: [PATCH 1/2] dt-bindings: remoteproc: qcom: Add firmware bindings for Q6V5 MSS
Date:   Wed, 12 Dec 2018 18:14:55 +0530
Message-Id: <20181212124456.3164-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212124456.3164-1-sibis@codeaurora.org>
References: <20181212124456.3164-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional firmware bindings for Q6V5 MSS. It lists the two relative
firmware paths which are used for booting and authenticating the Hexagon
core.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 9ff5b0309417..1f6988a60636 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -36,6 +36,13 @@ on the Qualcomm Hexagon core.
 	Value type: <stringlist>
 	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack"
 
+- qcom,firmware:
+	Usage: optional
+	Value type: <stringlist>
+	Definition: must list the 2 relative firmware paths (mba and modem
+		    metadata respectively) which are used for booting and
+		    authenticating the Hexagon core.
+
 - clocks:
 	Usage: required
 	Value type: <phandle>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

