Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D18ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1773E20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1773E20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388248AbeGXKIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:08:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52276 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388183AbeGXKIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:08:25 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 11CB1207AD; Tue, 24 Jul 2018 11:02:57 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id D477120731;
        Tue, 24 Jul 2018 11:02:46 +0200 (CEST)
Date:   Tue, 24 Jul 2018 11:02:47 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        srinivas.kandagatla@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: allwinner: h5: Add SID for H5
Message-ID: <20180724090247.uhvtnukrr5cevv2j@flea>
References: <20180723104255.94244-1-manu@freebsd.org>
 <20180723104255.94244-4-manu@freebsd.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yfpyl6fm4hqkllkg"
Content-Disposition: inline
In-Reply-To: <20180723104255.94244-4-manu@freebsd.org>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yfpyl6fm4hqkllkg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 12:42:55PM +0200, Emmanuel Vadot wrote:
> The SID controller on H5 look the same as the one present in the A64.
> But in case we find some difference one day at a compatible string
> of it's own and a fallback to the A64 one.
>=20
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> ---
>  .../devicetree/bindings/nvmem/allwinner,sunxi-sid.txt        | 1 +
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi                 | 5 +++++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.=
txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> index e319fe5e205a..99c4ba6a3f61 100644
> --- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> +++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> @@ -7,6 +7,7 @@ Required properties:
>    "allwinner,sun8i-a83t-sid"
>    "allwinner,sun8i-h3-sid"
>    "allwinner,sun50i-a64-sid"
> +  "allwinner,sun50i-h5-sid"
> =20
>  - reg: Should contain registers location and length

Bindings patches should be separate.

> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h5.dtsi
> index 62d646baac3c..28183bf77164 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> @@ -129,3 +129,8 @@
>  		     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>  	compatible =3D "allwinner,sun50i-h5-pinctrl";
>  };
> +
> +&sid {
> +	compatible =3D "allwinner,sun50i-h5-sid",
> +		     "allwinner,sun50i-a64-sid";
> +};

I'm not sure doing a split similar to what you're doing here just to
save the reg line is worth it.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--yfpyl6fm4hqkllkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltW6zYACgkQ0rTAlCFN
r3QsIA/+KYzlpbnTerhFv1nubywZSkaDVEb46QiGxIzsPlMvzT1KckgzK9jHdnLo
TdzVqof8gIknUvyMfqE136KP+KNzz37qNG1ZJscSrvWVYjGNnKvCTuYr3CbPUkzs
PzKVUugFnmoFo1HYSSDjdQ6psR7vPRlsLAPNXlOt4bfRX41GmsKHyXM/Ia9f571J
uZ7EW6Z8fXJE6laEyQ4H4amXlfhpC2axIezEQ1rX2YqYvVt4WfikQOZ18OtylvUY
MuIkR6ZRN8/ntQYJx1RMJfM9N8LK4lflpgUzmiLMsrHL7hPyxtod6yR0G9LtYMVw
x2PEFtckbzmQUjIlm29fJoF2hbbMI3Xdx/2TT2fH7Wp+rpf6DgI7pKAgefiPKggx
9nAgEuD5TpnTkGgnlBhzggZ/v49U9/TwiP0fcIiRil6nXTM+/vMIym367I3KLTYP
lD5y5ixGXMWMno5Akiw16zehd3naO8nMBY2NVw5IkGoGrcVWg4Ch4aZgtsBgVs3S
Nw4aHHWdA1/dOGXbvCHCiWpe7fDL4+fRMxF0/QHf9cIWnsHsSoSb6i54kArUkTmw
a41HCRRSTPgODijqaRKhFO92POjwty0Lg9GLIZIoFKzjSzG8JRid0N7ifTi0/ecG
8SkH68ds7VtM1pytEyoB52uwODZu16ca1JIavT9whXb3S8UHY7E=
=QXD1
-----END PGP SIGNATURE-----

--yfpyl6fm4hqkllkg--
