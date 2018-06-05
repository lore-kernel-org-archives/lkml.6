Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbeFEVpW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:45:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34584 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751619AbeFEVpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:45:18 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, robh@kernel.org, frowand.list@gmail.com,
        mark.rutland@arm.com, sudeep.holla@arm.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: [PATCH 12/20] dts: spreadtrum: Update coresight bindings for hw ports
Date: Tue,  5 Jun 2018 22:43:23 +0100
Message-Id: <1528235011-30691-13-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the new coresight bindings for hw ports

Cc: orsonzhai@gmail.com
Cc: zhang.lyra@gmail.com
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/boot/dts/sprd/sc9836.dtsi |  40 ++++++++++----
 arch/arm64/boot/dts/sprd/sc9860.dtsi | 101 +++++++++++++++++++++++++----------
 2 files changed, 102 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9836.dtsi b/arch/arm64/boot/dts/sprd/sc9836.dtsi
index 63894c4..27ccc29 100644
--- a/arch/arm64/boot/dts/sprd/sc9836.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9836.dtsi
@@ -52,8 +52,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etf_in: endpoint {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&funnel_out_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -71,48 +72,55 @@
 			port@0 {
 				reg = <0>;
 				funnel_out_port0: endpoint {
+					direction = <1>;
 					remote-endpoint = <&etf_in>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			/* funnel input port 0-4 */
 			port@1 {
-				reg = <0>;
+				reg = <1>;
 				funnel_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&etm0_out>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			port@2 {
-				reg = <1>;
+				reg = <2>;
 				funnel_in_port1: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&etm1_out>;
+					coresight,hwid = <1>;
 				};
 			};
 
 			port@3 {
-				reg = <2>;
+				reg = <3>;
 				funnel_in_port2: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&etm2_out>;
+					coresight,hwid = <2>;
 				};
 			};
 
 			port@4 {
-				reg = <3>;
+				reg = <4>;
 				funnel_in_port3: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&etm3_out>;
+					coresight,hwid = <3>;
 				};
 			};
 
 			port@5 {
-				reg = <4>;
+				reg = <5>;
 				funnel_in_port4: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&stm_out>;
+					coresight,hwid = <4>;
 				};
 			};
 			/* Other input ports aren't connected to anyone */
@@ -128,7 +136,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etm0_out: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel_in_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -142,7 +152,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etm1_out: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel_in_port1>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -156,7 +168,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etm2_out: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel_in_port2>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -170,7 +184,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etm3_out: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel_in_port3>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -184,7 +200,9 @@
 		clock-names = "apb_pclk";
 		port {
 			stm_out: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel_in_port4>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
index 5dbfb79..1615014 100644
--- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
@@ -309,25 +309,29 @@
 				port@0 {
 					reg = <0>;
 					soc_funnel_out_port: endpoint {
+						direction = <1>;
 						remote-endpoint = <&etb_in>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port@1 {
-					reg = <0>;
+					reg = <1>;
 					soc_funnel_in_port0: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 						<&main_funnel_out_port>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port@2 {
-					reg = <4>;
+					reg = <2>;
 					soc_funnel_in_port1: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpioint =
 							<&stm_out_port>;
+						coresight,hwid = <4>;
 					};
 				};
 			};
@@ -340,9 +344,10 @@
 			clock-names = "apb_pclk";
 			port {
 				etb_in: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint =
 						<&soc_funnel_out_port>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -356,8 +361,10 @@
 			clock-names = "apb_pclk";
 			port {
 				stm_out_port: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&soc_funnel_in_port1>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -374,40 +381,46 @@
 				port@0 {
 					reg = <0>;
 					cluster0_funnel_out_port: endpoint {
+						direction = <1>;
 						remote-endpoint =
 							<&cluster0_etf_in>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port@1 {
-					reg = <0>;
+					reg = <1>;
 					cluster0_funnel_in_port0: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm0_out>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port@2 {
-					reg = <1>;
+					reg = <2>;
 					cluster0_funnel_in_port1: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm1_out>;
+						coresight,hwid = <1>;
 					};
 				};
 
 				port@3 {
-					reg = <2>;
+					reg = <3>;
 					cluster0_funnel_in_port2: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm2_out>;
+						coresight,hwid = <2>;
 					};
 				};
 
 				port@4 {
 					reg = <4>;
 					cluster0_funnel_in_port3: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm3_out>;
+						coresight,hwid = <4>;
 					};
 				};
 			};
@@ -425,40 +438,46 @@
 				port@0 {
 					reg = <0>;
 					cluster1_funnel_out_port: endpoint {
+						direction = <1>;
 						remote-endpoint =
 							<&cluster1_etf_in>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port@1 {
-					reg = <0>;
+					reg = <1>;
 					cluster1_funnel_in_port0: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm4_out>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port@2 {
-					reg = <1>;
+					reg = <2>;
 					cluster1_funnel_in_port1: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm5_out>;
+						coresight,hwid = <1>;
 					};
 				};
 
 				port@3 {
-					reg = <2>;
+					reg = <3>;
 					cluster1_funnel_in_port2: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm6_out>;
+						coresight,hwid = <2>;
 					};
 				};
 
 				port@4 {
-					reg = <3>;
+					reg = <4>;
 					cluster1_funnel_in_port3: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm7_out>;
+						coresight,hwid = <3>;
 					};
 				};
 			};
@@ -477,17 +496,20 @@
 				port@0 {
 					reg = <0>;
 					cluster0_etf_out: endpoint {
+						direction = <1>;
 						remote-endpoint =
 						<&main_funnel_in_port0>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port@1 {
-					reg = <0>;
+					reg = <1>;
 					cluster0_etf_in: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 						<&cluster0_funnel_out_port>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -506,17 +528,20 @@
 				port@0 {
 					reg = <0>;
 					cluster1_etf_out: endpoint {
+						direction = <1>;
 						remote-endpoint =
 						<&main_funnel_in_port1>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port@1 {
-					reg = <0>;
+					reg = <1>;
 					cluster1_etf_in: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 						<&cluster1_funnel_out_port>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -535,26 +560,30 @@
 				port@0 {
 					reg = <0>;
 					main_funnel_out_port: endpoint {
+						direction = <1>;
 						remote-endpoint =
 							<&soc_funnel_in_port0>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port@1 {
-					reg = <0>;
+					reg = <1>;
 					main_funnel_in_port0: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&cluster0_etf_out>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port@2 {
-					reg = <1>;
+					reg = <2>;
 					main_funnel_in_port1: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&cluster1_etf_out>;
+						coresight,hwid = <1>;
 					};
 				};
 			};
@@ -569,8 +598,10 @@
 
 			port {
 				etm0_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&cluster0_funnel_in_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -584,8 +615,10 @@
 
 			port {
 				etm1_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&cluster0_funnel_in_port1>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -599,8 +632,10 @@
 
 			port {
 				etm2_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&cluster0_funnel_in_port2>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -614,8 +649,10 @@
 
 			port {
 				etm3_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&cluster0_funnel_in_port3>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -629,8 +666,10 @@
 
 			port {
 				etm4_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&cluster1_funnel_in_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -644,8 +683,10 @@
 
 			port {
 				etm5_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&cluster1_funnel_in_port1>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -659,8 +700,10 @@
 
 			port {
 				etm6_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&cluster1_funnel_in_port2>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -674,8 +717,10 @@
 
 			port {
 				etm7_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&cluster1_funnel_in_port3>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
-- 
2.7.4
