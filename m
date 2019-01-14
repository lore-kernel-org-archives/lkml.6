Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EB6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BF820656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="axgXACx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfANVTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:19:12 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43316 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfANVTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:19:12 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so190702pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 13:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6o7BAvE3aeGLkKJv4pE4WZ6qRnXk7UoDS9kvLhYm9zY=;
        b=axgXACx7Yy4VP34gyn2VmZrH9/hdoV6Bre4YwLV+EFsd2kLzTIx4yXyQifwHy2Jj5I
         8YS5BJKJm95qRbI7VHBA4BEba/nETXqeVi5i+/EiXQx9FaQoJ2/6nrwHBqcrKJsPm8eI
         CUWOitlA4clOhl1ORnfSo2l/uUrC+Fw/MPiWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6o7BAvE3aeGLkKJv4pE4WZ6qRnXk7UoDS9kvLhYm9zY=;
        b=qYUhNBsn+Pa6CMWpcD+w4g1MHzV/L8c/XTCntOr8yfxwLBi5yNRkvk15P9TaGeq1/P
         ob2StyGlJ18oUg6ZGNDathpFIVLtbFrnXF6buAUiRdB3YrBaSZtviUNhmX87IIfls1m6
         tcEdc5FGYgPQ5GQNFNbeKAKigT49lcfVS1JOV0BPnW7eZe6HgCSQD7laTeoYXsrcuDJt
         hylAHV5Vmn1O9PLMMio64dqDMFD94Wmr9ZBVmjyAYjhhcMbZBCbKI8p+reizoMyP26VH
         uFdLk8Eb63+QqaJsE8lFT3yp60QucWADO5/O6pp4C3PigViCZwLxISxQ87JUVkQzg0X6
         izWg==
X-Gm-Message-State: AJcUukdnjojXdL6hlEKIenvYJaM4pdLULk88ENgU0bfKnL83dBDir7KG
        4ZhjCU0ZSd3vidMzbJpz4LlPPw==
X-Google-Smtp-Source: ALg8bN5sKR4d1dIadb48AgpDN+qsg7R9WsgJJzt+jaiY60WXhX9Hczz0Xm1dQmcRSSmua1sJ6+t3RA==
X-Received: by 2002:a65:590b:: with SMTP id f11mr522827pgu.60.1547500749953;
        Mon, 14 Jan 2019 13:19:09 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n78sm2059899pfk.19.2019.01.14.13.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 13:19:08 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sdm845: Expand soc bus address range
Date:   Mon, 14 Jan 2019 13:18:24 -0800
Message-Id: <20190114211824.2320-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA memory allocations for devices on the soc bus must be constrained to
the 36 address bits that the bus provides, which without IOMMU is taken
care of by the addresses being direct physical allocations.

Unless the bus_dma_mask is defined DMA allocations for devices will use
all 40 bits available by the SMMU. Causing addresses to be truncated on
the bus.

By the current choice of specifying #address-cells and #size-cells to 1,
it's possible to define the region of DMA allocations to the lower 32
bits. But the SMMU implementation requires that it can 1:1 map the page
table, which might be allocated above 32 bits (as we have RAM there).

So this patch increases the #size-cells to 2, in order to be able to add
a dma-ranges that defines the 36 bit DMA capability of the bus, and
bumps #address-cells to 2 for symmetry. Then defines the dma-ranges to
36 bits.

While touching all reg properties, addresses are padded to 8 digits.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

This applies to and is tested on 0f60e6fb54fb ("arm64: dts: qcom: pm8916: Add
PON watchdog node") of:
https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/log/?h=for-next

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 265 ++++++++++++++-------------
 1 file changed, 133 insertions(+), 132 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d9be5bba62c4..ffa9ca93d2ae 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -336,14 +336,15 @@
 	};
 
 	soc: soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0 0 0xffffffff>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0 0 0 0 0 0xffffffff>;
