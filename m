Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52861C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1485420869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1485420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbeIDJFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:05:19 -0400
Received: from hermes.aosc.io ([199.195.250.187]:44963 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbeIDJFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:05:19 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 9E276FFA2D;
        Tue,  4 Sep 2018 04:41:56 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 04/11] drm/sun4i: Add support for A64 mixers
Date:   Tue,  4 Sep 2018 12:40:46 +0800
Message-Id: <20180904044053.15425-5-icenowy@aosc.io>
In-Reply-To: <20180904044053.15425-1-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagan Teki <jagan@amarulasolutions.com>

Mixers in Allwinner have similar capabilities as others SoCs with DE2.

Add support for them.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
[Icenowy: Add mixer1]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
Changes for v4:
- none
Changes for v3.1:
- Add mixer0
Changes for v3:
- none 
Changes for v2:
- New patch

 drivers/gpu/drm/sun4i/sun8i_mixer.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index cb65b0ed53fd..091f6cf40353 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -553,6 +553,22 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.mod_rate = 150000000,
 };
 
+static const struct sun8i_mixer_cfg sun50i_a64_mixer0_cfg = {
+	.ccsc		= 0,
+	.mod_rate	= 297000000,
+	.scaler_mask	= 0xf,
+	.ui_num		= 3,
+	.vi_num		= 1,
+};
+
+static const struct sun8i_mixer_cfg sun50i_a64_mixer1_cfg = {
+	.ccsc		= 1,
+	.mod_rate	= 297000000,
+	.scaler_mask	= 0x3,
+	.ui_num		= 1,
+	.vi_num		= 1,
+};
+
 static const struct of_device_id sun8i_mixer_of_table[] = {
 	{
 		.compatible = "allwinner,sun8i-a83t-de2-mixer-0",
@@ -570,6 +586,14 @@ static const struct of_device_id sun8i_mixer_of_table[] = {
 		.compatible = "allwinner,sun8i-v3s-de2-mixer",
 		.data = &sun8i_v3s_mixer_cfg,
 	},
+	{
+		.compatible = "allwinner,sun50i-a64-de2-mixer-0",
+		.data = &sun50i_a64_mixer0_cfg,
+	},
+	{
+		.compatible = "allwinner,sun50i-a64-de2-mixer-1",
+		.data = &sun50i_a64_mixer1_cfg,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun8i_mixer_of_table);
-- 
2.18.0

