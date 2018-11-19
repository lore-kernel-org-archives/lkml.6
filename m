Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FD8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B552206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B552206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeKSTsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:48:52 -0500
Received: from ns.mm-sol.com ([37.157.136.199]:58276 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbeKSTsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:48:52 -0500
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 37EE04F883;
        Mon, 19 Nov 2018 11:25:47 +0200 (EET)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vivek.gautam@codeaurora.org,
        Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: msm8996: Add CAMSS support
Date:   Mon, 19 Nov 2018 11:25:37 +0200
Message-Id: <1542619537-24038-2-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542619537-24038-1-git-send-email-todor.tomov@linaro.org>
References: <1542619537-24038-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the Camera Subsystem present on the Qualcomm
MSM8996 SoC.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 135 ++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index a4d087e5..8585c61 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -967,6 +967,141 @@
 			status = "ok";
 		};
 
+		camss: camss@a00000 {
+			compatible = "qcom,msm8996-camss";
+			reg = <0xa34000 0x1000>,
+				<0xa00030 0x4>,
+				<0xa35000 0x1000>,
+				<0xa00038 0x4>,
+				<0xa36000 0x1000>,
+				<0xa00040 0x4>,
+				<0xa30000 0x100>,
+				<0xa30400 0x100>,
+				<0xa30800 0x100>,
+				<0xa30c00 0x100>,
+				<0xa31000 0x500>,
+				<0xa00020 0x10>,
+				<0xa10000 0x1000>,
+				<0xa14000 0x1000>;
+			reg-names = "csiphy0",
+				"csiphy0_clk_mux",
+				"csiphy1",
+				"csiphy1_clk_mux",
+				"csiphy2",
+				"csiphy2_clk_mux",
+				"csid0",
+				"csid1",
+				"csid2",
+				"csid3",
+				"ispif",
+				"csi_clk_mux",
+				"vfe0",
+				"vfe1";
+			interrupts = <GIC_SPI 78 0>,
+				<GIC_SPI 79 0>,
+				<GIC_SPI 80 0>,
+				<GIC_SPI 296 0>,
+				<GIC_SPI 297 0>,
+				<GIC_SPI 298 0>,
+				<GIC_SPI 299 0>,
+				<GIC_SPI 309 0>,
+				<GIC_SPI 314 0>,
+				<GIC_SPI 315 0>;
+			interrupt-names = "csiphy0",
+				"csiphy1",
+				"csiphy2",
+				"csid0",
+				"csid1",
+				"csid2",
+				"csid3",
+				"ispif",
+				"vfe0",
+				"vfe1";
+			power-domains = <&mmcc VFE0_GDSC>;
+			clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
+				<&mmcc CAMSS_ISPIF_AHB_CLK>,
+				<&mmcc CAMSS_CSI0PHYTIMER_CLK>,
+				<&mmcc CAMSS_CSI1PHYTIMER_CLK>,
+				<&mmcc CAMSS_CSI2PHYTIMER_CLK>,
+				<&mmcc CAMSS_CSI0_AHB_CLK>,
+				<&mmcc CAMSS_CSI0_CLK>,
+				<&mmcc CAMSS_CSI0PHY_CLK>,
+				<&mmcc CAMSS_CSI0PIX_CLK>,
+				<&mmcc CAMSS_CSI0RDI_CLK>,
+				<&mmcc CAMSS_CSI1_AHB_CLK>,
+				<&mmcc CAMSS_CSI1_CLK>,
+				<&mmcc CAMSS_CSI1PHY_CLK>,
+				<&mmcc CAMSS_CSI1PIX_CLK>,
+				<&mmcc CAMSS_CSI1RDI_CLK>,
+				<&mmcc CAMSS_CSI2_AHB_CLK>,
+				<&mmcc CAMSS_CSI2_CLK>,
+				<&mmcc CAMSS_CSI2PHY_CLK>,
+				<&mmcc CAMSS_CSI2PIX_CLK>,
+				<&mmcc CAMSS_CSI2RDI_CLK>,
+				<&mmcc CAMSS_CSI3_AHB_CLK>,
+				<&mmcc CAMSS_CSI3_CLK>,
+				<&mmcc CAMSS_CSI3PHY_CLK>,
+				<&mmcc CAMSS_CSI3PIX_CLK>,
+				<&mmcc CAMSS_CSI3RDI_CLK>,
+				<&mmcc CAMSS_AHB_CLK>,
+				<&mmcc CAMSS_VFE0_CLK>,
+				<&mmcc CAMSS_CSI_VFE0_CLK>,
+				<&mmcc CAMSS_VFE0_AHB_CLK>,
+				<&mmcc CAMSS_VFE0_STREAM_CLK>,
+				<&mmcc CAMSS_VFE1_CLK>,
+				<&mmcc CAMSS_CSI_VFE1_CLK>,
+				<&mmcc CAMSS_VFE1_AHB_CLK>,
+				<&mmcc CAMSS_VFE1_STREAM_CLK>,
+				<&mmcc CAMSS_VFE_AHB_CLK>,
+				<&mmcc CAMSS_VFE_AXI_CLK>;
+			clock-names = "top_ahb",
+				"ispif_ahb",
+				"csiphy0_timer",
+				"csiphy1_timer",
+				"csiphy2_timer",
+				"csi0_ahb",
+				"csi0",
+				"csi0_phy",
+				"csi0_pix",
+				"csi0_rdi",
+				"csi1_ahb",
+				"csi1",
+				"csi1_phy",
+				"csi1_pix",
+				"csi1_rdi",
+				"csi2_ahb",
+				"csi2",
+				"csi2_phy",
+				"csi2_pix",
+				"csi2_rdi",
+				"csi3_ahb",
+				"csi3",
+				"csi3_phy",
+				"csi3_pix",
+				"csi3_rdi",
+				"ahb",
+				"vfe0",
+				"csi_vfe0",
+				"vfe0_ahb",
+				"vfe0_stream",
+				"vfe1",
+				"csi_vfe1",
+				"vfe1_ahb",
+				"vfe1_stream",
+				"vfe_ahb",
+				"vfe_axi";
+			vdda-supply = <&pm8994_l2>;
+			iommus = <&vfe_smmu 0>,
+				 <&vfe_smmu 1>,
+				 <&vfe_smmu 2>,
+				 <&vfe_smmu 3>;
+			status = "disabled";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		agnoc@0 {
 			power-domains = <&gcc AGGRE0_NOC_GDSC>;
 			compatible = "simple-pm-bus";
-- 
2.7.4

