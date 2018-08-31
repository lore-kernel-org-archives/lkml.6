Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA46C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C9220837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C9220837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeHaNUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:20:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34090 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727292AbeHaNUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:20:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 73A8C207EB; Fri, 31 Aug 2018 11:14:06 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 45ADF203EC;
        Fri, 31 Aug 2018 11:14:06 +0200 (CEST)
Date:   Fri, 31 Aug 2018 11:14:05 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 25/30] ARM: dts: sun8i: h3: add thermal zone to H3
Message-ID: <20180831091405.qr5daepgmx3otq7m@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-26-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dnpyaz3qnlascrvt"
Content-Disposition: inline
In-Reply-To: <20180830154518.29507-26-embed3d@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dnpyaz3qnlascrvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 05:45:13PM +0200, Philipp Rossak wrote:
> This patch adds the thermal zones to the H3. We have only one sensor and
> that is placed in the cpu.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi    | 31 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi |  1 +
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3=
=2Edtsi
> index 5b7994cb1471..954848d5df50 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -78,6 +78,8 @@
>  			clock-names =3D "cpu";
>  			operating-points-v2 =3D <&cpu0_opp_table>;
>  			#cooling-cells =3D <2>;
> +			cooling-min-level =3D <0>;
> +			cooling-max-level =3D <15>;
>  		};
> =20
>  		cpu@1 {
> @@ -102,6 +104,35 @@
>  		};
>  	};
> =20
> +	thermal-zones {
> +		cpu-thermal {
> +			/* milliseconds */
> +			polling-delay-passive =3D <250>;
> +			polling-delay =3D <1000>;
> +			thermal-sensors =3D <&ths>;
> +
> +			trips {
> +				cpu_hot_trip: cpu-warm {
> +					temperature =3D <65000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +				cpu_very_hot_trip: cpu-very-hot {
> +					temperature =3D <90000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +			};

Where are those trip points coming from?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--dnpyaz3qnlascrvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluJBtwACgkQ0rTAlCFN
r3SnNxAAmg0ZB4SNncuiVkqxlSb5M2cgBcDualedWaHYl8ulFLZ/kHaMkc9Dq8Jx
ZoCEHNDFB3W95LZptUYD6E5JfRXEmUhig9wzlqFeylEfDA3TjhmbGVVSk2Y58Ges
A6+y0tm1ep5To5xBdwkEKtnssTHTHLUmXlmhfEETYYcwHGqtxZIb55N9usA8fmMa
2CNOPS1Sx5iGqk7SmJfD83aof5xFbvRlnjGn3sreUsKGlRwwaGpEAeZVYKoNBQTI
kCIdSe9IOoHEN6YJedsHf99u+zzO2XiPcLGfNVOlDp0Bl0ecxUMsVVr9WkeMYDP4
R0eWmx9+aTH0omKdximy/BeLgnEP64bj4ittOKPPE/lIK0Sr5meOMa3TQwhTTn4B
NRjEvFrnD/ueZuOXj8HjBO3xmkF3sw4hnbO9WGDPdAYvhrNBvaRbcPewLIt+swZ1
2S4cknf2qoTew3AGD37qG0OAWDO7bQUGNmxFoCgI9ksaXt7vY3tJSbzqaSseJrtu
MLNH/sgCcfQ7X+l49vY5uKFCz3nDJS5BMPp4qRx8PA2UGTv7CCyC0f0Kmh489KNJ
HKjZ9fUxdetJMDfa1Oooia/TDaKNY9+a+PFLWGhAuJofiW8oHPhVauYOc0339mVx
F11t4kDtUfSthBCSZs3Ovb8OhnK86yNkKBRDDioXxBcW6MXU4J4=
=aaav
-----END PGP SIGNATURE-----

--dnpyaz3qnlascrvt--
