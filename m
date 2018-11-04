Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF5FC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855FC20854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855FC20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbeKEDoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:44:05 -0500
Received: from mailoutvs4.siol.net ([185.57.226.195]:47438 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387585AbeKEDoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:44:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id F17FB5212AE;
        Sun,  4 Nov 2018 19:28:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zv_3YNgSxMMO; Sun,  4 Nov 2018 19:28:08 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 3454E521257;
        Sun,  4 Nov 2018 19:28:08 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 97DE35212B5;
        Sun,  4 Nov 2018 19:28:02 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, jernej.skrabec@siol.net
Subject: [PATCH v3 13/28] drm/sun4i: Add support for H6 DE3 mixer 0
Date:   Sun,  4 Nov 2018 19:26:50 +0100
Message-Id: <20181104182705.18047-14-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mixer 0 has 1 VI and 3 UI planes, scaler on all planes and can output
4K image @60Hz. It also support 10 bit colors, which are not yet
implemented.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
index ca402cf0f5ba..44a9ba7d8433 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -613,6 +613,15 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer=
1_cfg =3D {
 	.vi_num		=3D 1,
 };
=20
+static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg =3D {
+	.ccsc		=3D 0,
+	.is_de3		=3D true,
+	.mod_rate	=3D 600000000,
+	.scaler_mask	=3D 0xf,
+	.ui_num		=3D 3,
+	.vi_num		=3D 1,
+};
+
 static const struct of_device_id sun8i_mixer_of_table[] =3D {
 	{
 		.compatible =3D "allwinner,sun8i-a83t-de2-mixer-0",
@@ -646,6 +655,10 @@ static const struct of_device_id sun8i_mixer_of_tabl=
e[] =3D {
 		.compatible =3D "allwinner,sun50i-a64-de2-mixer-1",
 		.data =3D &sun50i_a64_mixer1_cfg,
 	},
+	{
+		.compatible =3D "allwinner,sun50i-h6-de3-mixer-0",
+		.data =3D &sun50i_h6_mixer0_cfg,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun8i_mixer_of_table);
--=20
2.19.1

