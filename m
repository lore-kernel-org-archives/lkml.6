Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53015C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0644720652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0644720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeICRzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:55:49 -0400
Received: from hermes.aosc.io ([199.195.250.187]:52356 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeICRzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:55:49 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 2E01EFF89E;
        Mon,  3 Sep 2018 13:35:30 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/3] drm/sun4i: change A64 HDMI PHY binding to R40
Date:   Mon,  3 Sep 2018 21:34:33 +0800
Message-Id: <20180903133434.58188-3-icenowy@aosc.io>
In-Reply-To: <20180903133434.58188-1-icenowy@aosc.io>
References: <20180903133434.58188-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner A64 SoC is proven to have no PLL-VIDEO mux in the HDMI PHY
clock, although it has two PLL-VIDEOs. The R40 SoC has this mux.

Change the binding compatible string from sun50i-a64 to sun8i-r40, and
let A64 to use H3 compatible string.

The compatible string is introduced in v4.19, and during the RC stage we
can still change it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 82502b351aec..744a8a2a15c0 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -396,7 +396,7 @@ static struct regmap_config sun8i_hdmi_phy_regmap_config = {
 	.name		= "phy"
 };
 
-static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy = {
+static const struct sun8i_hdmi_phy_variant sun8i_r40_hdmi_phy = {
 	.has_phy_clk = true,
 	.has_second_pll = true,
 	.phy_init = &sun8i_hdmi_phy_init_h3,
@@ -419,8 +419,8 @@ static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy = {
 
 static const struct of_device_id sun8i_hdmi_phy_of_table[] = {
 	{
-		.compatible = "allwinner,sun50i-a64-hdmi-phy",
-		.data = &sun50i_a64_hdmi_phy,
+		.compatible = "allwinner,sun8i-r40-hdmi-phy",
+		.data = &sun8i_r40_hdmi_phy,
 	},
 	{
 		.compatible = "allwinner,sun8i-a83t-hdmi-phy",
-- 
2.18.0

