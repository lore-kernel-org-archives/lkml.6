Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D2AC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 16:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09F22146E
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 16:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfA0Qjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 11:39:35 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:60168 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfA0Qje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 11:39:34 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 705275FD14; Mon, 28 Jan 2019 00:39:32 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: allwinner: h6: Move GIC device node fix base address ordering
Date:   Mon, 28 Jan 2019 00:39:30 +0800
Message-Id: <20190127163930.985-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GIC device node was placed out of order in the initial device tree
submission. Move it so the nodes are correctly sorted by base address
again.

Fixes: e54be32d0273 ("arm64: allwinner: h6: add the basical Allwinner H6 DTSI file")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index d93a7add67e7..60bf6d915809 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -178,17 +178,6 @@
 			#reset-cells = <1>;
 		};
 
-		gic: interrupt-controller@3021000 {
-			compatible = "arm,gic-400";
-			reg = <0x03021000 0x1000>,
-			      <0x03022000 0x2000>,
-			      <0x03024000 0x2000>,
-			      <0x03026000 0x2000>;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-			interrupt-controller;
-			#interrupt-cells = <3>;
-		};
-
 		pio: pinctrl@300b000 {
 			compatible = "allwinner,sun50i-h6-pinctrl";
 			reg = <0x0300b000 0x400>;
@@ -239,6 +228,17 @@
 			};
 		};
 
+		gic: interrupt-controller@3021000 {
+			compatible = "arm,gic-400";
+			reg = <0x03021000 0x1000>,
+			      <0x03022000 0x2000>,
+			      <0x03024000 0x2000>,
+			      <0x03026000 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
 		mmc0: mmc@4020000 {
 			compatible = "allwinner,sun50i-h6-mmc",
 				     "allwinner,sun50i-a64-mmc";
-- 
2.20.1

