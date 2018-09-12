Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5ACC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E7C20854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E7C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeILS7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:59:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60186 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbeILS7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:59:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6530580D;
        Wed, 12 Sep 2018 06:54:25 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6E7C23F557;
        Wed, 12 Sep 2018 06:54:23 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, coresight@lists.linaro.org,
        leo.yan@linaro.org, suzuki.poulose@arm.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 10/11] arm: dts: sama5d2: Update coresight bindings for hardware ports
Date:   Wed, 12 Sep 2018 14:53:51 +0100
Message-Id: <20180912135352.19722-11-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180912135352.19722-1-suzuki.poulose@arm.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the new coresight bindings for hardware ports

Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 61f68e5c48e9..f0fd2b1c04ba 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -84,10 +84,11 @@
 		clocks = <&mck>;
 		clock-names = "apb_pclk";
 
-		port {
-			etb_in: endpoint {
-				slave-mode;
-				remote-endpoint = <&etm_out>;
+		in-ports {
+			port {
+				etb_in: endpoint {
+					remote-endpoint = <&etm_out>;
+				};
 			};
 		};
 	};
@@ -99,9 +100,11 @@
 		clocks = <&mck>;
 		clock-names = "apb_pclk";
 
-		port {
-			etm_out: endpoint {
-				remote-endpoint = <&etb_in>;
+		out-ports {
+			port {
+				etm_out: endpoint {
+					remote-endpoint = <&etb_in>;
+				};
 			};
 		};
 	};
-- 
2.19.0

