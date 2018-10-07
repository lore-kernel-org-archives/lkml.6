Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B62C677F5
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3710E20895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3710E20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeJGQqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 12:46:55 -0400
Received: from mailoutvs46.siol.net ([185.57.226.237]:40061 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728371AbeJGQqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 12:46:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id A6BD7520479;
        Sun,  7 Oct 2018 11:40:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DMYwWRxjVhFA; Sun,  7 Oct 2018 11:40:10 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 11D14520456;
        Sun,  7 Oct 2018 11:40:10 +0200 (CEST)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id A68ED520422;
        Sun,  7 Oct 2018 11:40:07 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, airlied@linux.ie,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 21/29] drm/sun4i: dw-hdmi-phy: Reorder quirks by family
Date:   Sun,  7 Oct 2018 11:38:57 +0200
Message-Id: <20181007093905.11253-22-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007093905.11253-1-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
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
2.19.0

