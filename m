Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E98AC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FD62086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FD62086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeIKPQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:16:33 -0400
Received: from foss.arm.com ([217.140.101.70]:41260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbeIKPQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:16:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F35381684;
        Tue, 11 Sep 2018 03:17:52 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 118623F557;
        Tue, 11 Sep 2018 03:17:50 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        mathieu.poirier@linaro.org, arm@kernel.org, sudeep.holla@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>
Subject: [PATCH 05/11] dts: arm: hisilicon: Update coresight bindings for hardware ports
Date:   Tue, 11 Sep 2018 11:17:06 +0100
Message-Id: <1536661032-30481-6-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the new the hardware port bindings.

Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/hip04.dtsi | 322 ++++++++++++++++++++++++-------------------
 1 file changed, 183 insertions(+), 139 deletions(-)

diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
index 44044f2..9ab1980 100644
--- a/arch/arm/boot/dts/hip04.dtsi
+++ b/arch/arm/boot/dts/hip04.dtsi
@@ -277,10 +277,11 @@
 
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
-		port {
-			etb0_in_port: endpoint@0 {
-				slave-mode;
-				remote-endpoint = <&replicator0_out_port0>;
+		in-ports {
+			port {
+				etb0_in_port: endpoint@0 {
+					remote-endpoint = <&replicator0_out_port0>;
+				};
 			};
 		};
 	};
@@ -291,10 +292,11 @@
 
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
-		port {
-			etb1_in_port: endpoint@0 {
-				slave-mode;
-				remote-endpoint = <&replicator1_out_port0>;
+		in-ports {
+			port {
+				etb1_in_port: endpoint@0 {
+					remote-endpoint = <&replicator1_out_port0>;
+				};
 			};
 		};
 	};
@@ -305,10 +307,11 @@
 
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
-		port {
-			etb2_in_port: endpoint@0 {
-				slave-mode;
-				remote-endpoint = <&replicator2_out_port0>;
+		in-ports {
+			port {
+				etb2_in_port: endpoint@0 {
+					remote-endpoint = <&replicator2_out_port0>;
+				};
 			};
 		};
 	};
@@ -319,10 +322,11 @@
 
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
-		port {
-			etb3_in_port: endpoint@0 {
-				slave-mode;
-				remote-endpoint = <&replicator3_out_port0>;
+		in-ports {
+			port {
+				etb3_in_port: endpoint@0 {
+					remote-endpoint = <&replicator3_out_port0>;
+				};
 			};
 		};
 	};
@@ -333,10 +337,11 @@
 
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
-		port {
-			tpiu_in_port: endpoint@0 {
-				slave-mode;
-				remote-endpoint = <&funnel4_out_port0>;
+		in-ports {
+			port {
+				tpiu_in_port: endpoint@0 {
+					remote-endpoint = <&funnel4_out_port0>;
+				};
 			};
 		};
 	};
@@ -347,7 +352,7 @@
 		 */
 		compatible = "arm,coresight-replicator";
 
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
@@ -365,12 +370,16 @@
 					remote-endpoint = <&funnel4_in_port0>;
 				};
 			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
 
 			/* replicator input port */
-			port@2 {
+			port@0 {
 				reg = <0>;
 				replicator0_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&funnel0_out_port0>;
 				};
 			};
@@ -383,7 +392,7 @@
 		 */
 		compatible = "arm,coresight-replicator";
 
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
@@ -401,12 +410,16 @@
 					remote-endpoint = <&funnel4_in_port1>;
 				};
 			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
 
 			/* replicator input port */
-			port@2 {
+			port@0 {
 				reg = <0>;
 				replicator1_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&funnel1_out_port0>;
 				};
 			};
@@ -419,11 +432,10 @@
 		 */
 		compatible = "arm,coresight-replicator";
 
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			/* replicator output ports */
 			port@0 {
 				reg = <0>;
 				replicator2_out_port0: endpoint {
@@ -437,12 +449,15 @@
 					remote-endpoint = <&funnel4_in_port2>;
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
 				replicator2_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&funnel2_out_port0>;
 				};
 			};
@@ -455,11 +470,10 @@
 		 */
 		compatible = "arm,coresight-replicator";
 
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			/* replicator output ports */
 			port@0 {
 				reg = <0>;
 				replicator3_out_port0: endpoint {
@@ -473,12 +487,15 @@
 					remote-endpoint = <&funnel4_in_port3>;
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
 				replicator3_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&funnel3_out_port0>;
 				};
 			};
@@ -491,11 +508,10 @@
 
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			/* funnel output port */
 			port@0 {
 				reg = <0>;
 				funnel0_out_port0: endpoint {
@@ -503,36 +519,36 @@
 						<&replicator0_in_port0>;
 				};
 			};
+		};
 
-			/* funnel input ports */
-			port@1 {
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
 				reg = <0>;
 				funnel0_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm0_out_port>;
 				};
 			};
 
-			port@2 {
+			port@1 {
 				reg = <1>;
 				funnel0_in_port1: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm1_out_port>;
 				};
 			};
 
-			port@3 {
+			port@2 {
 				reg = <2>;
 				funnel0_in_port2: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm2_out_port>;
 				};
 			};
 
-			port@4 {
+			port@3 {
 				reg = <3>;
 				funnel0_in_port3: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm3_out_port>;
 				};
 			};
@@ -545,11 +561,10 @@
 
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			/* funnel output port */
 			port@0 {
 				reg = <0>;
 				funnel1_out_port0: endpoint {
@@ -557,36 +572,36 @@
 						<&replicator1_in_port0>;
 				};
 			};
+		};
 
-			/* funnel input ports */
-			port@1 {
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
 				reg = <0>;
 				funnel1_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm4_out_port>;
 				};
 			};
 
