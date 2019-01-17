Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7706C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D12920657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pb3LeRNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfAQEad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 23:30:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44766 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbfAQEa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 23:30:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so3830445pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 20:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c5CQ+yyPgI8wQuT1/8I4+RWZc8S11TKE/UcS9UdNS/E=;
        b=Pb3LeRNhHDHnsP1t5kt+14D5VqWWDmS0QQn2yvJ+4+jx8lQYJpjwDbIjeycbT6R/ul
         e40fZbzgRDjBFOV022+9IeHzLWR1gGxnf/FgfGAA6aHBT/pxSLbDyO2gTZMZpM9bfkWy
         6ev3MG8pMHdpNRdR+TUhp4ov3xzYHj8tRZqaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c5CQ+yyPgI8wQuT1/8I4+RWZc8S11TKE/UcS9UdNS/E=;
        b=fH7CluFpSJwTqCjStMR8yYZm9nUZaSLED0S0018T4Mu1tpe/p/o3iFbgfe2bkVejp3
         OHOGpONFKOYzROJ5EX79+EuWEbEKHn+vWd1oSSdPpbQ1UuBAcwMMHVG0+YV+ZizkN3yJ
         1GP5jY3ZDUbALAUS/dDNf0+609cdKxGoao7HU0eFovT8ZtIITr+SZdIC82TWoNwALFaX
         L8mzgDB7pMVvKu7SUu+N2RRAy0F1f/8AjIgMw6lSkf/meh4aEEwvt1aPU347EzfGsK98
         UrWbUI2Zr6ro2uozWGUMz0DUgOFuaSd7gulIkA8xl1qroGvP2WpxQcx/cxxvSpG8MrVH
         XjGA==
X-Gm-Message-State: AJcUukf+zlFXJhqGyXetwch4hbPa9DdOFv9+uSY1grFQ7mUksLit7aw6
        bF8BhHLq7Wb8g2xHR2gu1tO0iw==
X-Google-Smtp-Source: ALg8bN4SiYgyUjGFIhbeZrY2DpFPKQ7Qggen0qVUqhNrQAzHcBFqFpYIbk188fqr13ejZO4uw+kMDw==
X-Received: by 2002:a63:ec4b:: with SMTP id r11mr11929696pgj.44.1547699423282;
        Wed, 16 Jan 2019 20:30:23 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d6sm361574pgc.89.2019.01.16.20.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 20:30:22 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] arm64: dts: qcom: sdm845: Increase address and size cells for soc
Date:   Wed, 16 Jan 2019 20:29:39 -0800
Message-Id: <20190117042940.25487-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190117042940.25487-1-bjorn.andersson@linaro.org>
References: <20190117042940.25487-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The busses on SDM845 provides 36 address bits, extend the address and
size cells to make it possible to describe this in "ranges" and
"dma-ranges".

