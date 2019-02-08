Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DATE_IN_PAST_06_12,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E979C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 07:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E869720857
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 07:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfBIH7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 02:59:16 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:47910 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfBIH7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 02:59:16 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id CEEAD19F4EA;
        Sat,  9 Feb 2019 08:58:37 +0100 (CET)
Subject: [PATCH v4 7/7] arm64: dts: qcom: msm8998: Add UFS nodes
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     MSM <linux-arm-msm@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Petersen <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <09ce9c20-c47b-f936-a8a9-6c8ec8f0f867@free.fr>
Message-ID: <195f153d-9e66-d571-2c1a-1ec2c7c7d222@free.fr>
Date:   Fri, 8 Feb 2019 23:22:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <09ce9c20-c47b-f936-a8a9-6c8ec8f0f867@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UFS host controller and PHY DT nodes for msm8998.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 19 +++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi     | 62 +++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index 19775cae1381..3e911488d4f3 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -284,3 +284,22 @@
 	vdda-phy-supply = <&vreg_l1a_0p875>;
 	vdda-pll-supply = <&vreg_l2a_1p2>;
 };
+
+&ufshc {
+	vcc-supply = <&vreg_l20a_2p95>;
+	vccq-supply = <&vreg_l26a_1p2>;
+	vccq2-supply = <&vreg_s4a_1p8>;
+	vcc-max-microamp = <750000>;
+	vccq-max-microamp = <560000>;
+	vccq2-max-microamp = <750000>;
+};
+
+&ufsphy {
+	vdda-phy-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l2a_1p2>;
+	vddp-ref-clk-supply = <&vreg_l26a_1p2>;
+	vdda-phy-max-microamp = <51400>;
+	vdda-pll-max-microamp = <14600>;
+	vddp-ref-clk-max-microamp = <100>;
+	vddp-ref-clk-always-on;
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 043ff2d2643c..d69401152089 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -983,6 +983,68 @@
 			redistributor-stride = <0x0 0x20000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		ufshc: ufshc@1da4000 {
+			compatible = "qcom,msm8998-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
+			reg = <0x01da4000 0x2500>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&ufsphy_lanes>;
+			phy-names = "ufsphy";
+			lanes-per-direction = <2>;
+			power-domains = <&gcc UFS_GDSC>;
+
+			clock-names =
+				"core_clk",
+				"bus_aggr_clk",
+				"iface_clk",
+				"core_clk_unipro",
+				"ref_clk",
+				"tx_lane0_sync_clk",
+				"rx_lane0_sync_clk",
+				"rx_lane1_sync_clk";
+			clocks =
+				<&gcc GCC_UFS_AXI_CLK>,
+				<&gcc GCC_AGGRE1_UFS_AXI_CLK>,
+				<&gcc GCC_UFS_AHB_CLK>,
+				<&gcc GCC_UFS_UNIPRO_CORE_CLK>,
+				<&rpmcc RPM_SMD_LN_BB_CLK1>,
+				<&gcc GCC_UFS_TX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_RX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_RX_SYMBOL_1_CLK>;
+			freq-table-hz =
+				<50000000 200000000>,
+				<0 0>,
+				<0 0>,
+				<37500000 150000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>;
+
+			resets = <&gcc GCC_UFS_BCR>;
+			reset-names = "rst";
+		};
+
+		ufsphy: phy@1da7000 {
+			compatible = "qcom,msm8998-qmp-ufs-phy";
+			reg = <0x01da7000 0x18c>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clock-names = "ref", "ref_aux";
+			clocks =
+				<&gcc GCC_UFS_CLKREF_CLK>,
+				<&gcc GCC_UFS_PHY_AUX_CLK>;
+
+			ufsphy_lanes: lanes@1da7400 {
+				reg = <0x01da7400 0x128>,
+				      <0x01da7600 0x1fc>,
+				      <0x01da7c00 0x1dc>,
+				      <0x01da7800 0x128>,
+				      <0x01da7a00 0x1fc>;
+				#phy-cells = <0>;
+			};
+		};
 	};
 };
 
-- 
2.17.1