-			port@2 {
+			port@1 {
 				reg = <1>;
 				funnel1_in_port1: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm5_out_port>;
 				};
 			};
 
-			port@3 {
+			port@2 {
 				reg = <2>;
 				funnel1_in_port2: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm6_out_port>;
 				};
 			};
 
-			port@4 {
+			port@3 {
 				reg = <3>;
 				funnel1_in_port3: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm7_out_port>;
 				};
 			};
@@ -599,11 +614,10 @@
 
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			/* funnel output port */
 			port@0 {
 				reg = <0>;
 				funnel2_out_port0: endpoint {
@@ -611,36 +625,36 @@
 						<&replicator2_in_port0>;
 				};
 			};
+		};
 
-			/* funnel input ports */
-			port@1 {
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
 				reg = <0>;
 				funnel2_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm8_out_port>;
 				};
 			};
 
-			port@2 {
+			port@1 {
 				reg = <1>;
 				funnel2_in_port1: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm9_out_port>;
 				};
 			};
 
-			port@3 {
+			port@2 {
 				reg = <2>;
 				funnel2_in_port2: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm10_out_port>;
 				};
 			};
 
-			port@4 {
+			port@3 {
 				reg = <3>;
 				funnel2_in_port3: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm11_out_port>;
 				};
 			};
@@ -653,11 +667,10 @@
 
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			/* funnel output port */
 			port@0 {
 				reg = <0>;
 				funnel3_out_port0: endpoint {
@@ -665,36 +678,36 @@
 						<&replicator3_in_port0>;
 				};
 			};
+		};
 
-			/* funnel input ports */
-			port@1 {
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
 				reg = <0>;
 				funnel3_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm12_out_port>;
 				};
 			};
 
-			port@2 {
+			port@1 {
 				reg = <1>;
 				funnel3_in_port1: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm13_out_port>;
 				};
 			};
 
-			port@3 {
+			port@2 {
 				reg = <2>;
 				funnel3_in_port2: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm14_out_port>;
 				};
 			};
 
-			port@4 {
+			port@3 {
 				reg = <3>;
 				funnel3_in_port3: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm15_out_port>;
 				};
 			};
@@ -707,50 +720,49 @@
 
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			/* funnel output port */
 			port@0 {
 				reg = <0>;
 				funnel4_out_port0: endpoint {
 					remote-endpoint = <&tpiu_in_port>;
 				};
 			};
+		};
 
-			/* funnel input ports */
-			port@1 {
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
 				reg = <0>;
 				funnel4_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint =
 						<&replicator0_out_port1>;
 				};
 			};
 
