Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752969AbeFEVp2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:45:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34624 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752946AbeFEVpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:45:24 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, robh@kernel.org, frowand.list@gmail.com,
        mark.rutland@arm.com, sudeep.holla@arm.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>
Subject: [PATCH 14/20] dts: arm: hisilicon: Update coresight bindings for hardware port
Date: Tue,  5 Jun 2018 22:43:25 +0100
Message-Id: <1528235011-30691-15-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the new the hardware port bindings.

Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/hip04.dtsi | 195 +++++++++++++++++++++++++++++++------------
 1 file changed, 141 insertions(+), 54 deletions(-)

diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
index 44044f2..dfd82be 100644
--- a/arch/arm/boot/dts/hip04.dtsi
+++ b/arch/arm/boot/dts/hip04.dtsi
@@ -279,8 +279,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etb0_in_port: endpoint@0 {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&replicator0_out_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -293,8 +294,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etb1_in_port: endpoint@0 {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&replicator1_out_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -307,8 +309,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etb2_in_port: endpoint@0 {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&replicator2_out_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -321,8 +324,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etb3_in_port: endpoint@0 {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&replicator3_out_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -335,8 +339,9 @@
 		clock-names = "apb_pclk";
 		port {
 			tpiu_in_port: endpoint@0 {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&funnel4_out_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -356,6 +361,8 @@
 				reg = <0>;
 				replicator0_out_port0: endpoint {
 					remote-endpoint = <&etb0_in_port>;
+					coresight,hwid = <0>;
+					direction = <1>;
 				};
 			};
 
@@ -363,15 +370,18 @@
 				reg = <1>;
 				replicator0_out_port1: endpoint {
 					remote-endpoint = <&funnel4_in_port0>;
+					coresight,hwid = <1>;
+					direction = <1>;
 				};
 			};
 
 			/* replicator input port */
 			port@2 {
-				reg = <0>;
+				reg = <2>;
 				replicator0_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&funnel0_out_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -392,6 +402,8 @@
 				reg = <0>;
 				replicator1_out_port0: endpoint {
 					remote-endpoint = <&etb1_in_port>;
+					coresight,hwid = <0>;
+					direction = <1>;
 				};
 			};
 
@@ -399,15 +411,18 @@
 				reg = <1>;
 				replicator1_out_port1: endpoint {
 					remote-endpoint = <&funnel4_in_port1>;
+					coresight,hwid = <1>;
+					direction = <1>;
 				};
 			};
 
 			/* replicator input port */
 			port@2 {
-				reg = <0>;
+				reg = <2>;
 				replicator1_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&funnel1_out_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -428,22 +443,27 @@
 				reg = <0>;
 				replicator2_out_port0: endpoint {
 					remote-endpoint = <&etb2_in_port>;
+					coresight,hwid = <0>;
+					direction = <1>;
 				};
 			};
 
 			port@1 {
 				reg = <1>;
-					replicator2_out_port1: endpoint {
+				replicator2_out_port1: endpoint {
 					remote-endpoint = <&funnel4_in_port2>;
+					coresight,hwid = <1>;
+					direction = <1>;
 				};
 			};
 
 			/* replicator input port */
 			port@2 {
-				reg = <0>;
+				reg = <2>;
 				replicator2_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&funnel2_out_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -464,6 +484,8 @@
 				reg = <0>;
 				replicator3_out_port0: endpoint {
 					remote-endpoint = <&etb3_in_port>;
+					coresight,hwid = <0>;
+					direction = <1>;
 				};
 			};
 
@@ -471,15 +493,18 @@
 				reg = <1>;
 				replicator3_out_port1: endpoint {
 					remote-endpoint = <&funnel4_in_port3>;
+					coresight,hwid = <1>;
+					direction = <1>;
 				};
 			};
 
 			/* replicator input port */
 			port@2 {
-				reg = <0>;
+				reg = <2>;
 				replicator3_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&funnel3_out_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -501,39 +526,45 @@
 				funnel0_out_port0: endpoint {
 					remote-endpoint =
 						<&replicator0_in_port0>;
+					coresight,hwid = <0>;
+					direction = <1>;
 				};
 			};
 
 			/* funnel input ports */
 			port@1 {
-				reg = <0>;
+				reg = <1>;
 				funnel0_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm0_out_port>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			port@2 {
-				reg = <1>;
+				reg = <2>;
 				funnel0_in_port1: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm1_out_port>;
+					coresight,hwid = <1>;
 				};
 			};
 
 			port@3 {
-				reg = <2>;
+				reg = <3>;
 				funnel0_in_port2: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm2_out_port>;
+					coresight,hwid = <2>;
 				};
 			};
 
 			port@4 {
-				reg = <3>;
+				reg = <4>;
 				funnel0_in_port3: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm3_out_port>;
+					coresight,hwid = <3>;
 				};
 			};
 		};
