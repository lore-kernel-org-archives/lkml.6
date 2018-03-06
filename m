Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753790AbeCFNFW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:05:22 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45729 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753756AbeCFNFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:05:17 -0500
X-Google-Smtp-Source: AG47ELsPZTPk0ReudNffQ6h0oddBVL+W+vkkCZAuU8YWOP39kacHgP4Yjh6USwJQjoTVLbLcYHmSGg==
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-arm-msm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: msm8916: Add cpu cooling maps
Date: Tue,  6 Mar 2018 18:35:01 +0530
Message-Id: <9f7199f0027ef2382e5ccc61a5118d0a00fa2e63.1520340931.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1520340931.git.amit.kucheria@linaro.org>
References: <cover.1520340931.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1520340931.git.amit.kucheria@linaro.org>
References: <cover.1520340931.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

Add cpu cooling maps for cpu passive trip points. The cpu cooling
device states are mapped to cpufreq based scaling frequencies.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index e468277..acac9e3 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/clock/qcom,gcc-msm8916.h>
 #include <dt-bindings/reset/qcom,gcc-msm8916.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM8916";
@@ -115,6 +116,10 @@
 			cpu-idle-states = <&CPU_SPC>;
 			clocks = <&apcs 0>;
 			operating-points-v2 = <&cpu_opp_table>;
+			/* cooling options */
+			cooling-min-level = <0>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>;
 		};
 
 		CPU1: cpu@1 {
@@ -126,6 +131,10 @@
 			cpu-idle-states = <&CPU_SPC>;
 			clocks = <&apcs 0>;
 			operating-points-v2 = <&cpu_opp_table>;
+			/* cooling options */
+			cooling-min-level = <0>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>;
 		};
 
 		CPU2: cpu@2 {
@@ -137,6 +146,10 @@
 			cpu-idle-states = <&CPU_SPC>;
 			clocks = <&apcs 0>;
 			operating-points-v2 = <&cpu_opp_table>;
+			/* cooling options */
+			cooling-min-level = <0>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>;
 		};
 
 		CPU3: cpu@3 {
@@ -148,6 +161,10 @@
 			cpu-idle-states = <&CPU_SPC>;
 			clocks = <&apcs 0>;
 			operating-points-v2 = <&cpu_opp_table>;
+			/* cooling options */
+			cooling-min-level = <0>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>;
 		};
 
 		L2_0: l2-cache {
@@ -196,6 +213,13 @@
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu-thermal1 {
@@ -216,6 +240,13 @@
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 	};
-- 
2.7.4
