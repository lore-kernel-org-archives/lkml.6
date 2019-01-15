Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CACC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE3720657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oM4g8JPR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XOXWpIBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388768AbfAOSgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:36:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49438 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfAOSgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:36:35 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 677A160300; Tue, 15 Jan 2019 18:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547577394;
        bh=HI2xz1kE/ceGl2qzqYQ17M48igVvikGs1+/WIXjnc80=;
        h=From:To:Cc:Subject:Date:From;
        b=oM4g8JPRITTee9cQILcaZVIXYnAUAmN64aXmIP9nAkVTthruRnpL4vB1RWzJnQJ6c
         uUWHeTN4W2eq3em11othmsaXSslFiZ8VK3fhR6ORghnH0kpAwXTXIn+Ji0E9CaB6K2
         7fvDsseS3vpyGfV2vbC6ymQenokLkA48rDegtcyA=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 462FB60300;
        Tue, 15 Jan 2019 18:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547577393;
        bh=HI2xz1kE/ceGl2qzqYQ17M48igVvikGs1+/WIXjnc80=;
        h=From:To:Cc:Subject:Date:From;
        b=XOXWpIBt5+Ekk+zxyFx+GoXPfAOPyYQ3Yy8e0KMYsd9vXY0JnF6XN9AcAtGFWpqh7
         cdoqLhvympiZkBrCSxuGR6qCzRJahF0O0sePY1mHgdmEShiK8mWtcYO1anOTw8QTyq
         SDsyGHYxpFB7GFmRo/p4btonjtJE5/QOKwLnJLd0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 462FB60300
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2] arm64: dts: qcom: msm8998: Enumerate i2c controllers
Date:   Tue, 15 Jan 2019 11:36:23 -0700
Message-Id: <1547577383-13478-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm8998 has a dozen i2c controllers which can be used to connect to board
specific peripherals.  Enumerate the controllers so that boards can wire
up as needed.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---

v2:
-relabeled to include a link to the relevant blsp
-corrected the abh clocks for blsp2 instances
-padded the reg addresses to a full 4 bytes

 arch/arm64/boot/dts/qcom/msm8998.dtsi | 180 ++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 8d41b69..ab71e32 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -624,6 +624,186 @@
 			status = "disabled";
 		};
 
+		blsp1_i2c1: i2c@c175000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x0c175000 0x600>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp1_i2c2: i2c@c176000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x0c176000 0x600>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp1_i2c3: i2c@c177000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x0c177000 0x600>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp1_i2c4: i2c@c178000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x0c178000 0x600>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp1_i2c5: i2c@c179000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x0c179000 0x600>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP5_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp1_i2c6: i2c@c17a000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x0c17a000 0x600>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp2_i2c7: i2c@c1b5000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x0c1b5000 0x600>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp2_i2c8: i2c@c1b6000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x0c1b6000 0x600>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp2_i2c9: i2c@c1b7000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x0c1b7000 0x600>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP3_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp2_i2c10: i2c@c1b8000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x0c1b8000 0x600>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP4_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp2_i2c11: i2c@c1b9000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x0c1b9000 0x600>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP5_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp2_i2c12: i2c@c1ba000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x0c175000 0x600>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP6_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		blsp2_uart1: serial@c1b0000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xc1b0000 0x1000>;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

