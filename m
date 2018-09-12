Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955EAC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5641520891
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5641520891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeILS7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:59:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60204 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbeILS7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:59:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F2C51684;
        Wed, 12 Sep 2018 06:54:27 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A4A713F557;
        Wed, 12 Sep 2018 06:54:25 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, coresight@lists.linaro.org,
        leo.yan@linaro.org, suzuki.poulose@arm.com,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 11/11] arm: dts: ste-dbx5x0: Update coresight bindings for hardware port
Date:   Wed, 12 Sep 2018 14:53:52 +0100
Message-Id: <20180912135352.19722-12-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180912135352.19722-1-suzuki.poulose@arm.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the new coresight bindings

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 65 ++++++++++++++++---------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 2310a4e97768..7f94b5a53205 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -67,9 +67,11 @@
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			cpu = <&CPU0>;
-			port {
-				ptm0_out_port: endpoint {
-					remote-endpoint = <&funnel_in_port0>;
+			out-ports {
+				port {
+					ptm0_out_port: endpoint {
+						remote-endpoint = <&funnel_in_port0>;
+					};
 				};
 			};
 		};
@@ -81,9 +83,11 @@
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			cpu = <&CPU1>;
-			port {
-				ptm1_out_port: endpoint {
-					remote-endpoint = <&funnel_in_port1>;
+			out-ports {
+				port {
+					ptm1_out_port: endpoint {
+						remote-endpoint = <&funnel_in_port1>;
+					};
 				};
 			};
 		};
@@ -94,32 +98,29 @@
 
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				/* funnel output ports */
-				port@0 {
-					reg = <0>;
+			out-ports {
+				port {
 					funnel_out_port: endpoint {
 						remote-endpoint =
 							<&replicator_in_port0>;
 					};
 				};
+			};
 
-				/* funnel input ports */
-				port@1 {
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
 					reg = <0>;
 					funnel_in_port0: endpoint {
-						slave-mode;
 						remote-endpoint = <&ptm0_out_port>;
 					};
 				};
 
-				port@2 {
+				port@1 {
 					reg = <1>;
 					funnel_in_port1: endpoint {
-						slave-mode;
 						remote-endpoint = <&ptm1_out_port>;
 					};
 				};
@@ -131,11 +132,10 @@
 			clocks = <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "atclk";
 
-			ports {
+			out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				/* replicator output ports */
 				port@0 {
 					reg = <0>;
 					replicator_out_port0: endpoint {
@@ -148,12 +148,11 @@
 						remote-endpoint = <&etb_in_port>;
 					};
 				};
+			};
 
-				/* replicator input port */
-				port@2 {
-					reg = <0>;
+			in-ports {
+				port {
 					replicator_in_port0: endpoint {
-						slave-mode;
 						remote-endpoint = <&funnel_out_port>;
 					};
 				};
@@ -166,10 +165,11 @@
 
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
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
@@ -180,10 +180,11 @@
 
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
-			port {
-				etb_in_port: endpoint {
-					slave-mode;
-					remote-endpoint = <&replicator_out_port1>;
+			in-ports {
+				port {
+					etb_in_port: endpoint {
+						remote-endpoint = <&replicator_out_port1>;
+					};
 				};
 			};
 		};
-- 
2.19.0

