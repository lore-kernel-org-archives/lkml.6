Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58696C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9E92133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9E92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeLEWDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:03:45 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51554 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeLEWDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:03:44 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9440126A028
Received: by earth.universe (Postfix, from userid 1000)
        id 16CA53C08D6; Wed,  5 Dec 2018 23:03:40 +0100 (CET)
Date:   Wed, 5 Dec 2018 23:03:40 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, Heiko Stuebner <heiko.stuebner@bq.com>
Subject: Re: [PATCH v2] power: supply: bq24190_charger: add support for
 bq24196 variant
Message-ID: <20181205220340.soejl65puivnwhz7@earth.universe>
References: <20181113124753.29948-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="djcjq7k5hkgqkwzd"
Content-Disposition: inline
In-Reply-To: <20181113124753.29948-1-heiko@sntech.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--djcjq7k5hkgqkwzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 13, 2018 at 01:47:53PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
>=20
> The bq24196 is another variant of the bq24190 charger ic.
> Its register set is identical to the bq24192 and it even reuses
> the same part number (0x5).
>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> ---

Thanks, queued.

-- Sebastian

> This should go on top of the bq24192 support patches from Brian Masney /
> Jonathan Marek [0]
>=20
> [0] https://patchwork.kernel.org/patch/10663409/
>=20
> changes in v2:
> - add missing compatible to dt-binding
>=20
>  Documentation/devicetree/bindings/power/supply/bq24190.txt | 1 +
>  drivers/power/supply/bq24190_charger.c                     | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.txt b=
/Documentation/devicetree/bindings/power/supply/bq24190.txt
> index c8ac028bd3c7..ffe2be408bb6 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq24190.txt
> +++ b/Documentation/devicetree/bindings/power/supply/bq24190.txt
> @@ -5,6 +5,7 @@ Required properties:
>      * "ti,bq24190"
>      * "ti,bq24192"
>      * "ti,bq24192i"
> +    * "ti,bq24196"
>  - reg: integer, I2C address of the charger.
>  - interrupts[-extended]: configuration for charger INT pin.
> =20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 4e64e6ac95c5..effa7c3c21e6 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -143,7 +143,7 @@
>  #define BQ24190_REG_VPRS_PN_MASK		(BIT(5) | BIT(4) | BIT(3))
>  #define BQ24190_REG_VPRS_PN_SHIFT		3
>  #define BQ24190_REG_VPRS_PN_24190			0x4
> -#define BQ24190_REG_VPRS_PN_24192			0x5 /* Also 24193 */
> +#define BQ24190_REG_VPRS_PN_24192			0x5 /* Also 24193, 24196 */
>  #define BQ24190_REG_VPRS_PN_24192I			0x3
>  #define BQ24190_REG_VPRS_TS_PROFILE_MASK	BIT(2)
>  #define BQ24190_REG_VPRS_TS_PROFILE_SHIFT	2
> @@ -1973,6 +1973,7 @@ static const struct i2c_device_id bq24190_i2c_ids[]=
 =3D {
>  	{ "bq24190" },
>  	{ "bq24192" },
>  	{ "bq24192i" },
> +	{ "bq24196" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
> @@ -1982,6 +1983,7 @@ static const struct of_device_id bq24190_of_match[]=
 =3D {
>  	{ .compatible =3D "ti,bq24190", },
>  	{ .compatible =3D "ti,bq24192", },
>  	{ .compatible =3D "ti,bq24192i", },
> +	{ .compatible =3D "ti,bq24196", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, bq24190_of_match);
> --=20
> 2.18.0
>=20

--djcjq7k5hkgqkwzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwISzsACgkQ2O7X88g7
+pp9MA/9GEAMpunDV0xEdz9AtlAi76d7vg9nJYtONi1lKe65JJaPTWnZq2O2sl+r
6aDZ/z3O68iZDN8AoFtVLijXNNNnN2Y6K3hEJQt6XxSNUE5NI4upeis/uFhbpreU
0mThrwHyhlHJ0jzGAakKHNmj92LAcle7hMj9hd0znbYy5bLWi6K2rfT0D8g+dR08
sbwwunnIK0VAvHutmcBjwvduoglyn0wCSCqYOqyKx8VZvU7Ii2Of8/Y8bK53VHbE
O3vu2f/KFdkEwWjdGzGh2JSkiqGnv6txTxRtcFPwSXKTTpofciRK4cnsx9FNZsa+
6T6+k4FeGHgL0X2uw9FrVsXeO+jxkKIIRsjl6F05FbpIw41HBgvhL1IBOD84R0s3
uZIeVKz2zk1TOqDlLYCzqQackSmeMMIBJxfXD7fTkSPyvoX3Bql/CUHFUkhyLiPa
pJ6hp1lGqhOA3y1RASxEFwtQs36BhwgkQiJ/EkYeLFAEjGhTs6nYMhDf8Bfn1syf
d9jitXPPDAougC2Ad+GNYghbUmK5f0VjULxTDw092A8oQsBtzTui9kuNYrtfhPwP
ho/5QpScPdRJTrwhszhd7Bpn3FrM3afzsmdHFtEHgTiHeQHN2QOPYfvnjlUoS+jn
+BNVEUdBmAyer2uAHJ05XzwLzCEam9CPjo3L5IZHf0xl1D32xLc=
=4VUa
-----END PGP SIGNATURE-----

--djcjq7k5hkgqkwzd--
