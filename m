Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753096AbeFEVqE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:46:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34722 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753032AbeFEVpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:45:40 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, robh@kernel.org, frowand.list@gmail.com,
        mark.rutland@arm.com, sudeep.holla@arm.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 19/20] dts: ste-dbx5x0: Update coresight bindings for hardware port
Date: Tue,  5 Jun 2018 22:43:30 +0100
Message-Id: <1528235011-30691-20-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the new coresight bindings

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 2310a4e..a02312a 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -69,7 +69,9 @@
 			cpu = <&CPU0>;
 			port {
 				ptm0_out_port: endpoint {
+					direction = <1>;
 					remote-endpoint = <&funnel_in_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -83,7 +85,9 @@
 			cpu = <&CPU1>;
 			port {
 				ptm1_out_port: endpoint {
+					direction = <1>;
 					remote-endpoint = <&funnel_in_port1>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -102,25 +106,29 @@
 				port@0 {
 					reg = <0>;
 					funnel_out_port: endpoint {
+						direction = <1>;
 						remote-endpoint =
 							<&replicator_in_port0>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				/* funnel input ports */
 				port@1 {
-					reg = <0>;
+					reg = <1>;
 					funnel_in_port0: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&ptm0_out_port>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port@2 {
-					reg = <1>;
+					reg = <2>;
 					funnel_in_port1: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&ptm1_out_port>;
+						coresight,hwid = <1>;
 					};
 				};
 			};
@@ -139,22 +147,27 @@
 				port@0 {
 					reg = <0>;
 					replicator_out_port0: endpoint {
+						direction = <1>;
 						remote-endpoint = <&tpiu_in_port>;
+						coresight,hwid = <0>;
 					};
 				};
 				port@1 {
 					reg = <1>;
 					replicator_out_port1: endpoint {
+						direction = <1>;
 						remote-endpoint = <&etb_in_port>;
+						coresight,hwid = <1>;
 					};
 				};
 
 				/* replicator input port */
 				port@2 {
-					reg = <0>;
+					reg = <2>;
 					replicator_in_port0: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&funnel_out_port>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -168,8 +181,9 @@
 			clock-names = "apb_pclk", "atclk";
 			port {
 				tpiu_in_port: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&replicator_out_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -182,8 +196,9 @@
 			clock-names = "apb_pclk", "atclk";
 			port {
 				etb_in_port: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&replicator_out_port1>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
-- 
2.7.4
