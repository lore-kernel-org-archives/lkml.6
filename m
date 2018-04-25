Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754231AbeDYKx2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 06:53:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44898 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753819AbeDYKxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 06:53:18 -0400
Date: Wed, 25 Apr 2018 11:53:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: linux-arm-kernel@lists.infradead.org,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi@googlegroups.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/3] regulator: add support for SY8106A regulator
Message-ID: <20180425105309.GC24769@sirena.org.uk>
References: <20180423144657.63264-1-icenowy@aosc.io>
 <20180423144657.63264-3-icenowy@aosc.io>
 <20180424170733.GD22073@sirena.org.uk>
 <C0C1F042-221A-420F-A8C1-5FADCFC687F1@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline
In-Reply-To: <C0C1F042-221A-420F-A8C1-5FADCFC687F1@aosc.io>
X-Cookie: MS-DOS must die!
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 07:41:35AM +0800, Icenowy Zheng wrote:
> =E4=BA=8E 2018=E5=B9=B44=E6=9C=8825=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=88=
1:07:33, Mark Brown <broonie@kernel.org> =E5=86=99=E5=88=B0:
> >On Mon, Apr 23, 2018 at 10:46:56PM +0800, Icenowy Zheng wrote:

> >> --- /dev/null
> >> +++ b/drivers/regulator/sy8106a-regulator.c
> >> @@ -0,0 +1,176 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/*
> >> + * sy8106a-regulator.c - Regulator device driver for SY8106A

> >Just make the entire thing a C++ comment so it looks consistent and
> >joined up.

> SPDX identifier is special -- it should be in a seperated
> comment block.

No, it just needs to be a C++ comment on the first line to ease machine
parsing.  The rest of the file doesn't matter for that.

> >> +	if (reg & SY8106A_GO_BIT)
> >> +		return reg & rdev->desc->vsel_mask;
> >> +	else
> >> +		return (chip->fixed_voltage - rdev->desc->min_uV) /
> >> +		       rdev->desc->uV_step;

> >You could use the standard get_voltage_sel() if you provide a mapping
> >operation that set everything with _GO_BIT set to return the fixed
> >voltage.  Though looking at this it seems that the fixed voltage will
> >always be one that could be set via the register anyway so I'm
> >wondering
> >if the easiest thing here isn't to just have the driver turn off
> >_GO_BIT

> Do you mean "turn on" here?

Yes.

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrgXhUACgkQJNaLcl1U
h9Dz8Af/ShUsBEhUOo12gD3i5rTHC+B7d/vXUVvbpwkxTOs9H+bKL3erRtuIA/mO
IbSgSqYjR7PqsVp6IIABDUItbRN2eFVjx/WlxfsHf2WqoXDK0CMq1b8h2I7Z9rd2
3Pg/ETgOEOcG3UG6mal2JuqEPqldetHJoaOAd/k71A4Z4fGmye2fQsHHl80sG5yw
Oafndtd2xNyVBaxff0NDNPCpMYPm/SFfCik0tH5VCTAENFqnS7FKkEKJW4Iv0+6+
bObcFF1mDrCzi9rfQPoTh4s+oXyqjwTdlj6jvz9zhmRv9yn5B9CWN/EI/bIvJYkg
CwWqSVKCyEZahQL5p4yYkQyR2M+Ufg==
=oG+g
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
