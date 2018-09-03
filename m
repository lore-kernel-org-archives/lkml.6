Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AB3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9982075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9982075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeICR4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:56:03 -0400
Received: from hermes.aosc.io ([199.195.250.187]:52380 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbeICR4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:56:03 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 78647FF89E;
        Mon,  3 Sep 2018 13:35:41 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 3/3] ARM: sun8i: dts: r40: drop A64 fallback compatible string of HDMI PHY
Date:   Mon,  3 Sep 2018 21:34:34 +0800
Message-Id: <20180903133434.58188-4-icenowy@aosc.io>
In-Reply-To: <20180903133434.58188-1-icenowy@aosc.io>
References: <20180903133434.58188-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A64 HDMI PHY is proven to have no PLL-VIDEO mux, thus it's not
compatible with the R40 one.

Drop the A64 fallback compatible string in R40 device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index ffd9f00f74a4..5f547c161baf 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -800,8 +800,7 @@
 		};
 
 		hdmi_phy: hdmi-phy@1ef0000 {
-			compatible = "allwinner,sun8i-r40-hdmi-phy",
-				     "allwinner,sun50i-a64-hdmi-phy";
+			compatible = "allwinner,sun8i-r40-hdmi-phy";
 			reg = <0x01ef0000 0x10000>;
 			clocks = <&ccu CLK_BUS_HDMI1>, <&ccu CLK_HDMI_SLOW>,
 				 <&ccu 7>, <&ccu 16>;
-- 
2.18.0

