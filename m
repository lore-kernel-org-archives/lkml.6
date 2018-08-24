Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60E8C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FE92152B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E15T9OWQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mdrKoO2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FE92152B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeHXQyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:54:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55730 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeHXQyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:54:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BF9806053B; Fri, 24 Aug 2018 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535116779;
        bh=DN+/brB14o0ESMg6UEejMiZDhhOL/wagYttz4YFLFqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E15T9OWQz6zo+qflH/4Rbe0Nk3zFhdvOAfHmUUXLKM1WWnVmBTzNJXmlSJXx0Z2OK
         JqzPweVsG6pQLxK+E8fB0yB2V55M+8ThrExbR4kIOnTzdUGwLtH/KUk5lCebIO7uEk
         INvbAdea6Vk3ZrNY3pFItdJ8HKl5LLTelDQpMeJk=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E17946055B;
        Fri, 24 Aug 2018 13:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535116777;
        bh=DN+/brB14o0ESMg6UEejMiZDhhOL/wagYttz4YFLFqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdrKoO2g05hvSrlPRmWtR/aEFkcedtpYZ+CaweZBAaRm31Vl/FGEejxbeSv/wkmFK
         4CiooSEpk5sWvfwyIxeyLzibla6ltNM2DVjJE3wAOOsSDsv/AqS/VUWJcfzZmegi9S
         1P2090AkuAjZC080+9e/HSEnxH+vX/3eZtJFFFBM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E17946055B
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
Subject: [PATCH v2 4/6] dt-bindings: remoteproc: Add PDC reset binding for Q6V5 PIL
Date:   Fri, 24 Aug 2018 18:48:58 +0530
Message-Id: <20180824131900.5353-5-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180824131900.5353-1-sibis@codeaurora.org>
References: <20180824131900.5353-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional pdc_reset binding required for Q6V5 Modem PIL on
SDM845 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index c45e4c131fa2..4c5473aeb697 100644
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
 		    for the wcss syb-system
+		    must be "mss_restart", "pdc_reset" for the modem
+		    sub-system on SDM845 SoCs
 
 - cx-supply:
 - mss-supply:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

