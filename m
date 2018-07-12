Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB1FC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2699221476
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2699221476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeGLHoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:44:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51702 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbeGLHoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:44:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C06B62093E; Thu, 12 Jul 2018 09:35:48 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8BADB20884;
        Thu, 12 Jul 2018 09:35:38 +0200 (CEST)
Date:   Thu, 12 Jul 2018 09:35:38 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] drm/sun4i: fix build failure with
 CONFIG_DRM_SUN8I_MIXER=m
Message-ID: <20180712073538.drmn75bp6xe5cniz@flea>
References: <20180711144403.1022829-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v2vvhu7azu7inmri"
Content-Disposition: inline
In-Reply-To: <20180711144403.1022829-1-arnd@arndb.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v2vvhu7azu7inmri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2018 at 04:43:10PM +0200, Arnd Bergmann wrote:
> Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module result=
s in
> a link error, as we try to access a symbol from the sun8i_tcon_top.ko mod=
ule:
>=20
> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko=
] undefined!
> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] und=
efined!
>=20
> This solves the problem by adding a silent symbol for the tcon_top module,
> building it as a separate module in exactly the cases that we need it,
> but in a way that it is reachable by the other modules.
>=20
> Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible c=
rtcs")
> Fixes: ef0cf6441fbb ("drm/sun4i: Add support for traversing graph with TC=
ON TOP")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--v2vvhu7azu7inmri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltHBMkACgkQ0rTAlCFN
r3TR5g//VYb7CM4LY37INFtComYldKAjYiFTY8DqWfoHPehe03dpr0YXXOxeyaMk
9BQ99zMlHVcWZut9dnscl/B7b4RNVJCL5MoWpsJqrfk+02XjLn+wy7LWV9UIBODD
y4b58KrzTt6rSNyNBUulH5CxQfcU6rM0HvuClJMGk9PWSWRn1Q3/TJ93+MWDO64E
hKmRY/81738ElIeIG6UfqswFdqdee4TsrBAwfu84k/EcV3Sm8WUgwTp5MBBQB49+
1ba0qJfjwXJRi9YzO4pcAyDw3xW1Rsu8WAhZ9gUjZw9E5eMAi+zMrE4LhN0hH6k8
MFmObHQxDd4c3R78E6LG5T+2Q6EHak0zat+1mcaJcF/TnaSNp3imBl+bn53WQ2J/
Ed5myYjleU7ZzAOK8INur9+KmPEYqEgQlBeFecpau/SJsJ6nclCJnhu9N8tobt8g
mTAi/63u2Voo2NmR87kmN1o7EuXBI46yftyPRIiq1epJw5NZ/J0LQF9Yah6AlAlz
LvZ8spIOpWBaXIymxajqOyG2ccchkEUXaHRvLXOSiqqvvho5UBNRfHMrdP1zgdvb
DfgNuQhTGkIBbIh7lMjCapzKNzYrpya22TFvubVku0II84hdFOkNUQgeLQm2t3ev
abfsolIcuB3lofEw63k9XBE/K+O8ANWxN57Gvtb77NJRtYvK18Y=
=OTH+
-----END PGP SIGNATURE-----

--v2vvhu7azu7inmri--
