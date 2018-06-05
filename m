Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbeFEVrb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:47:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34572 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752190AbeFEVpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:45:15 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, robh@kernel.org, frowand.list@gmail.com,
        mark.rutland@arm.com, sudeep.holla@arm.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>, xuwei5@hisilicon.com,
        lipengcheng8@huawei.com
Subject: [PATCH 11/20] dts: hisilicon: Update coresight bindings for hw ports
Date: Tue,  5 Jun 2018 22:43:22 +0100
Message-Id: <1528235011-30691-12-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to updated coresight bindings for hw ports.

Cc: xuwei5@hisilicon.com
Cc: lipengcheng8@huawei.com
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../arm64/boot/dts/hisilicon/hi6220-coresight.dtsi | 89 ++++++++++++++++------
 1 file changed, 64 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
index 7afee5d..a394a65 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
@@ -27,17 +27,20 @@
 				port@0 {
 					reg = <0>;
 					soc_funnel_out: endpoint {
+						direction = <1>;
 						remote-endpoint =
 							<&etf_in>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port@1 {
-					reg = <0>;
+					reg = <1>;
 					soc_funnel_in: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&acpu_funnel_out>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -56,17 +59,20 @@
 				port@0 {
 					reg = <0>;
 					etf_in: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&soc_funnel_out>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port@1 {
-					reg = <0>;
+					reg = <1>;
 					etf_out: endpoint {
+						direction = <1>;
 						remote-endpoint =
 							<&replicator_in>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -84,25 +90,30 @@
 				port@0 {
 					reg = <0>;
 					replicator_in: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etf_out>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port@1 {
-					reg = <0>;
+					reg = <1>;
 					replicator_out0: endpoint {
+						direction = <1>;
 						remote-endpoint =
 							<&etr_in>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port@2 {
-					reg = <1>;
+					reg = <2>;
 					replicator_out1: endpoint {
+						direction = <1>;
 						remote-endpoint =
 							<&tpiu_in>;
+						coresight,hwid = <1>;
 					};
 				};
 			};
@@ -121,9 +132,10 @@
 				port@0 {
 					reg = <0>;
 					etr_in: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&replicator_out0>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -142,9 +154,10 @@
 				port@0 {
 					reg = <0>;
 					tpiu_in: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&replicator_out1>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -163,80 +176,90 @@
 				port@0 {
 					reg = <0>;
 					acpu_funnel_out: endpoint {
+						direction = <1>;
 						remote-endpoint =
 							<&soc_funnel_in>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port@1 {
-					reg = <0>;
+					reg = <1>;
 					acpu_funnel_in0: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etm0_out>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port@2 {
-					reg = <1>;
+					reg = <2>;
 					acpu_funnel_in1: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etm1_out>;
+						coresight,hwid = <1>;
 					};
 				};
 
 				port@3 {
-					reg = <2>;
+					reg = <3>;
 					acpu_funnel_in2: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etm2_out>;
+						coresight,hwid = <2>;
 					};
 				};
 
 				port@4 {
-					reg = <3>;
+					reg = <4>;
 					acpu_funnel_in3: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etm3_out>;
+						coresight,hwid = <3>;
 					};
 				};
 
 				port@5 {
-					reg = <4>;
+					reg = <5>;
 					acpu_funnel_in4: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etm4_out>;
+						coresight,hwid = <4>;
 					};
 				};
 
 				port@6 {
-					reg = <5>;
+					reg = <6>;
 					acpu_funnel_in5: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etm5_out>;
+						coresight,hwid = <5>;
 					};
 				};
 
 				port@7 {
-					reg = <6>;
+					reg = <7>;
 					acpu_funnel_in6: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etm6_out>;
+						coresight,hwid = <6>;
 					};
 				};
 
 				port@8 {
-					reg = <7>;
+					reg = <8>;
 					acpu_funnel_in7: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etm7_out>;
+						coresight,hwid = <7>;
 					};
 				};
 			};
@@ -253,8 +276,10 @@
 
 			port {
 				etm0_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&acpu_funnel_in0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -270,8 +295,10 @@
 
 			port {
 				etm1_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&acpu_funnel_in1>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -287,8 +314,10 @@
 
 			port {
 				etm2_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&acpu_funnel_in2>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -304,8 +333,10 @@
 
 			port {
 				etm3_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&acpu_funnel_in3>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -321,8 +352,10 @@
 
 			port {
 				etm4_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&acpu_funnel_in4>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -338,8 +371,10 @@
 
 			port {
 				etm5_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&acpu_funnel_in5>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -355,8 +390,10 @@
 
 			port {
 				etm6_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&acpu_funnel_in6>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -372,8 +409,10 @@
 
 			port {
 				etm7_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&acpu_funnel_in7>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
-- 
2.7.4
