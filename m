Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E7FC282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EEA2085A
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfAYDYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 22:24:17 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:59284 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfAYDXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 22:23:18 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 333CE5FCE9; Fri, 25 Jan 2019 11:23:15 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] dt-bindings: display: sun4i-drm: Add compatible strings for A23 display
Date:   Fri, 25 Jan 2019 11:23:05 +0800
Message-Id: <20190125032314.20915-3-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125032314.20915-1-wens@csie.org>
References: <20190125032314.20915-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A23's display pipeline is similar to the A33. Differences include:

  - Display backend supports larger layers, 8192x8192 instead of 2048x2048

  - TCON has DMA input

  - There is no SAT module packed in the display backend

Add compatible strings for the display pipeline and its components.

As the MIPI DSI output device is not officially documented, and there
are no A23 reference devices to test it, it is not covered by this
patch.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index f426bdb42f18..31ab72cba3d4 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -156,6 +156,7 @@ Required properties:
    * allwinner,sun6i-a31-tcon
    * allwinner,sun6i-a31s-tcon
    * allwinner,sun7i-a20-tcon
+   * allwinner,sun8i-a23-tcon
    * allwinner,sun8i-a33-tcon
    * allwinner,sun8i-a83t-tcon-lcd
    * allwinner,sun8i-a83t-tcon-tv
@@ -276,6 +277,7 @@ Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-drc
     * allwinner,sun6i-a31s-drc
+    * allwinner,sun8i-a23-drc
     * allwinner,sun8i-a33-drc
     * allwinner,sun9i-a80-drc
   - reg: base address and size of the memory-mapped region.
@@ -303,6 +305,7 @@ Required properties:
     * allwinner,sun5i-a13-display-backend
     * allwinner,sun6i-a31-display-backend
     * allwinner,sun7i-a20-display-backend
+    * allwinner,sun8i-a23-display-backend
     * allwinner,sun8i-a33-display-backend
     * allwinner,sun9i-a80-display-backend
   - reg: base address and size of the memory-mapped region.
@@ -360,6 +363,7 @@ Required properties:
     * allwinner,sun5i-a13-display-frontend
     * allwinner,sun6i-a31-display-frontend
     * allwinner,sun7i-a20-display-frontend
+    * allwinner,sun8i-a23-display-frontend
     * allwinner,sun8i-a33-display-frontend
     * allwinner,sun9i-a80-display-frontend
   - reg: base address and size of the memory-mapped region.
@@ -419,6 +423,7 @@ Required properties:
     * allwinner,sun6i-a31-display-engine
     * allwinner,sun6i-a31s-display-engine
     * allwinner,sun7i-a20-display-engine
+    * allwinner,sun8i-a23-display-engine
     * allwinner,sun8i-a33-display-engine
     * allwinner,sun8i-a83t-display-engine
     * allwinner,sun8i-h3-display-engine
-- 
2.20.1