+		dma-ranges = <0 0 0 0 0x10 0>;
 		compatible = "simple-bus";
 
 		gcc: clock-controller@100000 {
 			compatible = "qcom,gcc-sdm845";
-			reg = <0x100000 0x1f0000>;
+			reg = <0 0x00100000 0 0x1f0000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
@@ -351,7 +352,7 @@
 
 		qfprom@784000 {
 			compatible = "qcom,qfprom";
-			reg = <0x784000 0x8ff>;
+			reg = <0 0x00784000 0 0x8ff>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
@@ -368,25 +369,25 @@
 
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
@@ -399,7 +400,7 @@
 
 			spi0: spi@880000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x880000 0x4000>;
+				reg = <0 0x00880000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
 				pinctrl-names = "default";
@@ -412,7 +413,7 @@
 
 			uart0: serial@880000 {
 				compatible = "qcom,geni-uart";
-				reg = <0x880000 0x4000>;
+				reg = <0 0x00880000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
 				pinctrl-names = "default";
@@ -423,7 +424,7 @@
 
 			i2c1: i2c@884000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x884000 0x4000>;
+				reg = <0 0x00884000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				pinctrl-names = "default";
@@ -436,7 +437,7 @@
 
 			spi1: spi@884000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x884000 0x4000>;
+				reg = <0 0x00884000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				pinctrl-names = "default";
@@ -449,7 +450,7 @@
 
 			uart1: serial@884000 {
 				compatible = "qcom,geni-uart";
-				reg = <0x884000 0x4000>;
+				reg = <0 0x00884000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				pinctrl-names = "default";
@@ -460,7 +461,7 @@
 
 			i2c2: i2c@888000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x888000 0x4000>;
+				reg = <0 0x00888000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
 				pinctrl-names = "default";
@@ -473,7 +474,7 @@
 
 			spi2: spi@888000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x888000 0x4000>;
+				reg = <0 0x00888000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
 				pinctrl-names = "default";
@@ -486,7 +487,7 @@
 
 			uart2: serial@888000 {
 				compatible = "qcom,geni-uart";
-				reg = <0x888000 0x4000>;
+				reg = <0 0x00888000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
 				pinctrl-names = "default";
@@ -497,7 +498,7 @@
 
 			i2c3: i2c@88c000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x88c000 0x4000>;
+				reg = <0 0x0088c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
 				pinctrl-names = "default";
@@ -510,7 +511,7 @@
 
 			spi3: spi@88c000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x88c000 0x4000>;
+				reg = <0 0x0088c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
 				pinctrl-names = "default";
@@ -523,7 +524,7 @@
 
 			uart3: serial@88c000 {
 				compatible = "qcom,geni-uart";
-				reg = <0x88c000 0x4000>;
+				reg = <0 0x0088c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
 				pinctrl-names = "default";
@@ -534,7 +535,7 @@
 
 			i2c4: i2c@890000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x890000 0x4000>;
+				reg = <0 0x00890000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
 				pinctrl-names = "default";
@@ -547,7 +548,7 @@
 
 			spi4: spi@890000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x890000 0x4000>;
+				reg = <0 0x00890000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
 				pinctrl-names = "default";
@@ -560,7 +561,7 @@
 
 			uart4: serial@890000 {
 				compatible = "qcom,geni-uart";
-				reg = <0x890000 0x4000>;
+				reg = <0 0x00890000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
 				pinctrl-names = "default";
@@ -571,7 +572,7 @@
 
 			i2c5: i2c@894000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x894000 0x4000>;
+				reg = <0 0x00894000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
 				pinctrl-names = "default";
@@ -584,7 +585,7 @@
 
 			spi5: spi@894000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x894000 0x4000>;
+				reg = <0 0x00894000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
 				pinctrl-names = "default";
@@ -597,7 +598,7 @@
 
 			uart5: serial@894000 {
 				compatible = "qcom,geni-uart";
-				reg = <0x894000 0x4000>;
+				reg = <0 0x00894000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
 				pinctrl-names = "default";
@@ -608,7 +609,7 @@
 
 			i2c6: i2c@898000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x898000 0x4000>;
+				reg = <0 0x00898000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
 				pinctrl-names = "default";
@@ -621,7 +622,7 @@
 
 			spi6: spi@898000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x898000 0x4000>;
+				reg = <0 0x00898000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
 				pinctrl-names = "default";
@@ -634,7 +635,7 @@
 
 			uart6: serial@898000 {
 				compatible = "qcom,geni-uart";
-				reg = <0x898000 0x4000>;
+				reg = <0 0x00898000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
 				pinctrl-names = "default";
@@ -645,7 +646,7 @@
 
 			i2c7: i2c@89c000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x89c000 0x4000>;
+				reg = <0 0x0089c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
 				pinctrl-names = "default";
@@ -658,7 +659,7 @@
 
 			spi7: spi@89c000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x89c000 0x4000>;
+				reg = <0 0x0089c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
 				pinctrl-names = "default";
@@ -671,7 +672,7 @@
 
 			uart7: serial@89c000 {
 				compatible = "qcom,geni-uart";
-				reg = <0x89c000 0x4000>;
+				reg = <0 0x0089c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
 				pinctrl-names = "default";
@@ -683,18 +684,18 @@
 
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
@@ -707,7 +708,7 @@
 
 			spi8: spi@a80000 {
 				compatible = "qcom,geni-spi";
-				reg = <0xa80000 0x4000>;
+				reg = <0 0x00a80000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
 				pinctrl-names = "default";
@@ -720,7 +721,7 @@
 
 			uart8: serial@a80000 {
 				compatible = "qcom,geni-uart";
-				reg = <0xa80000 0x4000>;
+				reg = <0 0x00a80000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
 				pinctrl-names = "default";
@@ -731,7 +732,7 @@
 
 			i2c9: i2c@a84000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0xa84000 0x4000>;
+				reg = <0 0x00a84000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
 				pinctrl-names = "default";
@@ -744,7 +745,7 @@
 
 			spi9: spi@a84000 {
 				compatible = "qcom,geni-spi";
-				reg = <0xa84000 0x4000>;
+				reg = <0 0x00a84000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
 				pinctrl-names = "default";
@@ -757,7 +758,7 @@
 
 			uart9: serial@a84000 {
 				compatible = "qcom,geni-debug-uart";
-				reg = <0xa84000 0x4000>;
+				reg = <0 0x00a84000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
 				pinctrl-names = "default";
@@ -768,7 +769,7 @@
 
 			i2c10: i2c@a88000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0xa88000 0x4000>;
+				reg = <0 0x00a88000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
 				pinctrl-names = "default";
@@ -781,7 +782,7 @@
 
 			spi10: spi@a88000 {
 				compatible = "qcom,geni-spi";
-				reg = <0xa88000 0x4000>;
+				reg = <0 0x00a88000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
 				pinctrl-names = "default";
@@ -794,7 +795,7 @@
 
 			uart10: serial@a88000 {
 				compatible = "qcom,geni-uart";
-				reg = <0xa88000 0x4000>;
+				reg = <0 0x00a88000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
 				pinctrl-names = "default";
@@ -805,7 +806,7 @@
 
 			i2c11: i2c@a8c000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0xa8c000 0x4000>;
+				reg = <0 0x00a8c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
 				pinctrl-names = "default";
@@ -818,7 +819,7 @@
 
 			spi11: spi@a8c000 {
 				compatible = "qcom,geni-spi";
-				reg = <0xa8c000 0x4000>;
+				reg = <0 0x00a8c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
 				pinctrl-names = "default";
@@ -831,7 +832,7 @@
 
 			uart11: serial@a8c000 {
 				compatible = "qcom,geni-uart";
-				reg = <0xa8c000 0x4000>;
+				reg = <0 0x00a8c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
 				pinctrl-names = "default";
@@ -842,7 +843,7 @@
 
 			i2c12: i2c@a90000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0xa90000 0x4000>;
+				reg = <0 0x00a90000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
 				pinctrl-names = "default";
@@ -855,7 +856,7 @@
 
 			spi12: spi@a90000 {
 				compatible = "qcom,geni-spi";
-				reg = <0xa90000 0x4000>;
+				reg = <0 0x00a90000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
 				pinctrl-names = "default";
@@ -868,7 +869,7 @@
 
 			uart12: serial@a90000 {
 				compatible = "qcom,geni-uart";
-				reg = <0xa90000 0x4000>;
+				reg = <0 0x00a90000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
 				pinctrl-names = "default";
@@ -879,7 +880,7 @@
 
 			i2c13: i2c@a94000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0xa94000 0x4000>;
+				reg = <0 0x00a94000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
 				pinctrl-names = "default";
@@ -892,7 +893,7 @@
 
 			spi13: spi@a94000 {
 				compatible = "qcom,geni-spi";
-				reg = <0xa94000 0x4000>;
+				reg = <0 0x00a94000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
 				pinctrl-names = "default";
@@ -905,7 +906,7 @@
 
 			uart13: serial@a94000 {
 				compatible = "qcom,geni-uart";
-				reg = <0xa94000 0x4000>;
+				reg = <0 0x00a94000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
 				pinctrl-names = "default";
@@ -916,7 +917,7 @@
 
 			i2c14: i2c@a98000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0xa98000 0x4000>;
+				reg = <0 0x00a98000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
 				pinctrl-names = "default";
@@ -929,7 +930,7 @@
 
 			spi14: spi@a98000 {
 				compatible = "qcom,geni-spi";
-				reg = <0xa98000 0x4000>;
+				reg = <0 0x00a98000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
 				pinctrl-names = "default";
@@ -942,7 +943,7 @@
 
 			uart14: serial@a98000 {
 				compatible = "qcom,geni-uart";
-				reg = <0xa98000 0x4000>;
+				reg = <0 0x00a98000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
 				pinctrl-names = "default";
@@ -953,7 +954,7 @@
 
 			i2c15: i2c@a9c000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0xa9c000 0x4000>;
+				reg = <0 0x00a9c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
 				pinctrl-names = "default";
@@ -966,7 +967,7 @@
 
 			spi15: spi@a9c000 {
 				compatible = "qcom,geni-spi";
-				reg = <0xa9c000 0x4000>;
+				reg = <0 0x00a9c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
 				pinctrl-names = "default";
@@ -979,7 +980,7 @@
 
 			uart15: serial@a9c000 {
 				compatible = "qcom,geni-uart";
-				reg = <0xa9c000 0x4000>;
+				reg = <0 0x00a9c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
 				pinctrl-names = "default";
@@ -992,7 +993,7 @@
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sdm845-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
-			reg = <0x1d84000 0x2500>;
+			reg = <0 0x01d84000 0 0x2500>;
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&ufs_mem_phy_lanes>;
 			phy-names = "ufsphy";
@@ -1034,9 +1035,9 @@
 
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
@@ -1046,23 +1047,23 @@
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
@@ -1424,7 +1425,7 @@
 
 		sdhc_2: sdhci@8804000 {
 			compatible = "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5";
-			reg = <0x8804000 0x1000>;
+			reg = <0 0x08804000 0 0x1000>;
 
 			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
@@ -1439,7 +1440,7 @@
 
 		usb_1_hsphy: phy@88e2000 {
 			compatible = "qcom,sdm845-qusb2-phy";
-			reg = <0x88e2000 0x400>;
+			reg = <0 0x088e2000 0 0x400>;
 			status = "disabled";
 			#phy-cells = <0>;
 
@@ -1454,7 +1455,7 @@
 
 		usb_2_hsphy: phy@88e3000 {
 			compatible = "qcom,sdm845-qusb2-phy";
-			reg = <0x88e3000 0x400>;
+			reg = <0 0x088e3000 0 0x400>;
 			status = "disabled";
 			#phy-cells = <0>;
 
@@ -1469,13 +1470,13 @@
 
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
@@ -1489,12 +1490,12 @@
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
@@ -1504,11 +1505,11 @@
 
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
@@ -1522,10 +1523,10 @@
 			reset-names = "phy", "common";
 
 			usb_2_ssphy: lane@88eb200 {
-				reg = <0x88eb200 0x128>,
-				      <0x88eb400 0x1fc>,
-				      <0x88eb800 0x218>,
-				      <0x88e9600 0x70>;
+				reg = <0 0x088eb200 0 0x128>,
+				      <0 0x088eb400 0 0x1fc>,
+				      <0 0x088eb800 0 0x218>,
+				      <0 0x088e9600 0 0x70>;
 				#phy-cells = <0>;
 				clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
 				clock-names = "pipe0";
@@ -1535,10 +1536,10 @@
 
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
@@ -1566,7 +1567,7 @@
 
 			usb_1_dwc3: dwc3@a600000 {
 				compatible = "snps,dwc3";
-				reg = <0xa600000 0xcd00>;
+				reg = <0 0x0a600000 0 0xcd00>;
 				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
@@ -1577,10 +1578,10 @@
 
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
@@ -1608,7 +1609,7 @@
 
 			usb_2_dwc3: dwc3@a800000 {
 				compatible = "snps,dwc3";
-				reg = <0xa800000 0xcd00>;
+				reg = <0 0x0a800000 0 0xcd00>;
 				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
@@ -1619,7 +1620,7 @@
 
 		dispcc: clock-controller@af00000 {
 			compatible = "qcom,sdm845-dispcc";
-			reg = <0xaf00000 0x10000>;
+			reg = <0 0x0af00000 0 0x10000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
@@ -1627,33 +1628,33 @@
 
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
@@ -1668,7 +1669,7 @@
 
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
-			reg = <0x15000000 0x80000>;
+			reg = <0 0x15000000 0 0x80000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
@@ -1740,16 +1741,16 @@
 
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
@@ -1769,85 +1770,85 @@
 
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
-- 
2.18.0

