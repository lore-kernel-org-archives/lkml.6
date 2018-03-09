Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932138AbeCIMu7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:50:59 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50104 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeCIMu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:50:58 -0500
Date: Fri, 9 Mar 2018 12:50:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Takashi Iwai <tiwai@suse.com>, Pavel Machek <pavel@ucw.cz>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-core: Add missing NULL check
Message-ID: <20180309125050.GD5252@sirena.org.uk>
References: <20180308200653.GA47801@beast>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <20180308200653.GA47801@beast>
X-Cookie: Beam me up, Scotty!
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2018 at 12:06:53PM -0800, Kees Cook wrote:

> If a codec is not attached to the sound soc, a NULL deref is possible as a
> regular user in /sys.

I can't parse this, sorry.  What is the "sound soc"?

> +++ b/sound/soc/soc-core.c
> @@ -137,6 +137,9 @@ static ssize_t soc_codec_reg_show(struct snd_soc_code=
c *codec, char *buf,
>  	size_t total =3D 0;
>  	loff_t p =3D 0;
> =20
> +	if (!codec || !codec->driver)
> +		return 0;
> +

How are we managing to create a sysfs file for a CODEC which doesn't
have a CODEC struct associated with it?  That is obviously nonsensical
and suggests we've got some more serious problem going on here - if
there's no CODEC those sysfs attributes simply shouldn't be there.

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqigyoACgkQJNaLcl1U
h9DiVQf/X7ZSftcm7/aW6N5+2aqS/gdxfYU4v8jETHcyr6Lqq/DR+/B7qv149I7i
k5fjo/RSG7lb7nKZZc8Bqa6NnO+6YyTVWGMQrW5pwYHKbFCTY/13yDZhUQiYuQuX
wBQfoA1wXCtHU2Q+JimDZXcR3FoFv5C68i9AhL0Rvd53oWeqSFPgFYJL4fkapYtY
DAih4xg3Ho+1ZUKJpzpGJ2fUQNy6EYyDr3lYEMxIC9TeV7V7WORgzX65o65Bb6wS
WeSAZx9izRZhdX7xYo+VRtjcslmMY5ZabegSrrR+wOwVqx5JIBok9ISymi85lz5J
hwqQMOh9/kZZwxA4lknhFXXVtganEA==
=/0cK
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
