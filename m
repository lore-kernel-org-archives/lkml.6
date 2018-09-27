Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3C7ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CDC21537
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CDC21537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeI0LVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:21:17 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:57684 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbeI0LVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:21:16 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g5OTA-0002BL-Bb from Jiada_Wang@mentor.com ; Wed, 26 Sep 2018 22:04:08 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 26 Sep 2018 22:04:04 -0700
From:   <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <jiada_wang@mentor.com>, <twischer@de.adit-jv.com>,
        <dragos_tarcatu@mentor.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH linux-next 02/10] arm64: r8a7795: add dma request number for busif1 ~ busif7
Date:   Thu, 27 Sep 2018 14:03:59 +0900
Message-ID: <20180927050407.17765-3-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180927050407.17765-1-jiada_wang@mentor.com>
References: <20180927050407.17765-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

This patch adds dma request number for busif1 ~ busif7

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 130 ++++++++++++++++++++---
 1 file changed, 113 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index b5f2273caca4..0a66bda7124f 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1923,53 +1923,149 @@
 			rcar_sound,ssi {
 				ssi0: ssi-0 {
 					interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dmas = <&audma0 0x01>, <&audma1 0x02>,
+					       <&audma0 0x15>, <&audma1 0x16>,
+					       <&audma0 0x35>, <&audma1 0x36>,
+					       <&audma0 0x37>, <&audma1 0x38>,
+					       <&audma0 0x47>, <&audma1 0x48>,
+					       <&audma0 0x3f>, <&audma1 0x40>,
+					       <&audma0 0x43>, <&audma1 0x44>,
+					       <&audma0 0x4f>, <&audma1 0x50>,
+					       <&audma0 0x53>, <&audma1 0x54>;
+					dma-names = "rx", "tx",
+						    "rxu0", "txu0",
+						    "rxu1", "txu1",
+						    "rxu2", "txu2",
+						    "rxu3", "txu3",
+						    "rxu4", "txu4",
+						    "rxu5", "txu5",
+						    "rxu6", "txu6",
+						    "rxu7", "txu7";
 				};
 				ssi1: ssi-1 {
-					 interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x03>, <&audma1 0x04>, <&audma0 0x49>, <&audma1 0x4a>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x03>, <&audma1 0x04>,
+					       <&audma0 0x49>, <&audma1 0x4a>,
+					       <&audma0 0x4b>, <&audma1 0x4c>,
+					       <&audma0 0x57>, <&audma1 0x58>,
+					       <&audma0 0x59>, <&audma1 0x5a>,
+					       <&audma0 0x5f>, <&audma1 0x60>,
+					       <&audma0 0xc3>, <&audma1 0xc4>,
+					       <&audma0 0xc7>, <&audma1 0xc8>,
+					       <&audma0 0xcb>, <&audma1 0xcc>;
+					dma-names = "rx", "tx",
+						    "rxu0", "txu0",
+						    "rxu1", "txu1",
+						    "rxu2", "txu2",
+						    "rxu3", "txu3",
+						    "rxu4", "txu4",
+						    "rxu5", "txu5",
+						    "rxu6", "txu6",
+						    "rxu7", "txu7";
 				};
 				ssi2: ssi-2 {
 					interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x05>, <&audma1 0x06>, <&audma0 0x63>, <&audma1 0x64>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dmas = <&audma0 0x05>, <&audma1 0x06>,
+					       <&audma0 0x63>, <&audma1 0x64>,
+					       <&audma0 0x67>, <&audma1 0x68>,
+					       <&audma0 0x6b>, <&audma1 0x6c>,
+					       <&audma0 0x6d>, <&audma1 0x6e>,
+					       <&audma0 0xcf>, <&audma1 0xce>,
+					       <&audma0 0xeb>, <&audma1 0xec>,
+					       <&audma0 0xed>, <&audma1 0xee>,
+					       <&audma0 0xef>, <&audma1 0xf0>;
+					dma-names = "rx", "tx",
+						    "rxu0", "txu0",
+						    "rxu1", "txu1",
+						    "rxu2", "txu2",
+						    "rxu3", "txu3",
+						    "rxu4", "txu4",
+						    "rxu5", "txu5",
+						    "rxu6", "txu6",
+						    "rxu7", "txu7";
 				};
 				ssi3: ssi-3 {
 					interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x07>, <&audma1 0x08>, <&audma0 0x6f>, <&audma1 0x70>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dmas = <&audma0 0x07>, <&audma1 0x08>,
+					       <&audma0 0x6f>, <&audma1 0x70>,
+					       <&audma0 0x21>, <&audma1 0x22>,
+					       <&audma0 0x23>, <&audma1 0x24>,
+					       <&audma0 0x25>, <&audma1 0x26>,
+					       <&audma0 0x27>, <&audma1 0x28>,
+					       <&audma0 0x29>, <&audma1 0x2a>,
+					       <&audma0 0x2b>, <&audma1 0x2c>,
+					       <&audma0 0x2d>, <&audma1 0x2e>;
+					dma-names = "rx", "tx",
+						    "rxu0", "txu0",
+						    "rxu1", "txu1",
+						    "rxu2", "txu2",
+						    "rxu3", "txu3",
+						    "rxu4", "txu4",
+						    "rxu5", "txu5",
+						    "rxu6", "txu6",
+						    "rxu7", "txu7";
 				};
 				ssi4: ssi-4 {
 					interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x09>, <&audma1 0x0a>, <&audma0 0x71>, <&audma1 0x72>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dmas = <&audma0 0x09>, <&audma1 0x0a>,
+					       <&audma0 0x71>, <&audma1 0x72>,
+					       <&audma0 0x17>, <&audma1 0x18>,
+					       <&audma0 0x19>, <&audma1 0x1a>,
+					       <&audma0 0x1b>, <&audma1 0x1c>,
+					       <&audma0 0x1d>, <&audma1 0x1e>,
+					       <&audma0 0x1f>, <&audma1 0x20>,
+					       <&audma0 0x31>, <&audma1 0x32>,
+					       <&audma0 0x33>, <&audma1 0x34>;
+					dma-names = "rx", "tx",
+						    "rxu0", "txu0",
+						    "rxu1", "txu1",
+						    "rxu2", "txu2",
+						    "rxu3", "txu3",
+						    "rxu4", "txu4",
+						    "rxu5", "txu5",
+						    "rxu6", "txu6",
+						    "rxu7", "txu7";
 				};
 				ssi5: ssi-5 {
 					interrupts = <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x0b>, <&audma1 0x0c>, <&audma0 0x73>, <&audma1 0x74>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dma-names = "rx", "tx", "rxu0", "txu0";
 				};
 				ssi6: ssi-6 {
 					interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x0d>, <&audma1 0x0e>, <&audma0 0x75>, <&audma1 0x76>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dma-names = "rx", "tx", "rxu0", "txu0";
 				};
 				ssi7: ssi-7 {
 					interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x0f>, <&audma1 0x10>, <&audma0 0x79>, <&audma1 0x7a>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dma-names = "rx", "tx", "rxu0", "txu0";
 				};
 				ssi8: ssi-8 {
 					interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x11>, <&audma1 0x12>, <&audma0 0x7b>, <&audma1 0x7c>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dma-names = "rx", "tx", "rxu0", "txu0";
 				};
 				ssi9: ssi-9 {
 					interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x13>, <&audma1 0x14>, <&audma0 0x7d>, <&audma1 0x7e>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dmas = <&audma0 0x13>, <&audma1 0x14>,
+					       <&audma0 0x7d>, <&audma1 0x7e>,
+					       <&audma0 0x7f>, <&audma1 0x80>,
+					       <&audma0 0x81>, <&audma1 0x82>,
+					       <&audma0 0x83>, <&audma1 0x84>,
+					       <&audma0 0xa3>, <&audma1 0xa4>,
+					       <&audma0 0xa5>, <&audma1 0xa6>,
+					       <&audma0 0xa7>, <&audma1 0xa8>,
+					       <&audma0 0xa9>, <&audma1 0xaa>;
+					dma-names = "rx", "tx",
+						    "rxu0", "txu0",
+						    "rxu1", "txu1",
+						    "rxu2", "txu2",
+						    "rxu3", "txu3",
+						    "rxu4", "txu4",
+						    "rxu5", "txu5",
+						    "rxu6", "txu6",
+						    "rxu7", "txu7";
 				};
 			};
 
-- 
2.17.0

