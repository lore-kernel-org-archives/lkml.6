Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085A3C3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91B020861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZuCoTJE4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dTbUJos9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfAUVdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:33:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59194 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfAUVdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:33:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 560A36055C; Mon, 21 Jan 2019 21:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548106419;
        bh=Kcyx5pr18cuY72AHdlhwp86inY8+mPP35+NMaFJJ3DY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZuCoTJE4boaQocX8LIZ9kgn/p6ocedYiV7HgrUWuGLVFpRYtB6UgwxavTmYTRkFt4
         aGqiDX3C8hPADW49yu0y+mJLAjbTj+84tOfrJZrr4UO1EXtO81n5zUAkP7b2Ddup6L
         InFvmnH8s1pdWYQEUHJqRyKPd2BFQb7C4hM300co=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D84EB601D3;
        Mon, 21 Jan 2019 21:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548106418;
        bh=Kcyx5pr18cuY72AHdlhwp86inY8+mPP35+NMaFJJ3DY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dTbUJos9rwfDyP8t3Cba+IDr7bS7Klta1YIn46bt3XYzjzzGYduK7YHmra7Kq4v0a
         F9vAp/W7Eb6RAA1Wo7LwwaOO556usxNuu9FHp7CkyRt2dLReigMbQrp7YGrVVTCduj
         +aV7QEF0HJysMkAIygsq6ctGuLxy+9W81l5kSH1A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D84EB601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v3 3/3] arm64: dts: qcom: msm8998: Add USB-related nodes
Date:   Mon, 21 Jan 2019 14:33:28 -0700
Message-Id: <1548106408-5127-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548106307-4762-1-git-send-email-jhugo@codeaurora.org>
References: <1548106307-4762-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for USB and related PHYs.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 22 ++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi     | 92 +++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index 50e9033..23676ae 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -65,6 +65,13 @@
 	status = "okay";
 };
 
+&qusb2phy {
+	status = "okay";
+
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
+};
+
 &rpm_requests {
 	pm8998-regulators {
 		compatible = "qcom,rpm-pm8998-regulators";
@@ -257,3 +264,18 @@
 	pinctrl-0 = <&sdc2_clk_on  &sdc2_cmd_on  &sdc2_data_on  &sdc2_cd_on>;
 	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
 };
+
+&usb3 {
+	status = "okay";
+};
+
+&usb3_dwc3 {
+	dr_mode = "host"; /* Force to host until we have Type-C hooked up */
+};
+
+&usb3phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l2a_1p2>;
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 8d41b69..89d8bef 100644
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
@@ -607,6 +612,93 @@
 			#mbox-cells = <1>;
 		};
 
+		usb3: usb@a8f8800 {
+			compatible = "qcom,msm8998-dwc3", "qcom,dwc3";
+			reg = <0x0a8f8800 0x400>;
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
+			usb3_dwc3: dwc3@a800000 {
+				compatible = "snps,dwc3";
+				reg = <0x0a800000 0xcd00>;
+				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				phys = <&qusb2phy>, <&usb3phy>;
+				phy-names = "usb2-phy", "usb3-phy";
+				snps,has-lpm-erratum;
+				snps,hird-threshold = /bits/ 8 <0x10>;
+			};
+		};
+
+		usb3phy: phy@c010000 {
+			compatible = "qcom,msm8998-qmp-usb3-phy";
+			reg = <0x0c010000 0x18c>;
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
+				      <0xc010c00 0x20c>,
+				      <0xc010600 0x128>,
+				      <0xc010800 0x200>;
+				#phy-cells = <0>;
+				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_phy_pipe_clk_src";
+			};
+		};
+
+		qusb2phy: phy@c012000 {
+			compatible = "qcom,msm8998-qusb2-phy";
+			reg = <0x0c012000 0x2a8>;
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

