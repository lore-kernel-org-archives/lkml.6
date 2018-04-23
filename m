Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755863AbeDWPiA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:38:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37082 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755506AbeDWPh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:37:57 -0400
Date: Mon, 23 Apr 2018 16:37:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz,
        tiwai@suse.com, dannenberg@ti.com, afd@ti.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ASoC: tas6424: Add support for the mute pin
Message-ID: <20180423153746.GJ19834@sirena.org.uk>
References: <1524218684-19752-1-git-send-email-jjhiblot@ti.com>
 <1524218684-19752-4-git-send-email-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n8884J15jRwcBTvu"
Content-Disposition: inline
In-Reply-To: <1524218684-19752-4-git-send-email-jjhiblot@ti.com>
X-Cookie: I think, therefore I am... I think.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8884J15jRwcBTvu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2018 at 12:04:44PM +0200, Jean-Jacques Hiblot wrote:

> +	- mute-gpio: GPIO used to mute all the outputs

Same thing with the plural here.

> +	if (tas6424->mute_gpio) {
> +		gpiod_set_value_cansleep(tas6424->mute_gpio, mute ? 1 : 0);
> +		return 0;
> +	}

Just use mute directly, the ternery operator is doing nothing for
legibility here and C does the integer to boolean thing for you.

> +	if (tas6424->mute_gpio) {
> +		gpiod_set_value_cansleep(tas6424->mute_gpio, 0);
> +		/*
> +		 * channels are muted via the mute pin, don't also. Don't also
> +		 * mute them via the registers so that subsequent register
> +		 * access is not necessary to un-mute the channels

Extra "don't also" in there.

--n8884J15jRwcBTvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrd/ckACgkQJNaLcl1U
h9DP7Qf+LcNLKDMaaEDioJluhqvPyFi/YfQF0mjrwrKRtQa/b4BPRVOA8HCqP0N8
Tc+Ao+VGQsaTvdkgVhE94uhuEGhebfEIug0dhHeudybwwBkCuw7dWJ/nBwFvmA9n
OY5W1KbvUAxNx4wUGICnehJ6Rm4yaY7CAMuoGVbybmfmSju3TRvTZBasK+YagtAv
oSzDsaF6vFDbOTnyUBkEzEOPLsMYoxqVGbTo232cFZvAKAJB8susvIr42FiPGCwF
3pJJr4VZKIfXpemRasRlr6nQw5Caeniw2HkSO1b+2jTwdyBuc8nJkib/nqZi0hND
d9MSRkr4KKZ3auawy6pbiv8jTejqyg==
=Plkg
-----END PGP SIGNATURE-----

--n8884J15jRwcBTvu--
