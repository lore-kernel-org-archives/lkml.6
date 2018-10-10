Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F4DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E932087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mHF0LzN+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JWzh6/Yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E932087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeJKEqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:46:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39154 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeJKEqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:46:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 50AED60C81; Wed, 10 Oct 2018 21:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539206536;
        bh=1Tc/UYpYAFU7NYzoq8KOc4mDfOSOqIk+W3P+wsAyIbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHF0LzN+SyEU3UW0FShT4MtjoyiXyaT2TbGULr4OMtca07yJSMR8ryYNdT5UgyxzL
         FooZfMSXb+s9gj4cIMdtjWLIu4g0oWQjgcuSjSC5zIAmUTV7lxxu5q0DDOJrScJMVk
         gsuqA5/FAuQP5zmznSibmAXdRaVmer/8xc7hOiOc=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A3F960CE9;
        Wed, 10 Oct 2018 21:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539206534;
        bh=1Tc/UYpYAFU7NYzoq8KOc4mDfOSOqIk+W3P+wsAyIbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JWzh6/YzsTpNzN0XSKexJ5bjtVvrUIvOCyLJtYoaA4gkAfVO/oR4Jj19hi/toMzUk
         xy3dV9wPByKkze7airCs94BauvoKWImUBKHbGVIQ1Y4PiCSuqS3kA1R9II7lKPNUdz
         a1JaDrK9AVvjDpp7eQl7dcrgRsRKXZuK2eoEm0GU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A3F960CE9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        ulf.hansson@linaro.org, khilman@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC v1 8/8] arm64: dtsi: sdm845: Add cpu power domain support
Date:   Thu, 11 Oct 2018 02:50:55 +0530
Message-Id: <1539206455-29342-9-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpu power domain support

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d3662a8..aadaa20 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -96,6 +96,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			power-domains = <&cpu_pd>;
 			L2_0: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -111,6 +112,7 @@
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
+			power-domains = <&cpu_pd>;
 			L2_100: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -123,6 +125,7 @@
 			reg = <0x0 0x200>;
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
+			power-domains = <&cpu_pd>;
 			L2_200: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -135,6 +138,7 @@
 			reg = <0x0 0x300>;
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
+			power-domains = <&cpu_pd>;
 			L2_300: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -147,6 +151,7 @@
 			reg = <0x0 0x400>;
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
+			power-domains = <&cpu_pd>;
 			L2_400: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -159,6 +164,7 @@
 			reg = <0x0 0x500>;
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
+			power-domains = <&cpu_pd>;
 			L2_500: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -171,6 +177,7 @@
 			reg = <0x0 0x600>;
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
+			power-domains = <&cpu_pd>;
 			L2_600: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -183,6 +190,7 @@
 			reg = <0x0 0x700>;
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
+			power-domains = <&cpu_pd>;
 			L2_700: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -1170,6 +1178,11 @@
 					  <WAKE_TCS    3>,
 					  <CONTROL_TCS 1>;
 
+			cpu_pd: power-domain-controller {
+				compatible = "qcom,cpu-pm-domain";
+				#power-domain-cells = <0>;
+			};
+
 			rpmhcc: clock-controller {
 				compatible = "qcom,sdm845-rpmh-clk";
 				#clock-cells = <1>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

