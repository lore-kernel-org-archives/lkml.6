Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C46C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46820218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A6Ob2Eb6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VGCinmJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389219AbeLTTTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:19:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50758 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbeLTTTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:19:11 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AEF5C60734; Thu, 20 Dec 2018 19:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545333549;
        bh=WWCQ7FCRrUJ8WS9+XVkOHFMxId/mZpH5TnDKQPjRx+0=;
        h=From:To:Cc:Subject:Date:From;
        b=A6Ob2Eb6jP/uaU10oUDl8xfq3NEoUy1kfynJ3Y+HPpg+ZuRYDbwcH8ZrW1bDe8V1+
         Cu6NZ+wk5nbO93hRyRkMsgE/ccoQow5yu3HkN6XeHnFd8DSdYjzDVDlLyMF7fexJNl
         H/q03Y4x1Bz5UvXnGFQVoBAebugQlbjk0i63pXUg=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2CCF60208;
        Thu, 20 Dec 2018 19:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545333541;
        bh=WWCQ7FCRrUJ8WS9+XVkOHFMxId/mZpH5TnDKQPjRx+0=;
        h=From:To:Cc:Subject:Date:From;
        b=VGCinmJmc7pOnmBNwIM75W4YQRaZiV3e/c/p2SE9d7iUsJmQ3M4BSHvcNmIUtky2g
         Pd0Vclys66VLIG+4jYIRkwiu+v7bJ7Y5XUKKIeogQ5FgDz/Gmoz6JpOQqfSy5Sbw69
         MAgo/SaDe2QuDdYN4gheN9b+jpLavYzrO5Ifk0Gk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2CCF60208
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, david.brown@linaro.org,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Matthias Kaehlcke <mka@google.com>, amit.kucheria@linaro.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH] arm64: dts: sdm845: Add cpufreq device node
Date:   Fri, 21 Dec 2018 00:48:50 +0530
Message-Id: <1545333530-30151-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds the cpufreq node as per the bindings example for SDM845.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 23a253b..5db4fcc 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -99,6 +99,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 				compatible = "cache";
@@ -114,6 +115,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			next-level-cache = <&L2_100>;
 			L2_100: l2-cache {
 				compatible = "cache";
@@ -126,6 +128,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			next-level-cache = <&L2_200>;
 			L2_200: l2-cache {
 				compatible = "cache";
@@ -138,6 +141,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			next-level-cache = <&L2_300>;
 			L2_300: l2-cache {
 				compatible = "cache";
@@ -150,6 +154,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x400>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			next-level-cache = <&L2_400>;
 			L2_400: l2-cache {
 				compatible = "cache";
@@ -162,6 +167,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x500>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			next-level-cache = <&L2_500>;
 			L2_500: l2-cache {
 				compatible = "cache";
@@ -174,6 +180,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x600>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			next-level-cache = <&L2_600>;
 			L2_600: l2-cache {
 				compatible = "cache";
@@ -186,6 +193,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x700>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			next-level-cache = <&L2_700>;
 			L2_700: l2-cache {
 				compatible = "cache";
@@ -341,6 +349,17 @@
 			#power-domain-cells = <1>;
 		};

+		cpufreq_hw: cpufreq@17d43000 {
+			compatible = "qcom,cpufreq-hw";
+			reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
+			reg-names = "freq-domain0", "freq-domain1";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#freq-domain-cells = <1>;
+		};
+
 		qfprom@784000 {
 			compatible = "qcom,qfprom";
 			reg = <0x784000 0x8ff>;
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

