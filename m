Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE73CC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED652591F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED652591F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966556AbeF0UIZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:08:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51821 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965695AbeF0UIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:08:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 04A48206DE; Wed, 27 Jun 2018 22:08:22 +0200 (CEST)
Received: from localhost (unknown [88.128.82.6])
        by mail.bootlin.com (Postfix) with ESMTPSA id B9CB1203B0;
        Wed, 27 Jun 2018 22:08:11 +0200 (CEST)
Date:   Wed, 27 Jun 2018 22:08:12 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Qiang Yu <yuq825@gmail.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH] ARM: dts: sun8i-h3: Increase the GPU clock to 576 MHz
Message-ID: <20180627200812.usm5ndoyrnmuhjrv@flea>
References: <20180627072635.3592-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zd3omamzv4izpv2n"
Content-Disposition: inline
In-Reply-To: <20180627072635.3592-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zd3omamzv4izpv2n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2018 at 09:26:35AM +0200, Paul Kocialkowski wrote:
> It was reported (based on declarations from the Allwiner BSP) that the
> Mali 400 found on the H3 can be clocked up to 576 MHz.
>=20
> The frequency was tested using the r6p2 out-of-tree driver and a Kodi
> userspace with associated r6p2 blobs, leading to a working result.
>=20
> This increases the clock to 576 MHz, which directly increases the pixel
> throughput of the GPU (given the 1 pixel-per-cycle rate).
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3=
=2Edtsi
> index 41d57c76f290..a14a63092dc6 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -133,7 +133,7 @@
>  			resets =3D <&ccu RST_BUS_GPU>;
> =20
>  			assigned-clocks =3D <&ccu CLK_GPU>;
> -			assigned-clock-rates =3D <384000000>;
> +			assigned-clock-rates =3D <576000000>;

This should really be fixed through the driver or through OPPs,
instead of just coding it here and hoping that it will remain set to
that rate.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--zd3omamzv4izpv2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsz7qsACgkQ0rTAlCFN
r3RdgxAAkWKTa+r1/vIOAUmyphIKpLXUNnwslbq3r7DW23gaheX/Ku7QSnU4ljyR
lB5XV6/Um3j3s7sW6tByzJzTwbuBl9WY/+k19ldpUmvSaLCl5W+IXd23U2EUiqPA
4hXZ1GRZWn0MeHlHh6UYiGS2wttYvKlVpH/nenD7XC3+GGInK4fjIZ/tD9nwAArb
uklP93qp3H48UPMdHbw75ZPGrKfKoP67fdiVKaAiR1BIixJXPyKjxN8EZjjcEGXb
3x6h3QakYO/v6NRvhetFj/WIee9TeOzQtV9x4LvmA77fCBKpkaq4RS1VEMlFa2bU
SdenEEfZnjgmHMmAPnY69EU7apPRU/OEg3d/0Hkqf1yeE0bPE6vnOOrz5hdCiTkS
LQphVeF8KefuaVZBSn4ekuFv7awZfRyR86R3bflmXcv6dBkIdb4aC8cB/HCKx300
85u4lH/CJpD9kBTxY9z03trhmj2uQesf6zYeZIZI1e07Q4xTCEs9Fxvnhf+AruHD
595ddKFyyGTfSQDhAe5UK/EXwl8U84MKO1z/4RcvSvVZ8zoct3TDNTOocRL69qu8
mm32CKY3Bzz2FPgMsTPuIg952zIgxYmzJCWaFNq3L9UpnG/lY8BCG7C63JXA3xNO
tC/1E3UazUjfGk0nP3F3fa6Qvs8IKSUz6Q863YSnrYDdz09pLtw=
=yFpg
-----END PGP SIGNATURE-----

--zd3omamzv4izpv2n--
