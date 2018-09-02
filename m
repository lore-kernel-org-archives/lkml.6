Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DE8C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C93B2064D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C93B2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeIBLmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 07:42:12 -0400
Received: from mailoutvs13.siol.net ([185.57.226.204]:54696 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725905AbeIBLmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 07:42:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 20DCB520BAC;
        Sun,  2 Sep 2018 09:27:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id i5wQQOxRJ-Qj; Sun,  2 Sep 2018 09:27:21 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 91388520B9C;
        Sun,  2 Sep 2018 09:27:21 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 0AB52520B98;
        Sun,  2 Sep 2018 09:27:19 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, maxime.ripard@bootlin.com, wens@csie.org
Cc:     mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 09/27] dt-bindings: display: sun4i-drm: Add H6 display engine compatibles
Date:   Sun,  2 Sep 2018 09:26:25 +0200
Message-Id: <20180902072643.4917-10-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds compatibles used in H6 display pipeline, namely for
display engine, mixer and TV TCON.

H6 display engine is somewhat similar to R40, just less TCONs and
mixer support more features.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index f8773ecb7525..dec2f8a6da9c 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -151,6 +151,7 @@ Required properties:
    * allwinner,sun8i-v3s-tcon
    * allwinner,sun9i-a80-tcon-lcd
    * allwinner,sun9i-a80-tcon-tv
+   * allwinner,sun50i-h6-tcon-tv, allwinner,sun8i-r40-tcon-tv
  - reg: base address and size of memory-mapped region
  - interrupts: interrupt associated to this IP
  - clocks: phandles to the clocks feeding the TCON.
@@ -370,6 +371,7 @@ Required properties:
     * allwinner,sun8i-a83t-de2-mixer-1
     * allwinner,sun8i-h3-de2-mixer-0
     * allwinner,sun8i-v3s-de2-mixer
+    * allwinner,sun50i-h6-de3-mixer-0
   - reg: base address and size of the memory-mapped region.
   - clocks: phandles to the clocks feeding the mixer
     * bus: the mixer interface clock
@@ -403,9 +405,10 @@ Required properties:
     * allwinner,sun8i-r40-display-engine
     * allwinner,sun8i-v3s-display-engine
     * allwinner,sun9i-a80-display-engine
+    * allwinner,sun50i-h6-display-engine
 
   - allwinner,pipelines: list of phandle to the display engine
-    frontends (DE 1.0) or mixers (DE 2.0) available.
+    frontends (DE 1.0) or mixers (DE 2.0/3.0) available.
 
 Example:
 
-- 
2.18.0

