Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752779AbeERJrc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:47:32 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42425 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752326AbeERJr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:47:28 -0400
X-Google-Smtp-Source: AB8JxZqk2ASrrzyFmkNPP1C6EW0CpCtjqs/fGP2zTLhHbMc7462bIAVjAHZdLRAGmkF18ew4GEgs0Q==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 13/26] drm/sun4i: Add support for A64 HDMI PHY
Date: Fri, 18 May 2018 15:15:23 +0530
Message-Id: <20180518094536.17201-14-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180518094536.17201-1-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

PHY is the same as in H3, except it can select between two clock parent.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- new patch

 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 0eadf087fc46..39fbf7257fce 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -392,6 +392,13 @@ static struct regmap_config sun8i_hdmi_phy_regmap_config = {
 	.name		= "phy"
 };
 
+static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy = {
+	.phy_clk_num = 2,
+	.phy_init = &sun8i_hdmi_phy_init_h3,
+	.phy_disable = &sun8i_hdmi_phy_disable_h3,
+	.phy_config = &sun8i_hdmi_phy_config_h3,
+};
+
 static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy = {
 	.phy_init = &sun8i_hdmi_phy_init_a83t,
 	.phy_disable = &sun8i_hdmi_phy_disable_a83t,
@@ -406,6 +413,10 @@ static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy = {
 };
 
 static const struct of_device_id sun8i_hdmi_phy_of_table[] = {
+	{
+		.compatible = "allwinner,sun50i-a64-hdmi-phy",
+		.data = &sun50i_a64_hdmi_phy,
+	},
 	{
 		.compatible = "allwinner,sun8i-a83t-hdmi-phy",
 		.data = &sun8i_a83t_hdmi_phy,
-- 
2.14.3
