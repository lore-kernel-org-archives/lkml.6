Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DF1C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276C020844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276C020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeIGQXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:23:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39798 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbeIGQXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:23:31 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BABE020726; Fri,  7 Sep 2018 13:42:56 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 806A120701;
        Fri,  7 Sep 2018 13:42:56 +0200 (CEST)
Date:   Fri, 7 Sep 2018 13:42:55 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH] [v3] drm/sun4i: fix build failure with
 CONFIG_DRM_SUN8I_MIXER=m
Message-ID: <20180907114255.7j7r6wzolnz5qkk7@flea>
References: <20180711144403.1022829-1-arnd@arndb.de>
 <105cb1cf-577a-043a-9b50-248a37090bdd@nvidia.com>
 <CAK8P3a1w0SrxFNRwjt1nWhQPdqgt=bZ8oqGaPE=z9iHp84R5mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4zkbdfg7sppywb2m"
Content-Disposition: inline
In-Reply-To: <CAK8P3a1w0SrxFNRwjt1nWhQPdqgt=bZ8oqGaPE=z9iHp84R5mw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4zkbdfg7sppywb2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 01:26:30PM +0200, Arnd Bergmann wrote:
> On Fri, Sep 7, 2018 at 11:41 AM Jon Hunter <jonathanh@nvidia.com> wrote:
> >
> >
> > On 11/07/18 15:43, Arnd Bergmann wrote:
> > > Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module re=
sults in
> > > a link error, as we try to access a symbol from the sun8i_tcon_top.ko=
 module:
> > >
> > > ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdm=
i.ko] undefined!
> > > ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko]=
 undefined!
> > >
> > > This solves the problem by adding a silent symbol for the tcon_top mo=
dule,
> > > building it as a separate module in exactly the cases that we need it,
> > > but in a way that it is reachable by the other modules.
> > >
> > > Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possib=
le crtcs")
> > > Fixes: ef0cf6441fbb ("drm/sun4i: Add support for traversing graph wit=
h TCON TOP")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > I am seeing the following on today's -next (20180907) as well the last
> > few -next versions for that matter ...
> >
> > ERROR: "sun8i_tcon_top_de_config" [drivers/gpu/drm/sun4i/sun4i-tcon.ko]=
 undefined!
> > ERROR: "sun8i_tcon_top_set_hdmi_src" [drivers/gpu/drm/sun4i/sun4i-tcon.=
ko] undefined!
> > ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] =
undefined!
> >
> > Seems like this issue has cropped up again as Arnd's fix is present. I
> > am seeing this on ARM64 builds.
>=20
> I have not started build testing on linux-next since the merge window, but
> looking at the changes that got queued up, I find commits cf77d79b4e29
> ("drm/sun4i: tcon: Add another way for matching mixers with tcon") and
> 0305189afb32 ("drm/sun4i: tcon: Add support for R40 TCON") that both
> introduced a reference to the tcon_top file from sun4i_tcon.c.
>=20
> More IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) checks in
> the caller like I did in my patch would help, or alternatively one could
> decide to give up and just always include the TCON_TOP.

Sorry for the breakage.

Can you test:

----8<----
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun=
4i_tcon.c
index 4834c90b4912..c78cd35a1294 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -974,7 +974,8 @@ static bool sun4i_tcon_connected_to_tcon_top(struct dev=
ice_node *node)
=20
 	remote =3D of_graph_get_remote_node(node, 0, -1);
 	if (remote) {
-		ret =3D !!of_match_node(sun8i_tcon_top_of_table, remote);
+		ret =3D !!(IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
+			 of_match_node(sun8i_tcon_top_of_table, remote));
 		of_node_put(remote);
 	}
=20
@@ -1402,13 +1403,20 @@ static int sun8i_r40_tcon_tv_set_mux(struct sun4i_t=
con *tcon,
 	if (!pdev)
 		return -EINVAL;
=20
-	if (encoder->encoder_type =3D=3D DRM_MODE_ENCODER_TMDS) {
+	if (IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
+	    encoder->encoder_type =3D=3D DRM_MODE_ENCODER_TMDS) {
 		ret =3D sun8i_tcon_top_set_hdmi_src(&pdev->dev, id);
 		if (ret)
 			return ret;
 	}
=20
-	return sun8i_tcon_top_de_config(&pdev->dev, tcon->id, id);
+	if (IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP)) {
+		ret =3D sun8i_tcon_top_de_config(&pdev->dev, tcon->id, id);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
=20
 static const struct sun4i_tcon_quirks sun4i_a10_quirks =3D {
----8<----

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4zkbdfg7sppywb2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluSZD4ACgkQ0rTAlCFN
r3Q6YQ//Yw5kuFRiog0m6febtwKIWUZc3Q3Yal+Xk+HgIw3yH03lRluKYwj8cY92
EYooUSv8eErK+8Z7DHYvTyMHWcZ6PVIAEq0sWRmlwac4PlJRhWGHAbbH1OozAG+i
RARz9LE/0Qmwnj648KxVqmF07ttApht4ECJRp8RCrogrC5HKyOtCTb/y3iVdwsMz
SjcUJbRC3oN+0qTOrbV3H0bGUbRwvb4SXI4X8USzwIXEcXUbiq03YioE+TDL8oz8
qkV8RiHPwD0NCGSAtVFmRXbyyv59zGiLWymuJXVvl8caoZm7XLBdnqyrAu07lk93
Y4jnYPyOtxOkQ4eGBcJgF+AAwR7njPgbhbkR4dONrd+lm6UCr5Q5rSJWjvJLijYc
cWb+zjra7OOP33BnX1zJYaT17SzXRbfHH1xPURuCxxpYNn95fOdM2PbWE1Y6Ea98
fZpNFSb76zrVLcOSe3tY+abd6B8BU9WnFK5Prf/5YD2fTYTLJiYO1hksm0Qyv+Jt
YZ+gsU+VGKuCsk+OsFp2lYfS6cUbVB30vtfjqqtDQBic73LilcKUxbqSSm+jJVtX
94TmcgcXooXZXe03vFqbnynp2Nuee0ETInH8rtd8cWtGKq1ZvDP5facBO+ldj6kK
bmZaPwx92XHRJsZ+eNrtaohmnJSNEIyJWKs3iiE5T/mYMOxVBYc=
=H2q2
-----END PGP SIGNATURE-----

--4zkbdfg7sppywb2m--
