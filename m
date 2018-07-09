Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E12DC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F742089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F742089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754522AbeGIIHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:07:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43312 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932427AbeGIIH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:07:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 34ACF20875; Mon,  9 Jul 2018 10:07:25 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0875E203D9;
        Mon,  9 Jul 2018 10:07:25 +0200 (CEST)
Date:   Mon, 9 Jul 2018 10:07:24 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonathan Liu <net147@gmail.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: fix build failure with
 CONFIG_DRM_SUN8I_MIXER=m
Message-ID: <20180709080724.3ekqb45fsjubvhcm@flea>
References: <20180706124628.3192421-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wlrk75kbro3bwy7g"
Content-Disposition: inline
In-Reply-To: <20180706124628.3192421-1-arnd@arndb.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wlrk75kbro3bwy7g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 06, 2018 at 02:45:53PM +0200, Arnd Bergmann wrote:
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
> This solves the problem by making DRM_SUN8I_MIXER a 'bool' symbol, buildi=
ng
> the sun8i_tcon_top module the same way as the core sun4i-drm module whene=
ver
> DRM_SUN8I_MIXER is enabled, or not building it at all otherwise.
>=20
> Alternatively, we could always build sun8i_tcon_top.ko along with sun4-dr=
m.ko
> and detach it from the mixer module, I could not tell which way is more
> appropriate here.

If that's easily doable, then yeah, that would be the preferred option
I guess. Jernej? Chen-Yu? Any opinion on this?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--wlrk75kbro3bwy7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltDF7sACgkQ0rTAlCFN
r3Q8pQ/+OOdyzKdSdBfGcn+aqWBrysacrlRaqBw2m7LADMrqnuLpIO5l0t4AO3/f
nguD0klMeMuHHfvkNQDsrWutLgx8vkzOD0Kgi0rFLpW4opjAWyVaLLGAlDW2TOYT
J+dbUl9RovUGLhwgmOQZj5gxIG2W5vCfpK3WMA74MhsJD71+ks+g6fBKZKS7jgpf
7iygvOtaI6+1Gg/DhgMcB+PT4x47rOIMxDdCWkxVY6hu1RbECCCNuUp/4jGolLjY
cjucqo4/VyMCF+82qHZjFNWPzHMKQRDCXIGnCWhvOEqmt8UQhDvZZKheYYfQtuRZ
QUq/dzca8X/vDx0qvYzSa11r9yIulPiuU4SPl6o1qt22iuy3cUg4XPHQCIgrwlEL
W3x03tHLUUAyPA08LuMEHNbLcXb26tCQROPB266XtNKEkl5Hqd2PtHdwApp7WyKE
R2VeCLd9yjKykmkzQtHLXVX00ASGrhtW5CtB9PNg4NAufh5yN5mGQO1aUQKreeu7
56HVVBnGXWKhW7/6V5STOiAR+54BPD7aMPNhp4Q7iYa28if4xPNNKKcko1IPFzON
UMERCcfRllX3sfrtlYalIDY40DAGoHw0F4XAUWz/CYZzCkMfTEuoLduM6wHwavoC
3vKGdWiJNFLmB9yRYyckrfBvNZ2tjnovSuguySAc7GQSxCa6KQY=
=FVcx
-----END PGP SIGNATURE-----

--wlrk75kbro3bwy7g--
