Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4330DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04ECA2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04ECA2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934696AbeFLUFL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:05:11 -0400
Received: from mailoutvs51.siol.net ([185.57.226.242]:38668 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934332AbeFLUCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:02:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 7B53352235D;
        Tue, 12 Jun 2018 22:02:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id V3AtCcYz8ill; Tue, 12 Jun 2018 22:02:34 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 07CC8522020;
        Tue, 12 Jun 2018 22:02:34 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 7CB2C52235D;
        Tue, 12 Jun 2018 22:02:31 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 18/27] dt-bindings: display: sun4i-drm: Add description of A64 HDMI PHY
Date:   Tue, 12 Jun 2018 22:00:27 +0200
Message-Id: <20180612200036.21483-19-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A64 HDMI PHY is similar to H3 HDMI PHY except it has two possible PLL
clock parents. It is compatible to other HDMI PHYs, like that found in
R40.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index d84df6d808c2..6fb45c7a9ac8 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -101,6 +101,7 @@ DWC HDMI PHY
 
 Required properties:
   - compatible: value must be one of:
+    * allwinner,sun50i-a64-hdmi-phy
     * allwinner,sun8i-a83t-hdmi-phy
     * allwinner,sun8i-h3-hdmi-phy
   - reg: base address and size of memory-mapped region
@@ -111,8 +112,9 @@ Required properties:
   - resets: phandle to the reset controller driving the PHY
   - reset-names: must be "phy"
 
-H3 HDMI PHY requires additional clock:
+H3 and A64 HDMI PHY require additional clocks:
   - pll-0: parent of phy clock
+  - pll-1: second possible phy clock parent (A64 only)
 
 TV Encoder
 ----------
-- 
2.17.1

