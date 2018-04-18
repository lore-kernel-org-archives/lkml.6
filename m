Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeDRQsJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 12:48:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44848 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeDRQsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 12:48:08 -0400
Date: Wed, 18 Apr 2018 17:48:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier@dowhile0.org>,
        David Collins <collinsd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, swboyd@chromium.org,
        linux-omap <linux-omap@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] regulator: Don't return or expect -errno from
 of_map_mode()
Message-ID: <20180418164804.GJ10061@sirena.org.uk>
References: <20180418033143.208986-1-dianders@chromium.org>
 <CABxcv=kx9KVJYPyRFBR5mzGgezoSmjrXpGa214E2v85YJYd1+Q@mail.gmail.com>
 <CAD=FV=U2_G=6yPndd0Fdd=e0zoM6x+h0Zqqyt6qcWx3TDohSdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xssso5lpTBgMxDfe"
Content-Disposition: inline
In-Reply-To: <CAD=FV=U2_G=6yPndd0Fdd=e0zoM6x+h0Zqqyt6qcWx3TDohSdg@mail.gmail.com>
X-Cookie: Sank heaven for leetle curls.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xssso5lpTBgMxDfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2018 at 08:56:22AM -0700, Doug Anderson wrote:
> On Wed, Apr 18, 2018 at 12:15 AM, Javier Martinez Canillas

> >>         if (!of_property_read_u32(np, "regulator-initial-mode", &pval)=
) {
> >>                 if (desc && desc->of_map_mode) {
> >> -                       ret =3D desc->of_map_mode(pval);
> >> -                       if (ret =3D=3D -EINVAL)
> >> +                       unsigned int mode =3D desc->of_map_mode(pval);

> > I think the convention is to always declare local variables at the
> > start of the function? Although I couldn't find anything in the coding
> > style document...

> I haven't seen this as a consistent kernel convention.  It seems a bit
> up to the subsystem and/or driver maintainer.  However, I'm happy to
> put it up at the top if it makes people happy.

It's *fairly* consistent (this is C code after all) - doing something
different usually has some form of motivation. =20

--Xssso5lpTBgMxDfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrXdsMACgkQJNaLcl1U
h9Cgwgf+L45bv3e9yxNHJhGSZS3zTVaDeXbSKorw2sho86f0DYSEneXEyBqHgI14
dBMe4KL0Q7miw3+YPmgzMc81v1m+wj72NOmaxO849mEK2t8LUxFgf+SlI2f2dozk
WaTRUQsJODb4ncvh40pzXVZE5Iwx31wRQufKaOP+BMZNIUkkVtYCZFk23l10kEjJ
QCzAcSC1Wyms8hhdWrwzggKLPTp49xw3Y77pxgDfmMED1BB5nYE3aN58+uDZmQhb
K4iIM3PtJ77H2e1FWMBYv1irZG23zw1Rk+cj9u5w/TNyw2wQmY6xylI6JZzBcMkM
1Crl75ctzHNv+bTk8ZQtCL1arm4ovg==
=GCTt
-----END PGP SIGNATURE-----

--Xssso5lpTBgMxDfe--
