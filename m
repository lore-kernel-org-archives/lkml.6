Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeEOD77 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 23:59:59 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44013 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeEOD74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 23:59:56 -0400
X-Google-Smtp-Source: AB8JxZo9rdkaALq2eYWVpyRc+TbOEkMLK193cx1me5lLNEOZWCGqPK5DF2nlfpoWTqUUC5VRFf1kbw==
From: Douglas Anderson <dianders@chromium.org>
To: Andy Gross <andy.gross@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-soc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] arm64: dts: qcom: sdm845: Sort nodes in the soc by address
Date: Mon, 14 May 2018 20:59:22 -0700
Message-Id: <20180515035922.179060-1-dianders@chromium.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is pure-churn and should be a no-op.  I'm doing it in the hopes
of reducing merge conflicts.  When things are sorted in a sane way
(and by base address seems sane) then it's less likely that future
patches will cause merge conflicts.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes in v2:
- rebase atop tree today

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 96 ++++++++++++++--------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 7c85e7c596db..96dd4b2a41d6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -198,6 +198,54 @@
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
+		gcc: clock-controller@100000 {
+			compatible = "qcom,gcc-sdm845";
+			reg = <0x100000 0x1f0000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		tcsr_mutex_regs: syscon@1f40000 {
+			compatible = "syscon";
+			reg = <0x1f40000 0x40000>;
+		};
+
+		tlmm: pinctrl@3400000 {
+			compatible = "qcom,sdm845-pinctrl";
+			reg = <0x03400000 0xc00000>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
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
+		apss_shared: mailbox@17990000 {
+			compatible = "qcom,sdm845-apss-shared";
+			reg = <0x17990000 0x1000>;
+			#mbox-cells = <1>;
+		};
+
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			#address-cells = <1>;
@@ -218,24 +266,6 @@
 			};
 		};
 
-		gcc: clock-controller@100000 {
-			compatible = "qcom,gcc-sdm845";
-			reg = <0x100000 0x1f0000>;
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-			#power-domain-cells = <1>;
-		};
-
-		tlmm: pinctrl@3400000 {
-			compatible = "qcom,sdm845-pinctrl";
-			reg = <0x03400000 0xc00000>;
-			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
 		timer@17c90000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -293,35 +323,5 @@
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
-		tcsr_mutex_regs: syscon@1f40000 {
-			compatible = "syscon";
-			reg = <0x1f40000 0x40000>;
-		};
-
-		apss_shared: mailbox@17990000 {
-			compatible = "qcom,sdm845-apss-shared";
-			reg = <0x17990000 0x1000>;
-			#mbox-cells = <1>;
-		};
 	};
 };
-- 
2.17.0.441.gb46fe60e1d-goog
