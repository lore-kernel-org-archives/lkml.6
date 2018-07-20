Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA600ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E95A20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V4WuBHtd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oS8aOBkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E95A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbeGTLeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:34:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49924 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeGTLeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:34:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E96AE60791; Fri, 20 Jul 2018 10:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532083596;
        bh=AwqDItVF6l3/7rPjcNy1ySYYel58DvxslLwoJWhpPL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4WuBHtdSS6dC9TG64GdFaReDHYNyQrdkbiTd30ucZE36yJPC7VV4AeCq5dUdCeHg
         A6J9jNNOx4uTkUAZy6f4t9+Z0S4Q3T8Y9xTUoIlQURmEgGxuOLLKKJ6QIUI7RqGTWA
         7oV0mDK/7Q+Z3ToLPfOr1CrKLFXGrD7XRy6lREFM=
Received: from hydcbspbld03.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vviswana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BE30B6071B;
        Fri, 20 Jul 2018 10:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532083595;
        bh=AwqDItVF6l3/7rPjcNy1ySYYel58DvxslLwoJWhpPL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oS8aOBkGhMz7aBXkGKJpSfEAQ3A9NN9x/V0EuRaMmuSuA047/9eJfKvefNheNDX8D
         3bSOa+ldcLNwwYSqCBzYkjXJ+qf0i3sbMEJjp7CcINEfmMlBg0kP3l8OIFF9WfKiOk
         eUE65HsVvnEF0yWRtL0N0U4vd3L2Ao2s1yffxlqM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE30B6071B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
From:   Vijay Viswanath <vviswana@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        vviswana@codeaurora.org, bjorn.andersson@linaro.org,
        riteshh@codeaurora.org, vbadigan@codeaurora.org,
        evgreen@chromium.org, dianders@google.com, sayalil@codeaurora.org
Subject: [PATCH V1 2/3] Documentation: sdhci-msm: Add entries for passing load values
Date:   Fri, 20 Jul 2018 16:16:05 +0530
Message-Id: <1532083566-43215-3-git-send-email-vviswana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532083566-43215-1-git-send-email-vviswana@codeaurora.org>
References: <1532083566-43215-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The load a particular sdhc controller should request from a regulator
is device specific and hence each device should individually vote for
the required load.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 502b3b8..ee34f28 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -26,6 +26,11 @@ Required properties:
 	"cal"	- reference clock for RCLK delay calibration (optional)
 	"sleep"	- sleep clock for RCLK delay calibration (optional)
 
+Optional properties:
+- <supply>-current-level - specifies load levels for supply during BUS_ON
+			and BUS_OFF states in power irq. Should be specified in
+			pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
+			Units uA.
 Example:
 
 	sdhc_1: sdhci@f9824900 {
@@ -37,6 +42,7 @@ Example:
 
 		vmmc-supply = <&pm8941_l20>;
 		vqmmc-supply = <&pm8941_s3>;
+		vqmmc-current-level = <200 22000>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

