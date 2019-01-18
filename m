Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D582C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C522087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfARPAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:00:38 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49786 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfARPAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:00:38 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DCECE20A2E; Fri, 18 Jan 2019 16:00:35 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id C07AF20CD0;
        Fri, 18 Jan 2019 15:57:44 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 1/2] ARM: dts: sun4i: Add support for the C1 SRAM region with the SRAM controller
Date:   Fri, 18 Jan 2019 15:57:29 +0100
Message-Id: <20190118145730.22227-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the C1 SRAM region (to be used with the SRAM
controller driver) for the A10 platform. The region is shared
between the Video Engine and the CPU.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index a2fb473cbb9d..c3a74024ca0f 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -229,6 +229,19 @@
 					status = "disabled";
 				};
 			};
+
+			sram_c: sram@1d00000 {
+				compatible = "mmio-sram";
+				reg = <0x01d00000 0xd0000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x01d00000 0xd0000>;
+
+				ve_sram: sram-section@0 {
+					compatible = "allwinner,sun4i-a10-sram-c1";
+					reg = <0x000000 0x80000>;
+				};
+			};
 		};
 
 		dma: dma-controller@1c02000 {
-- 
2.20.1

