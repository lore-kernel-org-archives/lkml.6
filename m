Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316C2C43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20A2218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Wj6//jgy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kZyYRotV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfADQvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:51:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfADQvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:51:44 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 23ECD609B4; Fri,  4 Jan 2019 16:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546620703;
        bh=LL7NdvzCDySzgzlLNQT8POatEkADg2tOi7f+/QbX3W0=;
        h=From:To:Cc:Subject:Date:From;
        b=Wj6//jgyPcp3xMSz0wM5ECiG8F/qdg2vMq01TK3EriXoHjQVou4bNktngK3cNPoyK
         o5ATxfkwhIoRdBEpUa9OLulma0T/thLzjILrNPnCSPkhrEX7c7xrDKpfsVNabe9L/Y
         P6DYx9jYZy+/xN+7781J7Pm/33JuVU38UGc2vgSI=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FF0C6087D;
        Fri,  4 Jan 2019 16:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546620700;
        bh=LL7NdvzCDySzgzlLNQT8POatEkADg2tOi7f+/QbX3W0=;
        h=From:To:Cc:Subject:Date:From;
        b=kZyYRotVNb3HU5N72zrccRQvE7WEr7Ng1BrU2FNeFJ53ELi75Lj9d7vnEwuOgkjhm
         eYk+eHgCuHYBDIEg460n+TTVvKS2u5IsprxYiOYMK8wturRx7dNLQmDJBzAF/fcvNa
         9FBhd9HEyI7qM5l2YSI2KJvgBAq9kY8NdLFp4jYs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FF0C6087D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org
Cc:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v1 6/6] arm64: dts: qcom: msm8998: Add USB-related nodes
Date:   Fri,  4 Jan 2019 09:51:29 -0700
Message-Id: <1546620689-2578-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for USB and related PHYs.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 22 ++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi     | 90 +++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index 50e9033..dc703fc 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -257,3 +257,25 @@
 	pinctrl-0 = <&sdc2_clk_on  &sdc2_cmd_on  &sdc2_data_on  &sdc2_cd_on>;
 	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
 };
+
+&usb1 {
+	status = "okay";
+};
+
+&usb1_dwc3 {
+	dr_mode = "host"; /* Force to host until we have Type-C hooked up */
+};
+
+&usb1_hsphy {
+	status = "okay";
+
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
+};
+
+&usb1_qmpphy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l2a_1p2>;
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 8d41b69..7c31c97 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -540,6 +540,11 @@
 			reg = <0x780000 0x621c>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			qusb2_hstx_trim: hstx-trim@423a {
+				reg = <0x423a 0x1>;
+				bits = <0 4>;
+			};
 		};
 
 		gcc: clock-controller@100000 {
@@ -607,6 +612,91 @@
 			#mbox-cells = <1>;
 		};
 
+		usb1: usb@a8f8800 {
+			compatible = "qcom,msm8998-dwc3", "qcom,dwc3";
+			reg = <0xa8f8800 0x400>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_AXI_CLK>,
+				 <&gcc GCC_USB30_MASTER_CLK>,
+				 <&gcc GCC_AGGRE1_USB3_AXI_CLK>,
+				 <&gcc GCC_USB30_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB30_SLEEP_CLK>;
+			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
+				      "sleep";
+
+			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <120000000>;
+
+			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq";
+
+			power-domains = <&gcc USB_30_GDSC>;
+
+			resets = <&gcc GCC_USB_30_BCR>;
+
+			usb1_dwc3: dwc3@a800000 {
+				compatible = "snps,dwc3";
+				reg = <0xa800000 0xcd00>;
+				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				phys = <&usb1_hsphy>, <&usb1_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
+				snps,has-lpm-erratum;
+				snps,hird-threshold = /bits/ 8 <0x10>;
+			};
+		};
+
+		usb1_qmpphy: phy@c010000 {
+			compatible = "qcom,msm8998-qmp-usb3-phy";
+			reg = <0xc010000 0x18c>;
+			status = "disabled";
+			#clock-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
+				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				 <&gcc GCC_USB3_CLKREF_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_USB3_PHY_BCR>,
+				 <&gcc GCC_USB3PHY_PHY_BCR>;
+			reset-names = "phy", "common";
+
+			usb1_ssphy: lane@c010200 {
+				reg = <0xc010200 0x128>,
+				      <0xc010400 0x200>,
+				      <0xc010c00 0x20c>;
+				#phy-cells = <0>;
+				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_phy_pipe_clk_src";
+			};
+		};
+
+		usb1_hsphy: phy@c012000 {
+			compatible = "qcom,msm8998-qusb2-phy";
+			reg = <0xc012000 0x2a8>;
+			status = "disabled";
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				 <&gcc GCC_RX1_USB2_CLKREF_CLK>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+
+			nvmem-cells = <&qusb2_hstx_trim>;
+		};
+
 		sdhc2: sdhci@c0a4900 {
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0xc0a4900 0x314>, <0xc0a4000 0x800>;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

