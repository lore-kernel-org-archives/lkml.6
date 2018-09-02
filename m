Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA65AC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976952064D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976952064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeIBLmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 07:42:54 -0400
Received: from mailoutvs50.siol.net ([185.57.226.241]:55164 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727415AbeIBLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 07:42:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 869B3520D4E;
        Sun,  2 Sep 2018 09:28:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Z7Vr9gV7FnCp; Sun,  2 Sep 2018 09:28:03 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 071D4520D5E;
        Sun,  2 Sep 2018 09:28:03 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 72397520D4E;
        Sun,  2 Sep 2018 09:28:00 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, maxime.ripard@bootlin.com, wens@csie.org
Cc:     mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 24/27] dt-bindings: display: sun4i-drm: document H6 TCON TOP
Date:   Sun,  2 Sep 2018 09:26:40 +0200
Message-Id: <20180902072643.4917-25-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Allwinner H6 SoC has a cut down version of TCON TOP.

Add binding documentation for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
[expanded description]
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../bindings/display/sunxi/sun4i-drm.txt           | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 278410e43940..a14eb9313e70 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -221,24 +221,26 @@ It allows display pipeline to be configured in very different ways:
                  \ [3] TCON-TV1 [1] - TVE1/RGB
 
 Note that both TCON TOP references same physical unit. Both mixers can be
-connected to any TCON.
+connected to any TCON. Not all TCON TOP variants support all features.
 
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun8i-r40-tcon-top
+    * allwinner,sun50i-h6-tcon-top
   - reg: base address and size of the memory-mapped region.
   - clocks: phandle to the clocks feeding the TCON TOP
     * bus: TCON TOP interface clock
     * tcon-tv0: TCON TV0 clock
-    * tve0: TVE0 clock
-    * tcon-tv1: TCON TV1 clock
-    * tve1: TVE0 clock
-    * dsi: MIPI DSI clock
+    * tve0: TVE0 clock (R40 only)
+    * tcon-tv1: TCON TV1 clock (R40 only)
+    * tve1: TVE0 clock (R40 only)
+    * dsi: MIPI DSI clock (R40 only)
   - clock-names: clock name mentioned above
   - resets: phandle to the reset line driving the TCON TOP
   - #clock-cells : must contain 1
   - clock-output-names: Names of clocks created for TCON TV0 channel clock,
-    TCON TV1 channel clock and DSI channel clock, in that order.
+    TCON TV1 channel clock (R40 only) and DSI channel clock (R40 only), in
+    that order.
 
 - ports: A ports node with endpoint definitions as defined in
     Documentation/devicetree/bindings/media/video-interfaces.txt. 6 ports should
-- 
2.18.0

