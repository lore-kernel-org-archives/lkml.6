Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755365AbeDCKtM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:49:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54666 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754906AbeDCKtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:49:10 -0400
Date: Tue, 3 Apr 2018 12:49:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCHv4 08/10] backlight: add TI LMU backlight driver
Message-ID: <20180403104908.GD6758@amd>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
 <20180330172414.26575-9-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
In-Reply-To: <20180330172414.26575-9-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +enum ti_lmu_bl_type {
> +	TI_LMU_BL,  /* backlight userspace interface */
> +	TI_LMU_LED, /* led userspace interface */
> +};
=2E..
> +static int ti_lmu_bl_add_device(struct ti_lmu_bank *lmu_bank)
> +{
> +	switch (lmu_bank->type) {
> +	case TI_LMU_BL:
> +		return ti_lmu_bl_register_backlight(lmu_bank);
> +	case TI_LMU_LED:
> +		return ti_lmu_bl_register_led(lmu_bank);
> +	default:
> +		return -EINVAL;
> +	}
> +}

Ok, this is somehow unusual/crazy. Single driver with two interfaces.

Do we need the LED interface for something?

If yes, I believe reasonable solution would be to always provide LED
interface, and then have "backlight-trigger" which that would provide
backlight interface for arbitrary LED.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrDXCQACgkQMOfwapXb+vKrxACgoI+6g+Ywup+P74KrVtsW0uRh
reIAoKNWQS+kZ6NN/TSqi3yN1o0Jwc5b
=gQ0H
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
