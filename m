Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D474C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134F420854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134F420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeILS6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:58:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60054 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbeILS6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:58:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E45C15BF;
        Wed, 12 Sep 2018 06:54:07 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A74533F557;
        Wed, 12 Sep 2018 06:54:05 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, coresight@lists.linaro.org,
        leo.yan@linaro.org, suzuki.poulose@arm.com
Subject: [PATCH v2 02/11] coresight: dts: binding: Update coresight binding examples
Date:   Wed, 12 Sep 2018 14:53:43 +0100
Message-Id: <20180912135352.19722-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180912135352.19722-1-suzuki.poulose@arm.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While we updated the coresight DT bindings, some of the
new examples were not updated due to the order in which they
were merged. Let us update all the missed out ones to the
new bindings to avoid confusion.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../devicetree/bindings/arm/coresight.txt     | 25 ++++++++-----------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 13b6198ce01c..f8aff65ab921 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -147,22 +147,16 @@ Example:
 
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			/* input port */
-			port@0 {
-				reg =  <0>;
+		in-ports {
+			port {
 				etr_in_port: endpoint {
-					slave-mode;
 					remote-endpoint = <&replicator2_out_port0>;
 				};
 			};
+		};
 
-			/* CATU link represented by output port */
-			port@1 {
-				reg = <1>;
+		out-ports {
+			port {
 				etr_out_port: endpoint {
 					remote-endpoint = <&catu_in_port>;
 				};
@@ -310,10 +304,11 @@ Example:
 		clock-names = "apb_pclk";
 
 		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-		port {
-			catu_in_port: endpoint {
-				slave-mode;
-				remote-endpoint = <&etr_out_port>;
+		in-ports {
+			port {
+				catu_in_port: endpoint {
+					remote-endpoint = <&etr_out_port>;
+				};
 			};
 		};
 	};
-- 
2.19.0

