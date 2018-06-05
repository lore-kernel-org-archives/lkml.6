Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeFEVrD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:47:03 -0400
Received: from foss.arm.com ([217.140.101.70]:34608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752927AbeFEVpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:45:21 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, robh@kernel.org, frowand.list@gmail.com,
        mark.rutland@arm.com, sudeep.holla@arm.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Ivan T . Ivanov" <ivan.ivanov@linaro.org>
Subject: [PATCH 13/20] dts: qcom: Update coresight bindings for hw ports
Date: Tue,  5 Jun 2018 22:43:24 +0100
Message-Id: <1528235011-30691-14-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to updated coresight bindings for hw ports

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 55 ++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 66b318e..40da823 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1101,8 +1101,9 @@
 
 			port {
 				tpiu_in: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&replicator_out1>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -1132,14 +1133,17 @@
 				port@4 {
 					reg = <4>;
 					funnel0_in4: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&funnel1_out>;
+						coresight,hwid = <4>;
 					};
 				};
 				port@8 {
-					reg = <0>;
+					reg = <8>;
 					funnel0_out: endpoint {
+						direction = <1>;
 						remote-endpoint = <&etf_in>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -1159,20 +1163,25 @@
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
@@ -1192,14 +1201,17 @@
 				port@0 {
 					reg = <0>;
 					etf_out: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&funnel0_out>;
+						coresight,hwid = <0>;
 					};
 				};
 				port@1 {
-					reg = <0>;
+					reg = <1>;
 					etf_in: endpoint {
+						direction = <1>;
 						remote-endpoint = <&replicator_in>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -1214,8 +1226,9 @@
 
 			port {
 				etr_in: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&replicator_out0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -1234,35 +1247,41 @@
 				port@0 {
 					reg = <0>;
 					funnel1_in0: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm0_out>;
+						coresight,hwid = <0>;
 					};
 				};
 				port@1 {
 					reg = <1>;
 					funnel1_in1: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm1_out>;
+						coresight,hwid = <1>;
 					};
 				};
 				port@2 {
 					reg = <2>;
 					funnel1_in2: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm2_out>;
+						coresight,hwid = <2>;
 					};
 				};
 				port@3 {
 					reg = <3>;
 					funnel1_in3: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm3_out>;
+						coresight,hwid = <3>;
 					};
 				};
 				port@4 {
-					reg = <0>;
+					reg = <4>;
 					funnel1_out: endpoint {
+						direction = <1>;
 						remote-endpoint = <&funnel0_in4>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -1311,7 +1330,9 @@
 
 			port {
 				etm0_out: endpoint {
-				remote-endpoint = <&funnel1_in0>;
+					direction = <1>;
+					remote-endpoint = <&funnel1_in0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -1327,7 +1348,9 @@
 
 			port {
 				etm1_out: endpoint {
+					direction = <1>;
 					remote-endpoint = <&funnel1_in1>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -1343,7 +1366,9 @@
 
 			port {
 				etm2_out: endpoint {
+					direction = <1>;
 					remote-endpoint = <&funnel1_in2>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -1359,7 +1384,9 @@
 
 			port {
 				etm3_out: endpoint {
+					direction = <1>;
 					remote-endpoint = <&funnel1_in3>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
-- 
2.7.4
