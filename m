Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0C8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499B421871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeLRVfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:35:08 -0500
Received: from palmtree.beeroclock.net ([178.79.160.154]:55368 "EHLO
        palmtree.beeroclock.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeLRVfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:35:07 -0500
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Dec 2018 16:35:06 EST
Received: from beros.lan (89-160-129-47.du.xdsl.is [89.160.129.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: karlp)
        by palmtree.beeroclock.net (Postfix) with ESMTPSA id 41B4910279;
        Tue, 18 Dec 2018 21:25:36 +0000 (UTC)
From:   Karl Palsson <karlp@tweak.net.au>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Karl Palsson <karlp@tweak.net.au>
Subject: [PATCH 1/3] ARM: dts: sunxi: h3/h5: add missing uart2 rts/cts pins
Date:   Tue, 18 Dec 2018 21:24:55 +0000
Message-Id: <20181218212457.30382-1-karlp@tweak.net.au>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uart1 and uart3 had existing pin definitions for the rts/cts pairs.
Add definitions for uart2 as well.

Signed-off-by: Karl Palsson <karlp@tweak.net.au>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index a4c757c0b741..38d3deefa0e3 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -472,6 +472,11 @@
 				function = "uart2";
 			};
 
+			uart2_rts_cts_pins: uart2_rts_cts {
+				pins = "PA2", "PA3";
+				function = "uart2";
+			};
+
 			uart3_pins: uart3 {
 				pins = "PA13", "PA14";
 				function = "uart3";
-- 
2.14.5

