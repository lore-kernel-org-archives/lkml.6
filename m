Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C132BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866F22075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866F22075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeIGMDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:03:05 -0400
Received: from hermes.aosc.io ([199.195.250.187]:44315 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeIGMDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:03:04 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 3D6A111C370;
        Fri,  7 Sep 2018 07:23:25 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 4/5] drm/sun4i: add support for R40 HDMI PHY
Date:   Fri,  7 Sep 2018 15:22:33 +0800
Message-Id: <20180907072234.48282-5-icenowy@aosc.io>
In-Reply-To: <20180907072234.48282-1-icenowy@aosc.io>
References: <20180907072234.48282-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R40 SoC has a HDMI PHY that is possible to mux two video PLLs.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index a564b5dfe082..471993097ced 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -416,6 +416,14 @@ static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy = {
 	.phy_config = &sun8i_hdmi_phy_config_h3,
 };
 
+static const struct sun8i_hdmi_phy_variant sun8i_r40_hdmi_phy = {
+	.has_phy_clk = true,
+	.has_second_pll = true,
+	.phy_init = &sun8i_hdmi_phy_init_h3,
+	.phy_disable = &sun8i_hdmi_phy_disable_h3,
+	.phy_config = &sun8i_hdmi_phy_config_h3,
+};
+
 static const struct of_device_id sun8i_hdmi_phy_of_table[] = {
 	{
 		.compatible = "allwinner,sun50i-a64-hdmi-phy",
@@ -429,6 +437,10 @@ static const struct of_device_id sun8i_hdmi_phy_of_table[] = {
 		.compatible = "allwinner,sun8i-h3-hdmi-phy",
 		.data = &sun8i_h3_hdmi_phy,
 	},
+	{
+		.compatible = "allwinner,sun8i-r40-hdmi-phy",
+		.data = &sun8i_r40_hdmi_phy,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.18.0

