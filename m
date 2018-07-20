Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF08ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A6B2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NaZ4xMDR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Rv4DMoTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A6B2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbeGTMn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 08:43:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44724 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeGTMn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 08:43:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7039E60BB0; Fri, 20 Jul 2018 11:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532087763;
        bh=02lBuoYJaUUHGY22LUWryssXx+Db5goo0A3khzTdae0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NaZ4xMDRYko7jOmIBM703uiLzkmUroZjaEScCnjxg/qg7BeS9HrMPXVwpAkMQEgtN
         jGAEfAKC/+RB4rLTCoOWon8AnPKxztDxwjL6+vp4W7a0TOkLb3YsmJRssGRPP4e4rw
         ZAsNGRhPJbJJnnk2WWeyFu0S+M2sPMQta3Aet6SU=
Received: from dkota-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dkota@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01B0D60B22;
        Fri, 20 Jul 2018 11:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532087762;
        bh=02lBuoYJaUUHGY22LUWryssXx+Db5goo0A3khzTdae0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rv4DMoTiMYRkUcIPu1nZLUclDITSTrbpo7wPYonCMVclJZzoyh28akl5Kw7xJytUM
         P3/d6lTLH0dSGkPGEh8OKkRGvhsb79J9qUjzkdjwn2wZ2LbfBVBhtZ1AXm2kVrPwNx
         1jFz3dlpzOqAK1t3HoMuzfosPmObkSVksghHPZpc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01B0D60B22
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=dkota@codeaurora.org
From:   Dilip Kota <dkota@codeaurora.org>
To:     timur@codeaurora.org, swboyd@chromium.org, broonie@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Subject: [PATCH V2] dt-bindings: soc: qcom: Add device tree binding for GENI SE
Date:   Fri, 20 Jul 2018 17:21:00 +0530
Message-Id: <1532087461-3474-3-git-send-email-dkota@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532087461-3474-1-git-send-email-dkota@codeaurora.org>
References: <1532087461-3474-1-git-send-email-dkota@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>

Add device tree binding support for the QCOM GENI SE driver.

Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  | 119 +++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
new file mode 100644
index 0000000..d330c73
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
@@ -0,0 +1,119 @@
+Qualcomm Technologies, Inc. GENI Serial Engine QUP Wrapper Controller
+
+Generic Interface (GENI) based Qualcomm Universal Peripheral (QUP) wrapper
+is a programmable module for supporting a wide range of serial interfaces
+like UART, SPI, I2C, I3C, etc. A single QUP module can provide upto 8 Serial
+Interfaces, using its internal Serial Engines. The GENI Serial Engine QUP
+Wrapper controller is modeled as a node with zero or more child nodes each
+representing a serial engine.
+
+Required properties:
+- compatible:		Must be "qcom,geni-se-qup".
+- reg:			Must contain QUP register address and length.
+- clock-names:		Must contain "m-ahb" and "s-ahb".
+- clocks:		AHB clocks needed by the device.
+
+Required properties if child node exists:
+- #address-cells: 	Must be <1> for Serial Engine Address
+- #size-cells: 		Must be <1> for Serial Engine Address Size
+- ranges: 		Must be present
+
+Properties for children:
+
+A GENI based QUP wrapper controller node can contain 0 or more child nodes
+representing serial devices.  These serial devices can be a QCOM UART, I2C
+controller, SPI controller, or some combination of aforementioned devices.
+Please refer below the child node definitions for the supported serial
+interface protocols.
+
+Qualcomm Technologies Inc. GENI Serial Engine based I2C Controller
+
+Required properties:
+- compatible:		Must be "qcom,geni-i2c".
+- reg: 			Must contain QUP register address and length.
+- interrupts: 		Must contain I2C interrupt.
+- clock-names: 		Must contain "se".
+- clocks: 		Serial engine core clock needed by the device.
+- #address-cells:	Must be <1> for I2C device address.
+- #size-cells:		Must be <0> as I2C addresses have no size component.
+
+Optional property:
+- clock-frequency:	Desired I2C bus clock frequency in Hz.
+			When missing default to 400000Hz.
+
+Child nodes should conform to I2C bus binding as described in i2c.txt.
+
+Qualcomm Technologies Inc. GENI Serial Engine based UART Controller
+
+Required properties:
+- compatible:		Must be "qcom,geni-debug-uart".
+- reg: 			Must contain UART register location and length.
+- interrupts: 		Must contain UART core interrupts.
+- clock-names:		Must contain "se".
+- clocks:		Serial engine core clock needed by the device.
+
+Qualcomm Technologies Inc. GENI Serial Engine based SPI Controller
+
+Required properties:
+- compatible:		Must contain "qcom,geni-spi".
+- reg:			Must contain SPI register location and length.
+- interrupts:		Must contain SPI controller interrupts.
+- clock-names:		Must contain "se".
+- clocks:		Serial engine core clock needed by the device.
+- spi-max-frequency:	Specifies maximum SPI clock frequency, units - Hz.
+- #address-cells:	Must be <1> to define a chip select address on
+			the SPI bus.
+- #size-cells:		Must be <0>.
+
+SPI slave nodes must be children of the SPI master node and conform to SPI bus
+binding as described in Documentation/devicetree/bindings/spi/spi-bus.txt.
+
+Example:
+	geniqup@8c0000 {
+		compatible = "qcom,geni-se-qup";
+		reg = <0x8c0000 0x6000>;
+		clock-names = "m-ahb", "s-ahb";
+		clocks = <&clock_gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
+			<&clock_gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		i2c0: i2c@a94000 {
+			compatible = "qcom,geni-i2c";
+			reg = <0xa94000 0x4000>;
+			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "se";
+			clocks = <&clock_gcc GCC_QUPV3_WRAP0_S5_CLK>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&qup_1_i2c_5_active>;
+			pinctrl-1 = <&qup_1_i2c_5_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		uart0: serial@a88000 {
+			compatible = "qcom,geni-debug-uart";
+			reg = <0xa88000 0x7000>;
+			interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "se";
+			clocks = <&clock_gcc GCC_QUPV3_WRAP0_S0_CLK>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&qup_1_uart_3_active>;
+			pinctrl-1 = <&qup_1_uart_3_sleep>;
+		};
+
+		spi0: spi@a84000 {
+			compatible = "qcom,geni-spi";
+			reg = <0xa84000 0x4000>;
+			interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "se";
+			clocks = <&clock_gcc GCC_QUPV3_WRAP0_S0_CLK>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&qup_1_spi_2_active>;
+			pinctrl-1 = <&qup_1_spi_2_sleep>;
+			spi-max-frequency = <19200000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

