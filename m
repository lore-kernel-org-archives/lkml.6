Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7DEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DB22170D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OgZAWuPV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cshXWqIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DB22170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732360AbeHCQHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:07:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39302 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731781AbeHCQHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:07:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5CDF76035F; Fri,  3 Aug 2018 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533305443;
        bh=eq+JmpWl1jnqMYGKuroI0esBUvPo2zjNZb7Agt1ZXAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OgZAWuPV10e7PIQBOrjLqJaz84k3eUkylRqxY1rBOQrpxE/Vz+KIIbrU3AItkLK2s
         eycUlTE40hEUNI3Z8531VirvyjshrcrYrw6jb+lg2BX7mPxHlTnRYOpYMR0/BqM6sz
         FULdU/Rc3ariujKgutavnU80CnpxdOlKMaeup5u4=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 62E9C6079C;
        Fri,  3 Aug 2018 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533305441;
        bh=eq+JmpWl1jnqMYGKuroI0esBUvPo2zjNZb7Agt1ZXAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cshXWqIZ1/byV6+PYdPBJKdhTR7hO7xEq+DCFmbzoV3w9MQSOcQm9TiygDrX0ZztC
         TEpdzyZe4Rk3thCkjshUTImaN0MxRZM5wQksCEo+MQvPqEuN34xBSLR5O594ty6J9p
         6Tt8dzlDkbewg6doybtKYjNONal5m2I133Og9ZkE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62E9C6079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sricharan@codeaurora.org
Subject: [PATCH 1/5] arm: dts: qcom: Add pcie nodes for ipq8064
Date:   Fri,  3 Aug 2018 19:40:15 +0530
Message-Id: <1533305419-29152-2-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533305419-29152-1-git-send-email-sricharan@codeaurora.org>
References: <1533305419-29152-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the pcie nodes and pins.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 182 ++++++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 70790ac..e02d588 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -2,8 +2,11 @@
 /dts-v1/;
 
 #include "skeleton.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
 #include <dt-bindings/clock/qcom,lcc-ipq806x.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/reset/qcom,gcc-ipq806x.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -114,6 +117,33 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+
+			pcie0_pins: pcie0_pinmux {
+				mux {
+					pins = "gpio3";
+					function = "pcie1_rst";
+					drive-strength = <12>;
+					bias-disable;
+				};
+			};
+
+			pcie1_pins: pcie1_pinmux {
+				mux {
+					pins = "gpio48";
+					function = "pcie2_rst";
+					drive-strength = <12>;
+					bias-disable;
+				};
+			};
+
+			pcie2_pins: pcie2_pinmux {
+				mux {
+					pins = "gpio63";
+					function = "pcie3_rst";
+					drive-strength = <12>;
+					bias-disable;
+				};
+			};
 		};
 
 		intc: interrupt-controller@2000000 {
@@ -373,5 +403,157 @@
 			#reset-cells = <1>;
 		};
 
