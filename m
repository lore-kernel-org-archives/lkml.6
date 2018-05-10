Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeEJSyE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:54:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42722 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbeEJSyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:54:03 -0400
Date: Thu, 10 May 2018 20:54:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dan Murphy <dmurphy@ti.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, jacek.anaszewski@gmail.com,
        afd@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt: bindings: lm3601x: Introduce the lm3601x
 driver
Message-ID: <20180510185401.GB12846@amd>
References: <20180510174717.26540-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <20180510174717.26540-1-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Introduce the device tree bindings for the lm3601x
> family of LED torch, flash and IR drivers.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Better, thanks.
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
> @@ -0,0 +1,50 @@
> +* Texas Instruments - lm3601x Single-LED Flash Driver

Ok, so is it single-LED driver, or can it driver ir & white LEDs at
the same time?

> +Example:
> +led-controller@64 {
> +	compatible =3D "ti,lm36010";
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	reg =3D <0x64>;
> +
> +	led@0 {
> +		reg =3D <0>;
> +		label =3D "white:torch";
> +		led-max-microamp =3D <10000>;
> +	};
> +
> +	led@1 {
> +		reg =3D <1>;
> +		label =3D "white:flash";
> +		flash-max-microamp =3D <10000>;
> +		flash-max-timeout-us =3D <800>;
> +	};

Is this realistic config? I'd expect flash to use more power than
torch, and would expect longer timeout than 0.8msec.

Also.. if this is physically one white LED, it should not be
spread over reg =3D <0> and reg =3D <1>...

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlr0lUkACgkQMOfwapXb+vJg4gCfQUnlmBYBsVn6YVgXLouAy2GT
jp0Amwf+o18z7hJWY+C02tv68/w1Xzfg
=wUOK
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
