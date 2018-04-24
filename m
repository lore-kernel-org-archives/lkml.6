Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeDXRqg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752513AbeDXRqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:46:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327CA204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] ARM: dts: exynos: Remove unnecessary address/size properties in Midas boards
Date: Tue, 24 Apr 2018 19:45:58 +0200
Message-Id: <20180424174602.3915-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The children of regulators node do not have reg/ranges properties.  Move the
children up one level, get rid of regulators node and remove
address-cells and size-cells properties.  This fixes warnings for
Exynos4412 Midas family boards:

    arch/arm/boot/dts/exynos4412-i9300.dtb: Warning (avoid_unnecessary_addr_size):
        /regulators: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
    arch/arm/boot/dts/exynos4412-i9305.dtb: Warning (avoid_unnecessary_addr_size):
        /regulators: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
    arch/arm/boot/dts/exynos4412-n710x.dtb: Warning (avoid_unnecessary_addr_size):
        /regulators: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi | 32 +++++------
 arch/arm/boot/dts/exynos4412-midas.dtsi     | 86 ++++++++++++++---------------
 2 files changed, 55 insertions(+), 63 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
index ee8e1f445370..31cd5f6fd83c 100644
--- a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
+++ b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
@@ -15,24 +15,22 @@
 		i2c10 = &i2c_cm36651;
 	};
 
-	regulators {
-		lcd_vdd3_reg: voltage-regulator-2 {
-			compatible = "regulator-fixed";
-			regulator-name = "LCD_VDD_2.2V";
-			regulator-min-microvolt = <2200000>;
-			regulator-max-microvolt = <2200000>;
-			gpio = <&gpc0 1 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	lcd_vdd3_reg: voltage-regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "LCD_VDD_2.2V";
+		regulator-min-microvolt = <2200000>;
+		regulator-max-microvolt = <2200000>;
+		gpio = <&gpc0 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		ps_als_reg: voltage-regulator-5 {
-			compatible = "regulator-fixed";
-			regulator-name = "LED_A_3.0V";
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3000000>;
-			gpio = <&gpj0 5 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	ps_als_reg: voltage-regulator-5 {
+		compatible = "regulator-fixed";
+		regulator-name = "LED_A_3.0V";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&gpj0 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
 
 	i2c_ak8975: i2c-gpio-0 {
diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 76f2b30f1731..4b182e26cfc8 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -46,56 +46,50 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cam_io_reg: voltage-regulator-1 {
-			compatible = "regulator-fixed";
-			regulator-name = "CAM_SENSOR_A";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-			enable-active-high;
-			status = "disabled";
-		};
+	cam_io_reg: voltage-regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "CAM_SENSOR_A";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		enable-active-high;
+		status = "disabled";
+	};
 
-		cam_af_reg: voltage-regulator-3 {
-			compatible = "regulator-fixed";
-			regulator-name = "CAM_AF";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-			enable-active-high;
-			status = "disabled";
-		};
+	cam_af_reg: voltage-regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "CAM_AF";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		enable-active-high;
+		status = "disabled";
+	};
 
-		vsil12: voltage-regulator-6 {
-			compatible = "regulator-fixed";
-			regulator-name = "VSIL_1.2V";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			gpio = <&gpl0 4 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-			vin-supply = <&buck7_reg>;
-		};
+	vsil12: voltage-regulator-6 {
+		compatible = "regulator-fixed";
+		regulator-name = "VSIL_1.2V";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		gpio = <&gpl0 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&buck7_reg>;
+	};
 
-		vcc33mhl: voltage-regulator-7 {
-			compatible = "regulator-fixed";
-			regulator-name = "VCC_3.3_MHL";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpl0 4 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	vcc33mhl: voltage-regulator-7 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3.3_MHL";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpl0 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		vcc18mhl: voltage-regulator-8 {
-			compatible = "regulator-fixed";
-			regulator-name = "VCC_1.8_MHL";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			gpio = <&gpl0 4 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	vcc18mhl: voltage-regulator-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1.8_MHL";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpl0 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
 
 	gpio-keys {
-- 
2.14.1
