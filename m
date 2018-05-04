Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeEDWEf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 18:04:35 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42826 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeEDWEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 18:04:32 -0400
X-Google-Smtp-Source: AB8JxZpNCXYYIw0UkPJG59+KTU2JhdWiFGHeunKN9JVZyIJteAHLR/42zK7sBrtOfLTCLbChaGb/iQ==
From: Douglas Anderson <dianders@chromium.org>
To: Andy Gross <andy.gross@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-soc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: qcom: sdm845: Sort nodes in the soc by address
Date: Fri,  4 May 2018 15:03:56 -0700
Message-Id: <20180504220356.261711-1-dianders@chromium.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is pure-churn and should be a no-op.  I'm doing it in the hopes
of reducing merge conflicts.  When things are sorted in a sane way
(and by base address seems sane) then it's less likely that future
patches will cause merge conflicts.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 152 +++++++++++++--------------
 1 file changed, 76 insertions(+), 76 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 486ace9a9e8b..101350743bd2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -158,32 +158,50 @@
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
-		intc: interrupt-controller@17a00000 {
-			compatible = "arm,gic-v3";
+		gcc: clock-controller@100000 {
+			compatible = "qcom,gcc-sdm845";
+			reg = <0x100000 0x1f0000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		geniqup@ac0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0xac0000 0x6000>;
+			clock-names = "m-ahb", "s-ahb";
+			clocks = <&gcc 105>,
+				 <&gcc 106>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			reg = <0x17a00000 0x10000>,     /* GICD */
-			      <0x17a60000 0x100000>;    /* GICR * 8 */
-			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 
-			gic-its@17a40000 {
-				compatible = "arm,gic-v3-its";
-				msi-controller;
-				#msi-cells = <1>;
-				reg = <0x17a40000 0x20000>;
+			uart2: serial@a84000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0xa84000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc 89>;
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&qup_uart2_default>;
+				pinctrl-1 = <&qup_uart2_sleep>;
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
-		};
 
-		gcc: clock-controller@100000 {
-			compatible = "qcom,gcc-sdm845";
-			reg = <0x100000 0x1f0000>;
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-			#power-domain-cells = <1>;
+			i2c10: i2c@a88000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0xa88000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc 91>;
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&qup_i2c10_default>;
+				pinctrl-1 = <&qup_i2c10_sleep>;
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		tlmm: pinctrl@3400000 {
@@ -224,6 +242,45 @@
 			};
 		};
 
+		spmi_bus: spmi@c440000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0xc440000 0x1100>,
+			      <0xc600000 0x2000000>,
+			      <0xe600000 0x100000>,
+			      <0xe700000 0xa0000>,
+			      <0xc40a000 0x26000>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts = <GIC_SPI 481 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+			cell-index = <0>;
+		};
+
+		intc: interrupt-controller@17a00000 {
+			compatible = "arm,gic-v3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x17a00000 0x10000>,     /* GICD */
+			      <0x17a60000 0x100000>;    /* GICR * 8 */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+			gic-its@17a40000 {
+				compatible = "arm,gic-v3-its";
+				msi-controller;
+				#msi-cells = <1>;
+				reg = <0x17a40000 0x20000>;
+				status = "disabled";
+			};
+		};
+
 		timer@17c90000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -281,62 +338,5 @@
 				status = "disabled";
 			};
 		};
-
-		spmi_bus: spmi@c440000 {
-			compatible = "qcom,spmi-pmic-arb";
-			reg = <0xc440000 0x1100>,
-			      <0xc600000 0x2000000>,
-			      <0xe600000 0x100000>,
-			      <0xe700000 0xa0000>,
-			      <0xc40a000 0x26000>;
-			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
-			interrupt-names = "periph_irq";
-			interrupts = <GIC_SPI 481 IRQ_TYPE_LEVEL_HIGH>;
-			qcom,ee = <0>;
-			qcom,channel = <0>;
-			#address-cells = <2>;
-			#size-cells = <0>;
-			interrupt-controller;
-			#interrupt-cells = <4>;
-			cell-index = <0>;
-		};
-
-		geniqup@ac0000 {
-			compatible = "qcom,geni-se-qup";
-			reg = <0xac0000 0x6000>;
-			clock-names = "m-ahb", "s-ahb";
-			clocks = <&gcc 105>,
-				 <&gcc 106>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			status = "disabled";
-
-			uart2: serial@a84000 {
-				compatible = "qcom,geni-debug-uart";
-				reg = <0xa84000 0x4000>;
-				clock-names = "se";
-				clocks = <&gcc 89>;
-				pinctrl-names = "default", "sleep";
-				pinctrl-0 = <&qup_uart2_default>;
-				pinctrl-1 = <&qup_uart2_sleep>;
-				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
-				status = "disabled";
-			};
-
-			i2c10: i2c@a88000 {
-				compatible = "qcom,geni-i2c";
-				reg = <0xa88000 0x4000>;
-				clock-names = "se";
-				clocks = <&gcc 91>;
-				pinctrl-names = "default", "sleep";
-				pinctrl-0 = <&qup_i2c10_default>;
-				pinctrl-1 = <&qup_i2c10_sleep>;
-				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				status = "disabled";
-			};
-		};
 	};
 };
-- 
2.17.0.441.gb46fe60e1d-goog
