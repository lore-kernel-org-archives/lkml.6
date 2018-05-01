Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755633AbeEAMpp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 08:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755229AbeEAMpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 08:45:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE6C22DC2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Tue, 1 May 2018 14:45:40 +0200
From: Sebastian Reichel <sre@kernel.org>
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: mfd: max8998: Add charger subnode
 binding
Message-ID: <20180501124540.3icpjevaxp44ew2e@earth.universe>
References: <1524844982-4714-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1524844982-4714-5-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wwovjhgx53obeehm"
Content-Disposition: inline
In-Reply-To: <1524844982-4714-5-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wwovjhgx53obeehm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 27, 2018 at 06:03:02PM +0200, Pawe=C5=82 Chmiel wrote:
> This patch adds devicetree bindings documentation for
> battery charging controller as the subnode of MAX8998 PMIC.
> It's based on current behavior of driver.
>=20
> Fixes: ee999fb3f17f ("mfd: max8998: Add support for Device Tree")
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/max8998.txt | 22 +++++++++++++++++=
+++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Document=
ation/devicetree/bindings/mfd/max8998.txt
> index 23a3650ff2a2..f95610afb57f 100644
> --- a/Documentation/devicetree/bindings/mfd/max8998.txt
> +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
> @@ -50,6 +50,21 @@ Additional properties required if max8998,pmic-buck2-d=
vs-gpio is defined:
>  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in microv=
olts
>    for buck2 regulator that can be selected using dvs gpio.
> =20
> +Charger: Configuration for battery charging controller should be added
> +inside a child node named 'charger'.
> +  Required properties:
> +  - max8998,charge-eoc: Setup "End of Charge". If value equals 0,
> +    remain value set from bootloader or default value will be used.
> +    Valid values: 0, 10 - 45
> +
> +  - max8998,charge-restart: Setup "Charge Restart Level". If value equal=
s 0,
> +    remain value set from bootloader or default value will be used.
> +    Valid values: -1, 0, 100, 150, 200
> +
> +  - max8998,charge-timeout: Setup "Charge Full Timeout". If value equals=
 0,
> +    remain value set from bootloader or default value will be used.
> +    Valid values: -1, 0, 5, 6, 7

What are those values? seconds?

> +
>  Regulators: All the regulators of MAX8998 to be instantiated shall be
>  listed in a child node named 'regulators'. Each regulator is represented
>  by a child node of the 'regulators' node.
> @@ -99,6 +114,13 @@ Example:
>  		max8998,pmic-buck2-dvs-gpio =3D <&gpx0 0 3 0 0>; /* SET3 */
>  		max8998,pmic-buck2-dvs-voltage =3D <1350000>, <1300000>;
> =20
> +		/* Charger configuration */
> +		charger {
> +			max8998,charge-eoc =3D <0>;
> +			max8998,charge-restart =3D <(-1)>;
> +			max8998,charge-timeout =3D <7>;
> +		};
> +
>  		/* Regulators to instantiate */
>  		regulators {
>  			ldo2_reg: LDO2 {
> --=20
> 2.7.4
>=20

--wwovjhgx53obeehm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlroYXQACgkQ2O7X88g7
+pr1AQ/6A1S8l6YS2U74zbBTOpiO3Lt1Q0OYZf8fWH4OQP8W2BXR35/Ew35A0ggD
gZpd2Zd5gZfm2AEzn6HNeTnDKl1Af0cZwF2ZkP6KM39f4Xm/F1EUytiCLgIZV6RW
fR0ibhuVNgWybwv5VkPz+dQt7sPWBidz9Ekvsf5xo2OauV394Xo1Q29RtopfytSn
FtjQrU++yQ7qals/RlNf6RTd5O6CAnGlkG52JtftIG7tDH4ArH0zng7JVXv75nxh
j09+TtkUbVqpaAQon0Y2tB7FSrfHI4znxIC20MyZv9hukP2cPtk4Xh3OnQ+i+0pe
p9scjUPRQ0x1ZYMIy/APIlTSC4985aJNV2D6JvJPpwWvgZeoDqlHjT7FTpu3cu0D
yQdFWDAuexYmdLPdhCTx/7+3Kekjm1+LV3k9eR5gWFvyI5OyLpJtu+EwO4LC6N44
q16q+hCzw/Uy7UL1lCtixfqJALiR1h3weFhxUQlp9rJ1o8X8iesI0bKL+twJMB6u
2el4m8Tq5jboH5Uy2IgZve1HW7EcTFqOYjqJupda1ohrNIpLMrVawe7Dl5Ij2F9z
u8H4zBlXBzfzRiSX6Rg/LaasLT8b5aV79CiKj39Z5A/QObiVQUWECvkzla2uMp+H
hNSdnD1+8ZqjnamMJ2c2LRP3i9njdDclyWPOSdtZ2g9opAIL+o0=
=ryrZ
-----END PGP SIGNATURE-----

--wwovjhgx53obeehm--
