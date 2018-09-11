Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDFDC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1ADB20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1ADB20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeIKPQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:16:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41220 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbeIKPQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:16:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DE4E1650;
        Tue, 11 Sep 2018 03:17:46 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5F5783F557;
        Tue, 11 Sep 2018 03:17:44 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        mathieu.poirier@linaro.org, arm@kernel.org, sudeep.holla@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        xuwei5@hisilicon.com, lipengcheng8@huawei.com
Subject: [PATCH 02/11] dts: hisilicon: Update coresight bindings for hardware ports
Date:   Tue, 11 Sep 2018 11:17:03 +0100
Message-Id: <1536661032-30481-3-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to updated coresight bindings for hw ports.

Cc: xuwei5@hisilicon.com
Cc: lipengcheng8@huawei.com
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../arm64/boot/dts/hisilicon/hi6220-coresight.dtsi | 147 ++++++++++++---------
 1 file changed, 85 insertions(+), 62 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
index 7afee5d..2202816 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
@@ -20,7 +20,7 @@
 			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
 			clock-names = "apb_pclk";
 
-			ports {
+			out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -31,11 +31,15 @@
 							<&etf_in>;
 					};
 				};
+			};
 
-				port@1 {
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
 					reg = <0>;
 					soc_funnel_in: endpoint {
-						slave-mode;
 						remote-endpoint =
 							<&acpu_funnel_out>;
 					};
@@ -49,20 +53,24 @@
 			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
 			clock-names = "apb_pclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
 				port@0 {
 					reg = <0>;
 					etf_in: endpoint {
-						slave-mode;
 						remote-endpoint =
 							<&soc_funnel_out>;
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
 					etf_out: endpoint {
 						remote-endpoint =
@@ -77,20 +85,24 @@
 			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
 			clock-names = "apb_pclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
 				port@0 {
 					reg = <0>;
 					replicator_in: endpoint {
-						slave-mode;
 						remote-endpoint =
 							<&etf_out>;
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
 					replicator_out0: endpoint {
 						remote-endpoint =
@@ -98,7 +110,7 @@
 					};
 				};
 
-				port@2 {
+				port@1 {
 					reg = <1>;
 					replicator_out1: endpoint {
 						remote-endpoint =
@@ -114,14 +126,13 @@
 			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
 			clock-names = "apb_pclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
 				port@0 {
 					reg = <0>;
 					etr_in: endpoint {
-						slave-mode;
 						remote-endpoint =
 							<&replicator_out0>;
 					};
@@ -135,14 +146,13 @@
 			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
 			clock-names = "apb_pclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
 				port@0 {
 					reg = <0>;
 					tpiu_in: endpoint {
-						slave-mode;
 						remote-endpoint =
 							<&replicator_out1>;
 					};
@@ -156,7 +166,7 @@
 			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
 			clock-names = "apb_pclk";
 
-			ports {
+			out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -167,74 +177,71 @@
 							<&soc_funnel_in>;
 					};
 				};
+			};
 
-				port@1 {
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
 					reg = <0>;
 					acpu_funnel_in0: endpoint {
-						slave-mode;
 						remote-endpoint =
 							<&etm0_out>;
 					};
 				};
 
-				port@2 {
+				port@1 {
 					reg = <1>;
 					acpu_funnel_in1: endpoint {
-						slave-mode;
 						remote-endpoint =
 							<&etm1_out>;
 					};
 				};
 
-				port@3 {
+				port@2 {
 					reg = <2>;
 					acpu_funnel_in2: endpoint {
-						slave-mode;
 						remote-endpoint =
 							<&etm2_out>;
 					};
 				};
 
-				port@4 {
+				port@3 {
 					reg = <3>;
 					acpu_funnel_in3: endpoint {
-						slave-mode;
 						remote-endpoint =
 							<&etm3_out>;
 					};
 				};
 
-				port@5 {
+				port@4 {
 					reg = <4>;
 					acpu_funnel_in4: endpoint {
-						slave-mode;
 						remote-endpoint =
 							<&etm4_out>;
 					};
 				};
 
-				port@6 {
+				port@5 {
 					reg = <5>;
 					acpu_funnel_in5: endpoint {
-						slave-mode;
 						remote-endpoint =
 							<&etm5_out>;
 					};
 				};
 
-				port@7 {
+				port@6 {
 					reg = <6>;
 					acpu_funnel_in6: endpoint {
-						slave-mode;
 						remote-endpoint =
 							<&etm6_out>;
 					};
 				};
 
-				port@8 {
+				port@7 {
 					reg = <7>;
 					acpu_funnel_in7: endpoint {
-						slave-mode;
 						remote-endpoint =
 							<&etm7_out>;
 					};
@@ -251,10 +258,12 @@
 
 			cpu = <&cpu0>;
 
-			port {
-				etm0_out: endpoint {
-					remote-endpoint =
-						<&acpu_funnel_in0>;
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint =
+							<&acpu_funnel_in0>;
+					};
 				};
 			};
 		};
@@ -268,10 +277,12 @@
 
 			cpu = <&cpu1>;
 
-			port {
-				etm1_out: endpoint {
-					remote-endpoint =
-						<&acpu_funnel_in1>;
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint =
+							<&acpu_funnel_in1>;
+					};
 				};
 			};
 		};
@@ -285,10 +296,12 @@
 
 			cpu = <&cpu2>;
 
-			port {
-				etm2_out: endpoint {
-					remote-endpoint =
-						<&acpu_funnel_in2>;
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint =
+							<&acpu_funnel_in2>;
+					};
 				};
 			};
 		};
@@ -302,10 +315,12 @@
 
 			cpu = <&cpu3>;
 
-			port {
-				etm3_out: endpoint {
-					remote-endpoint =
-						<&acpu_funnel_in3>;
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint =
+							<&acpu_funnel_in3>;
+					};
 				};
 			};
 		};
@@ -319,10 +334,12 @@
 
 			cpu = <&cpu4>;
 
-			port {
+			out-ports {
+				port {
 				etm4_out: endpoint {
-					remote-endpoint =
-						<&acpu_funnel_in4>;
+						remote-endpoint =
+							<&acpu_funnel_in4>;
+					};
 				};
 			};
 		};
@@ -336,10 +353,12 @@
 
 			cpu = <&cpu5>;
 
-			port {
-				etm5_out: endpoint {
-					remote-endpoint =
-						<&acpu_funnel_in5>;
+			out-ports {
+				port {
+					etm5_out: endpoint {
+						remote-endpoint =
+							<&acpu_funnel_in5>;
+					};
 				};
 			};
 		};
@@ -353,10 +372,12 @@
 
 			cpu = <&cpu6>;
 
-			port {
-				etm6_out: endpoint {
-					remote-endpoint =
-						<&acpu_funnel_in6>;
+			out-ports {
+				port {
+					etm6_out: endpoint {
+						remote-endpoint =
+							<&acpu_funnel_in6>;
+					};
 				};
 			};
 		};
@@ -370,10 +391,12 @@
 
 			cpu = <&cpu7>;
 
-			port {
-				etm7_out: endpoint {
-					remote-endpoint =
-						<&acpu_funnel_in7>;
+			out-ports {
+				port {
+					etm7_out: endpoint {
+						remote-endpoint =
+							<&acpu_funnel_in7>;
+					};
 				};
 			};
 		};
-- 
2.7.4

