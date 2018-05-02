Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeEBUMC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 16:12:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55663 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbeEBUL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 16:11:59 -0400
X-Google-Smtp-Source: AB8JxZoVE02qfg7shbvBAuvnD/OrVQrBkFXDis2BMdnPelvV3CI7i7f7RMYzzWg8+6vofQqMPYAwJQ==
From: Mathieu Malaterre <malat@debian.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: malat@debian.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm: exynos/s3c: dts: Remove leading 0x and 0s from bindings notation
Date: Wed,  2 May 2018 22:11:52 +0200
Message-Id: <20180502201153.7459-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171215124630.30082-1-malat@debian.org>
References: <20171215124630.30082-1-malat@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the DTS files by removing all the leading "0x" and zeros to fix the
following dtc warnings:

Warning (unit_address_format): Node /XXX unit name should not have leading "0x"

and

Warning (unit_address_format): Node /XXX unit name should not have leading 0s

Converted using the following command:

find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed  -i -e "s/@\([0-9a-fA-FxX\.;:#]\+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0\+\(.*\) {/@0\1 {/g" {} +

For simplicity, two sed expressions were used to solve each warnings separately.

To make the regex expression more robust a few other issues were resolved,
namely setting unit-address to lower case, and adding a whitespace before the
the opening curly brace:

https://elinux.org/Device_Tree_Linux#Linux_conventions

This will solve as a side effect warning:

Warning (simple_bus_reg): Node /XXX@<UPPER> simple-bus unit address format error, expected "<lower>"

This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")

Reported-by: David Daney <ddaney@caviumnetworks.com>
Suggested-by: Rob Herring <robh@kernel.org>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: intermediate patch contained unrelated changes. restrict to S3 and Exynos*

 arch/arm/boot/dts/exynos5420.dtsi | 36 ++++++++++++++++++------------------
 arch/arm/boot/dts/s3c2416.dtsi    |  8 ++++----
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 2f3cb2a97f71..633952a96427 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -761,7 +761,7 @@
 			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
-		sysmmu_g2dr: sysmmu@0x10A60000 {
+		sysmmu_g2dr: sysmmu@10a60000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x10A60000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -771,7 +771,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_g2dw: sysmmu@0x10A70000 {
+		sysmmu_g2dw: sysmmu@10a70000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x10A70000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -781,7 +781,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_tv: sysmmu@0x14650000 {
+		sysmmu_tv: sysmmu@14650000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x14650000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -792,7 +792,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_gscl0: sysmmu@0x13E80000 {
+		sysmmu_gscl0: sysmmu@13e80000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x13E80000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -803,7 +803,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_gscl1: sysmmu@0x13E90000 {
+		sysmmu_gscl1: sysmmu@13e90000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x13E90000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -814,7 +814,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_scaler0r: sysmmu@0x12880000 {
+		sysmmu_scaler0r: sysmmu@12880000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x12880000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -824,7 +824,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_scaler1r: sysmmu@0x12890000 {
+		sysmmu_scaler1r: sysmmu@12890000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x12890000 0x1000>;
 			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
@@ -833,7 +833,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_scaler2r: sysmmu@0x128A0000 {
+		sysmmu_scaler2r: sysmmu@128a0000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x128A0000 0x1000>;
 			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
@@ -842,7 +842,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_scaler0w: sysmmu@0x128C0000 {
+		sysmmu_scaler0w: sysmmu@128c0000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x128C0000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -852,7 +852,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_scaler1w: sysmmu@0x128D0000 {
+		sysmmu_scaler1w: sysmmu@128d0000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x128D0000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -862,7 +862,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_scaler2w: sysmmu@0x128E0000 {
+		sysmmu_scaler2w: sysmmu@128e0000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x128E0000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -872,7 +872,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_rotator: sysmmu@0x11D40000 {
+		sysmmu_rotator: sysmmu@11d40000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x11D40000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -882,7 +882,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_jpeg0: sysmmu@0x11F10000 {
+		sysmmu_jpeg0: sysmmu@11f10000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x11F10000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -892,7 +892,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_jpeg1: sysmmu@0x11F20000 {
+		sysmmu_jpeg1: sysmmu@11f20000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x11F20000 0x1000>;
 			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
@@ -901,7 +901,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_mfc_l: sysmmu@0x11200000 {
+		sysmmu_mfc_l: sysmmu@11200000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x11200000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -912,7 +912,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_mfc_r: sysmmu@0x11210000 {
+		sysmmu_mfc_r: sysmmu@11210000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x11210000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -923,7 +923,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_fimd1_0: sysmmu@0x14640000 {
+		sysmmu_fimd1_0: sysmmu@14640000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x14640000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -934,7 +934,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_fimd1_1: sysmmu@0x14680000 {
+		sysmmu_fimd1_1: sysmmu@14680000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x14680000 0x1000>;
 			interrupt-parent = <&combiner>;
diff --git a/arch/arm/boot/dts/s3c2416.dtsi b/arch/arm/boot/dts/s3c2416.dtsi
index 3c7385cab248..46cf85f3c18b 100644
--- a/arch/arm/boot/dts/s3c2416.dtsi
+++ b/arch/arm/boot/dts/s3c2416.dtsi
@@ -30,7 +30,7 @@
 		compatible = "samsung,s3c2416-irq";
 	};
 
-	clocks: clock-controller@0x4c000000 {
+	clocks: clock-controller@4c000000 {
 		compatible = "samsung,s3c2416-clock";
 		reg = <0x4c000000 0x40>;
 		#clock-cells = <1>;
@@ -69,7 +69,7 @@
 				<&clocks SCLK_UART>;
 	};
 
-	uart_3: serial@5000C000 {
+	uart_3: serial@5000c000 {
 		compatible = "samsung,s3c2440-uart";
 		reg = <0x5000C000 0x4000>;
 		interrupts = <1 18 24 4>, <1 18 25 4>;
@@ -80,7 +80,7 @@
 		status = "disabled";
 	};
 
-	sdhci_1: sdhci@4AC00000 {
+	sdhci_1: sdhci@4ac00000 {
 		compatible = "samsung,s3c6410-sdhci";
 		reg = <0x4AC00000 0x100>;
 		interrupts = <0 0 21 3>;
@@ -91,7 +91,7 @@
 		status = "disabled";
 	};
 
-	sdhci_0: sdhci@4A800000 {
+	sdhci_0: sdhci@4a800000 {
 		compatible = "samsung,s3c6410-sdhci";
 		reg = <0x4A800000 0x100>;
 		interrupts = <0 0 20 3>;
-- 
2.11.0
