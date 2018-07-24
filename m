Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE0FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C6620856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C6620856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbeGXN6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:58:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59300 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388280AbeGXN6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:58:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A19EA20737; Tue, 24 Jul 2018 14:52:01 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 68CF4207B0;
        Tue, 24 Jul 2018 14:51:51 +0200 (CEST)
Date:   Tue, 24 Jul 2018 14:51:51 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Akash Gajjar <gajjar04akash@gmail.com>
Cc:     icenowy@aosc.xyz, Akash Gajjar <Akash_Gajjar@mentor.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: activate spi flash on pine64 LTS board
Message-ID: <20180724125151.plhn5g3x37ah62xu@flea>
References: <Akash_Gajjar@mentor.com>
 <1532274409-9921-1-git-send-email-Akash_Gajjar@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="73kd7dr4snfa6aze"
Content-Disposition: inline
In-Reply-To: <1532274409-9921-1-git-send-email-Akash_Gajjar@mentor.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--73kd7dr4snfa6aze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sun, Jul 22, 2018 at 09:16:49PM +0530, Akash Gajjar wrote:
> This board has a 128M SPI flash. add spi flash support in device tree.
>=20
> Tested on pine64 LTS.
>=20
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>

The author email should match the one in the SoB, and the prefix of
your commit title should be "arm64: dts: allwinner: ..."

> ---
>  .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  | 23 ++++++++++++++++=
++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dt=
s b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> index abe179d..d54637d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> @@ -134,6 +134,29 @@
>  	regulator-name =3D "vcc-wifi";
>  };
> =20
> +&spi0  {
> +	status =3D "okay";
> +
> +	m25p80@0 {

The node-name should be the device class, not the device model

> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "w25q128";

According to the binding, this should have "jedec,spi-nor", and you
should put the vendor name before the model name as well.

> +		reg =3D <0x0>;
> +		linux,modalias =3D "m25p80", "w25q128";

This property isn

> +		spi-max-frequency =3D <40000000>;
> +
> +		uboot@0 {
> +			label =3D "uboot";
> +			reg =3D <0x0 0x100000>;
> +		};
> +
> +		rootfs@0 {
> +			label =3D "rootfs";
> +			reg =3D <0x100000 0x7F00000>;
> +		};

This forces a partition scheme on users that might feel
differently. This should be removed.

maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--73kd7dr4snfa6aze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltXIOYACgkQ0rTAlCFN
r3TtXA/8D7eQ91HzEaD+i3PJCzhswl3ZGc/fabyKdh+7Y4Zvct3UTfj7MWRq16rH
nvZnKHW060DaDfDYy8WrIuaP0DWCMhoXvlnqUP2OW/fVpuwnuuDj5iD1oyxt2PcV
4cn4JcWB8hGkZ2KZxIc8RqqllQ0nltBedbXHbEMdygrRx8DQGFgGFM+YXZVaVW/l
wINs6ODG7u3z26Fxl4bSP/xwp13xWQRZC853Dh1UbG4YpCrMlJUDd+yfQnVz5kWt
yivzzd0TyHgVgKQSGl/w5BF3OybtHgDjkExTtrUpzVpisOttw2xy3D8ZDcjaoCCO
4FVyJ++ZnE/z485In/a3uCec8ASiIRLQ1Vb1knRu+vrWYFv4cVKaBLsTjafz4Zlr
K0jq5RJKkda/mnKuES5YUWRJeb/TEfdDzjNUXpILqTtyMaUMnJvpCnObT0NbpS7O
65FUhrxDkjVXaaD7oKbfd4C26ZoYEARl5UG24rxIiDz3GNdym12x9RM0+JvvwVvh
OczG8rZb60lphVSJNTVz8eREVVJkN0B03Tn+JIW6GmDfbFYvusCVipmbtcuJfQsS
UnqyUIUdSP7b/gHIkWnYzhcV1K0ZmL10qObgeEcEpAarKfmIeJqgd77foFfEa+sP
jbXrg2h0SLEYvNbLpkes5/VMNgAWPM3KhxhSDe/9PFGzEOYqbVw=
=rgUq
-----END PGP SIGNATURE-----

--73kd7dr4snfa6aze--
