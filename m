Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeFEVpR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:45:17 -0400
Received: from foss.arm.com ([217.140.101.70]:34548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751780AbeFEVpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:45:12 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, robh@kernel.org, frowand.list@gmail.com,
        mark.rutland@arm.com, sudeep.holla@arm.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH 10/20] dts: juno: Update coresight bindings for hw port
Date: Tue,  5 Jun 2018 22:43:21 +0100
Message-Id: <1528235011-30691-11-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to updated coresight bindings for hw ports.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V1:
  - Add support Juno for r1 & r2.
---
 arch/arm64/boot/dts/arm/juno-base.dtsi    | 82 ++++++++++++++++++++++---------
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 26 +++++++---
 arch/arm64/boot/dts/arm/juno.dts          |  5 +-
 3 files changed, 81 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index eb749c5..33b41ba 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -122,15 +122,18 @@
 			port@0 {
 				reg = <0>;
 				etf0_in_port: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&main_funnel_out_port>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			/* output port */
 			port@1 {
-				reg = <0>;
+				reg = <1>;
 				etf0_out_port: endpoint {
+					coresight,hwid = <0>;
+					direction = <1>;
 				};
 			};
 		};
@@ -145,8 +148,9 @@
 		power-domains = <&scpi_devpd 0>;
 		port {
 			tpiu_in_port: endpoint {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&replicator_out_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -168,23 +172,27 @@
 				reg = <0>;
 				main_funnel_out_port: endpoint {
 					remote-endpoint = <&etf0_in_port>;
+					coresight,hwid = <0>;
+					direction = <1>;
 				};
 			};
 
 			/* input ports */
 			port@1 {
-				reg = <0>;
+				reg = <1>;
 				main_funnel_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&cluster0_funnel_out_port>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			port@2 {
-				reg = <1>;
+				reg = <2>;
 				main_funnel_in_port1: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&cluster1_funnel_out_port>;
+					coresight,hwid = <1>;
 				};
 			};
 		};
@@ -200,8 +208,9 @@
 		power-domains = <&scpi_devpd 0>;
 		port {
 			etr_in_port: endpoint {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&replicator_out_port1>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -217,6 +226,8 @@
 		power-domains = <&scpi_devpd 0>;
 		port {
 			stm_out_port: endpoint {
+				coresight,hwid = <0>;
+				direction = <1>;
 			};
 		};
 	};
@@ -240,6 +251,8 @@
 		port {
 			cluster0_etm0_out_port: endpoint {
 				remote-endpoint = <&cluster0_funnel_in_port0>;
+				coresight,hwid = <0>;
+				direction = <1>;
 			};
 		};
 	};
@@ -259,22 +272,26 @@
 				reg = <0>;
 				cluster0_funnel_out_port: endpoint {
 					remote-endpoint = <&main_funnel_in_port0>;
+					coresight,hwid = <0>;
+					direction = <1>;
 				};
 			};
 
 			port@1 {
-				reg = <0>;
+				reg = <1>;
 				cluster0_funnel_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&cluster0_etm0_out_port>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			port@2 {
-				reg = <1>;
+				reg = <2>;
 				cluster0_funnel_in_port1: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&cluster0_etm1_out_port>;
+					coresight,hwid = <1>;
 				};
 			};
 		};
@@ -299,6 +316,8 @@
 		port {
 			cluster0_etm1_out_port: endpoint {
 				remote-endpoint = <&cluster0_funnel_in_port1>;
+				coresight,hwid = <0>;
+				direction = <1>;
 			};
 		};
 	};
@@ -322,6 +341,8 @@
 		port {
 			cluster1_etm0_out_port: endpoint {
 				remote-endpoint = <&cluster1_funnel_in_port0>;
+				coresight,hwid = <0>;
+				direction = <1>;
 			};
 		};
 	};
