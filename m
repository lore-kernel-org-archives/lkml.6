Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeDSLWn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 07:22:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51472 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbeDSLWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 07:22:42 -0400
Date: Thu, 19 Apr 2018 12:22:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [BUG] NULL pointer on next-20180419 on Odroid XU3
 (snd_soc_register_card)
Message-ID: <20180419112232.GB27188@sirena.org.uk>
References: <CAJKOXPd-+jp99p=5MsCa=68TNSJk57+drcFgUr2Y1rWW3RPbSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <CAJKOXPd-+jp99p=5MsCa=68TNSJk57+drcFgUr2Y1rWW3RPbSA@mail.gmail.com>
X-Cookie: We've upped our standards, so up yours!
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 09:08:07AM +0200, Krzysztof Kozlowski wrote:

> On today's next-20180419, NULL pointer exception appeared in
> snd_soc_instantiate_card() on Odroid XU3 and XU boards (Samsung,
> Exynos5422, Exynos5410, max98090 codec). Built with exynos_defconfig
> (ARM).

> I bisected it to:
> 45f8cb57da0d7a9ead4b39d7f5def333a5b0c08b is the first bad commit
> commit 45f8cb57da0d7a9ead4b39d7f5def333a5b0c08b
> Author: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Date:   Tue Mar 27 14:30:40 2018 +0100
>=20
>     ASoC: core: Allow topology to override machine driver FE DAI link con=
fig.

OK, reverting this one as well for now along with f11a5c27f9287 "ASoC:
core: Add name prefix for machines with topology rewrites" which depends
on it :(

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrYe/cACgkQJNaLcl1U
h9B76gf9HlWxBpQgKJSERvvphkwHewaLd2GMKeK+9jQtL3CelbLKeJgs4BKKPj3S
iCcYpC+wTumtc/xV41okaOZLalAKDRR+Skhrjb94RDKK4wmFFB9sFRqxAEMK6yF4
baQJ0gyKB35kIdsBFuc/zUXD4rm8icOCiEuivvz8dgFE6uHVRdeOYlq8deqde+6G
dQ11do0uEQNBMvTvKE3cQP/Dlq4MFz29k0VjD0/zNTo7RqBBWAHBuO+eVSTEHB1D
JzjsJxDqG7qlqniqpHjt//7yGuMpXp/g0JpzGAkSUtceqp2x1OyLI6w4w9+feRaQ
F3KvpNdhBuLrKW4/M08tc0FWRS2Huw==
=R69U
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