-			port@2 {
+			port@1 {
 				reg = <1>;
 				funnel4_in_port1: endpoint {
-					slave-mode;
 					remote-endpoint =
 						<&replicator1_out_port1>;
 				};
 			};
 
-			port@3 {
+			port@2 {
 				reg = <2>;
 				funnel4_in_port2: endpoint {
-					slave-mode;
 					remote-endpoint =
 						<&replicator2_out_port1>;
 				};
 			};
 
-			port@4 {
+			port@3 {
 				reg = <3>;
 				funnel4_in_port3: endpoint {
-					slave-mode;
 					remote-endpoint =
 						<&replicator3_out_port1>;
 				};
@@ -765,9 +777,11 @@
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
 		cpu = <&CPU0>;
-		port {
-			ptm0_out_port: endpoint {
-				remote-endpoint = <&funnel0_in_port0>;
+		out-ports {
+			port {
+				ptm0_out_port: endpoint {
+					remote-endpoint = <&funnel0_in_port0>;
+				};
 			};
 		};
 	};
@@ -779,9 +793,11 @@
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
 		cpu = <&CPU1>;
-		port {
-			ptm1_out_port: endpoint {
-				remote-endpoint = <&funnel0_in_port1>;
+		out-ports {
+			port {
+				ptm1_out_port: endpoint {
+					remote-endpoint = <&funnel0_in_port1>;
+				};
 			};
 		};
 	};
@@ -793,9 +809,11 @@
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
 		cpu = <&CPU2>;
-		port {
-			ptm2_out_port: endpoint {
-				remote-endpoint = <&funnel0_in_port2>;
+		out-ports {
+			port {
+				ptm2_out_port: endpoint {
+					remote-endpoint = <&funnel0_in_port2>;
+				};
 			};
 		};
 	};
@@ -807,9 +825,11 @@
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
 		cpu = <&CPU3>;
-		port {
-			ptm3_out_port: endpoint {
-				remote-endpoint = <&funnel0_in_port3>;
+		out-ports {
+			port {
+				ptm3_out_port: endpoint {
+					remote-endpoint = <&funnel0_in_port3>;
+				};
 			};
 		};
 	};
@@ -821,9 +841,11 @@
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
 		cpu = <&CPU4>;
-		port {
-			ptm4_out_port: endpoint {
-				remote-endpoint = <&funnel1_in_port0>;
+		out-ports {
+			port {
+				ptm4_out_port: endpoint {
+					remote-endpoint = <&funnel1_in_port0>;
+				};
 			};
 		};
 	};
@@ -835,9 +857,11 @@
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
 		cpu = <&CPU5>;
-		port {
-			ptm5_out_port: endpoint {
-				remote-endpoint = <&funnel1_in_port1>;
+		out-ports {
+			port {
+				ptm5_out_port: endpoint {
+					remote-endpoint = <&funnel1_in_port1>;
+				};
 			};
 		};
 	};
@@ -849,9 +873,11 @@
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
 		cpu = <&CPU6>;
-		port {
-			ptm6_out_port: endpoint {
-				remote-endpoint = <&funnel1_in_port2>;
+		out-ports {
+			port {
+				ptm6_out_port: endpoint {
+					remote-endpoint = <&funnel1_in_port2>;
+				};
 			};
 		};
 	};
@@ -863,9 +889,11 @@
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
 		cpu = <&CPU7>;
-		port {
-			ptm7_out_port: endpoint {
-				remote-endpoint = <&funnel1_in_port3>;
+		out-ports {
+			port {
+				ptm7_out_port: endpoint {
+					remote-endpoint = <&funnel1_in_port3>;
+				};
 			};
 		};
 	};
@@ -877,9 +905,11 @@
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
 		cpu = <&CPU8>;
-		port {
-			ptm8_out_port: endpoint {
-				remote-endpoint = <&funnel2_in_port0>;
+		out-ports {
+			port {
+				ptm8_out_port: endpoint {
+					remote-endpoint = <&funnel2_in_port0>;
+				};
 			};
 		};
 	};
@@ -890,9 +920,11 @@
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
 		cpu = <&CPU9>;
-		port {
-			ptm9_out_port: endpoint {
-				remote-endpoint = <&funnel2_in_port1>;
+		out-ports {
+			port {
+				ptm9_out_port: endpoint {
+					remote-endpoint = <&funnel2_in_port1>;
+				};
 			};
 		};
 	};
@@ -904,9 +936,11 @@
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
 		cpu = <&CPU10>;
-		port {
-			ptm10_out_port: endpoint {
-				remote-endpoint = <&funnel2_in_port2>;
+		out-ports {
+			port {
+				ptm10_out_port: endpoint {
+					remote-endpoint = <&funnel2_in_port2>;
+				};
 			};
 		};
 	};
@@ -918,9 +952,11 @@
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
 		cpu = <&CPU11>;
-		port {
-			ptm11_out_port: endpoint {
-				remote-endpoint = <&funnel2_in_port3>;
+		out-ports {
+			port {
+				ptm11_out_port: endpoint {
+					remote-endpoint = <&funnel2_in_port3>;
+				};
 			};
 		};
 	};
@@ -932,9 +968,11 @@
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
 		cpu = <&CPU12>;
-		port {
-			ptm12_out_port: endpoint {
-				remote-endpoint = <&funnel3_in_port0>;
+		out-ports {
+			port {
+				ptm12_out_port: endpoint {
+					remote-endpoint = <&funnel3_in_port0>;
+				};
 			};
 		};
 	};
@@ -946,9 +984,11 @@
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
 		cpu = <&CPU13>;
-		port {
-			ptm13_out_port: endpoint {
-				remote-endpoint = <&funnel3_in_port1>;
+		out-ports {
+			port {
+				ptm13_out_port: endpoint {
+					remote-endpoint = <&funnel3_in_port1>;
+				};
 			};
 		};
 	};
@@ -960,9 +1000,11 @@
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
 		cpu = <&CPU14>;
-		port {
-			ptm14_out_port: endpoint {
-				remote-endpoint = <&funnel3_in_port2>;
+		out-ports {
+			port {
+				ptm14_out_port: endpoint {
+					remote-endpoint = <&funnel3_in_port2>;
+				};
 			};
 		};
 	};
@@ -974,9 +1016,11 @@
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
 		cpu = <&CPU15>;
-		port {
-			ptm15_out_port: endpoint {
-				remote-endpoint = <&funnel3_in_port3>;
+		out-ports {
+			port {
+				ptm15_out_port: endpoint {
+					remote-endpoint = <&funnel3_in_port3>;
+				};
 			};
 		};
 	};
-- 
2.7.4

