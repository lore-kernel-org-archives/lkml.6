Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600CCC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AF6267A5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AF6267A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753253AbeF0H1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:27:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58627 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751298AbeF0H1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:27:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E7CD42075D; Wed, 27 Jun 2018 09:27:16 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8F166206D8;
        Wed, 27 Jun 2018 09:27:06 +0200 (CEST)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Qiang Yu <yuq825@gmail.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] ARM: dts: sun8i-h3: Increase the GPU clock to 576 MHz
Date:   Wed, 27 Jun 2018 09:26:35 +0200
Message-Id: <20180627072635.3592-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported (based on declarations from the Allwiner BSP) that the
Mali 400 found on the H3 can be clocked up to 576 MHz.

The frequency was tested using the r6p2 out-of-tree driver and a Kodi
userspace with associated r6p2 blobs, leading to a working result.

This increases the clock to 576 MHz, which directly increases the pixel
throughput of the GPU (given the 1 pixel-per-cycle rate).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 41d57c76f290..a14a63092dc6 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -133,7 +133,7 @@
 			resets = <&ccu RST_BUS_GPU>;
 
 			assigned-clocks = <&ccu CLK_GPU>;
-			assigned-clock-rates = <384000000>;
+			assigned-clock-rates = <576000000>;
 		};
 	};
 };
-- 
2.17.1

