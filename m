Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8A4C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3987D20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3987D20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeIKPQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:16:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41276 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbeIKPQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:16:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72A2A18A;
        Tue, 11 Sep 2018 03:17:55 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3E1F43F557;
        Tue, 11 Sep 2018 03:17:53 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        mathieu.poirier@linaro.org, arm@kernel.org, sudeep.holla@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 06/11] dts: arm: imx7{d,s}: Update coresight binding for hardware ports
Date:   Tue, 11 Sep 2018 11:17:07 +0100
Message-Id: <1536661032-30481-7-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the updated coresight bindings.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 11 ++++---
 arch/arm/boot/dts/imx7s.dtsi | 78 ++++++++++++++++++++++++++------------------
 2 files changed, 53 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 7cbc2ff..4ced17c 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -63,9 +63,11 @@
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
 
-			port {
-				etm1_out_port: endpoint {
-					remote-endpoint = <&ca_funnel_in_port1>;
+			out-ports {
+				port {
+					etm1_out_port: endpoint {
+						remote-endpoint = <&ca_funnel_in_port1>;
+					};
 				};
 			};
 		};
@@ -148,11 +150,10 @@
 	};
 };
 
-&ca_funnel_ports {
+&ca_funnel_in_ports {
 	port@1 {
 		reg = <1>;
 		ca_funnel_in_port1: endpoint {
-			slave-mode;
 			remote-endpoint = <&etm1_out_port>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index a052198..9176885 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -106,7 +106,7 @@
 		 */
 		compatible = "arm,coresight-replicator";
 
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 				/* replicator output ports */
@@ -123,12 +123,15 @@
 					remote-endpoint = <&etr_in_port>;
 				};
 			};
+		};
 
-			/* replicator input port */
-			port@2 {
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
 				reg = <0>;
 				replicator_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&etf_out_port>;
 				};
 			};
@@ -168,28 +171,31 @@
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
 
-			ca_funnel_ports: ports {
+			ca_funnel_in_ports: in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				/* funnel input ports */
 				port@0 {
 					reg = <0>;
 					ca_funnel_in_port0: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm0_out_port>;
 					};
 				};
 
-				/* funnel output port */
-				port@2 {
+				/* the other input ports are not connect to anything */
+			};
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
 					reg = <0>;
 					ca_funnel_out_port0: endpoint {
 						remote-endpoint = <&hugo_funnel_in_port0>;
 					};
 				};
 
-				/* the other input ports are not connect to anything */
 			};
 		};
 
@@ -200,9 +206,11 @@
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
 
-			port {
-				etm0_out_port: endpoint {
-					remote-endpoint = <&ca_funnel_in_port0>;
+			out-ports {
+				port {
+					etm0_out_port: endpoint {
+						remote-endpoint = <&ca_funnel_in_port0>;
+					};
 				};
 			};
 		};
@@ -213,15 +221,13 @@
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				/* funnel input ports */
 				port@0 {
 					reg = <0>;
 					hugo_funnel_in_port0: endpoint {
-						slave-mode;
 						remote-endpoint = <&ca_funnel_out_port0>;
 					};
 				};
@@ -229,18 +235,22 @@
 				port@1 {
 					reg = <1>;
 					hugo_funnel_in_port1: endpoint {
-						slave-mode; /* M4 input */
+						/* M4 input */
 					};
 				};
+				/* the other input ports are not connect to anything */
+			};
 
-				port@2 {
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
 					reg = <0>;
 					hugo_funnel_out_port0: endpoint {
 						remote-endpoint = <&etf_in_port>;
 					};
 				};
-
-				/* the other input ports are not connect to anything */
 			};
 		};
 
@@ -250,19 +260,23 @@
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
 				port@0 {
 					reg = <0>;
 					etf_in_port: endpoint {
-						slave-mode;
 						remote-endpoint = <&hugo_funnel_out_port0>;
 					};
 				};
+			};
 
-				port@1 {
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
 					reg = <0>;
 					etf_out_port: endpoint {
 						remote-endpoint = <&replicator_in_port0>;
@@ -277,10 +291,11 @@
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
 
-			port {
-				etr_in_port: endpoint {
-					slave-mode;
-					remote-endpoint = <&replicator_out_port1>;
+			in-ports {
+				port {
+					etr_in_port: endpoint {
+						remote-endpoint = <&replicator_out_port1>;
+					};
 				};
 			};
 		};
@@ -291,10 +306,11 @@
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
 
-			port {
-				tpiu_in_port: endpoint {
-					slave-mode;
-					remote-endpoint = <&replicator_out_port0>;
+			in-ports {
+				port {
+					tpiu_in_port: endpoint {
+						remote-endpoint = <&replicator_out_port0>;
+					};
 				};
 			};
 		};
-- 
2.7.4

