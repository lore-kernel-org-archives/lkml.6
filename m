Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E7DECDFC1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136A920854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136A920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeILS64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:58:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60130 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbeILS64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:58:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A982515BF;
        Wed, 12 Sep 2018 06:54:18 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 74CE73F557;
        Wed, 12 Sep 2018 06:54:16 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, coresight@lists.linaro.org,
        leo.yan@linaro.org, suzuki.poulose@arm.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH v2 07/11] arm: dts: imx7: Update coresight binding for hardware ports
Date:   Wed, 12 Sep 2018 14:53:48 +0100
Message-Id: <20180912135352.19722-8-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180912135352.19722-1-suzuki.poulose@arm.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 arch/arm/boot/dts/imx7d.dtsi | 14 +++---
 arch/arm/boot/dts/imx7s.dtsi | 82 ++++++++++++++++--------------------
 2 files changed, 46 insertions(+), 50 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 7cbc2ffa4b3a..a96d031ad46c 100644
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
@@ -148,11 +150,13 @@
 	};
 };
 
-&ca_funnel_ports {
+&ca_funnel_in_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	port@1 {
 		reg = <1>;
 		ca_funnel_in_port1: endpoint {
-			slave-mode;
 			remote-endpoint = <&etm1_out_port>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index a052198f6e96..b65cfc6a8841 100644
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
@@ -123,12 +123,11 @@
 					remote-endpoint = <&etr_in_port>;
 				};
 			};
+		};
 
-			/* replicator input port */
-			port@2 {
-				reg = <0>;
+		in-ports {
+			port {
 				replicator_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&etf_out_port>;
 				};
 			};
@@ -168,28 +167,23 @@
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
 
-			ca_funnel_ports: ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				/* funnel input ports */
-				port@0 {
-					reg = <0>;
+			ca_funnel_in_ports: in-ports {
+				port {
 					ca_funnel_in_port0: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm0_out_port>;
 					};
 				};
 
-				/* funnel output port */
-				port@2 {
-					reg = <0>;
+				/* the other input ports are not connect to anything */
+			};
+
+			out-ports {
+				port {
 					ca_funnel_out_port0: endpoint {
 						remote-endpoint = <&hugo_funnel_in_port0>;
 					};
 				};
 
-				/* the other input ports are not connect to anything */
 			};
 		};
 
@@ -200,9 +194,11 @@
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
@@ -213,15 +209,13 @@
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
@@ -229,18 +223,18 @@
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
-					reg = <0>;
+			out-ports {
+				port {
 					hugo_funnel_out_port0: endpoint {
 						remote-endpoint = <&etf_in_port>;
 					};
 				};
-
-				/* the other input ports are not connect to anything */
 			};
 		};
 
@@ -250,20 +244,16 @@
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
 
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
+			in-ports {
+				port {
 					etf_in_port: endpoint {
-						slave-mode;
 						remote-endpoint = <&hugo_funnel_out_port0>;
 					};
 				};
+			};
 
-				port@1 {
-					reg = <0>;
+			out-ports {
+				port {
 					etf_out_port: endpoint {
 						remote-endpoint = <&replicator_in_port0>;
 					};
@@ -277,10 +267,11 @@
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
@@ -291,10 +282,11 @@
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
2.19.0

