Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753066AbeFEVpp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:45:45 -0400
Received: from foss.arm.com ([217.140.101.70]:34734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752559AbeFEVpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:45:43 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, robh@kernel.org, frowand.list@gmail.com,
        mark.rutland@arm.com, sudeep.holla@arm.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 20/20] dts: tc2: Update coresight bindings for hardware ports
Date: Tue,  5 Jun 2018 22:43:31 +0100
Message-Id: <1528235011-30691-21-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the new coresight bindings

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 48 ++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index a4c7713..407693e 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -394,8 +394,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etb_in_port: endpoint {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&replicator_out_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -408,8 +409,9 @@
 		clock-names = "apb_pclk";
 		port {
 			tpiu_in_port: endpoint {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&replicator_out_port1>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -428,23 +430,28 @@
 			port@0 {
 				reg = <0>;
 				replicator_out_port0: endpoint {
+					direction = <1>;
 					remote-endpoint = <&etb_in_port>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			port@1 {
 				reg = <1>;
 				replicator_out_port1: endpoint {
+					direction = <1>;
 					remote-endpoint = <&tpiu_in_port>;
+					coresight,hwid = <1>;
 				};
 			};
 
 			/* replicator input port */
 			port@2 {
-				reg = <0>;
+				reg = <2>;
 				replicator_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&funnel_out_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -464,33 +471,38 @@
 			port@0 {
 				reg = <0>;
 				funnel_out_port0: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&replicator_in_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			/* funnel input ports */
 			port@1 {
-				reg = <0>;
+				reg = <1>;
 				funnel_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm0_out_port>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			port@2 {
-				reg = <1>;
+				reg = <2>;
 				funnel_in_port1: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm1_out_port>;
+					coresight,hwid = <1>;
 				};
 			};
 
 			port@3 {
-				reg = <2>;
+				reg = <3>;
 				funnel_in_port2: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&etm0_out_port>;
+					coresight,hwid = <2>;
 				};
 			};
 
@@ -499,16 +511,18 @@
 			port@4 {
 				reg = <4>;
 				funnel_in_port4: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&etm1_out_port>;
+					coresight,hwid = <4>;
 				};
 			};
 
 			port@5 {
 				reg = <5>;
 				funnel_in_port5: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&etm2_out_port>;
+					coresight,hwid = <5>;
 				};
 			};
 		};
@@ -523,7 +537,9 @@
 		clock-names = "apb_pclk";
 		port {
 			ptm0_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel_in_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -537,7 +553,9 @@
 		clock-names = "apb_pclk";
 		port {
 			ptm1_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel_in_port1>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -551,7 +569,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etm0_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel_in_port2>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -565,7 +585,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etm1_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel_in_port4>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -579,7 +601,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etm2_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel_in_port5>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
-- 
2.7.4
