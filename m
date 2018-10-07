Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159D0C67869
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB12B2084D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB12B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeJGQqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 12:46:20 -0400
Received: from mailoutvs20.siol.net ([185.57.226.211]:39699 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727752AbeJGQqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 12:46:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 21D2D520C12;
        Sun,  7 Oct 2018 11:39:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gY_BKQovFXRF; Sun,  7 Oct 2018 11:39:34 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id B085B520C2E;
        Sun,  7 Oct 2018 11:39:34 +0200 (CEST)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 49947520C12;
        Sun,  7 Oct 2018 11:39:32 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, airlied@linux.ie,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 07/29] dt-bindings: display: sun4i-drm: Add H6 display engine compatibles
Date:   Sun,  7 Oct 2018 11:38:43 +0200
Message-Id: <20181007093905.11253-8-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007093905.11253-1-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds compatibles used in H6 display pipeline, namely for
display engine, mixer and TV TCON.

H6 display engine is somewhat similar to R40, just less TCONs and
mixer support more features.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.tx=
t b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 7854fff4fc16..62c83b351344 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -158,6 +158,7 @@ Required properties:
    * allwinner,sun9i-a80-tcon-tv
    * "allwinner,sun50i-a64-tcon-lcd", "allwinner,sun8i-a83t-tcon-lcd"
    * "allwinner,sun50i-a64-tcon-tv", "allwinner,sun8i-a83t-tcon-tv"
+   * allwinner,sun50i-h6-tcon-tv, allwinner,sun8i-r40-tcon-tv
  - reg: base address and size of memory-mapped region
  - interrupts: interrupt associated to this IP
  - clocks: phandles to the clocks feeding the TCON.
@@ -381,6 +382,7 @@ Required properties:
     * allwinner,sun8i-v3s-de2-mixer
     * allwinner,sun50i-a64-de2-mixer-0
     * allwinner,sun50i-a64-de2-mixer-1
+    * allwinner,sun50i-h6-de3-mixer-0
   - reg: base address and size of the memory-mapped region.
   - clocks: phandles to the clocks feeding the mixer
     * bus: the mixer interface clock
@@ -415,9 +417,10 @@ Required properties:
     * allwinner,sun8i-v3s-display-engine
     * allwinner,sun9i-a80-display-engine
     * allwinner,sun50i-a64-display-engine
+    * allwinner,sun50i-h6-display-engine
=20
   - allwinner,pipelines: list of phandle to the display engine
-    frontends (DE 1.0) or mixers (DE 2.0) available.
+    frontends (DE 1.0) or mixers (DE 2.0/3.0) available.
=20
 Example:
=20
--=20
2.19.0

