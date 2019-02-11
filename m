Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D50C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB80620863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n+bhs7+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbfBKTAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:00:38 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39285 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733095AbfBKTAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:00:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so5362756pgp.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pYNOvelWwFkHPENbU/kBpVx6z3IS8Bg9qXDKamgEBak=;
        b=n+bhs7+L7PeamvCEjeVskCgaQ1weNe0ACqLd7MVVEmrsclfjFww/vOMgSq+EkaWwoC
         uf/YLZxEcxDo46u09VEN0SDv+NA4Tn+iFYAtc8vatzQVURVcVTKEsCczZuOAHKBNevT/
         gYtq3EBLc4WukDbziQEOzlYLIk0oI3rbjuujI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pYNOvelWwFkHPENbU/kBpVx6z3IS8Bg9qXDKamgEBak=;
        b=XntFTqwWi8IN25jMGQq2ktFKzrAC8lsn5frwLMN2CutkJWtSxk5Du5usOllNt33TyC
         iyMaF23MxGd1xlxwo4t5PZrLgXXreMr9NNssawa8nnQkbcsBa5wQ6WL6ezyV3U/vhy7W
         rB9EKznuqPhcrKKkM9g6R3vNpAEObQO7GB/pTfbpUrvRYJOP/7/i+0Cmhkw5nhse2OdU
         MiqlC9bRNDRsMXpHvmdYMm/KgMIrx7MOtRTezajiWPskIdAU0+9G55twk/SFEAjC8cz3
         R5pxvuNW8VexWoJj31ZMilx+Laa0DdojTP38ah4RaAYt2XMyHBGpL7x03sxEVIOsIdTt
         cPSA==
X-Gm-Message-State: AHQUAua1ZtYSZmSzDaw+6S5ddpCNrNLvDW6XlHbpzB2bRKspeQgA9+DJ
        lKtFnJL1E8m0C9+MDM8ATgaVhHeIv7Y=
X-Google-Smtp-Source: AHgI3IaKT36hWmiALLqBKq6dxaqgvu2LvCz59eDuLyPzipvfQA2Rj3pwyKkuGsZIPxQ4NLkO4ttIsA==
X-Received: by 2002:a62:53c5:: with SMTP id h188mr37507131pfb.190.1549911636040;
        Mon, 11 Feb 2019 11:00:36 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e63sm27015287pfc.47.2019.02.11.11.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:00:35 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: sdm845: Add dynamic CPU power coefficients
Date:   Mon, 11 Feb 2019 11:00:19 -0800
Message-Id: <20190211190019.171583-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dynamic power coefficients for the Silver and Gold CPU cores of
the Qualcomm SDM845.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index e4b69c74fe077..6e8a2331176ec 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -120,6 +120,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_0>;
@@ -137,6 +138,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_100>;
@@ -151,6 +153,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_200>;
@@ -165,6 +168,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_300>;
@@ -179,6 +183,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x400>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <396>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_400>;
@@ -193,6 +198,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x500>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <396>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_500>;
@@ -207,6 +213,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x600>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <396>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_600>;
@@ -221,6 +228,7 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x700>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <396>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_700>;
-- 
2.20.1.791.gb4d0f1c61a-goog

