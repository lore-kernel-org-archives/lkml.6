Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C471ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F12214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F12214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbeISPHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:07:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43215 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbeISPHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:07:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5D17D20795; Wed, 19 Sep 2018 11:30:11 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2F45920798;
        Wed, 19 Sep 2018 11:30:01 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 03/12] Documentation/bindings: net: marvell-pp2: update the IRQs description
Date:   Wed, 19 Sep 2018 11:27:02 +0200
Message-Id: <20180919092711.22296-4-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919092711.22296-1-antoine.tenart@bootlin.com>
References: <20180919092711.22296-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the interrupts part of the Marvell PPv2 driver
bindings documentation, to keep it in sync with the driver.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 .../devicetree/bindings/net/marvell-pp2.txt   | 45 +++++++++++++------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/marvell-pp2.txt b/Documentation/devicetree/bindings/net/marvell-pp2.txt
index fc019df0d863..b78397669320 100644
--- a/Documentation/devicetree/bindings/net/marvell-pp2.txt
+++ b/Documentation/devicetree/bindings/net/marvell-pp2.txt
@@ -31,7 +31,7 @@ required.
 
 Required properties (port):
 
-- interrupts: interrupt for the port
+- interrupts: interrupt(s) for the port
 - port-id: ID of the port from the MAC point of view
 - gop-port-id: only for marvell,armada-7k-pp2, ID of the port from the
   GOP (Group Of Ports) point of view. This ID is used to index the
@@ -43,10 +43,12 @@ Optional properties (port):
 - marvell,loopback: port is loopback mode
 - phy: a phandle to a phy node defining the PHY address (as the reg
   property, a single integer).
-- interrupt-names: if more than a single interrupt for rx is given, must
-                   be the name associated to the interrupts listed. Valid
-                   names are: "tx-cpu0", "tx-cpu1", "tx-cpu2", "tx-cpu3",
-		   "rx-shared", "link".
+- interrupt-names: if more than a single interrupt for is given, must be the
+                   name associated to the interrupts listed. Valid names are:
+                   "hifX", with X in [0..8], and "link". The names "tx-cpu0",
+                   "tx-cpu1", "tx-cpu2", "tx-cpu3" and "rx-shared" are supported
+                   for backward compatibility but shouldn't be used for new
+                   additions.
 - marvell,system-controller: a phandle to the system controller.
 
 Example for marvell,armada-375-pp2:
@@ -89,9 +91,14 @@ cpm_ethernet: ethernet@0 {
 			     <ICU_GRP_NSR 43 IRQ_TYPE_LEVEL_HIGH>,
 			     <ICU_GRP_NSR 47 IRQ_TYPE_LEVEL_HIGH>,
 			     <ICU_GRP_NSR 51 IRQ_TYPE_LEVEL_HIGH>,
-			     <ICU_GRP_NSR 55 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
-				  "tx-cpu3", "rx-shared";
+			     <ICU_GRP_NSR 55 IRQ_TYPE_LEVEL_HIGH>,
+			     <ICU_GRP_NSR 59 IRQ_TYPE_LEVEL_HIGH>,
+			     <ICU_GRP_NSR 63 IRQ_TYPE_LEVEL_HIGH>,
+			     <ICU_GRP_NSR 67 IRQ_TYPE_LEVEL_HIGH>,
+			     <ICU_GRP_NSR 71 IRQ_TYPE_LEVEL_HIGH>,
+			     <ICU_GRP_NSR 129 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "hif0", "hif1", "hif2", "hif3", "hif4",
+				  "hif5", "hif6", "hif7", "hif8", "link";
 		port-id = <0>;
 		gop-port-id = <0>;
 	};
@@ -101,9 +108,14 @@ cpm_ethernet: ethernet@0 {
 			     <ICU_GRP_NSR 44 IRQ_TYPE_LEVEL_HIGH>,
 			     <ICU_GRP_NSR 48 IRQ_TYPE_LEVEL_HIGH>,
 			     <ICU_GRP_NSR 52 IRQ_TYPE_LEVEL_HIGH>,
-			     <ICU_GRP_NSR 56 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
-				  "tx-cpu3", "rx-shared";
+			     <ICU_GRP_NSR 56 IRQ_TYPE_LEVEL_HIGH>,
+			     <ICU_GRP_NSR 60 IRQ_TYPE_LEVEL_HIGH>,
+			     <ICU_GRP_NSR 64 IRQ_TYPE_LEVEL_HIGH>,
+			     <ICU_GRP_NSR 68 IRQ_TYPE_LEVEL_HIGH>,
+			     <ICU_GRP_NSR 72 IRQ_TYPE_LEVEL_HIGH>,
+			     <ICU_GRP_NSR 128 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "hif0", "hif1", "hif2", "hif3", "hif4",
+				  "hif5", "hif6", "hif7", "hif8", "link";
 		port-id = <1>;
 		gop-port-id = <2>;
 	};
@@ -113,9 +125,14 @@ cpm_ethernet: ethernet@0 {
 			     <ICU_GRP_NSR 45 IRQ_TYPE_LEVEL_HIGH>,
 			     <ICU_GRP_NSR 49 IRQ_TYPE_LEVEL_HIGH>,
 			     <ICU_GRP_NSR 53 IRQ_TYPE_LEVEL_HIGH>,
-			     <ICU_GRP_NSR 57 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
-				  "tx-cpu3", "rx-shared";
+			     <ICU_GRP_NSR 57 IRQ_TYPE_LEVEL_HIGH>,
+			     <ICU_GRP_NSR 61 IRQ_TYPE_LEVEL_HIGH>,
+			     <ICU_GRP_NSR 65 IRQ_TYPE_LEVEL_HIGH>,
+			     <ICU_GRP_NSR 69 IRQ_TYPE_LEVEL_HIGH>,
+			     <ICU_GRP_NSR 73 IRQ_TYPE_LEVEL_HIGH>,
+			     <ICU_GRP_NSR 127 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "hif0", "hif1", "hif2", "hif3", "hif4",
+				  "hif5", "hif6", "hif7", "hif8", "link";
 		port-id = <2>;
 		gop-port-id = <3>;
 	};
-- 
2.17.1

