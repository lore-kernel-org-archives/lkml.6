Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeC0IRe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:17:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36836 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750937AbeC0IRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:17:33 -0400
Date: Tue, 27 Mar 2018 10:17:31 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 02/10] drm/sun4i: Disable YUV channel when using the
 frontend and set interlace
Message-ID: <20180327081731.he3lhnvqffuimsi5@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-3-paul.kocialkowski@bootlin.com>
 <20180323095529.5nptn5achjt3esog@flea>
 <1522137643.1110.4.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cgmzifoncvtg7qrv"
Content-Disposition: inline
In-Reply-To: <1522137643.1110.4.camel@bootlin.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cgmzifoncvtg7qrv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2018 at 10:00:43AM +0200, Paul Kocialkowski wrote:
> Hi,
>=20
> On Fri, 2018-03-23 at 10:55 +0100, Maxime Ripard wrote:
> > On Wed, Mar 21, 2018 at 04:28:56PM +0100, Paul Kocialkowski wrote:
> > > The YUV channel was only disabled in
> > > sun4i_backend_update_layer_formats,
> > > which is not called when the frontend is selected.
> > >=20
> > > Thus, creating a layer with a YUV format handled by the backend and
> > > then
> > > switching to a format that requires the frontend would keep the YUV
> > > channel enabled for the layer.
> > >=20
> > > This explicitly disables the YUV channel for the layer when using
> > > the
> > > frontend as well. It also sets the relevant interlace bit, which was
> > > missing in the frontend path as well.
> >=20
> > This should be part of a separate patch. Usually, if you write "it
> > also does..." at the end of your commit log, it's a pretty good
> > indication that it should be another patch :)
>=20
> I must say, I figured that this part was missing in the frontend path by
> chance and couldn't really test the feature, so I'm also tempted to drop
> it altogether. What do you think?

If you haven't been able to test it, then yeah, don't submit it.

> Also, is interlacing actually used on any of the video outputs we
> support? Perhaps RGB?

Composite would be a better guess :)

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--cgmzifoncvtg7qrv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlq5/hoACgkQ0rTAlCFN
r3Q5SQ//VZ4bUUFhHz41dByBblMcM+4wj7Po4beEvD1jjl65PRe3A1LTHoNTuhvw
d3p2NKHeuRnzHx/wd1tohQxyZFUmho3iK2w/4ZSLS7ntUr/Y/gPtp+psiHTocIeE
QaqY8e6NfPs3hB3MkAQy5EDXtQmsh7Z2U7YrNCP5eMidG4ZIRGqNcE0IAek+aWjh
Bs/A08N/TdFHH8vjprRCakQofI3+zwLGUXNdaopQxLMdy0aw++NtEl4MEQEYalzX
5L3v2mKEB2Zm0UN4b+Y0NmpsH3FHhTWwCV34hdkHUsjzK/y3LSEAg+cjdi+0qVbx
DxjcAHVyVRvVEA3FtgQValYriBM9bDMawWA6u0p0ur/4Ow5huXuoxhHgXFvsc9Sg
9LtXrlLGfYEPBwADsjhyDppxNekwdKFiKQ2RCG6I+JL9wsw/eBMVqN7h/6TciLRR
RFbnMlB8CJIXYorWZz9QEEmUvvTaNQ0Xe+8ldRdc+VOfcTnWv1DieU0lJoc4HbG+
I2lkkDa/wv9ooK8Ir2b0uPuVOkMOS7fJCfIxpsDiFmUnaL2mybPJbNJMSNrERTf5
O3rhHw2kNU1YxYJon5kET5cYmZ6Qf5QT5lgaRluM/5zGR/t3ePkSCi/M7eED/X4j
S7AyDNwakDAAAF2fe4rkxH8pNpDJm1pg3ZEgwaETXpdDxaKJwE0=
=+3Fg
-----END PGP SIGNATURE-----

--cgmzifoncvtg7qrv--
