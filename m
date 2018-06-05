Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeFEVpg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:45:36 -0400
Received: from foss.arm.com ([217.140.101.70]:34676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751698AbeFEVpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:45:34 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, robh@kernel.org, frowand.list@gmail.com,
        mark.rutland@arm.com, sudeep.holla@arm.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Subject: [PATCH 17/20] dts: arm: qcom: Update coresight bindings for hardware ports
Date: Tue,  5 Jun 2018 22:43:28 +0100
Message-Id: <1528235011-30691-18-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the new hardware port bindings for coresight

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 37 +++++++++++++++++------
 arch/arm/boot/dts/qcom-msm8974.dtsi | 60 +++++++++++++++++++++++++++----------
 2 files changed, 73 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 5341a39..d854220 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1609,8 +1609,9 @@
 
 			port {
 				etb_in: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&replicator_out0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -1624,8 +1625,9 @@
 
 			port {
 				tpiu_in: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&replicator_out1>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -1644,19 +1646,22 @@
 					reg = <0>;
 					replicator_out0: endpoint {
 						remote-endpoint = <&etb_in>;
+						coresight,hwid = <0>;
 					};
 				};
 				port@1 {
 					reg = <1>;
 					replicator_out1: endpoint {
 						remote-endpoint = <&tpiu_in>;
+						coresight,hwid = <1>;
 					};
 				};
 				port@2 {
-					reg = <0>;
+					reg = <2>;
 					replicator_in: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&funnel_out>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -1683,35 +1688,41 @@
 				port@0 {
 					reg = <0>;
 					funnel_in0: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm0_out>;
+						coresight,hwid = <0>;
 					};
 				};
 				port@1 {
 					reg = <1>;
 					funnel_in1: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm1_out>;
+						coresight,hwid = <1>;
 					};
 				};
 				port@4 {
 					reg = <4>;
 					funnel_in4: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm2_out>;
+						coresight,hwid = <4>;
 					};
 				};
 				port@5 {
 					reg = <5>;
 					funnel_in5: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm3_out>;
+						coresight,hwid = <5>;
 					};
 				};
 				port@8 {
-					reg = <0>;
+					reg = <8>;
 					funnel_out: endpoint {
+						direction = <1>;
 						remote-endpoint = <&replicator_in>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -1728,7 +1739,9 @@
 
 			port {
 				etm0_out: endpoint {
+					direction = <1>;
 					remote-endpoint = <&funnel_in0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -1744,7 +1757,9 @@
 
 			port {
 				etm1_out: endpoint {
+					direction = <1>;
 					remote-endpoint = <&funnel_in1>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -1760,7 +1775,9 @@
 
 			port {
 				etm2_out: endpoint {
+					direction = <1>;
 					remote-endpoint = <&funnel_in4>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -1776,7 +1793,9 @@
 
 			port {
 				etm3_out: endpoint {
+					direction = <1>;
 					remote-endpoint = <&funnel_in5>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index d9019a4..89c7eb3 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -772,8 +772,9 @@
 
 			port {
 				etr_in: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&replicator_out0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -787,8 +788,9 @@
 
 			port {
 				tpiu_in: endpoint {
-					 slave-mode;
+					 direction = <0>;
 					 remote-endpoint = <&replicator_out1>;
+					coresight,hwid = <0>;
 				 };
 			};
 		};
@@ -807,20 +809,25 @@
 				port@0 {
 					reg = <0>;
 					replicator_out0: endpoint {
+						direction = <1>;
 						remote-endpoint = <&etr_in>;
+						coresight,hwid = <0>;
 					};
 				};
 				port@1 {
 					reg = <1>;
 					replicator_out1: endpoint {
+						direction = <1>;
 						remote-endpoint = <&tpiu_in>;
+						coresight,hwid = <1>;
 					};
 				};
 				port@2 {
-					reg = <0>;
+					reg = <2>;
 					replicator_in: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etf_out>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -840,14 +847,17 @@
 				port@0 {
 					reg = <0>;
 					etf_out: endpoint {
+						direction = <1>;
 						remote-endpoint = <&replicator_in>;
+						coresight,hwid = <0>;
 					};
 				};
 				port@1 {
-					reg = <0>;
+					reg = <1>;
 					etf_in: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&merger_out>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -873,14 +883,17 @@
 				port@1 {
 					reg = <1>;
 					merger_in1: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&funnel1_out>;
+						coresight,hwid = <1>;
 					};
 				};
 				port@8 {
-					reg = <0>;
+					reg = <8>;
 					merger_out: endpoint {
+						direction = <1>;
 						remote-endpoint = <&etf_in>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -910,14 +923,17 @@
 				port@5 {
 					reg = <5>;
 					funnel1_in5: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&kpss_out>;
+						coresight,hwid = <5>;
 					};
 				};
 				port@8 {
-					reg = <0>;
+					reg = <8>;
 					funnel1_out: endpoint {
+						direction = <1>;
 						remote-endpoint = <&merger_in1>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -937,35 +953,41 @@
 				port@0 {
 					reg = <0>;
 					kpss_in0: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm0_out>;
+						coresight,hwid = <0>;
 					};
 				};
 				port@1 {
 					reg = <1>;
 					kpss_in1: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm1_out>;
+						coresight,hwid = <1>;
 					};
 				};
 				port@2 {
 					reg = <2>;
 					kpss_in2: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm2_out>;
+						coresight,hwid = <2>;
 					};
 				};
 				port@3 {
 					reg = <3>;
 					kpss_in3: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm3_out>;
+						coresight,hwid = <3>;
 					};
 				};
 				port@8 {
-					reg = <0>;
+					reg = <8>;
 					kpss_out: endpoint {
+						direction = <1>;
 						remote-endpoint = <&funnel1_in5>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -982,7 +1004,9 @@
 
 			port {
 				etm0_out: endpoint {
+					direction = <1>;
 					remote-endpoint = <&kpss_in0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -998,7 +1022,9 @@
 
 			port {
 				etm1_out: endpoint {
+					direction = <1>;
 					remote-endpoint = <&kpss_in1>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -1014,7 +1040,9 @@
 
 			port {
 				etm2_out: endpoint {
+					direction = <1>;
 					remote-endpoint = <&kpss_in2>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -1030,7 +1058,9 @@
 
 			port {
 				etm3_out: endpoint {
+					direction = <1>;
 					remote-endpoint = <&kpss_in3>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
-- 
2.7.4
