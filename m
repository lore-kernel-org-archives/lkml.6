Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6D0C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AB320869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AB320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeIDJFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:05:13 -0400
Received: from hermes.aosc.io ([199.195.250.187]:44946 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbeIDJFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:05:13 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 2A23D5A0D3;
        Tue,  4 Sep 2018 04:41:47 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 03/11] dt-bindings: display: Add compatible for A64 DE2 display pipeline
Date:   Tue,  4 Sep 2018 12:40:45 +0800
Message-Id: <20180904044053.15425-4-icenowy@aosc.io>
In-Reply-To: <20180904044053.15425-1-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagan Teki <jagan@amarulasolutions.com>

Allwinner A64 has a DE2 display pipeline. The TCONs are similar to the
ones in A83T, but the mixers are new (similar to the later R40 SoC).

This patch adds dt-binding documentation for A64 DE2 display pipeline.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
[Icenowy: Refactor and also cover TCON1]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes for v4:
- none
Changes for v3.1:
- added mixer0 and TCON0
Changes for v3:
- collect Rob r-w-b tag
Changes for v2:
- Add fallback compatible for tcon1
- Add separate compatible for mixer1 

 .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index f8773ecb7525..7b79c5e3dffc 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -151,6 +151,8 @@ Required properties:
    * allwinner,sun8i-v3s-tcon
    * allwinner,sun9i-a80-tcon-lcd
    * allwinner,sun9i-a80-tcon-tv
+   * "allwinner,sun50i-a64-tcon-lcd", "allwinner,sun8i-a83t-tcon-lcd"
+   * "allwinner,sun50i-a64-tcon-tv", "allwinner,sun8i-a83t-tcon-tv"
  - reg: base address and size of memory-mapped region
  - interrupts: interrupt associated to this IP
  - clocks: phandles to the clocks feeding the TCON.
@@ -370,6 +372,8 @@ Required properties:
     * allwinner,sun8i-a83t-de2-mixer-1
     * allwinner,sun8i-h3-de2-mixer-0
     * allwinner,sun8i-v3s-de2-mixer
+    * allwinner,sun50i-a64-de2-mixer-0
+    * allwinner,sun50i-a64-de2-mixer-1
   - reg: base address and size of the memory-mapped region.
   - clocks: phandles to the clocks feeding the mixer
     * bus: the mixer interface clock
@@ -403,6 +407,7 @@ Required properties:
     * allwinner,sun8i-r40-display-engine
     * allwinner,sun8i-v3s-display-engine
     * allwinner,sun9i-a80-display-engine
+    * allwinner,sun50i-a64-display-engine
 
   - allwinner,pipelines: list of phandle to the display engine
     frontends (DE 1.0) or mixers (DE 2.0) available.
-- 
2.18.0

