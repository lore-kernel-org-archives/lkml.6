Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DBEECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D00020875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D00020875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbeGXLtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:49:22 -0400
Received: from mout.perfora.net ([74.208.4.196]:58595 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388413AbeGXLtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:49:21 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LebdI-1gMGI63x3m-00qNqi; Tue, 24 Jul 2018 12:43:25 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 05/15] ARM: tegra: apalis-tk1: regulator clean-up
Date:   Tue, 24 Jul 2018 12:42:59 +0200
Message-Id: <20180724104309.21741-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724104309.21741-1-marcel@ziswiler.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Xxa72Y0uwmR/3Txyp+zP1dB1IyPoxYd/i3SSDJWzWtQSIc0eMGu
 TJlGm/s9CosDLLe011wG6igEN7p/tgSavrLgn6iZ5U5iO0GIp5cuREQhXuQ/urOTz+a1ud+
 AuoPawTUVEo876dk4xpF0ZJxmavYC5eD8cFm1C2DIlTK+XECFzSjRw1grk+3n3adyZQD8RU
 u/9skj1+gEcwfSpSpLF0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N70S90FU8eM=:LWHJSH1TbKMyDUvz9b9evu
 4EOtEeWHJjnJnu6oRz3U8Mi8815O+xYarBgihqZh7XWKSsEol/qZeoufUFUaxDYC+AfiNs/jr
 3pcVD4eHSddf7wLcrn0RMw7IuPLRysx15eL2Q4Q7czVVZLiHhpgNsh8cQUAmq9zSK8B3jiYgu
 jmsfXXWIFxg/WJamh8spQTHAaxnTBAU5SQnibH3/51LsidIbz4ydjeZJdhqW5CkVmkXUh6LCN
 cQn+YuOlS/mKaoRy0d0F49gnO+CFjdQ1V0hRlwgplP7NOAowdIBq6KwiF9JtZXX2seC01EPfq
 jAOq9iS2JiyOtn1ZuD1YtJ10EHXtvAIKLpre/KbjMSVCITr1e3p5BwGsOgBUcEMR9BqOkpo6b
 n2MbUjEwiwvPvTYCa66QHeyvj4Ip9mh6oEGW2q3/W6AHZn4T3ZHP75QBDkO3uisPicR23Wr6J
 PDoCFhIg1EszSIV78sHoheErNcSrJJA0yfX/QMmqX8TY+a0GWyCgBWI2lfvUbW7ADWgcC4Ddj
 LWYEOcOVI3vmLnPjYyiEN+RcbOsBPYlWn/3SMchBm637yEl/HLszRyyaYXDOLW0ojjkPBwznR
 KBFMz7EcgEedhX5m37UtVwosblWEH8xhftjkH7jXyxF9MfAuLNGYiZjx5PO4p/Z3Kr7S7aiz8
 BELYhp/peI8MZpWzQUMaFEIfGDG/oB7ir53TBKWGL1FdA7KiqxeUOAnwvbeZXjisRgao=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Just cosmetic regulator clean-up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 100 ++++++++++++++--------------
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 100 ++++++++++++++--------------
 2 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index fe74dd73a572..8323fddceed8 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -21,13 +21,13 @@
 
 	pcie@1003000 {
 		status = "okay";
-		avddio-pex-supply = <&vdd_1v05>;
-		avdd-pex-pll-supply = <&vdd_1v05>;
-		avdd-pll-erefe-supply = <&avdd_1v05>;
-		dvddio-pex-supply = <&vdd_1v05>;
-		hvdd-pex-pll-e-supply = <&reg_3v3>;
-		hvdd-pex-supply = <&reg_3v3>;
-		vddio-pex-ctl-supply = <&reg_3v3>;
+		avddio-pex-supply = <&reg_1v05_vdd>;
+		avdd-pex-pll-supply = <&reg_1v05_vdd>;
+		avdd-pll-erefe-supply = <&reg_1v05_avdd>;
+		dvddio-pex-supply = <&reg_1v05_vdd>;
+		hvdd-pex-pll-e-supply = <&reg_module_3v3>;
+		hvdd-pex-supply = <&reg_module_3v3>;
+		vddio-pex-ctl-supply = <&reg_module_3v3>;
 
 		/* Apalis PCIe (additional lane Apalis type specific) */
 		pci@1,0 {
@@ -65,7 +65,7 @@
 		 * Node left disabled on purpose - the bootloader will enable
 		 * it after having set the VPR up
 		 */
-		vdd-supply = <&vdd_gpu>;
+		vdd-supply = <&reg_vdd_gpu>;
 	};
 
 	pinmux: pinmux@70000868 {
@@ -1565,8 +1565,8 @@
 		sgtl5000: codec@a {
 			compatible = "fsl,sgtl5000";
 			reg = <0x0a>;
-			VDDA-supply = <&reg_3v3>;
-			VDDIO-supply = <&vddio_1v8>;
+			VDDA-supply = <&reg_module_3v3>;
+			VDDIO-supply = <&reg_1v8_vddio>;
 			clocks = <&tegra_car TEGRA124_CLK_EXTERN1>;
 		};
 
@@ -1598,18 +1598,18 @@
 			};
 
 			regulators {
-				vsup-sd2-supply = <&reg_3v3>;
-				vsup-sd3-supply = <&reg_3v3>;
-				vsup-sd4-supply = <&reg_3v3>;
-				vsup-sd5-supply = <&reg_3v3>;
-				vin-ldo0-supply = <&vddio_ddr_1v35>;
-				vin-ldo1-6-supply = <&reg_3v3>;
-				vin-ldo2-5-7-supply = <&vddio_1v8>;
-				vin-ldo3-4-supply = <&reg_3v3>;
-				vin-ldo9-10-supply = <&reg_3v3>;
-				vin-ldo11-supply = <&reg_3v3>;
-
-				vdd_cpu: sd0 {
+				vsup-sd2-supply = <&reg_module_3v3>;
+				vsup-sd3-supply = <&reg_module_3v3>;
+				vsup-sd4-supply = <&reg_module_3v3>;
+				vsup-sd5-supply = <&reg_module_3v3>;
+				vin-ldo0-supply = <&reg_1v35_vddio_ddr>;
+				vin-ldo1-6-supply = <&reg_module_3v3>;
+				vin-ldo2-5-7-supply = <&reg_1v8_vddio>;
+				vin-ldo3-4-supply = <&reg_module_3v3>;
+				vin-ldo9-10-supply = <&reg_module_3v3>;
+				vin-ldo11-supply = <&reg_module_3v3>;
+
+				reg_vdd_cpu: sd0 {
 					regulator-name = "+VDD_CPU_AP";
 					regulator-min-microvolt = <700000>;
 					regulator-max-microvolt = <1400000>;
@@ -1631,7 +1631,7 @@
 					ams,ext-control = <1>;
 				};
 
-				vddio_ddr_1v35: sd2 {
+				reg_1v35_vddio_ddr: sd2 {
 					regulator-name =
 						"+V1.35_VDDIO_DDR(sd2)";
 					regulator-min-microvolt = <1350000>;
@@ -1649,13 +1649,13 @@
 					regulator-boot-on;
 				};
 
-				vdd_1v05: sd4 {
+				reg_1v05_vdd: sd4 {
 					regulator-name = "+V1.05";
 					regulator-min-microvolt = <1050000>;
 					regulator-max-microvolt = <1050000>;
 				};
 
-				vddio_1v8: sd5 {
+				reg_1v8_vddio: sd5 {
 					regulator-name = "+V1.8";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
@@ -1663,7 +1663,7 @@
 					regulator-always-on;
 				};
 
-				vdd_gpu: sd6 {
+				reg_vdd_gpu: sd6 {
 					regulator-name = "+VDD_GPU_AP";
 					regulator-min-microvolt = <650000>;
 					regulator-max-microvolt = <1200000>;
@@ -1673,7 +1673,7 @@
 					regulator-always-on;
 				};
 
-				avdd_1v05: ldo0 {
+				reg_1v05_avdd: ldo0 {
 					regulator-name = "+V1.05_AVDD";
 					regulator-min-microvolt = <1050000>;
 					regulator-max-microvolt = <1050000>;
@@ -1785,9 +1785,9 @@
 	sata@70020000 {
 		phys = <&{/padctl@7009f000/pads/sata/lanes/sata-0}>;
 		phy-names = "sata-0";
-		avdd-supply = <&vdd_1v05>;
-		hvdd-supply = <&reg_3v3>;
-		vddio-supply = <&vdd_1v05>;
+		avdd-supply = <&reg_1v05_vdd>;
+		hvdd-supply = <&reg_module_3v3>;
+		vddio-supply = <&reg_1v05_vdd>;
 	};
 
 	usb@70090000 {
@@ -1798,14 +1798,14 @@
 		       <&{/padctl@7009f000/pads/usb2/lanes/usb2-2}>,
 		       <&{/padctl@7009f000/pads/pcie/lanes/pcie-0}>;
 		phy-names = "usb2-0", "usb3-1", "usb2-1", "usb2-2", "usb3-0";
-		avddio-pex-supply = <&vdd_1v05>;
-		avdd-pll-erefe-supply = <&avdd_1v05>;
-		avdd-pll-utmip-supply = <&vddio_1v8>;
-		avdd-usb-ss-pll-supply = <&vdd_1v05>;
-		avdd-usb-supply = <&reg_3v3>;
-		dvddio-pex-supply = <&vdd_1v05>;
-		hvdd-usb-ss-pll-e-supply = <&reg_3v3>;
-		hvdd-usb-ss-supply = <&reg_3v3>;
+		avddio-pex-supply = <&reg_1v05_vdd>;
+		avdd-pll-erefe-supply = <&reg_1v05_avdd>;
+		avdd-pll-utmip-supply = <&reg_1v8_vddio>;
+		avdd-usb-ss-pll-supply = <&reg_1v05_vdd>;
+		avdd-usb-supply = <&reg_module_3v3>;
+		dvddio-pex-supply = <&reg_1v05_vdd>;
+		hvdd-usb-ss-pll-e-supply = <&reg_module_3v3>;
+		hvdd-usb-ss-supply = <&reg_module_3v3>;
 	};
 
 	padctl@7009f000 {
@@ -1921,7 +1921,7 @@
 	/* CPU DFLL clock */
 	clock@70110000 {
 		status = "okay";
-		vdd-cpu-supply = <&vdd_cpu>;
+		vdd-cpu-supply = <&reg_vdd_cpu>;
 		nvidia,i2c-fs-rate = <400000>;
 	};
 
@@ -1946,7 +1946,7 @@
 
 	cpus {
 		cpu@0 {
-			vdd-cpu-supply = <&vdd_cpu>;
+			vdd-cpu-supply = <&reg_vdd_cpu>;
 		};
 	};
 
@@ -1956,7 +1956,7 @@
 		regulator-min-microvolt = <1050000>;
 		regulator-max-microvolt = <1050000>;
 		gpio = <&gpio TEGRA_GPIO(H, 7) GPIO_ACTIVE_LOW>;
-		vin-supply = <&vdd_1v05>;
+		vin-supply = <&reg_1v05_vdd>;
 	};
 
 	reg_3v3_mxm: regulator-3v3-mxm {
@@ -1968,7 +1968,15 @@
 		regulator-boot-on;
 	};
 
-	reg_3v3: regulator-3v3 {
+	reg_3v3_avdd_hdmi: regulator-3v3-avdd-hdmi {
+		compatible = "regulator-fixed";
+		regulator-name = "+V3.3_AVDD_HDMI";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_1v05_vdd>;
+	};
+
+	reg_module_3v3: regulator-module-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "+V3.3";
 		regulator-min-microvolt = <3300000>;
@@ -1981,14 +1989,6 @@
 		vin-supply = <&reg_3v3_mxm>;
 	};
 
-	reg_3v3_avdd_hdmi: regulator-3v3-avdd-hdmi {
-		compatible = "regulator-fixed";
-		regulator-name = "+V3.3_AVDD_HDMI";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vdd_1v05>;
-	};
-
 	sound {
 		compatible = "toradex,tegra-audio-sgtl5000-apalis_tk1",
 			     "nvidia,tegra-audio-sgtl5000";
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 3fc41e25b5e8..4ad14c7a64db 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -56,13 +56,13 @@
 
 	pcie@1003000 {
 		status = "okay";
-		avddio-pex-supply = <&vdd_1v05>;
-		avdd-pex-pll-supply = <&vdd_1v05>;
-		avdd-pll-erefe-supply = <&avdd_1v05>;
-		dvddio-pex-supply = <&vdd_1v05>;
-		hvdd-pex-pll-e-supply = <&reg_3v3>;
-		hvdd-pex-supply = <&reg_3v3>;
-		vddio-pex-ctl-supply = <&reg_3v3>;
+		avddio-pex-supply = <&reg_1v05_vdd>;
+		avdd-pex-pll-supply = <&reg_1v05_vdd>;
+		avdd-pll-erefe-supply = <&reg_1v05_avdd>;
+		dvddio-pex-supply = <&reg_1v05_vdd>;
+		hvdd-pex-pll-e-supply = <&reg_module_3v3>;
+		hvdd-pex-supply = <&reg_module_3v3>;
+		vddio-pex-ctl-supply = <&reg_module_3v3>;
 
 		/* Apalis PCIe (additional lane Apalis type specific) */
 		pci@1,0 {
@@ -100,7 +100,7 @@
 		 * Node left disabled on purpose - the bootloader will enable
 		 * it after having set the VPR up
 		 */
-		vdd-supply = <&vdd_gpu>;
+		vdd-supply = <&reg_vdd_gpu>;
 	};
 
 	pinmux: pinmux@70000868 {
@@ -1594,8 +1594,8 @@
 		sgtl5000: codec@a {
 			compatible = "fsl,sgtl5000";
 			reg = <0x0a>;
-			VDDA-supply = <&reg_3v3>;
-			VDDIO-supply = <&vddio_1v8>;
+			VDDA-supply = <&reg_module_3v3>;
+			VDDIO-supply = <&reg_1v8_vddio>;
 			clocks = <&tegra_car TEGRA124_CLK_EXTERN1>;
 		};
 
@@ -1627,18 +1627,18 @@
 			};
 
 			regulators {
-				vsup-sd2-supply = <&reg_3v3>;
-				vsup-sd3-supply = <&reg_3v3>;
-				vsup-sd4-supply = <&reg_3v3>;
-				vsup-sd5-supply = <&reg_3v3>;
-				vin-ldo0-supply = <&vddio_ddr_1v35>;
-				vin-ldo1-6-supply = <&reg_3v3>;
-				vin-ldo2-5-7-supply = <&vddio_1v8>;
-				vin-ldo3-4-supply = <&reg_3v3>;
-				vin-ldo9-10-supply = <&reg_3v3>;
-				vin-ldo11-supply = <&reg_3v3>;
-
-				vdd_cpu: sd0 {
+				vsup-sd2-supply = <&reg_module_3v3>;
+				vsup-sd3-supply = <&reg_module_3v3>;
+				vsup-sd4-supply = <&reg_module_3v3>;
+				vsup-sd5-supply = <&reg_module_3v3>;
+				vin-ldo0-supply = <&reg_1v35_vddio_ddr>;
+				vin-ldo1-6-supply = <&reg_module_3v3>;
+				vin-ldo2-5-7-supply = <&reg_1v8_vddio>;
+				vin-ldo3-4-supply = <&reg_module_3v3>;
+				vin-ldo9-10-supply = <&reg_module_3v3>;
+				vin-ldo11-supply = <&reg_module_3v3>;
+
+				reg_vdd_cpu: sd0 {
 					regulator-name = "+VDD_CPU_AP";
 					regulator-min-microvolt = <700000>;
 					regulator-max-microvolt = <1400000>;
@@ -1660,7 +1660,7 @@
 					ams,ext-control = <1>;
 				};
 
-				vddio_ddr_1v35: sd2 {
+				reg_1v35_vddio_ddr: sd2 {
 					regulator-name =
 						"+V1.35_VDDIO_DDR(sd2)";
 					regulator-min-microvolt = <1350000>;
@@ -1678,13 +1678,13 @@
 					regulator-boot-on;
 				};
 
-				vdd_1v05: sd4 {
+				reg_1v05_vdd: sd4 {
 					regulator-name = "+V1.05";
 					regulator-min-microvolt = <1050000>;
 					regulator-max-microvolt = <1050000>;
 				};
 
-				vddio_1v8: sd5 {
+				reg_1v8_vddio: sd5 {
 					regulator-name = "+V1.8";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
@@ -1692,7 +1692,7 @@
 					regulator-always-on;
 				};
 
-				vdd_gpu: sd6 {
+				reg_vdd_gpu: sd6 {
 					regulator-name = "+VDD_GPU_AP";
 					regulator-min-microvolt = <650000>;
 					regulator-max-microvolt = <1200000>;
@@ -1702,7 +1702,7 @@
 					regulator-always-on;
 				};
 
-				avdd_1v05: ldo0 {
+				reg_1v05_avdd: ldo0 {
 					regulator-name = "+V1.05_AVDD";
 					regulator-min-microvolt = <1050000>;
 					regulator-max-microvolt = <1050000>;
@@ -1814,9 +1814,9 @@
 	sata@70020000 {
 		phys = <&{/padctl@7009f000/pads/sata/lanes/sata-0}>;
 		phy-names = "sata-0";
-		avdd-supply = <&vdd_1v05>;
-		hvdd-supply = <&reg_3v3>;
-		vddio-supply = <&vdd_1v05>;
+		avdd-supply = <&reg_1v05_vdd>;
+		hvdd-supply = <&reg_module_3v3>;
+		vddio-supply = <&reg_1v05_vdd>;
 	};
 
 	usb@70090000 {
@@ -1827,14 +1827,14 @@
 		       <&{/padctl@7009f000/pads/usb2/lanes/usb2-2}>,
 		       <&{/padctl@7009f000/pads/pcie/lanes/pcie-0}>;
 		phy-names = "usb2-0", "usb3-1", "usb2-1", "usb2-2", "usb3-0";
-		avddio-pex-supply = <&vdd_1v05>;
-		avdd-pll-erefe-supply = <&avdd_1v05>;
-		avdd-pll-utmip-supply = <&vddio_1v8>;
-		avdd-usb-ss-pll-supply = <&vdd_1v05>;
-		avdd-usb-supply = <&reg_3v3>;
-		dvddio-pex-supply = <&vdd_1v05>;
-		hvdd-usb-ss-pll-e-supply = <&reg_3v3>;
-		hvdd-usb-ss-supply = <&reg_3v3>;
+		avddio-pex-supply = <&reg_1v05_vdd>;
+		avdd-pll-erefe-supply = <&reg_1v05_avdd>;
+		avdd-pll-utmip-supply = <&reg_1v8_vddio>;
+		avdd-usb-ss-pll-supply = <&reg_1v05_vdd>;
+		avdd-usb-supply = <&reg_module_3v3>;
+		dvddio-pex-supply = <&reg_1v05_vdd>;
+		hvdd-usb-ss-pll-e-supply = <&reg_module_3v3>;
+		hvdd-usb-ss-supply = <&reg_module_3v3>;
 	};
 
 	padctl@7009f000 {
@@ -1950,7 +1950,7 @@
 	/* CPU DFLL clock */
 	clock@70110000 {
 		status = "okay";
-		vdd-cpu-supply = <&vdd_cpu>;
+		vdd-cpu-supply = <&reg_vdd_cpu>;
 		nvidia,i2c-fs-rate = <400000>;
 	};
 
@@ -1975,7 +1975,7 @@
 
 	cpus {
 		cpu@0 {
-			vdd-cpu-supply = <&vdd_cpu>;
+			vdd-cpu-supply = <&reg_vdd_cpu>;
 		};
 	};
 
@@ -1985,7 +1985,7 @@
 		regulator-min-microvolt = <1050000>;
 		regulator-max-microvolt = <1050000>;
 		gpio = <&gpio TEGRA_GPIO(H, 7) GPIO_ACTIVE_LOW>;
-		vin-supply = <&vdd_1v05>;
+		vin-supply = <&reg_1v05_vdd>;
 	};
 
 	reg_3v3_mxm: regulator-3v3-mxm {
@@ -1997,7 +1997,15 @@
 		regulator-boot-on;
 	};
 
-	reg_3v3: regulator-3v3 {
+	reg_3v3_avdd_hdmi: regulator-3v3-avdd-hdmi {
+		compatible = "regulator-fixed";
+		regulator-name = "+V3.3_AVDD_HDMI";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_1v05_vdd>;
+	};
+
+	reg_module_3v3: regulator-module-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "+V3.3";
 		regulator-min-microvolt = <3300000>;
@@ -2010,14 +2018,6 @@
 		vin-supply = <&reg_3v3_mxm>;
 	};
 
-	reg_3v3_avdd_hdmi: regulator-3v3-avdd-hdmi {
-		compatible = "regulator-fixed";
-		regulator-name = "+V3.3_AVDD_HDMI";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vdd_1v05>;
-	};
-
 	sound {
 		compatible = "toradex,tegra-audio-sgtl5000-apalis_tk1",
 			     "nvidia,tegra-audio-sgtl5000";
-- 
2.14.4

