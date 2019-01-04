Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6BFC43444
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37960218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mjt80pS4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nLvN7YiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfADQvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:51:23 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34674 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfADQvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:51:22 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CB23960850; Fri,  4 Jan 2019 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546620682;
        bh=mLh67TCX7JDCMU4sI7Kpr4PBMeDztf6I7vDQLHXRyl4=;
        h=From:To:Cc:Subject:Date:From;
        b=mjt80pS4t3VYhtR0wYnlBjlGkso7GjKP5vZ1NHf9bbvbzviUKT6Fy6uJGLjM051+1
         mjUaoa9hWDm0hCkDAbPk6uXYOqxd3QACNWhssj8xakWxAYLmvKe9evzWFM9OJHhv7U
         flvtQr1LyzHJlaNfWlQ8cNOLrhBN0NN5n/mkZIQ4=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C5366085F;
        Fri,  4 Jan 2019 16:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546620674;
        bh=mLh67TCX7JDCMU4sI7Kpr4PBMeDztf6I7vDQLHXRyl4=;
        h=From:To:Cc:Subject:Date:From;
        b=nLvN7YiSsgBtY+Cr0rawaoIrPAN0OH+/DgffAff7mnP+5a7pUYgvpL61v2Nab/jkq
         i8V4WP3PH8PPXj3d9yerKTddAho9LIv1s1iGLFABajf7fZayxm0nyZtXjJzDa+js+u
         WCVWf2l1RggBg4Y++eD5q4U+lK8AOQJbKCVOt31Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C5366085F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     robh+dt@kernel.org, balbi@kernel.org
Cc:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v1 5/6] usb: dwc3: qcom: Add support for MSM8998
Date:   Fri,  4 Jan 2019 09:51:02 -0700
Message-Id: <1546620662-2504-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a MSM8998 specific DT compatible so that we can properly bind to the
device and enable the USB controller.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.txt | 1 +
 drivers/usb/dwc3/dwc3-qcom.c                        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
index 95afdcf..cb695aa 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible:		Compatible list, contains
 			"qcom,dwc3"
 			"qcom,msm8996-dwc3" for msm8996 SOC.
+			"qcom,msm8998-dwc3" for msm8998 SOC.
 			"qcom,sdm845-dwc3" for sdm845 SOC.
 - reg:			Offset and length of register set for QSCRATCH wrapper
 - power-domains:	specifies a phandle to PM domain provider node
diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index a6d0203..184df4d 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -595,6 +595,7 @@ static int __maybe_unused dwc3_qcom_runtime_resume(struct device *dev)
 static const struct of_device_id dwc3_qcom_of_match[] = {
 	{ .compatible = "qcom,dwc3" },
 	{ .compatible = "qcom,msm8996-dwc3" },
+	{ .compatible = "qcom,msm8998-dwc3" },
 	{ .compatible = "qcom,sdm845-dwc3" },
 	{ }
 };
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

