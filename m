Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABE1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6D620811
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eWh93uPB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eWh93uPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbeLSTwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:52:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33806 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeLSTwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:52:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C42EB6058E; Wed, 19 Dec 2018 19:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545249168;
        bh=KcvvPK1QoefApDWLIZYgOhr2Z4ApmfzGh91E9lf8gcE=;
        h=From:To:Cc:Subject:Date:From;
        b=eWh93uPBGSXRJyO+nuwGnKoDqxt8aSMQ4Yf4fyqi3+aWqA31jX4eBdJevgEIwj+/2
         yXqEiNd/FOQTljqqwMOqb9ZqGziExu5RlKUNKjS/a6floBGL6XmkM+wmNtW5/25Ysz
         FA25yhV1xis5R10S/a7b7D1wBX9V9X87W79XoSDM=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7DC546028D;
        Wed, 19 Dec 2018 19:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545249168;
        bh=KcvvPK1QoefApDWLIZYgOhr2Z4ApmfzGh91E9lf8gcE=;
        h=From:To:Cc:Subject:Date:From;
        b=eWh93uPBGSXRJyO+nuwGnKoDqxt8aSMQ4Yf4fyqi3+aWqA31jX4eBdJevgEIwj+/2
         yXqEiNd/FOQTljqqwMOqb9ZqGziExu5RlKUNKjS/a6floBGL6XmkM+wmNtW5/25Ysz
         FA25yhV1xis5R10S/a7b7D1wBX9V9X87W79XoSDM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7DC546028D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH] arm64: dts: qcom: msm8998: Enumerate i2c controllers
Date:   Wed, 19 Dec 2018 12:52:39 -0700
Message-Id: <1545249159-18628-1-git-send-email-jhugo@codeaurora.org>
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
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 180 ++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 8d41b69..720bce6 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -624,6 +624,186 @@
 			status = "disabled";
 		};
 
+		i2c1: i2c@c175000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0xc175000 0x600>;
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
+		i2c2: i2c@c176000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0xc176000 0x600>;
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
+		i2c3: i2c@c177000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0xc177000 0x600>;
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
+		i2c4: i2c@c178000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0xc178000 0x600>;
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
+		i2c5: i2c@c179000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0xc179000 0x600>;
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
+		i2c6: i2c@c17a000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0xc17a000 0x600>;
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
+		i2c7: i2c@c1b5000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0xc1b5000 0x600>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c8: i2c@c1b6000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0xc1b6000 0x600>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c9: i2c@c1b7000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0xc1b7000 0x600>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP3_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10: i2c@c1b8000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0xc1b8000 0x600>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP4_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c11: i2c@c1b9000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0xc1b9000 0x600>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP5_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c12: i2c@c1ba000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0xc175000 0x600>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP6_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
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

