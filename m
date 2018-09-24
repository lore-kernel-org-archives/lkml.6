Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14849ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A0A208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A0A208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeIXPGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:06:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55532 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbeIXPGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:06:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BB06E208A1; Mon, 24 Sep 2018 11:05:00 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8E48B207CA;
        Mon, 24 Sep 2018 11:05:00 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     gregory.clement@bootlin.com, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, jason@lakedaemon.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com
Subject: [PATCH 1/2] arm64: dts: marvell: armada-cp110: change the PPv2 IRQ names
Date:   Mon, 24 Sep 2018 11:00:01 +0200
Message-Id: <20180924090002.27939-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the PPv2 IRQ names in the CP110 device tree to match
a corresponding change in the Marvell PPv2 driver. The reason this was
updated is the IRQ where names after Tx/Rx interrupts, but this is not
true and can be configured. A following patch will add more of them and
the names wouldn't make sense.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 840c8454d03e..6a13690cf1e4 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -53,8 +53,8 @@
 					<ICU_GRP_NSR 51 IRQ_TYPE_LEVEL_HIGH>,
 					<ICU_GRP_NSR 55 IRQ_TYPE_LEVEL_HIGH>,
 					<ICU_GRP_NSR 129 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
-					"tx-cpu3", "rx-shared", "link";
+				interrupt-names = "hif0", "hif1", "hif2",
+					"hif3", "hif4", "link";
 				port-id = <0>;
 				gop-port-id = <0>;
 				status = "disabled";
@@ -67,8 +67,8 @@
 					<ICU_GRP_NSR 52 IRQ_TYPE_LEVEL_HIGH>,
 					<ICU_GRP_NSR 56 IRQ_TYPE_LEVEL_HIGH>,
 					<ICU_GRP_NSR 128 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
-					"tx-cpu3", "rx-shared", "link";
+				interrupt-names = "hif0", "hif1", "hif2",
+					"hif3", "hif4", "link";
 				port-id = <1>;
 				gop-port-id = <2>;
 				status = "disabled";
@@ -81,8 +81,8 @@
 					<ICU_GRP_NSR 53 IRQ_TYPE_LEVEL_HIGH>,
 					<ICU_GRP_NSR 57 IRQ_TYPE_LEVEL_HIGH>,
 					<ICU_GRP_NSR 127 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
-					"tx-cpu3", "rx-shared", "link";
+				interrupt-names = "hif0", "hif1", "hif2",
+					"hif3", "hif4", "link";
 				port-id = <2>;
 				gop-port-id = <3>;
 				status = "disabled";
-- 
2.17.1

