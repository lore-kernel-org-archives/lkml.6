Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeB0W1s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:27:48 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:60577 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752085AbeB0W1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:27:46 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 08/16] drm/sun4i: Add support for H3 mixer 0
Date: Tue, 27 Feb 2018 23:26:53 +0100
Message-Id: <20180227222701.9716-9-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180227222701.9716-1-jernej.skrabec@siol.net>
References: <20180227222701.9716-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mixer supports 1 VI plane, 3 UI plane and HW scaling on all planes.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 9b0256d31a61..126899d6f0d3 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -492,6 +492,14 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixer1_cfg = {
 	.vi_num		= 1,
 };
 
+static const struct sun8i_mixer_cfg sun8i_h3_mixer0_cfg = {
+	.ccsc		= 0,
+	.mod_rate	= 432000000,
+	.scaler_mask	= 0xf,
+	.ui_num		= 3,
+	.vi_num		= 1,
+};
+
 static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.vi_num = 2,
 	.ui_num = 1,
@@ -509,6 +517,10 @@ static const struct of_device_id sun8i_mixer_of_table[] = {
 		.compatible = "allwinner,sun8i-a83t-de2-mixer-1",
 		.data = &sun8i_a83t_mixer1_cfg,
 	},
+	{
+		.compatible = "allwinner,sun8i-h3-de2-mixer-0",
+		.data = &sun8i_h3_mixer0_cfg,
+	},
 	{
 		.compatible = "allwinner,sun8i-v3s-de2-mixer",
 		.data = &sun8i_v3s_mixer_cfg,
-- 
2.16.2