@@ -553,41 +584,47 @@
 			port@0 {
 				reg = <0>;
 				funnel1_out_port0: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&replicator1_in_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			/* funnel input ports */
 			port@1 {
-				reg = <0>;
+				reg = <1>;
 				funnel1_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm4_out_port>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			port@2 {
-				reg = <1>;
+				reg = <2>;
 				funnel1_in_port1: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm5_out_port>;
+					coresight,hwid = <1>;
 				};
 			};
 
 			port@3 {
-				reg = <2>;
+				reg = <3>;
 				funnel1_in_port2: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm6_out_port>;
+					coresight,hwid = <2>;
 				};
 			};
 
 			port@4 {
-				reg = <3>;
+				reg = <4>;
 				funnel1_in_port3: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm7_out_port>;
+					coresight,hwid = <3>;
 				};
 			};
 		};
@@ -607,41 +644,47 @@
 			port@0 {
 				reg = <0>;
 				funnel2_out_port0: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&replicator2_in_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			/* funnel input ports */
 			port@1 {
-				reg = <0>;
+				reg = <1>;
 				funnel2_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm8_out_port>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			port@2 {
-				reg = <1>;
+				reg = <2>;
 				funnel2_in_port1: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm9_out_port>;
+					coresight,hwid = <1>;
 				};
 			};
 
 			port@3 {
-				reg = <2>;
+				reg = <3>;
 				funnel2_in_port2: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm10_out_port>;
+					coresight,hwid = <2>;
 				};
 			};
 
 			port@4 {
-				reg = <3>;
+				reg = <4>;
 				funnel2_in_port3: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm11_out_port>;
+					coresight,hwid = <3>;
 				};
 			};
 		};
@@ -661,41 +704,47 @@
 			port@0 {
 				reg = <0>;
 				funnel3_out_port0: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&replicator3_in_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			/* funnel input ports */
 			port@1 {
-				reg = <0>;
+				reg = <1>;
 				funnel3_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm12_out_port>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			port@2 {
-				reg = <1>;
+				reg = <2>;
 				funnel3_in_port1: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm13_out_port>;
+					coresight,hwid = <1>;
 				};
 			};
 
 			port@3 {
-				reg = <2>;
+				reg = <3>;
 				funnel3_in_port2: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm14_out_port>;
+					coresight,hwid = <2>;
 				};
 			};
 
 			port@4 {
-				reg = <3>;
+				reg = <4>;
 				funnel3_in_port3: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm15_out_port>;
+					coresight,hwid = <3>;
 				};
 			};
 		};
@@ -715,44 +764,50 @@
 			port@0 {
 				reg = <0>;
 				funnel4_out_port0: endpoint {
+					direction = <1>;
 					remote-endpoint = <&tpiu_in_port>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			/* funnel input ports */
 			port@1 {
-				reg = <0>;
+				reg = <1>;
 				funnel4_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint =
 						<&replicator0_out_port1>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			port@2 {
-				reg = <1>;
+				reg = <2>;
 				funnel4_in_port1: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint =
 						<&replicator1_out_port1>;
+					coresight,hwid = <1>;
 				};
 			};
 
 			port@3 {
-				reg = <2>;
+				reg = <3>;
 				funnel4_in_port2: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint =
 						<&replicator2_out_port1>;
+					coresight,hwid = <2>;
 				};
 			};
 
 			port@4 {
-				reg = <3>;
+				reg = <4>;
 				funnel4_in_port3: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint =
 						<&replicator3_out_port1>;
+					coresight,hwid = <3>;
 				};
 			};
 		};
@@ -767,7 +822,9 @@
 		cpu = <&CPU0>;
 		port {
 			ptm0_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel0_in_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -781,7 +838,9 @@
 		cpu = <&CPU1>;
 		port {
 			ptm1_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel0_in_port1>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -795,7 +854,9 @@
 		cpu = <&CPU2>;
 		port {
 			ptm2_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel0_in_port2>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -809,7 +870,9 @@
 		cpu = <&CPU3>;
 		port {
 			ptm3_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel0_in_port3>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -823,7 +886,9 @@
 		cpu = <&CPU4>;
 		port {
 			ptm4_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel1_in_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -837,7 +902,9 @@
 		cpu = <&CPU5>;
 		port {
 			ptm5_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel1_in_port1>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -851,7 +918,9 @@
 		cpu = <&CPU6>;
 		port {
 			ptm6_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel1_in_port2>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -865,7 +934,9 @@
 		cpu = <&CPU7>;
 		port {
 			ptm7_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel1_in_port3>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -879,7 +950,9 @@
 		cpu = <&CPU8>;
 		port {
 			ptm8_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel2_in_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -892,7 +965,9 @@
 		cpu = <&CPU9>;
 		port {
 			ptm9_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel2_in_port1>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -906,7 +981,9 @@
 		cpu = <&CPU10>;
 		port {
 			ptm10_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel2_in_port2>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -920,7 +997,9 @@
 		cpu = <&CPU11>;
 		port {
 			ptm11_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel2_in_port3>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -934,7 +1013,9 @@
 		cpu = <&CPU12>;
 		port {
 			ptm12_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel3_in_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -948,7 +1029,9 @@
 		cpu = <&CPU13>;
 		port {
 			ptm13_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel3_in_port1>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -962,7 +1045,9 @@
 		cpu = <&CPU14>;
 		port {
 			ptm14_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel3_in_port2>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -976,7 +1061,9 @@
 		cpu = <&CPU15>;
 		port {
 			ptm15_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel3_in_port3>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
-- 
2.7.4
