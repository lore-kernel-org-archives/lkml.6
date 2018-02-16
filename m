Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758353AbeBPPux (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:50:53 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:54443 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758251AbeBPPuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:50:51 -0500
Date: Fri, 16 Feb 2018 16:50:49 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: airlied@linux.ie, wens@csie.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/sun4i: Handle DRM_MODE_FLAG_**SYNC_POSITIVE
 correctly
Message-ID: <20180216155049.r2mc724nfluwrrbe@flea.lan>
References: <1516474221-114596-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1516474221-114596-2-git-send-email-giulio.benetti@micronovasrl.com>
 <20180122085112.7xo2t3x5ag4k2kpl@flea.lan>
 <aa724bd5-cfb1-128c-af32-db29253f32aa@micronovasrl.com>
 <59f7b542-3b1d-ff62-e290-37c47f4075ff@micronovasrl.com>
 <9929d894-53c3-a7e9-a328-a00cfc1ef546@micronovasrl.com>
 <20180207103905.mtyzgu73mmifyvvj@flea>
 <653f0438-c55a-02a5-dffb-2ee8e6d9ef4a@micronovasrl.com>
 <20180208204043.mqryuqhx7a6z4v3b@flea>
 <e5d49c13-9b8f-d597-508c-10fed5300769@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3h2no4wlgtkccz5a"
Content-Disposition: inline
In-Reply-To: <e5d49c13-9b8f-d597-508c-10fed5300769@micronovasrl.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3h2no4wlgtkccz5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2018 at 07:05:56PM +0100, Giulio Benetti wrote:
> > If so, and if remember the captures properly, the sampling would occur
> > right before the rise, and not really around the fall.
> >=20
> > Would 2/3 be better here?
>=20
> Yes, you're right, 2/3 phase is better:
>=20
> 1/3 phase: https://pasteboard.co/H4VehON.png
> 2/3 phase: https://pasteboard.co/H4Veq8a.png
>=20
> Take a look at the bit in middle(yellow) sampled by clock(blue).
>=20
> Rising edge is almost in the middle of D0 bit.
>=20
> >=20
> > > According to scope captures above on both A20 and A33.
> > > Unfortunately I don't have other boards for the other SoCs to take ca=
ptures.
> > >=20
> > > What do you think?
> >=20
> > I guess we can make that part applicable to all SoCs, we haven't seen
> > any significant differences on those part.
>=20
> So let's keep:
> - As normal(rising edge) =3D> IO_POL_REG "0x2 =3D> 2/3 phase"
> - As inverted(falling edge) =3D> IO_POL_REG "0x0 =3D> normal phase"

I was actually thinking 1/3 for rising, 2/3 for falling.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--3h2no4wlgtkccz5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqG/dgACgkQ0rTAlCFN
r3Rh3Q/9H+/9DM+WcxqeefVe3ycjpTQbmKS83jbAVMT3Bi7v58IblhXp9Nel6xXb
Iy7S0jrzNXhLCTPJ2b5YJltpYq4Ne4iiwwzZsu5w8IeW0juepWU5J5jkgx9OV+nh
LjL45vSXMqpg3llDz79ElSnjdF6Ly3BL0EGRkpWjPdn2fQn3dyTNd1MS5t4WY1j9
OyCIrcQ0e3tqiooZTYo9dWXbgXc/i/Rx7ERc3GNAy67tVS1Ka7ZZXTi4rjCq/WBX
IJq1TIxZTeMMy9xg6n5Rex388nKQUZ9nigWhk0Do/TNmf1L4UfzuXzafb3KiIb9r
CAfpvZotcYWQPMoWPsl9sjq2PYPs5nzYa8Mr+OX/Ms/uSqrF5qM9xM0cRW6cLX/i
jcEaVZx/DUHEwvdLN5y14KdszfMOCnk34M0D2Vac37qhcrj0k5V3NsXwe3xYzyT1
3PrPHOktnty1eAzLEXj9KyDaOlPEZWeBHOYD9NdRdONsT9svZ9zNV6L+Al2GRhZm
w/SOCkjTxqkKDxfJezc+I0QKHt/VDAcauhcwEB1hChzduYTbwdNbtXCuVhKHgW/A
mieyCiYPAogp3m5VQTmHFhne3gO0MOiLQGz0QZo1zQ5+lX7q3Me/I1MXvPTS07TY
jNLaORoDEqo4WJv4vtMU+jQpqo6EkcVVdIOC1ceK6Lf5kA+1CJk=
=nyQE
-----END PGP SIGNATURE-----

--3h2no4wlgtkccz5a--
