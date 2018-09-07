Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF030C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931AD2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931AD2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeIGMCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:02:36 -0400
Received: from hermes.aosc.io ([199.195.250.187]:44255 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbeIGMCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:02:36 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id B5CA85768C;
        Fri,  7 Sep 2018 07:22:57 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/5] dt-bindings: sun4i-drm: drop second PLL from A64 HDMI PHY binding
Date:   Fri,  7 Sep 2018 15:22:30 +0800
Message-Id: <20180907072234.48282-2-icenowy@aosc.io>
In-Reply-To: <20180907072234.48282-1-icenowy@aosc.io>
References: <20180907072234.48282-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By experiments it seems that the A64 HDMI PHY is not able to use the
second video PLL as the clock parent.

Drop pll-1 from the device tree binding of A64 HDMI PHY.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index f8773ecb7525..62034039cee1 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -114,7 +114,6 @@ Required properties:
 
 H3 and A64 HDMI PHY require additional clocks:
   - pll-0: parent of phy clock
-  - pll-1: second possible phy clock parent (A64 only)
 
 TV Encoder
 ----------
-- 
2.18.0

