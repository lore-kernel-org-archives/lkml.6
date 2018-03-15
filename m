Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeCOHTc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 03:19:32 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:62159 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750722AbeCOHTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 03:19:30 -0400
From: <gabriel.fernandez@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gabriel.fernandez@st.com>
Subject: [PATCH] ARM: dts: stm32: Enable stm32mp1 clock driver on stm32mp157c
Date: Thu, 15 Mar 2018 08:18:47 +0100
Message-ID: <1521098327-13958-1-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch enables stm32mp1 clock driver.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 24 ++++++++--------
 arch/arm/boot/dts/stm32mp157c.dtsi        | 48 +++++++++++--------------------
 2 files changed, 28 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index c0743305..6f044100 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -20,7 +20,7 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x0 0x400>;
-				clocks = <&clk_pll3_p>;
+				clocks = <&rcc GPIOA>;
 				st,bank-name = "GPIOA";
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 0 16>;
@@ -32,7 +32,7 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x1000 0x400>;
-				clocks = <&clk_pll3_p>;
+				clocks = <&rcc GPIOB>;
 				st,bank-name = "GPIOB";
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 16 16>;
@@ -44,7 +44,7 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x2000 0x400>;
-				clocks = <&clk_pll3_p>;
+				clocks = <&rcc GPIOC>;
 				st,bank-name = "GPIOC";
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 32 16>;
@@ -56,7 +56,7 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x3000 0x400>;
-				clocks = <&clk_pll3_p>;
+				clocks = <&rcc GPIOD>;
 				st,bank-name = "GPIOD";
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 48 16>;
@@ -68,7 +68,7 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x4000 0x400>;
-				clocks = <&clk_pll3_p>;
+				clocks = <&rcc GPIOE>;
 				st,bank-name = "GPIOE";
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 64 16>;
@@ -80,7 +80,7 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x5000 0x400>;
-				clocks = <&clk_pll3_p>;
+				clocks = <&rcc GPIOF>;
 				st,bank-name = "GPIOF";
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 80 16>;
@@ -92,7 +92,7 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x6000 0x400>;
-				clocks = <&clk_pll3_p>;
+				clocks = <&rcc GPIOG>;
 				st,bank-name = "GPIOG";
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 96 16>;
@@ -104,7 +104,7 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x7000 0x400>;
-				clocks = <&clk_pll3_p>;
+				clocks = <&rcc GPIOH>;
 				st,bank-name = "GPIOH";
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 112 16>;
@@ -116,7 +116,7 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x8000 0x400>;
-				clocks = <&clk_pll3_p>;
+				clocks = <&rcc GPIOI>;
 				st,bank-name = "GPIOI";
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 128 16>;
@@ -128,7 +128,7 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x9000 0x400>;
-				clocks = <&clk_pll3_p>;
+				clocks = <&rcc GPIOJ>;
 				st,bank-name = "GPIOJ";
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 144 16>;
@@ -140,7 +140,7 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0xa000 0x400>;
-				clocks = <&clk_pll3_p>;
+				clocks = <&rcc GPIOK>;
 				st,bank-name = "GPIOK";
 				ngpios = <8>;
 				gpio-ranges = <&pinctrl 0 160 8>;
@@ -174,7 +174,7 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0 0x400>;
-				clocks = <&clk_pll2_p>;
+				clocks = <&rcc GPIOZ>;
 				st,bank-name = "GPIOZ";
 				st,bank-ioport = <11>;
 				ngpios = <8>;
diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 9e17e42..bc3eddc 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -4,6 +4,7 @@
  * Author: Ludovic Barre <ludovic.barre@st.com> for STMicroelectronics.
  */
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/stm32mp1-clks.h>
 
 / {
 	#address-cells = <1>;
@@ -71,12 +72,6 @@
 			clock-frequency = <24000000>;
 		};
 
-		clk_pll_per: clk-pll-per {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <64000000>;
-		};
-
 		clk_hsi: clk-hsi {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
@@ -100,24 +95,6 @@
 			compatible = "fixed-clock";
 			clock-frequency = <4000000>;
 		};
-
-		clk_pclk1: clk-pclk1 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <86000000>;
-		};
-
-		clk_pll3_p: clk-pll3_p {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <172000000>;
-		};
-
-		clk_pll2_p: clk-pll2_p {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <264000000>;
-		};
 	};
 
 	soc {
@@ -131,7 +108,7 @@
 			compatible = "st,stm32h7-uart";
 			reg = <0x4000e000 0x400>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_NONE>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc USART2_K>;
 			status = "disabled";
 		};
 
@@ -139,7 +116,7 @@
 			compatible = "st,stm32h7-uart";
 			reg = <0x4000f000 0x400>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_NONE>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc USART3_K>;
 			status = "disabled";
 		};
 
@@ -147,7 +124,7 @@
 			compatible = "st,stm32h7-uart";
 			reg = <0x40010000 0x400>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_NONE>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc UART4_K>;
 			status = "disabled";
 		};
 
@@ -155,7 +132,7 @@
 			compatible = "st,stm32h7-uart";
 			reg = <0x40011000 0x400>;
 			interrupts = <GIC_SPI 53 IRQ_TYPE_NONE>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc UART5_K>;
 			status = "disabled";
 		};
 
@@ -163,7 +140,7 @@
 			compatible = "st,stm32h7-uart";
 			reg = <0x40018000 0x400>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_NONE>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc UART7_K>;
 			status = "disabled";
 		};
 
@@ -171,7 +148,7 @@
 			compatible = "st,stm32h7-uart";
 			reg = <0x40019000 0x400>;
 			interrupts = <GIC_SPI 83 IRQ_TYPE_NONE>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc UART8_K>;
 			status = "disabled";
 		};
 
@@ -179,15 +156,22 @@
 			compatible = "st,stm32h7-uart";
 			reg = <0x44003000 0x400>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_NONE>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc USART6_K>;
 			status = "disabled";
 		};
 
+		rcc: rcc@50000000 {
+			compatible = "st,stm32mp1-rcc", "syscon";
+			reg = <0x50000000 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		usart1: serial@5c000000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x5c000000 0x400>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_NONE>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc USART1_K>;
 			status = "disabled";
 		};
 	};
-- 
1.9.1
