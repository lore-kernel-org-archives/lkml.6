Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422826AbeCBMlG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:41:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33072 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034295AbeCBMlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:41:03 -0500
Date: Fri, 2 Mar 2018 12:40:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc: kuninori.morimoto.gx@renesas.com, maxime.ripard@free-electrons.com,
        wens@csie.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [BUG] Kernel crash on Allwinner H3 due to sound core changes
Message-ID: <20180302124050.GF6255@sirena.org.uk>
References: <2424862.oPtAVTfrB9@jernej-laptop>
 <63331816.68OamKINx1@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Content-Disposition: inline
In-Reply-To: <63331816.68OamKINx1@jernej-laptop>
X-Cookie: He who laughs last didn't get the joke.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 11:23:57PM +0100, Jernej =C5=A0krabec wrote:

> I removed parts of the code from the sun4i codec driver and interestingly=
 it=20
> doesn't crash if I remove following lines:

> ret =3D devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
> if (ret) {
> 	dev_err(&pdev->dev, "Failed to register against DMAEngine\n");
> 	goto err_assert_reset;
> }

> Is it possible that NULL pointer causes troubles somewhere down the line?

Shouldn't be, that's just the configuration which is optional and not
what we're crashing trying to register, we can mostly configure things
by querying the capabilities of the DMA controller via the dmaengine API
these days.  You're removing all the DMA support there so cutting out a
huge segment of the initialization of both this driver and the machine
driver.  Other sunxi devices seem to be starting happily in -next so
there's something system dependent here...

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqZRlEACgkQJNaLcl1U
h9BgIgf/Q3GZOlQCfAnUF4m/v9NaH4QxNM0OA/bgzS8qZecbkX1umIBvadiVvQk2
5iUAggTvZY64JxScseXyAkR2/KnzUcrzn3wCzA+7tRbuHzAliU3hLw4ZKjJPjhPP
3MJ6D1S4OXijQBQV6ASWXU7D1IEWucfCo57SY1BVwCVuCXOy1UQixQrrRWbDG76e
Epe/i0ZFTxzI2+v2xJF2b3JKf0KaIUKFeVOYo5XtGBMqPjyDJcaIIg9xyBt5Oz63
e9zNDJ+7zQ/ydK0eGNLKCB4GvPTKGFkddbgArI9GJnfrb4fEzaavaqif+4ub5qm1
0F+GgKNInRSl0+f0HaDQorBPVNHf9A==
=6y1d
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--