@@ -341,36 +362,42 @@
 				reg = <0>;
 				cluster1_funnel_out_port: endpoint {
 					remote-endpoint = <&main_funnel_in_port1>;
+					coresight,hwid = <0>;
+					direction = <1>;
 				};
 			};
 
 			port@1 {
-				reg = <0>;
+				reg = <1>;
 				cluster1_funnel_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&cluster1_etm0_out_port>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			port@2 {
-				reg = <1>;
+				reg = <2>;
 				cluster1_funnel_in_port1: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&cluster1_etm1_out_port>;
+					coresight,hwid = <1>;
 				};
 			};
 			port@3 {
-				reg = <2>;
+				reg = <3>;
 				cluster1_funnel_in_port2: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&cluster1_etm2_out_port>;
+					coresight,hwid = <2>;
 				};
 			};
 			port@4 {
-				reg = <3>;
+				reg = <4>;
 				cluster1_funnel_in_port3: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&cluster1_etm3_out_port>;
+					coresight,hwid = <3>;
 				};
 			};
 		};
@@ -395,6 +422,8 @@
 		port {
 			cluster1_etm1_out_port: endpoint {
 				remote-endpoint = <&cluster1_funnel_in_port1>;
+				coresight,hwid = <0>;
+				direction = <1>;
 			};
 		};
 	};
@@ -418,6 +447,8 @@
 		port {
 			cluster1_etm2_out_port: endpoint {
 				remote-endpoint = <&cluster1_funnel_in_port2>;
+				coresight,hwid = <0>;
+				direction = <1>;
 			};
 		};
 	};
@@ -441,6 +472,8 @@
 		port {
 			cluster1_etm3_out_port: endpoint {
 				remote-endpoint = <&cluster1_funnel_in_port3>;
+				coresight,hwid = <0>;
+				direction = <1>;
 			};
 		};
 	};
@@ -462,6 +495,8 @@
 				reg = <0>;
 				replicator_out_port0: endpoint {
 					remote-endpoint = <&tpiu_in_port>;
+					coresight,hwid = <0>;
+					direction = <1>;
 				};
 			};
 
@@ -469,14 +504,17 @@
 				reg = <1>;
 				replicator_out_port1: endpoint {
 					remote-endpoint = <&etr_in_port>;
+					coresight,hwid = <1>;
+					direction = <1>;
 				};
 			};
 
 			/* replicator input port */
 			port@2 {
-				reg = <0>;
+				reg = <2>;
 				replicator_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
index 0c43fb3..146a5d9 100644
--- a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
@@ -15,15 +15,18 @@
 			port@0 {
 				reg = <0>;
 				csys1_funnel_out_port: endpoint {
+					coresight,hwid = <0>;
+					direction = <1>;
 					remote-endpoint = <&etf1_in_port>;
 				};
 			};
 
 			/* input port */
 			port@1 {
-				reg = <0>;
+				reg = <1>;
 				csys1_funnel_in_port0: endpoint {
-					slave-mode;
+					coresight,hwid = <0>;
+					direction = <0>;
 				};
 			};
 
@@ -45,15 +48,18 @@
 			port@0 {
 				reg = <0>;
 				etf1_in_port: endpoint {
-					slave-mode;
+					direction = <0>;
+					coresight,hwid = <0>;
 					remote-endpoint = <&csys1_funnel_out_port>;
 				};
 			};
 
 			/* output port */
 			port@1 {
-				reg = <0>;
+				reg = <1>;
 				etf1_out_port: endpoint {
+					coresight,hwid = <0>;
+					direction = <1>;
 					remote-endpoint = <&csys2_funnel_in_port1>;
 				};
 			};
@@ -75,23 +81,27 @@
 			port@0 {
 				reg = <0>;
 				csys2_funnel_out_port: endpoint {
+					coresight,hwid = <0>;
+					direction = <1>;
 					remote-endpoint = <&replicator_in_port0>;
 				};
 			};
 
 			/* input ports */
 			port@1 {
-				reg = <0>;
+				reg = <1>;
 				csys2_funnel_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
+					coresight,hwid = <0>;
 					remote-endpoint = <&etf0_out_port>;
 				};
 			};
 
 			port@2 {
-				reg = <1>;
+				reg = <2>;
 				csys2_funnel_in_port1: endpoint {
-					slave-mode;
+					direction = <0>;
+					coresight,hwid = <1>;
 					remote-endpoint = <&etf1_out_port>;
 				};
 			};
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index c9236c4..27b8036 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -260,10 +260,11 @@
 &main_funnel {
 	ports {
 		port@3 {
-			reg = <2>;
+			reg = <3>;
 			main_funnel_in_port2: endpoint {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&stm_out_port>;
+				coresight,hwid = <2>;
 			};
 		};
 	};
-- 
2.7.4
