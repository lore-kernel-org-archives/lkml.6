Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94A2C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7223C2170D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VBQMjC03";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JAzrJV7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7223C2170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbeHCQHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:07:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39576 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731781AbeHCQHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:07:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F188960AFF; Fri,  3 Aug 2018 14:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533305451;
        bh=DVGdmtNtKpeKURO1+P5XZeWTqDAOj6c1fbHeVSBaRmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VBQMjC03Flj+hLZvaSGZHHSzh6j1EAlzhhQzwIARXQaG4jXkCCDEUGD1ecdep47EG
         J+yiJwSCZ7jm2BG4JyuD7P/lgPvL2JlVmXxKgXpK9Um8IBHPRCWwemMVRgW9G/Wgoc
         YO53lRmxRVkjBPf+dF+beUvquLAAs/KmifHFFL8M=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0061560117;
        Fri,  3 Aug 2018 14:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533305450;
        bh=DVGdmtNtKpeKURO1+P5XZeWTqDAOj6c1fbHeVSBaRmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAzrJV7xjQCMHcuUrAgeZwdtK5hfq0mP1vxvxnVhE7zhn074K6MQjMbvK6+pHtZG5
         3ClDtyqLuQU2MDQFXAAUGKagLJz0Y1eyPnyNO3ulKOKallE8ZITY+P294guJ984slQ
         V6v622jWEWbXJWpFb6zafzXFEjgRaLZSqsdrnDIY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0061560117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sricharan@codeaurora.org
Subject: [PATCH 4/5] arm: dts: qcom: Add ipq8064-ap161.dts
Date:   Fri,  3 Aug 2018 19:40:18 +0530
Message-Id: <1533305419-29152-5-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533305419-29152-1-git-send-email-sricharan@codeaurora.org>
References: <1533305419-29152-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new board dts for ipq8064-ap161.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/qcom.txt | 2 ++
 arch/arm/boot/dts/Makefile                     | 1 +
 arch/arm/boot/dts/qcom-ipq8064-ap161.dts       | 7 +++++++
 3 files changed, 10 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq8064-ap161.dts

diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
index ee532e7..2325135 100644
--- a/Documentation/devicetree/bindings/arm/qcom.txt
+++ b/Documentation/devicetree/bindings/arm/qcom.txt
@@ -15,6 +15,7 @@ The 'SoC' and 'board' elements are required. All other elements are optional.
 
 The 'SoC' element must be one of the following strings:
 
+	ipq8064
 	apq8016
 	apq8074
 	apq8084
@@ -30,6 +31,7 @@ The 'SoC' element must be one of the following strings:
 
 The 'board' element must be one of the following strings:
 
+	ap
 	cdp
 	liquid
 	dragonboard
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37a3de7..233661a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -772,6 +772,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-ipq4019-ap.dk07.1-c1.dtb \
 	qcom-ipq4019-ap.dk07.1-c2.dtb \
 	qcom-ipq8064-ap148.dtb \
+	qcom-ipq8064-ap161.dtb \
 	qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb \
 	qcom-msm8974-fairphone-fp2.dtb \
diff --git a/arch/arm/boot/dts/qcom-ipq8064-ap161.dts b/arch/arm/boot/dts/qcom-ipq8064-ap161.dts
new file mode 100644
index 0000000..aab5174
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq8064-ap161.dts
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "qcom-ipq8064-v1.0.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ8064/AP-161";
+	compatible = "qcom,ipq8064-ap161";
+};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

