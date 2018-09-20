Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08073ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54172083A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A0JFurwn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nM3azftV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54172083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbeITMGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:06:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32992 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731455AbeITMGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:06:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D98BE60CEC; Thu, 20 Sep 2018 06:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537424688;
        bh=Z/wZCSrW/PKnz8kwCsu27uQgMnefINjwbqiAHtQqyDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0JFurwn5LiT4iEDzWTvhwY1qgYYu8CzG4aSmXrz3kjDAJRBtHRHJwwK8xNfEGvDL
         Fwax5QJov9gyY8vZkIZXusmscTTjCXlyGXy50mPGvCJycdrsPTZpqggFAvkVTuyXet
         e0aEbU2LXC/WTpygwtAh2fsKWJRnxz2nxO2O6Zzk=
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFB2060C84;
        Thu, 20 Sep 2018 06:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537424677;
        bh=Z/wZCSrW/PKnz8kwCsu27uQgMnefINjwbqiAHtQqyDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nM3azftVDDHInF9l1Q3beWv86mT3tD9NpDsjTtiebP7kb+rhKyUCRfIrndRc8bb7b
         TEZRyUYqXFDsdMFVwomANkPLGea8OUUzXGbUKnf6+uN8UcajzcKpYSjGlRvjz+NzW1
         QYCo35s87QhmTEE5R5nQeNbZa84KncvW6l5DNghg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFB2060C84
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     linux-mmc@vger.kernel.org, asutoshd@codeaurora.org,
        riteshh@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, evgreen@chromium.org, dianders@google.com,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 2/3] dt-bindings: mmc: sdhci-msm: Add entries for passing load values
Date:   Thu, 20 Sep 2018 11:52:37 +0530
Message-Id: <1537424558-17989-3-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537424558-17989-1-git-send-email-vbadigan@codeaurora.org>
References: <1537424558-17989-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijay Viswanath <vviswana@codeaurora.org>

The load a particular sdhc controller should request from a regulator
is device specific and hence each device should individually vote for
the required load.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 502b3b8..3720385 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -26,6 +26,11 @@ Required properties:
 	"cal"	- reference clock for RCLK delay calibration (optional)
 	"sleep"	- sleep clock for RCLK delay calibration (optional)
 
+Optional properties:
+- qcom,<supply>-current-level-microamp - specifies load levels for supply during BUS_ON and
+					BUS_OFF states in power irq. Should be specified in
+					pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
+					Units uA.
 Example:
 
 	sdhc_1: sdhci@f9824900 {
@@ -37,6 +42,7 @@ Example:
 
 		vmmc-supply = <&pm8941_l20>;
 		vqmmc-supply = <&pm8941_s3>;
+		qcom,vqmmc-current-level-microamp = <200 22000>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

