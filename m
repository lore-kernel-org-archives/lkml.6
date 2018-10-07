Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA1EC677F5
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2242084D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2242084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeJGQqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 12:46:50 -0400
Received: from mailoutvs48.siol.net ([185.57.226.239]:39987 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728371AbeJGQqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 12:46:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id A1727520CD3;
        Sun,  7 Oct 2018 11:40:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1S0c-LsjQMKU; Sun,  7 Oct 2018 11:40:05 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 3908F520CBF;
        Sun,  7 Oct 2018 11:40:05 +0200 (CEST)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id B933F520CD3;
        Sun,  7 Oct 2018 11:40:02 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, airlied@linux.ie,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 19/29] dt-bindings: display: sunxi: add DT binding for Allwinner H6 DW HDMI
Date:   Sun,  7 Oct 2018 11:38:55 +0200
Message-Id: <20181007093905.11253-20-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007093905.11253-1-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

The Allwinner H6 SoC uses a v2.12a DesignWare HDMI controller, with
dedicated CEC and HDCP clocks added; the PHY connected is a standard
DesignWare HDMI PHY.

Add binding for it.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
[added HDCP clock and reset]
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../devicetree/bindings/display/sunxi/sun4i-drm.txt   | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.tx=
t b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 62c83b351344..478b288eebd9 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -79,6 +79,7 @@ Required properties:
   - compatible: value must be one of:
     * "allwinner,sun8i-a83t-dw-hdmi"
     * "allwinner,sun50i-a64-dw-hdmi", "allwinner,sun8i-a83t-dw-hdmi"
+    * "allwinner,sun50i-h6-dw-hdmi"
   - reg: base address and size of memory-mapped region
   - reg-io-width: See dw_hdmi.txt. Shall be 1.
   - interrupts: HDMI interrupt number
@@ -86,9 +87,14 @@ Required properties:
     * iahb: the HDMI bus clock
     * isfr: the HDMI register clock
     * tmds: TMDS clock
+    * cec: HDMI CEC clock (H6 only)
+    * hdcp: HDCP clock (H6 only)
+    * hdcp-bus: HDCP bus clock (H6 only)
   - clock-names: the clock names mentioned above
-  - resets: phandle to the reset controller
-  - reset-names: must be "ctrl"
+  - resets:
+    * ctrl: HDMI controller reset
+    * hdcp: HDCP reset (H6 only)
+  - reset-names: reset names mentioned above
   - phys: phandle to the DWC HDMI PHY
   - phy-names: must be "phy"
=20
@@ -109,6 +115,7 @@ Required properties:
     * allwinner,sun8i-h3-hdmi-phy
     * allwinner,sun8i-r40-hdmi-phy
     * allwinner,sun50i-a64-hdmi-phy
+    * allwinner,sun50i-h6-hdmi-phy
   - reg: base address and size of memory-mapped region
   - clocks: phandles to the clocks feeding the HDMI PHY
     * bus: the HDMI PHY interface clock
--=20
2.19.0

