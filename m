Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BA6C65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B422084D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B422084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeJGQqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 12:46:38 -0400
Received: from mailoutvs35.siol.net ([185.57.226.226]:39873 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728270AbeJGQqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 12:46:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 2B5CB520CA3;
        Sun,  7 Oct 2018 11:39:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cEeHBv64HWEn; Sun,  7 Oct 2018 11:39:52 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id DCAD5520CA4;
        Sun,  7 Oct 2018 11:39:52 +0200 (CEST)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 75BA8520CA3;
        Sun,  7 Oct 2018 11:39:50 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, airlied@linux.ie,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 14/29] drm/sun4i: Add support for H6 DE3 mixer 0
Date:   Sun,  7 Oct 2018 11:38:50 +0200
Message-Id: <20181007093905.11253-15-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007093905.11253-1-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
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
index 64daeb017d10..ace8b6cb8a8b 100644
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
2.19.0

