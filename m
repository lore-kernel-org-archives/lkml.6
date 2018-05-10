Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935364AbeEJL2L (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 07:28:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58172 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeEJL2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 07:28:09 -0400
Date: Thu, 10 May 2018 13:28:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dan Murphy <dmurphy@ti.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt: bindings: lm3601x: Introduce the lm3601x
 driver
Message-ID: <20180510112807.GF6977@amd>
References: <20180508141704.24271-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pyE8wggRBhVBcj8z"
Content-Disposition: inline
In-Reply-To: <20180508141704.24271-1-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pyE8wggRBhVBcj8z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-05-08 09:17:03, Dan Murphy wrote:
> Introduce the device tree bindings for the lm3601x
> family of LED torch, flash and IR drivers.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>=20
> v2 - No changes - https://patchwork.kernel.org/patch/10384587/
>=20
>  .../devicetree/bindings/leds/leds-lm3601x.txt | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3601x.t=
xt
>=20
> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt b/Do=
cumentation/devicetree/bindings/leds/leds-lm3601x.txt
> new file mode 100644
> index 000000000000..38cdabf6ca7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
> @@ -0,0 +1,51 @@
> +* Texas Instruments - lm3601x Single-LED Flash Driver
> +
> +The LM3601X are ultra-small LED flash drivers that
> +provides a high level of adjustability.

"provide".

> +Required properties:
> +	- compatible : Can be one of the following
> +		"ti,lm3601x"
> +		"ti,lm36010"
> +		"ti,lm36011"
> +	- reg : I2C slave address
> +	- #address-cells : 1
> +	- #size-cells : 0
> +
> +Required child properties:
> +	- reg : 0 - Indicates to support and register a torch interface
> +		1 - Indicates to support and register a strobe interface
> +		2 - Indicates to support and register an ir interface

I'd delete "to support and register" -- we are describing hardware here.

> +Optional child properties:
> +	- label : see Documentation/devicetree/bindings/leds/common.txt
> +
> +Example:
> +led-controller@64 {
> +	compatible =3D "ti,lm3601x";
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	reg =3D <0x64>;
> +
> +	led@0 {
> +		reg =3D <0>;
> +		label =3D "white:torch";
> +		led-max-microamp=3D<10000>;
> +	};
> +
> +	led@1 {
> +		reg =3D <1>;
> +		label =3D "white:strobe";
> +		flash-max-microamp=3D<10000>;
> +		flash-max-timeout-us=3D<800>;
> +	};
> +
> +	led@2 {
> +		reg =3D <2>;
> +		label =3D "invisible:ir";
> +	};
> +}

Title says this is single-LED driver chip, but it controls three chips
in this example?

I'd put " " around "=3D" for consistency.

We use "flash" elsewhere, I'd replace "strobe" with that. Userspace
would like consistency, too.

What is the IR led good for? Taking videos in the dark?

I guess for consistency, it is "ir:torch" :-).

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pyE8wggRBhVBcj8z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlr0LMcACgkQMOfwapXb+vI1igCfR3PBrzknyo2zuV5qghdEPA9j
bZUAoIDk6ULSlOTimfVCCCsVoA+hZga/
=kSWL
-----END PGP SIGNATURE-----

--pyE8wggRBhVBcj8z--
