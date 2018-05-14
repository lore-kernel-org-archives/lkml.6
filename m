Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeENUgW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:36:22 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:43556 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751498AbeENUgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:36:20 -0400
Message-ID: <0da5787f0ce2309a74db88820bc58b3b3501c451.camel@paulk.fr>
Subject: Re: [PATCH v4 3/3] ARM: dts: sun7i: Add support for the Ainol AW1
 tablet
From: Paul Kocialkowski <contact@paulk.fr>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Date: Mon, 14 May 2018 22:36:08 +0200
In-Reply-To: <20180511143647.ici2bfoeeldto3ju@flea>
References: <20180507220413.21990-1-contact@paulk.fr>
         <20180507220413.21990-3-contact@paulk.fr>
         <20180511143647.ici2bfoeeldto3ju@flea>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-rEbSIXPLZuMc9DLenYlf"
X-Mailer: Evolution 3.28.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rEbSIXPLZuMc9DLenYlf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi and thanks for the review!

Le vendredi 11 mai 2018 =C3=A0 16:36 +0200, Maxime Ripard a =C3=A9crit :
> On Tue, May 08, 2018 at 12:04:13AM +0200, Paul Kocialkowski wrote:
> > +++ b/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
> > @@ -0,0 +1,297 @@
> > +/*
> > + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>=20
> This really should be the first line, and with a C++ style comment, as
> in:
>=20
> // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> /*
>  * Copyright (C) ...
>=20
> See Documentation/process/license-rules.rst

Okay, will do in v5.

> > +	backlight: backlight {
> > +		compatible =3D "pwm-backlight";
> > +		pwms =3D <&pwm 0 50000 PWM_POLARITY_INVERTED>;
> > +		brightness-levels =3D <  0   1   1   1   1   2   2   2
> > +				       2   3   3   3   3   4   4   4
> > +				       5   5   5   6   6   6   7   7
> > +				       8   8   8   9   9   9  10  10
> > +				      10  11  11  12  12  12  13  13
> > +				      14  14  14  15  15  16  16  17
> > +				      17  17  18  18  19  19  20  20
> > +				      21  21  21  22  22  23  23  24
> > +				      24  25  25  26  26  27  27  28
> > +				      28  29  30  30  31  31  32  32
> > +				      33  33  34  35  35  36  36  37
> > +				      38  38  39  39  40  41  41  42
> > +				      43  43  44  44  45  46  47  47
> > +				      48  49  49  50  51  51  52  53
> > +				      54  54  55  56  57  57  58  59
> > +				      60  61  61  62  63  64  65  65
> > +				      66  67  68  69  70  71  71  72
> > +				      73  74  75  76  77  78  79  80
> > +				      81  82  83  84  85  86  87  88
> > +				      89  90  91  92  93  94  95  96
> > +				      97  98  99 101 102 103 104 105
> > +				     106 108 109 110 111 112 114 115
> > +				     116 117 119 120 121 123 124 125
> > +				     127 128 129 131 132 133 135 136
> > +				     138 139 141 142 144 145 147 148
> > +				     150 151 153 154 156 157 159 161
> > +				     162 164 166 167 169 171 173 174
> > +				     176 178 180 181 183 185 187 189
> > +				     191 192 194 196 198 200 202 204
> > +				     206 208 210 212 214 216 219 221
> > +				     223 225 227 229 232 234 236 238
> > +				     241 242 244 246 248 250 253 255>;
>=20
> You kind of overdid it here :)
>=20
> What I meant to say before was that if you have 10 elements (and you
> really should have something in that magnitude) each step should
> increase the perceived brightness by 10%.

Mhh I think 10 elements would fall too short to really depict the curve
with appropriate precision. Given the usual size for brightness cursors
in e.g. gnome-shell, it feels like a bigger number would be more
appropriate. Let's make it to 100 with values from 0 to 255!

> In this particular case, I really think having something close to <0 4
> 8 16 32 64 128 255> would be enough.
>=20
> And in general, that kind of odd looking table without any more
> context is just screaming for a comment :)

Noted, I will explain the idea, but probably without the exact formula
that's really a nasty hack written down on a piece of paper sitting in
my garbage at this point.

--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-rEbSIXPLZuMc9DLenYlf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlr58zgACgkQhP3B6o/u
lQxlYQ/7Bpcw5T+Y3D0YmpkLVWbfBxshm7sjymE7q3tImY3RHbbykewcJQnwYXB2
0rxDLNtvzsvI6Xbgd4ul2hAFWaJ/VIy7DxaQB0PE432m2dJ51ESVtKolMQDqguxf
D1oM7TF8HXulEXc0EZRgJ/gIOIjrcy+j8zV7RyupZaTeifmcTsoV2AkgycbZdpyf
qRg4yd0dnC3lXbsDPiZCFQSJvhinZLYWKG1Hj7MgcCL4TzOfFeg5fDwQveBzrvlV
olYOYLrDrMRetu9nYP3u/g8nlDMbTLnqqr+YNlGPo52XgMIKHNSzjFW7hN5X8pke
++OjRa8aD1E+lsXxZG5NhsndKTMNL5Y0tioyhtf1+jhDfTv4iMFhBTXIDN62lyWx
qgMcAKykrJJcNTmOIxmWS0YTgbLC3Mbb2lIpySuLvoppaoUJqAkw7nRP8KyVg2DG
BuGo4ERkZZH4JxIO8ACMxSJkhL+ZM8VavWE8n62PqSh3yvv1EVtVfnTpNc4+qVWy
zY+rWKt3MVoKUz3C+9CjEsz/cfSOpDpd49S+RpRRDMvdXpcBBKuY4JebX3QMznOm
89y/x7d18zN1DNv3qjKmEmIZS4TVLDqXhZ/yFhwvWYcHadSV9cBTI96pOfzuGVSE
VL7l6FH6ROJ5DbH6kyT9UDEZ7muYGAOoCo1HtnhAkOxlvfRRVYg=
=UMjr
-----END PGP SIGNATURE-----

--=-rEbSIXPLZuMc9DLenYlf--
