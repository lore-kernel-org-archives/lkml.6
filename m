Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED0EECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BC82081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BC82081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbeKEDoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:44:17 -0500
Received: from mailoutvs60.siol.net ([185.57.226.251]:47561 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731652AbeKEDoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:44:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id A7AD4521282;
        Sun,  4 Nov 2018 19:28:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Q3F9uqaoaQ2W; Sun,  4 Nov 2018 19:28:21 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 18E75521293;
        Sun,  4 Nov 2018 19:28:21 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 976DC521282;
        Sun,  4 Nov 2018 19:28:18 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, jernej.skrabec@siol.net,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v3 18/28] dt-bindings: display: sunxi: add DT binding for Allwinner H6 DW HDMI
Date:   Sun,  4 Nov 2018 19:26:55 +0100
Message-Id: <20181104182705.18047-19-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
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
2.19.1

