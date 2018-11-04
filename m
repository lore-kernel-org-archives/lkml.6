Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A100CECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C262081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C262081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbeKEDoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:44:22 -0500
Received: from mailoutvs16.siol.net ([185.57.226.207]:47632 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731728AbeKEDoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:44:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id A4987521294;
        Sun,  4 Nov 2018 19:28:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MAK7tY_kv6Nd; Sun,  4 Nov 2018 19:28:26 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 5751A521233;
        Sun,  4 Nov 2018 19:28:26 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id D4E695212AE;
        Sun,  4 Nov 2018 19:28:23 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, jernej.skrabec@siol.net
Subject: [PATCH v3 20/28] drm/sun4i: dw-hdmi-phy: Reorder quirks by family
Date:   Sun,  4 Nov 2018 19:26:57 +0100
Message-Id: <20181104182705.18047-21-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, quirks and compatibles are sorted alphabetically. However,
they should be sorted by family release date and then alphabetically.

Fix that by moving A64 quirks and compatible to bottom. No functional
change is made.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun=
4i/sun8i_hdmi_phy.c
index 365cb5a9fb77..adc3ba7df7e3 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -403,13 +403,6 @@ static struct regmap_config sun8i_hdmi_phy_regmap_co=
nfig =3D {
 	.name		=3D "phy"
 };
=20
-static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy =3D {
-	.has_phy_clk =3D true,
-	.phy_init =3D &sun8i_hdmi_phy_init_h3,
-	.phy_disable =3D &sun8i_hdmi_phy_disable_h3,
-	.phy_config =3D &sun8i_hdmi_phy_config_h3,
-};
-
 static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy =3D {
 	.phy_init =3D &sun8i_hdmi_phy_init_a83t,
 	.phy_disable =3D &sun8i_hdmi_phy_disable_a83t,
@@ -431,11 +424,14 @@ static const struct sun8i_hdmi_phy_variant sun8i_r4=
0_hdmi_phy =3D {
 	.phy_config =3D &sun8i_hdmi_phy_config_h3,
 };
=20
+static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy =3D {
+	.has_phy_clk =3D true,
+	.phy_init =3D &sun8i_hdmi_phy_init_h3,
+	.phy_disable =3D &sun8i_hdmi_phy_disable_h3,
+	.phy_config =3D &sun8i_hdmi_phy_config_h3,
+};
+
 static const struct of_device_id sun8i_hdmi_phy_of_table[] =3D {
-	{
-		.compatible =3D "allwinner,sun50i-a64-hdmi-phy",
-		.data =3D &sun50i_a64_hdmi_phy,
-	},
 	{
 		.compatible =3D "allwinner,sun8i-a83t-hdmi-phy",
 		.data =3D &sun8i_a83t_hdmi_phy,
@@ -448,6 +444,10 @@ static const struct of_device_id sun8i_hdmi_phy_of_t=
able[] =3D {
 		.compatible =3D "allwinner,sun8i-r40-hdmi-phy",
 		.data =3D &sun8i_r40_hdmi_phy,
 	},
+	{
+		.compatible =3D "allwinner,sun50i-a64-hdmi-phy",
+		.data =3D &sun50i_a64_hdmi_phy,
+	},
 	{ /* sentinel */ }
 };
=20
--=20
2.19.1