+		pcie0: pci@1b500000 {
+			compatible = "qcom,pcie-ipq8064";
+			reg = <0x1b500000 0x1000
+			       0x1b502000 0x80
+			       0x1b600000 0x100
+			       0x0ff00000 0x100000>;
+			reg-names = "dbi", "elbi", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00100000   /* downstream I/O */
+				  0x82000000 0 0x08000000 0x08000000 0 0x07e00000>; /* non-prefetchable memory */
+
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 36 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 37 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 38 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc PCIE_A_CLK>,
+				 <&gcc PCIE_H_CLK>,
+				 <&gcc PCIE_PHY_CLK>,
+				 <&gcc PCIE_AUX_CLK>,
+				 <&gcc PCIE_ALT_REF_CLK>;
+			clock-names = "core", "iface", "phy", "aux", "ref";
+
+			assigned-clocks = <&gcc PCIE_ALT_REF_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			resets = <&gcc PCIE_ACLK_RESET>,
+				 <&gcc PCIE_HCLK_RESET>,
+				 <&gcc PCIE_POR_RESET>,
+				 <&gcc PCIE_PCI_RESET>,
+				 <&gcc PCIE_PHY_RESET>,
+				 <&gcc PCIE_EXT_RESET>;
+			reset-names = "axi", "ahb", "por", "pci", "phy", "ext";
+
+			pinctrl-0 = <&pcie0_pins>;
+			pinctrl-names = "default";
+
+			status = "disabled";
+			perst-gpio = <&qcom_pinmux 3 GPIO_ACTIVE_LOW>;
+		};
+
+		pcie1: pci@1b700000 {
+			compatible = "qcom,pcie-ipq8064";
+			reg = <0x1b700000 0x1000
+			       0x1b702000 0x80
+			       0x1b800000 0x100
+			       0x31f00000 0x100000>;
+			reg-names = "dbi", "elbi", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00100000   /* downstream I/O */
+				  0x82000000 0 0x2e000000 0x2e000000 0 0x03e00000>; /* non-prefetchable memory */
+
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 58 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 59 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 60 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 61 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc PCIE_1_A_CLK>,
+				 <&gcc PCIE_1_H_CLK>,
+				 <&gcc PCIE_1_PHY_CLK>,
+				 <&gcc PCIE_1_AUX_CLK>,
+				 <&gcc PCIE_1_ALT_REF_CLK>;
+			clock-names = "core", "iface", "phy", "aux", "ref";
+
+			assigned-clocks = <&gcc PCIE_1_ALT_REF_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			resets = <&gcc PCIE_1_ACLK_RESET>,
+				 <&gcc PCIE_1_HCLK_RESET>,
+				 <&gcc PCIE_1_POR_RESET>,
+				 <&gcc PCIE_1_PCI_RESET>,
+				 <&gcc PCIE_1_PHY_RESET>,
+				 <&gcc PCIE_1_EXT_RESET>;
+			reset-names = "axi", "ahb", "por", "pci", "phy", "ext";
+
+			pinctrl-0 = <&pcie1_pins>;
+			pinctrl-names = "default";
+
+			status = "disabled";
+			perst-gpio = <&qcom_pinmux 48 GPIO_ACTIVE_LOW>;
+		};
+
+		pcie2: pci@1b900000 {
+			compatible = "qcom,pcie-ipq8064";
+			reg = <0x1b900000 0x1000
+			       0x1b902000 0x80
+			       0x1ba00000 0x100
+			       0x35f00000 0x100000>;
+			reg-names = "dbi", "elbi", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <2>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00100000   /* downstream I/O */
+				  0x82000000 0 0x32000000 0x32000000 0 0x03e00000>; /* non-prefetchable memory */
+
+			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 72 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 73 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 74 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 75 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc PCIE_2_A_CLK>,
+				 <&gcc PCIE_2_H_CLK>,
+				 <&gcc PCIE_2_PHY_CLK>,
+				 <&gcc PCIE_2_AUX_CLK>,
+				 <&gcc PCIE_2_ALT_REF_CLK>;
+			clock-names = "core", "iface", "phy", "aux", "ref";
+
+			assigned-clocks = <&gcc PCIE_2_ALT_REF_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			resets = <&gcc PCIE_2_ACLK_RESET>,
+				 <&gcc PCIE_2_HCLK_RESET>,
+				 <&gcc PCIE_2_POR_RESET>,
+				 <&gcc PCIE_2_PCI_RESET>,
+				 <&gcc PCIE_2_PHY_RESET>,
+				 <&gcc PCIE_2_EXT_RESET>;
+			reset-names = "axi", "ahb", "por", "pci", "phy", "ext";
+
+			pinctrl-0 = <&pcie2_pins>;
+			pinctrl-names = "default";
+
+			status = "disabled";
+			perst-gpio = <&qcom_pinmux 63 GPIO_ACTIVE_LOW>;
+		};
 	};
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

