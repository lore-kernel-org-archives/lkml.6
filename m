Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932320AbeENNNE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:13:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45186 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932297AbeENNM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:12:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5AF76085F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: Ilia Lin <ilialin@codeaurora.org>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org,
        david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com,
        rjw@rjwysocki.net, linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rnayak@codeaurora.org, ilialin@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: [PATCH v6 08/14] dt: qcom: Add opp and thermal to the msm8996
Date: Mon, 14 May 2018 16:11:54 +0300
Message-Id: <1526303520-5843-9-git-send-email-ilialin@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
References: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 269 ++++++++++++++++++++++++++++++++--
 1 file changed, 260 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 37b7152c..e6cf290 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/qcom,gcc-msm8996.h>
 #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM8996";
@@ -97,6 +98,9 @@
 			compatible = "qcom,kryo";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			clocks = <&kryocc 0>;
+			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 			      compatible = "cache";
@@ -109,6 +113,9 @@
 			compatible = "qcom,kryo";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			clocks = <&kryocc 0>;
+			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_0>;
 		};
 
@@ -117,6 +124,9 @@
 			compatible = "qcom,kryo";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			clocks = <&kryocc 1>;
+			operating-points-v2 = <&cluster1_opp>;
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
 			      compatible = "cache";
@@ -129,6 +139,9 @@
 			compatible = "qcom,kryo";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
+			clocks = <&kryocc 1>;
+			operating-points-v2 = <&cluster1_opp>;
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_1>;
 		};
 
@@ -155,6 +168,182 @@
 		};
 	};
 
+	cluster0_opp: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-307200000 {
+			opp-hz = /bits/ 64 <307200000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-422400000 {
+			opp-hz = /bits/ 64 <422400000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-556800000 {
+			opp-hz = /bits/ 64 <556800000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-729600000 {
+			opp-hz = /bits/ 64 <729600000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-844800000 {
+			opp-hz = /bits/ 64 <844800000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-960000000 {
+			opp-hz = /bits/ 64 <960000000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1036800000 {
+			opp-hz = /bits/ 64 <1036800000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1113600000 {
+			opp-hz = /bits/ 64 <1113600000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1228800000 {
+			opp-hz = /bits/ 64 <1228800000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1478400000 {
+			opp-hz = /bits/ 64 <1478400000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1593600000 {
+			opp-hz = /bits/ 64 <1593600000>;
+			clock-latency-ns = <200000>;
+		};
+	};
+
+	cluster1_opp: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-307200000 {
+			opp-hz = /bits/ 64 <307200000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-403200000 {
+			opp-hz = /bits/ 64 <403200000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-556800000 {
+			opp-hz = /bits/ 64 <556800000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-729600000 {
+			opp-hz = /bits/ 64 <729600000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-806400000 {
+			opp-hz = /bits/ 64 <806400000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-883200000 {
+			opp-hz = /bits/ 64 <883200000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-940800000 {
+			opp-hz = /bits/ 64 <940800000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1036800000 {
+			opp-hz = /bits/ 64 <1036800000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1113600000 {
+			opp-hz = /bits/ 64 <1113600000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1478400000 {
+			opp-hz = /bits/ 64 <1478400000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1555200000 {
+			opp-hz = /bits/ 64 <1555200000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1632000000 {
+			opp-hz = /bits/ 64 <1632000000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1785600000 {
+			opp-hz = /bits/ 64 <1785600000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1824000000 {
+			opp-hz = /bits/ 64 <1824000000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1920000000 {
+			opp-hz = /bits/ 64 <1920000000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1996800000 {
+			opp-hz = /bits/ 64 <1996800000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-2073600000 {
+			opp-hz = /bits/ 64 <2073600000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-2150400000 {
+			opp-hz = /bits/ 64 <2150400000>;
+			clock-latency-ns = <200000>;
+		};
+	};
+
 	thermal-zones {
 		cpu-thermal0 {
 			polling-delay-passive = <250>;
@@ -163,18 +352,34 @@
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
-				cpu_alert0: trip0 {
+				cpu_alert0: cpu_alert0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
+					type = "active";
+				};
+				cpu_warn0: cpu_warn0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit0: trip1 {
+				cpu_crit0: cpu_crit0 {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT 7>;
+				};
+				map1 {
+					trip = <&cpu_warn0>;
+					cooling-device = <&CPU0 8 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu-thermal1 {
@@ -184,18 +389,34 @@
 			thermal-sensors = <&tsens0 5>;
 
 			trips {
-				cpu_alert1: trip0 {
+				cpu_alert1: cpu_alert1 {
 					temperature = <75000>;
 					hysteresis = <2000>;
+					type = "active";
+				};
+				cpu_warn1: cpu_warn1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit1: trip1 {
+				cpu_crit1: cpu_crit1 {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT 7>;
+				};
+				map1 {
+					trip = <&cpu_warn1>;
+					cooling-device = <&CPU0 8 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu-thermal2 {
@@ -205,18 +426,33 @@
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
-				cpu_alert2: trip0 {
+				cpu_alert2: cpu_alert2 {
 					temperature = <75000>;
 					hysteresis = <2000>;
+					type = "active";
+				};
+				cpu_warn2: cpu_warn2 {
+					temperature = <90000>;
+					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit2: trip1 {
+				cpu_crit2: cpu_crit2 {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert2>;
+					cooling-device = <&CPU2 THERMAL_NO_LIMIT 7>;
+				};
+				map1 {
+					trip = <&cpu_warn2>;
+					cooling-device = <&CPU2 8 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu-thermal3 {
@@ -226,9 +462,14 @@
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
-				cpu_alert3: trip0 {
+				cpu_alert3: cpu_alert3 {
 					temperature = <75000>;
 					hysteresis = <2000>;
+					type = "active";
+				};
+				cpu_warn3: cpu_warn3 {
+					temperature = <90000>;
+					hysteresis = <2000>;
 					type = "passive";
 				};
 
@@ -238,6 +479,16 @@
 					type = "critical";
 				};
 			};
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert3>;
+					cooling-device = <&CPU2 THERMAL_NO_LIMIT 7>;
+				};
+				map1 {
+					trip = <&cpu_warn3>;
+					cooling-device = <&CPU2 8 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 	};
 
@@ -414,7 +665,7 @@
 		};
 
 		kryocc: clock-controller@6400000 {
-			compatible = "qcom,apcc-msm8996";
+			compatible = "qcom,msm8996-apcc";
 			reg = <0x6400000 0x90000>;
 			#clock-cells = <1>;
 		};
@@ -1001,7 +1252,7 @@
 
 				pinctrl-names = "default", "sleep";
 				pinctrl-0 = <&pcie2_clkreq_default &pcie2_perst_default &pcie2_wake_default>;
-				pinctrl-1 = <&pcie2_clkreq_sleep &pcie2_perst_default &pcie2_wake_sleep >;
+				pinctrl-1 = <&pcie2_clkreq_sleep &pcie2_perst_default &pcie2_wake_sleep>;
 
 				vdda-supply = <&pm8994_l28>;
 
-- 
1.9.1