While touching all reg properties, addresses are padded to 8 digits.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Split out address-cells/size-cells change
- Rewrote commit message from scratch

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 300 +++++++++++++--------------
 1 file changed, 150 insertions(+), 150 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0c92a603133e..9867d42dc836 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -351,14 +351,14 @@
 	};
 
 	soc: soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0 0 0xffffffff>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0 0 0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
 		gcc: clock-controller@100000 {
 			compatible = "qcom,gcc-sdm845";
-			reg = <0x100000 0x1f0000>;
+			reg = <0 0x00100000 0 0x1f0000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
@@ -366,7 +366,7 @@
 
 		qfprom@784000 {
 			compatible = "qcom,qfprom";
-			reg = <0x784000 0x8ff>;
+			reg = <0 0x00784000 0 0x8ff>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
@@ -383,25 +383,25 @@
 
 		rng: rng@793000 {
 			compatible = "qcom,prng-ee";
-			reg = <0x00793000 0x1000>;
+			reg = <0 0x00793000 0 0x1000>;
 			clocks = <&gcc GCC_PRNG_AHB_CLK>;
 			clock-names = "core";
 		};
 
 		qupv3_id_0: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
-			reg = <0x8c0000 0x6000>;
+			reg = <0 0x008c0000 0 0x6000>;
 			clock-names = "m-ahb", "s-ahb";
 			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
 				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
-			#address-cells = <1>;
-			#size-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
 			ranges;
 			status = "disabled";
 
 			i2c0: i2c@880000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x880000 0x4000>;
+				reg = <0 0x00880000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
 				pinctrl-names = "default";
@@ -414,7 +414,7 @@
 
 			spi0: spi@880000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x880000 0x4000>;
+				reg = <0 0x00880000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
 				pinctrl-names = "default";
@@ -427,7 +427,7 @@
 
 			uart0: serial@880000 {
 				compatible = "qcom,geni-uart";
-				reg = <0x880000 0x4000>;
+				reg = <0 0x00880000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
 				pinctrl-names = "default";
@@ -438,7 +438,7 @@
 
 			i2c1: i2c@884000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x884000 0x4000>;
+				reg = <0 0x00884000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				pinctrl-names = "default";
@@ -451,7 +451,7 @@
 
 			spi1: spi@884000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x884000 0x4000>;
+				reg = <0 0x00884000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				pinctrl-names = "default";
@@ -464,7 +464,7 @@
 
 			uart1: serial@884000 {
 				compatible = "qcom,geni-uart";
-				reg = <0x884000 0x4000>;
+				reg = <0 0x00884000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				pinctrl-names = "default";
@@ -475,7 +475,7 @@
 
 			i2c2: i2c@888000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x888000 0x4000>;
+				reg = <0 0x00888000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
 				pinctrl-names = "default";
@@ -488,7 +488,7 @@
 
 			spi2: spi@888000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x888000 0x4000>;
+				reg = <0 0x00888000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
 				pinctrl-names = "default";
@@ -501,7 +501,7 @@
 
 			uart2: serial@888000 {
 				compatible = "qcom,geni-uart";
-				reg = <0x888000 0x4000>;
+				reg = <0 0x00888000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
 				pinctrl-names = "default";
@@ -512,7 +512,7 @@
 
 			i2c3: i2c@88c000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x88c000 0x4000>;
+				reg = <0 0x0088c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
 				pinctrl-names = "default";
@@ -525,7 +525,7 @@
 
 			spi3: spi@88c000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x88c000 0x4000>;
+				reg = <0 0x0088c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
 				pinctrl-names = "default";
@@ -538,7 +538,7 @@
 
 			uart3: serial@88c000 {
 				compatible = "qcom,geni-uart";
-				reg = <0x88c000 0x4000>;
+				reg = <0 0x0088c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
 				pinctrl-names = "default";
@@ -549,7 +549,7 @@
 
 			i2c4: i2c@890000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x890000 0x4000>;
+				reg = <0 0x00890000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
 				pinctrl-names = "default";
@@ -562,7 +562,7 @@
 
 			spi4: spi@890000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x890000 0x4000>;
+				reg = <0 0x00890000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
 				pinctrl-names = "default";
@@ -575,7 +575,7 @@
 
 			uart4: serial@890000 {
 				compatible = "qcom,geni-uart";
-				reg = <0x890000 0x4000>;
+				reg = <0 0x00890000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
 				pinctrl-names = "default";
@@ -586,7 +586,7 @@
 
 			i2c5: i2c@894000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x894000 0x4000>;
+				reg = <0 0x00894000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
 				pinctrl-names = "default";
@@ -599,7 +599,7 @@
 
 			spi5: spi@894000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x894000 0x4000>;
+				reg = <0 0x00894000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
 				pinctrl-names = "default";
@@ -612,7 +612,7 @@
 
 			uart5: serial@894000 {
 				compatible = "qcom,geni-uart";
-				reg = <0x894000 0x4000>;
+				reg = <0 0x00894000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
 				pinctrl-names = "default";
@@ -623,7 +623,7 @@
 
 			i2c6: i2c@898000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x898000 0x4000>;
+				reg = <0 0x00898000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
 				pinctrl-names = "default";
@@ -636,7 +636,7 @@
 
 			spi6: spi@898000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x898000 0x4000>;
+				reg = <0 0x00898000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
 				pinctrl-names = "default";
@@ -649,7 +649,7 @@
 
 			uart6: serial@898000 {
 				compatible = "qcom,geni-uart";
-				reg = <0x898000 0x4000>;
+				reg = <0 0x00898000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
 				pinctrl-names = "default";
@@ -660,7 +660,7 @@
 
 			i2c7: i2c@89c000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x89c000 0x4000>;
+				reg = <0 0x0089c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
 				pinctrl-names = "default";
@@ -673,7 +673,7 @@
 
 			spi7: spi@89c000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x89c000 0x4000>;
+				reg = <0 0x0089c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
 				pinctrl-names = "default";
@@ -686,7 +686,7 @@
 
 			uart7: serial@89c000 {
 				compatible = "qcom,geni-uart";
-				reg = <0x89c000 0x4000>;
+				reg = <0 0x0089c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
 				pinctrl-names = "default";
@@ -698,18 +698,18 @@
 
 		qupv3_id_1: geniqup@ac0000 {
 			compatible = "qcom,geni-se-qup";
-			reg = <0xac0000 0x6000>;
+			reg = <0 0x00ac0000 0 0x6000>;
 			clock-names = "m-ahb", "s-ahb";
 			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
 				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
-			#address-cells = <1>;
-			#size-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
 			ranges;
 			status = "disabled";
 
 			i2c8: i2c@a80000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0xa80000 0x4000>;
+				reg = <0 0x00a80000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
 				pinctrl-names = "default";
@@ -722,7 +722,7 @@
 
 			spi8: spi@a80000 {
 				compatible = "qcom,geni-spi";
-				reg = <0xa80000 0x4000>;
+				reg = <0 0x00a80000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
 				pinctrl-names = "default";
@@ -735,7 +735,7 @@
 
 			uart8: serial@a80000 {
 				compatible = "qcom,geni-uart";
-				reg = <0xa80000 0x4000>;
+				reg = <0 0x00a80000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
 				pinctrl-names = "default";
@@ -746,7 +746,7 @@
 
 			i2c9: i2c@a84000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0xa84000 0x4000>;
+				reg = <0 0x00a84000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
 				pinctrl-names = "default";
@@ -759,7 +759,7 @@
 
 			spi9: spi@a84000 {
 				compatible = "qcom,geni-spi";
-				reg = <0xa84000 0x4000>;
+				reg = <0 0x00a84000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
 				pinctrl-names = "default";
@@ -772,7 +772,7 @@
 
 			uart9: serial@a84000 {
 				compatible = "qcom,geni-debug-uart";
-				reg = <0xa84000 0x4000>;
+				reg = <0 0x00a84000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
 				pinctrl-names = "default";
@@ -783,7 +783,7 @@
 
 			i2c10: i2c@a88000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0xa88000 0x4000>;
+				reg = <0 0x00a88000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
 				pinctrl-names = "default";
@@ -796,7 +796,7 @@
 
 			spi10: spi@a88000 {
 				compatible = "qcom,geni-spi";
-				reg = <0xa88000 0x4000>;
+				reg = <0 0x00a88000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
 				pinctrl-names = "default";
@@ -809,7 +809,7 @@
 
 			uart10: serial@a88000 {
 				compatible = "qcom,geni-uart";
-				reg = <0xa88000 0x4000>;
+				reg = <0 0x00a88000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
 				pinctrl-names = "default";
@@ -820,7 +820,7 @@
 
 			i2c11: i2c@a8c000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0xa8c000 0x4000>;
+				reg = <0 0x00a8c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
 				pinctrl-names = "default";
@@ -833,7 +833,7 @@
 
 			spi11: spi@a8c000 {
 				compatible = "qcom,geni-spi";
-				reg = <0xa8c000 0x4000>;
+				reg = <0 0x00a8c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
 				pinctrl-names = "default";
@@ -846,7 +846,7 @@
 
 			uart11: serial@a8c000 {
 				compatible = "qcom,geni-uart";
-				reg = <0xa8c000 0x4000>;
+				reg = <0 0x00a8c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
 				pinctrl-names = "default";
@@ -857,7 +857,7 @@
 
 			i2c12: i2c@a90000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0xa90000 0x4000>;
+				reg = <0 0x00a90000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
 				pinctrl-names = "default";
@@ -870,7 +870,7 @@
 
 			spi12: spi@a90000 {
 				compatible = "qcom,geni-spi";
-				reg = <0xa90000 0x4000>;
+				reg = <0 0x00a90000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
 				pinctrl-names = "default";
@@ -883,7 +883,7 @@
 
 			uart12: serial@a90000 {
 				compatible = "qcom,geni-uart";
-				reg = <0xa90000 0x4000>;
+				reg = <0 0x00a90000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
 				pinctrl-names = "default";
@@ -894,7 +894,7 @@
 
 			i2c13: i2c@a94000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0xa94000 0x4000>;
+				reg = <0 0x00a94000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
 				pinctrl-names = "default";
@@ -907,7 +907,7 @@
 
 			spi13: spi@a94000 {
 				compatible = "qcom,geni-spi";
-				reg = <0xa94000 0x4000>;
+				reg = <0 0x00a94000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
 				pinctrl-names = "default";
@@ -920,7 +920,7 @@
 
 			uart13: serial@a94000 {
 				compatible = "qcom,geni-uart";
-				reg = <0xa94000 0x4000>;
+				reg = <0 0x00a94000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
 				pinctrl-names = "default";
@@ -931,7 +931,7 @@
 
 			i2c14: i2c@a98000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0xa98000 0x4000>;
+				reg = <0 0x00a98000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
 				pinctrl-names = "default";
@@ -944,7 +944,7 @@
 
 			spi14: spi@a98000 {
 				compatible = "qcom,geni-spi";
-				reg = <0xa98000 0x4000>;
+				reg = <0 0x00a98000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
 				pinctrl-names = "default";
@@ -957,7 +957,7 @@
 
 			uart14: serial@a98000 {
 				compatible = "qcom,geni-uart";
-				reg = <0xa98000 0x4000>;
+				reg = <0 0x00a98000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
 				pinctrl-names = "default";
@@ -968,7 +968,7 @@
 
 			i2c15: i2c@a9c000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0xa9c000 0x4000>;
+				reg = <0 0x00a9c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
 				pinctrl-names = "default";
@@ -981,7 +981,7 @@
 
 			spi15: spi@a9c000 {
 				compatible = "qcom,geni-spi";
-				reg = <0xa9c000 0x4000>;
+				reg = <0 0x00a9c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
 				pinctrl-names = "default";
@@ -994,7 +994,7 @@
 
 			uart15: serial@a9c000 {
 				compatible = "qcom,geni-uart";
-				reg = <0xa9c000 0x4000>;
+				reg = <0 0x00a9c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
 				pinctrl-names = "default";
@@ -1007,7 +1007,7 @@
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sdm845-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
-			reg = <0x1d84000 0x2500>;
+			reg = <0 0x01d84000 0 0x2500>;
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&ufs_mem_phy_lanes>;
 			phy-names = "ufsphy";
@@ -1049,9 +1049,9 @@
 
 		ufs_mem_phy: phy@1d87000 {
 			compatible = "qcom,sdm845-qmp-ufs-phy";
-			reg = <0x1d87000 0x18c>;
-			#address-cells = <1>;
-			#size-cells = <1>;
+			reg = <0 0x01d87000 0 0x18c>;
+			#address-cells = <2>;
+			#size-cells = <2>;
 			ranges;
 			clock-names = "ref",
 				      "ref_aux";
@@ -1061,23 +1061,23 @@
 			status = "disabled";
 
 			ufs_mem_phy_lanes: lanes@1d87400 {
-				reg = <0x1d87400 0x108>,
-				      <0x1d87600 0x1e0>,
-				      <0x1d87c00 0x1dc>,
-				      <0x1d87800 0x108>,
-				      <0x1d87a00 0x1e0>;
+				reg = <0 0x01d87400 0 0x108>,
+				      <0 0x01d87600 0 0x1e0>,
+				      <0 0x01d87c00 0 0x1dc>,
+				      <0 0x01d87800 0 0x108>,
+				      <0 0x01d87a00 0 0x1e0>;
 				#phy-cells = <0>;
 			};
 		};
 
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
-			reg = <0x1f40000 0x40000>;
+			reg = <0 0x01f40000 0 0x40000>;
 		};
 
 		tlmm: pinctrl@3400000 {
 			compatible = "qcom,sdm845-pinctrl";
-			reg = <0x03400000 0xc00000>;
+			reg = <0 0x03400000 0 0xc00000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -1474,7 +1474,7 @@
 
 		gpucc: clock-controller@5090000 {
 			compatible = "qcom,sdm845-gpucc";
-			reg = <0x05090000 0x9000>;
+			reg = <0 0x05090000 0 0x9000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
@@ -1484,7 +1484,7 @@
 
 		sdhc_2: sdhci@8804000 {
 			compatible = "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5";
-			reg = <0x8804000 0x1000>;
+			reg = <0 0x08804000 0 0x1000>;
 
 			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
@@ -1499,7 +1499,7 @@
 
 		qspi: spi@88df000 {
 			compatible = "qcom,sdm845-qspi", "qcom,qspi-v1";
-			reg = <0x88df000 0x600>;
+			reg = <0 0x088df000 0 0x600>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
@@ -1511,7 +1511,7 @@
 
 		usb_1_hsphy: phy@88e2000 {
 			compatible = "qcom,sdm845-qusb2-phy";
-			reg = <0x88e2000 0x400>;
+			reg = <0 0x088e2000 0 0x400>;
 			status = "disabled";
 			#phy-cells = <0>;
 
@@ -1526,7 +1526,7 @@
 
 		usb_2_hsphy: phy@88e3000 {
 			compatible = "qcom,sdm845-qusb2-phy";
-			reg = <0x88e3000 0x400>;
+			reg = <0 0x088e3000 0 0x400>;
 			status = "disabled";
 			#phy-cells = <0>;
 
@@ -1541,13 +1541,13 @@
 
 		usb_1_qmpphy: phy@88e9000 {
 			compatible = "qcom,sdm845-qmp-usb3-phy";
-			reg = <0x88e9000 0x18c>,
-			      <0x88e8000 0x10>;
+			reg = <0 0x088e9000 0 0x18c>,
+			      <0 0x088e8000 0 0x10>;
 			reg-names = "reg-base", "dp_com";
 			status = "disabled";
 			#clock-cells = <1>;
-			#address-cells = <1>;
-			#size-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
 			ranges;
 
 			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
@@ -1561,12 +1561,12 @@
 			reset-names = "phy", "common";
 
 			usb_1_ssphy: lanes@88e9200 {
-				reg = <0x88e9200 0x128>,
-				      <0x88e9400 0x200>,
-				      <0x88e9c00 0x218>,
-				      <0x88e9600 0x128>,
-				      <0x88e9800 0x200>,
-				      <0x88e9a00 0x100>;
+				reg = <0 0x088e9200 0 0x128>,
+				      <0 0x088e9400 0 0x200>,
+				      <0 0x088e9c00 0 0x218>,
+				      <0 0x088e9600 0 0x128>,
+				      <0 0x088e9800 0 0x200>,
+				      <0 0x088e9a00 0 0x100>;
 				#phy-cells = <0>;
 				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
 				clock-names = "pipe0";
@@ -1576,11 +1576,11 @@
 
 		usb_2_qmpphy: phy@88eb000 {
 			compatible = "qcom,sdm845-qmp-usb3-uni-phy";
-			reg = <0x88eb000 0x18c>;
+			reg = <0 0x088eb000 0 0x18c>;
 			status = "disabled";
 			#clock-cells = <1>;
-			#address-cells = <1>;
-			#size-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
 			ranges;
 
 			clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
@@ -1594,10 +1594,10 @@
 			reset-names = "phy", "common";
 
 			usb_2_ssphy: lane@88eb200 {
-				reg = <0x88eb200 0x128>,
-				      <0x88eb400 0x1fc>,
-				      <0x88eb800 0x218>,
-				      <0x88eb600 0x70>;
+				reg = <0 0x088eb200 0 0x128>,
+				      <0 0x088eb400 0 0x1fc>,
+				      <0 0x088eb800 0 0x218>,
+				      <0 0x088eb600 0 0x70>;
 				#phy-cells = <0>;
 				clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
 				clock-names = "pipe0";
@@ -1607,10 +1607,10 @@
 
 		usb_1: usb@a6f8800 {
 			compatible = "qcom,sdm845-dwc3", "qcom,dwc3";
-			reg = <0xa6f8800 0x400>;
+			reg = <0 0x0a6f8800 0 0x400>;
 			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
 			ranges;
 
 			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
@@ -1638,7 +1638,7 @@
 
 			usb_1_dwc3: dwc3@a600000 {
 				compatible = "snps,dwc3";
-				reg = <0xa600000 0xcd00>;
+				reg = <0 0x0a600000 0 0xcd00>;
 				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
@@ -1649,10 +1649,10 @@
 
 		usb_2: usb@a8f8800 {
 			compatible = "qcom,sdm845-dwc3", "qcom,dwc3";
-			reg = <0xa8f8800 0x400>;
+			reg = <0 0x0a8f8800 0 0x400>;
 			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
 			ranges;
 
 			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
@@ -1680,7 +1680,7 @@
 
 			usb_2_dwc3: dwc3@a800000 {
 				compatible = "snps,dwc3";
-				reg = <0xa800000 0xcd00>;
+				reg = <0 0x0a800000 0 0xcd00>;
 				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
@@ -1691,7 +1691,7 @@
 
 		videocc: clock-controller@ab00000 {
 			compatible = "qcom,sdm845-videocc";
-			reg = <0x0ab00000 0x10000>;
+			reg = <0 0x0ab00000 0 0x10000>;
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
 			#reset-cells = <1>;
@@ -1699,7 +1699,7 @@
 
 		mdss: mdss@ae00000 {
 			compatible = "qcom,sdm845-mdss";
-			reg = <0x0ae00000 0x1000>;
+			reg = <0 0x0ae00000 0 0x1000>;
 			reg-names = "mdss";
 
 			power-domains = <&dispcc MDSS_GDSC>;
@@ -1721,14 +1721,14 @@
 
 			status = "disabled";
 
-			#address-cells = <1>;
-			#size-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
 			ranges;
 
 			mdss_mdp: mdp@ae01000 {
 				compatible = "qcom,sdm845-dpu";
-				reg = <0x0ae01000 0x8f000>,
-				      <0x0aeb0000 0x2008>;
+				reg = <0 0x0ae01000 0 0x8f000>,
+				      <0 0x0aeb0000 0 0x2008>;
 				reg-names = "mdp", "vbif";
 
 				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
@@ -1769,7 +1769,7 @@
 
 			dsi0: dsi@ae94000 {
 				compatible = "qcom,mdss-dsi-ctrl";
-				reg = <0xae94000 0x400>;
+				reg = <0 0x0ae94000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
 				interrupt-parent = <&mdss>;
@@ -1817,9 +1817,9 @@
 
 			dsi0_phy: dsi-phy@ae94400 {
 				compatible = "qcom,dsi-phy-10nm";
-				reg = <0xae94400 0x200>,
-				      <0xae94600 0x280>,
-				      <0xae94a00 0x1e0>;
+				reg = <0 0x0ae94400 0 0x200>,
+				      <0 0x0ae94600 0 0x280>,
+				      <0 0x0ae94a00 0 0x1e0>;
 				reg-names = "dsi_phy",
 					    "dsi_phy_lane",
 					    "dsi_pll";
@@ -1835,7 +1835,7 @@
 
 			dsi1: dsi@ae96000 {
 				compatible = "qcom,mdss-dsi-ctrl";
-				reg = <0xae96000 0x400>;
+				reg = <0 0x0ae96000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
 				interrupt-parent = <&mdss>;
@@ -1883,9 +1883,9 @@
 
 			dsi1_phy: dsi-phy@ae96400 {
 				compatible = "qcom,dsi-phy-10nm";
-				reg = <0xae96400 0x200>,
-				      <0xae96600 0x280>,
-				      <0xae96a00 0x10e>;
+				reg = <0 0x0ae96400 0 0x200>,
+				      <0 0x0ae96600 0 0x280>,
+				      <0 0x0ae96a00 0 0x10e>;
 				reg-names = "dsi_phy",
 					    "dsi_phy_lane",
 					    "dsi_pll";
@@ -1902,7 +1902,7 @@
 
 		dispcc: clock-controller@af00000 {
 			compatible = "qcom,sdm845-dispcc";
-			reg = <0xaf00000 0x10000>;
+			reg = <0 0x0af00000 0 0x10000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
@@ -1910,39 +1910,39 @@
 
 		pdc_reset: reset-controller@b2e0000 {
 			compatible = "qcom,sdm845-pdc-global";
-			reg = <0x0b2e0000 0x20000>;
+			reg = <0 0x0b2e0000 0 0x20000>;
 			#reset-cells = <1>;
 		};
 
 		tsens0: thermal-sensor@c263000 {
 			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
-			reg = <0xc263000 0x1ff>, /* TM */
-			      <0xc222000 0x1ff>; /* SROT */
+			reg = <0 0x0c263000 0 0x1ff>, /* TM */
+			      <0 0x0c222000 0 0x1ff>; /* SROT */
 			#qcom,sensors = <13>;
 			#thermal-sensor-cells = <1>;
 		};
 
 		tsens1: thermal-sensor@c265000 {
 			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
-			reg = <0xc265000 0x1ff>, /* TM */
-			      <0xc223000 0x1ff>; /* SROT */
+			reg = <0 0x0c265000 0 0x1ff>, /* TM */
+			      <0 0x0c223000 0 0x1ff>; /* SROT */
 			#qcom,sensors = <8>;
 			#thermal-sensor-cells = <1>;
 		};
 
 		aoss_reset: reset-controller@c2a0000 {
 			compatible = "qcom,sdm845-aoss-cc";
-			reg = <0xc2a0000 0x31000>;
+			reg = <0 0x0c2a0000 0 0x31000>;
 			#reset-cells = <1>;
 		};
 
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
-			reg = <0xc440000 0x1100>,
-			      <0xc600000 0x2000000>,
-			      <0xe600000 0x100000>,
-			      <0xe700000 0xa0000>,
-			      <0xc40a000 0x26000>;
+			reg = <0 0x0c440000 0 0x1100>,
+			      <0 0x0c600000 0 0x2000000>,
+			      <0 0x0e600000 0 0x100000>,
+			      <0 0x0e700000 0 0xa0000>,
+			      <0 0x0c40a000 0 0x26000>;
 			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
 			interrupt-names = "periph_irq";
 			interrupts = <GIC_SPI 481 IRQ_TYPE_LEVEL_HIGH>;
@@ -1957,7 +1957,7 @@
 
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
-			reg = <0x15000000 0x80000>;
+			reg = <0 0x15000000 0 0x80000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
@@ -2037,16 +2037,16 @@
 
 		apss_shared: mailbox@17990000 {
 			compatible = "qcom,sdm845-apss-shared";
-			reg = <0x17990000 0x1000>;
+			reg = <0 0x17990000 0 0x1000>;
 			#mbox-cells = <1>;
 		};
 
 		apps_rsc: rsc@179c0000 {
 			label = "apps_rsc";
 			compatible = "qcom,rpmh-rsc";
-			reg = <0x179c0000 0x10000>,
-			      <0x179d0000 0x10000>,
-			      <0x179e0000 0x10000>;
+			reg = <0 0x179c0000 0 0x10000>,
+			      <0 0x179d0000 0 0x10000>,
+			      <0 0x179e0000 0 0x10000>;
 			reg-names = "drv-0", "drv-1", "drv-2";
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
@@ -2066,85 +2066,85 @@
 
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
-			#address-cells = <1>;
-			#size-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
 			ranges;
 			#interrupt-cells = <3>;
 			interrupt-controller;
-			reg = <0x17a00000 0x10000>,     /* GICD */
-			      <0x17a60000 0x100000>;    /* GICR * 8 */
+			reg = <0 0x17a00000 0 0x10000>,     /* GICD */
+			      <0 0x17a60000 0 0x100000>;    /* GICR * 8 */
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
 			gic-its@17a40000 {
 				compatible = "arm,gic-v3-its";
 				msi-controller;
 				#msi-cells = <1>;
-				reg = <0x17a40000 0x20000>;
+				reg = <0 0x17a40000 0 0x20000>;
 				status = "disabled";
 			};
 		};
 
 		timer@17c90000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
 			ranges;
 			compatible = "arm,armv7-timer-mem";
-			reg = <0x17c90000 0x1000>;
+			reg = <0 0x17c90000 0 0x1000>;
 
 			frame@17ca0000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x17ca0000 0x1000>,
-				      <0x17cb0000 0x1000>;
+				reg = <0 0x17ca0000 0 0x1000>,
+				      <0 0x17cb0000 0 0x1000>;
 			};
 
 			frame@17cc0000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x17cc0000 0x1000>;
+				reg = <0 0x17cc0000 0 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17cd0000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x17cd0000 0x1000>;
+				reg = <0 0x17cd0000 0 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17ce0000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x17ce0000 0x1000>;
+				reg = <0 0x17ce0000 0 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17cf0000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x17cf0000 0x1000>;
+				reg = <0 0x17cf0000 0 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17d00000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x17d00000 0x1000>;
+				reg = <0 0x17d00000 0 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17d10000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x17d10000 0x1000>;
+				reg = <0 0x17d10000 0 0x1000>;
 				status = "disabled";
 			};
 		};
 
 		cpufreq_hw: cpufreq@17d43000 {
 			compatible = "qcom,cpufreq-hw";
-			reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
+			reg = <0 0x17d43000 0 0x1400>, <0 0x17d45800 0 0x1400>;
 			reg-names = "freq-domain0", "freq-domain1";
 
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
@@ -2156,7 +2156,7 @@
 		wifi: wifi@18800000 {
 			compatible = "qcom,wcn3990-wifi";
 			status = "disabled";
-			reg = <0x18800000 0x800000>;
+			reg = <0 0x18800000 0 0x800000>;
 			reg-names = "membase";
 			memory-region = <&wlan_msa_mem>;
 			interrupts =
-- 
2.18.0

