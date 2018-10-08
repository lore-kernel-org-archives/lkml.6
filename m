Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C509C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36382087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36382087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJHOjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:39:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33031 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeJHOjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:39:20 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 88024207CC; Mon,  8 Oct 2018 09:28:58 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 42005206A2;
        Mon,  8 Oct 2018 09:28:58 +0200 (CEST)
Date:   Mon, 8 Oct 2018 09:28:58 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/6] arm64: dts: allwinner: axp803: add AC and battery
 power supplies
Message-ID: <20181008072858.kwhht67idbmevxyv@qschulz>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
 <20181006211836.28253-4-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nien25lswmkt5zkw"
Content-Disposition: inline
In-Reply-To: <20181006211836.28253-4-oskari@lemmela.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nien25lswmkt5zkw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oskari,

On Sun, Oct 07, 2018 at 12:18:33AM +0300, Oskari Lemmela wrote:
> AXP803 is compatible with AXP813. Add DT nodes ADC, GPIO,
> AC and battery power supplies.
>=20
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  arch/arm64/boot/dts/allwinner/axp803.dtsi | 31 +++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/=
dts/allwinner/axp803.dtsi
> index e5eae8bafc42..533987b2fe7a 100644
> --- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> @@ -49,6 +49,37 @@
>  	interrupt-controller;
>  	#interrupt-cells =3D <1>;
> =20
> +	axp_adc: adc {
> +		compatible =3D "x-powers,axp813-adc";
> +		#io-channel-cells =3D <1>;
> +	};
> +
> +	axp_gpio: gpio {
> +		compatible =3D "x-powers,axp813-gpio";
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
> +		gpio0_ldo: gpio0-ldo {
> +			pins =3D "GPIO0";
> +			function =3D "ldo";
> +		};
> +
> +		gpio1_ldo: gpio1-ldo {
> +			pins =3D "GPIO1";
> +			function =3D "ldo";
> +		};
> +	};
> +
> +	ac_power_supply: ac-power-supply {
> +		compatible =3D "x-powers,axp813-ac-power-supply";
> +		status =3D "disabled";
> +	};
> +

Same as the patch before, I'd put it before axp_adc.

Thanks,
Quentin

--nien25lswmkt5zkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu7BzkACgkQhLiadT7g
8aMKChAAmCqckD3HLafXfq8eWXLc6uiJjUHK42ONv78dbf9Wn7Bc06xGV9gLNCk1
swJ62e8mYD63/7BAoEl+9z1ocTWRm+RUyAZUpWh7r6PJbjmisNvrtqYjW4JYcvN+
18vHD7KTK0PstqHoULlYOLGvZpNHJ8TE7/qFuLUHXW5MymGVAgTUB21aocjRXAsn
R7wZrhIEPHr3ghEEM+K85V70jiVvXs91rcO2ctEqd5z1ZA7W3SBSfC6BK6HaNUzn
deSUoBnOsLQwwlsOY/72yALUN6jQR8EzorK0VAUEZXMJkn0x5tdy9F+ZJGlg0fpi
45ygdlyw/kG1bbTGNNHKWRqsz778b6DoEbBadMdRDd/ZCwcWm1fRvDYATgJTBvht
9i7/R80Fdf7s8ix2zLn/8ZIQi2t74w+RksoxMHej67uOlOyGug67MAV27Q2RPMJk
TFzylNi0tKq9HENdWKIOHtWwp6qtSDYJZxU52kmEJLxMY8oCujxeWRflBZApYbh1
3m7GV8JTfQs/heDaz3E4npG6DJpMXArrXKz7Q/3Ys2ft9fezk4esUMnCPedyzgIH
WijPr+etjSg2WGEKIq76/K+wEQc4NN0rHeLgm162xP5MFp/cOWCpyVb5ZwVRPsf8
gmwqNvnJXY9ADm8XrQl34av5RAxt+ssceffN09iV3DAcSSR3p50=
=wwHW
-----END PGP SIGNATURE-----

--nien25lswmkt5zkw--
