Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeC2V2V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 17:28:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36272 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeC2V2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 17:28:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FC4B61134
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: Ilia Lin <ilialin@codeaurora.org>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org,
        david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: rnayak@codeaurora.org, ilialin@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: [PATCH v4 11/14] dt: qcom: Add SAW regulator for 8x96 CPUs
Date: Fri, 30 Mar 2018 00:26:44 +0300
Message-Id: <1522358807-10413-12-git-send-email-ilialin@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add syscon node for the SAW CPU registers
2. Add SAW regulators gang definition for s8-s11
3. Add voltages to the OPP tables
4. Add the s11 SAW regulator as CPU regulator

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 77 +++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index a0792bd..993f0a3 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -15,6 +15,8 @@
 #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/spmi/spmi.h>
+
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM8996";
@@ -99,6 +101,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			clocks = <&kryocc 0>;
+			cpu-supply = <&pm8994_s11_saw>;
 			operating-points-v2 = <&cluster0_opp>;
 			cooling-min-level = <0>;
 			cooling-max-level = <15>;
@@ -116,6 +119,7 @@
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			clocks = <&kryocc 0>;
+			cpu-supply = <&pm8994_s11_saw>;
 			operating-points-v2 = <&cluster0_opp>;
 			cooling-min-level = <0>;
 			cooling-max-level = <15>;
@@ -129,6 +133,7 @@
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			clocks = <&kryocc 1>;
+			cpu-supply = <&pm8994_s11_saw>;
 			operating-points-v2 = <&cluster1_opp>;
 			cooling-min-level = <0>;
 			cooling-max-level = <15>;
@@ -146,6 +151,7 @@
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			clocks = <&kryocc 1>;
+			cpu-supply = <&pm8994_s11_saw>;
 			operating-points-v2 = <&cluster1_opp>;
 			cooling-min-level = <0>;
 			cooling-max-level = <15>;
@@ -182,66 +188,82 @@
 
 		opp-307200000 {
 			opp-hz = /bits/ 64 <  307200000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-422400000 {
 			opp-hz = /bits/ 64 <  422400000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-480000000 {
 			opp-hz = /bits/ 64 <  480000000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-556800000 {
 			opp-hz = /bits/ 64 <  556800000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-652800000 {
 			opp-hz = /bits/ 64 <  652800000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-729600000 {
 			opp-hz = /bits/ 64 <  729600000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-844800000 {
 			opp-hz = /bits/ 64 <  844800000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-960000000 {
 			opp-hz = /bits/ 64 <  960000000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1036800000 {
 			opp-hz = /bits/ 64 < 1036800000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1113600000 {
 			opp-hz = /bits/ 64 < 1113600000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1190400000 {
 			opp-hz = /bits/ 64 < 1190400000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1228800000 {
 			opp-hz = /bits/ 64 < 1228800000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1324800000 {
 			opp-hz = /bits/ 64 < 1324800000 >;
+			opp-microvolt = <1140000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1401600000 {
 			opp-hz = /bits/ 64 < 1401600000 >;
+			opp-microvolt = <1140000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1478400000 {
 			opp-hz = /bits/ 64 < 1478400000 >;
+			opp-microvolt = <1140000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1593600000 {
 			opp-hz = /bits/ 64 < 1593600000 >;
+			opp-microvolt = <1140000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 	};
@@ -252,102 +274,127 @@
 
 		opp-307200000 {
 			opp-hz = /bits/ 64 <  307200000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-403200000 {
 			opp-hz = /bits/ 64 <  403200000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-480000000 {
 			opp-hz = /bits/ 64 <  480000000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-556800000 {
 			opp-hz = /bits/ 64 <  556800000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-652800000 {
 			opp-hz = /bits/ 64 <  652800000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-729600000 {
 			opp-hz = /bits/ 64 <  729600000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-806400000 {
 			opp-hz = /bits/ 64 <  806400000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-883200000 {
 			opp-hz = /bits/ 64 <  883200000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-940800000 {
 			opp-hz = /bits/ 64 <  940800000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1036800000 {
 			opp-hz = /bits/ 64 < 1036800000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1113600000 {
 			opp-hz = /bits/ 64 < 1113600000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1190400000 {
 			opp-hz = /bits/ 64 < 1190400000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1248000000 {
 			opp-hz = /bits/ 64 < 1248000000 >;
+			opp-microvolt = <905000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1324800000 {
 			opp-hz = /bits/ 64 < 1324800000 >;
+			opp-microvolt = <1140000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1401600000 {
 			opp-hz = /bits/ 64 < 1401600000 >;
+			opp-microvolt = <1140000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1478400000 {
 			opp-hz = /bits/ 64 < 1478400000 >;
+			opp-microvolt = <1140000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1555200000 {
 			opp-hz = /bits/ 64 < 1555200000 >;
+			opp-microvolt = <1140000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1632000000 {
 			opp-hz = /bits/ 64 < 1632000000 >;
+			opp-microvolt = <1140000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1708800000 {
 			opp-hz = /bits/ 64 < 1708800000 >;
+			opp-microvolt = <1140000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1785600000 {
 			opp-hz = /bits/ 64 < 1785600000 >;
+			opp-microvolt = <1140000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1824000000 {
 			opp-hz = /bits/ 64 < 1824000000 >;
+			opp-microvolt = <1140000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1920000000 {
 			opp-hz = /bits/ 64 < 1920000000 >;
+			opp-microvolt = <1140000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1996800000 {
 			opp-hz = /bits/ 64 < 1996800000 >;
+			opp-microvolt = <1140000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-2073600000 {
 			opp-hz = /bits/ 64 < 2073600000 >;
+			opp-microvolt = <1140000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 		opp-2150400000 {
 			opp-hz = /bits/ 64 < 2150400000 >;
+			opp-microvolt = <1140000 905000 1140000>;
 			clock-latency-ns = <200000>;
 		};
 	};
@@ -664,6 +711,11 @@
 			#mbox-cells = <1>;
 		};
 
+		saw3: syscon@9A10000 {
+			compatible = "syscon";
+			reg = <0x9A10000 0x1000>;
+		};
+
 		gcc: clock-controller@300000 {
 			compatible = "qcom,gcc-msm8996";
 			#clock-cells = <1>;
@@ -880,6 +932,31 @@
 			#size-cells = <0>;
 			interrupt-controller;
 			#interrupt-cells = <4>;
+			pmic@1 {
+				compatible = "qcom,pm8994", "qcom,spmi-pmic";
+				reg = <0x1 SPMI_USID>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				spm-regulators {
+					compatible = "qcom,pm8994-regulators";
+					qcom,saw-reg = <&saw3>;
+					s8 {
+						qcom,saw-slave;
+					};
+					s9 {
+						qcom,saw-slave;
+					};
+					s10 {
+						qcom,saw-slave;
+					};
+					pm8994_s11_saw: s11 {
+						qcom,saw-leader;
+						regulator-always-on;
+						regulator-min-microvolt = <905000>;
+						regulator-max-microvolt = <1140000>;
+					};
+				};
+			};
 		};
 
 		mmcc: clock-controller@8c0000 {
-- 
1.9.1
