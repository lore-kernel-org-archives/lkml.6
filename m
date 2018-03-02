Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424806AbeCBOht (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:37:49 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34148 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424605AbeCBOhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:37:48 -0500
Date: Fri, 2 Mar 2018 15:37:36 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/sun4i: add lvds mode_valid function
Message-ID: <20180302143736.kkxx54og2ppcmpzh@flea.lan>
References: <1519840432-61489-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1519840432-61489-2-git-send-email-giulio.benetti@micronovasrl.com>
 <20180301095721.4iga7dcgg566j44m@flea>
 <ebe7cfe5-e731-10cf-17cd-fe79bee0fdc4@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t5i6yb5trfttukcl"
Content-Disposition: inline
In-Reply-To: <ebe7cfe5-e731-10cf-17cd-fe79bee0fdc4@micronovasrl.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t5i6yb5trfttukcl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 12:42:14PM +0100, Giulio Benetti wrote:
> Hi,
>=20
> Il 01/03/2018 10:57, Maxime Ripard ha scritto:
> > On Wed, Feb 28, 2018 at 06:53:52PM +0100, Giulio Benetti wrote:
> > >   static struct drm_connector_helper_funcs sun4i_lvds_con_helper_func=
s =3D {
> > >   	.get_modes	=3D sun4i_lvds_get_modes,
> > > +	.mode_valid	=3D sun4i_lvds_mode_valid,
> > >   };
> >=20
> > This should be on the encoder, not the connector.
>=20
> I've seen it is bound to connector in rgb and to encoder in hdmi.
> Is it correct rgb mode_valid under connector funcs?
> Otherwise I send a patch also for that one.

This would need to be fixed as well. Bridges attach to encoder, not
connectors, so if you ever have a bridge connected to the RGB output
(like on the A13-Olinuxino), mode_valid isn't called at the moment.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--t5i6yb5trfttukcl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqZYa8ACgkQ0rTAlCFN
r3Q1GQ//Q9/viLpoCbU8KGqwIspUtP4HKMX5ly6O6f6dk0zNJRfDLsYZaEG8RddL
usJk3OzvBN2t+XgRDcM8M2k6/hVClcCsgBzp5XkcVI9s9r2eCnDZBl6BPhp+EA7G
eWD4vjIm/uWuylAElD3lOjEJ/tMXp5atQHCF9fM4X5RTfAQpJndtHFUYHd93BwaG
E7JXjge+T8eQBd8dYfLh47cn7umbMoNE9adDy9nFH6V80lG35lIDcT54ehSGfjVD
IQb1AAVRQyd8nLqHV/DArAKDnJizpbfYQEUPO1HHLeV0X9GYrWXo6AJhH152ntPQ
BDYy2HJZQUQk/cTVTZixbatM4JR2sMBVZ7dLmtlfsqWHvyEAOGSvpK1M0aKqnEzl
UwCGHi6NH/JgjGrx1s4P9FZnli6B6BcQ22HPfBrAfWufSUZYGZ6YDMguQyrGJ7JR
GlORF0yFPvmwt88QCPvBBllQ1lHHpKh2NFprAbyxFCbmGZ8HHKRhtrI7I9E8Xdam
dJOWr36W3TyQO0BHmRP6BBohbYWastboXdB8HVFdJtP57xwwk3YXMpCPJMovJw4K
/TQwswtWTXJo5paJMicFa65sW8xNfFWsUUZs32lfKmIs7b4slyPfN1s8j/dvXjIW
G4Wiki3Nzcg7NEpVXmpxs8sSa8kNWbKz3io9B3qfuoammzCXOpc=
=zBQJ
-----END PGP SIGNATURE-----

--t5i6yb5trfttukcl--
