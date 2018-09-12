Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E19C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C3E20854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C3E20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeILS6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:58:52 -0400
Received: from foss.arm.com ([217.140.101.70]:60098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbeILS6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:58:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01E901688;
        Wed, 12 Sep 2018 06:54:14 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E52F73F557;
        Wed, 12 Sep 2018 06:54:11 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, coresight@lists.linaro.org,
        leo.yan@linaro.org, suzuki.poulose@arm.com,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Ivan T . Ivanov" <ivan.ivanov@linaro.org>
Subject: [PATCH v2 05/11] arm64: dts: msm8916: Update coresight bindings for hardware ports
Date:   Wed, 12 Sep 2018 14:53:46 +0100
Message-Id: <20180912135352.19722-6-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180912135352.19722-1-suzuki.poulose@arm.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to updated coresight bindings for hw ports

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v1:
 - Fixed TPIU port direction
 - Use better subject tag for the patch
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 95 ++++++++++++++-------------
 1 file changed, 51 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7b32b8990d62..fe375a9c218e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1099,10 +1099,11 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			port {
-				tpiu_in: endpoint {
-					slave-mode;
-					remote-endpoint = <&replicator_out1>;
+			in-ports {
+				port {
+					tpiu_in: endpoint {
+						remote-endpoint = <&replicator_out1>;
+					};
 				};
 			};
 		};
@@ -1114,7 +1115,7 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1132,12 +1133,13 @@
 				port@4 {
 					reg = <4>;
 					funnel0_in4: endpoint {
-						slave-mode;
 						remote-endpoint = <&funnel1_out>;
 					};
 				};
-				port@8 {
-					reg = <0>;
+			};
+
+			out-ports {
+				port {
 					funnel0_out: endpoint {
 						remote-endpoint = <&etf_in>;
 					};
@@ -1152,7 +1154,7 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1168,10 +1170,11 @@
 						remote-endpoint = <&tpiu_in>;
 					};
 				};
-				port@2 {
-					reg = <0>;
+			};
+
+			in-ports {
+				port {
 					replicator_in: endpoint {
-						slave-mode;
 						remote-endpoint = <&etf_out>;
 					};
 				};
@@ -1185,19 +1188,16 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
+			in-ports {
+				port {
 					etf_in: endpoint {
-						slave-mode;
 						remote-endpoint = <&funnel0_out>;
 					};
 				};
-				port@1 {
-					reg = <0>;
+			};
+
+			out-ports {
+				port {
 					etf_out: endpoint {
 						remote-endpoint = <&replicator_in>;
 					};
@@ -1212,10 +1212,11 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			port {
-				etr_in: endpoint {
-					slave-mode;
-					remote-endpoint = <&replicator_out0>;
+			in-ports {
+				port {
+					etr_in: endpoint {
+						remote-endpoint = <&replicator_out0>;
+					};
 				};
 			};
 		};
@@ -1227,40 +1228,38 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
 				port@0 {
 					reg = <0>;
 					funnel1_in0: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm0_out>;
 					};
 				};
 				port@1 {
 					reg = <1>;
 					funnel1_in1: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm1_out>;
 					};
 				};
 				port@2 {
 					reg = <2>;
 					funnel1_in2: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm2_out>;
 					};
 				};
 				port@3 {
 					reg = <3>;
 					funnel1_in3: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm3_out>;
 					};
 				};
-				port@4 {
-					reg = <0>;
+			};
+
+			out-ports {
+				port {
 					funnel1_out: endpoint {
 						remote-endpoint = <&funnel0_in4>;
 					};
@@ -1309,9 +1308,11 @@
 
 			cpu = <&CPU0>;
 
-			port {
-				etm0_out: endpoint {
-				remote-endpoint = <&funnel1_in0>;
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint = <&funnel1_in0>;
+					};
 				};
 			};
 		};
@@ -1325,9 +1326,11 @@
 
 			cpu = <&CPU1>;
 
-			port {
-				etm1_out: endpoint {
-					remote-endpoint = <&funnel1_in1>;
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint = <&funnel1_in1>;
+					};
 				};
 			};
 		};
@@ -1341,9 +1344,11 @@
 
 			cpu = <&CPU2>;
 
-			port {
-				etm2_out: endpoint {
-					remote-endpoint = <&funnel1_in2>;
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint = <&funnel1_in2>;
+					};
 				};
 			};
 		};
@@ -1357,9 +1362,11 @@
 
 			cpu = <&CPU3>;
 
-			port {
-				etm3_out: endpoint {
-					remote-endpoint = <&funnel1_in3>;
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint = <&funnel1_in3>;
+					};
 				};
 			};
 		};
-- 
2.19.0

