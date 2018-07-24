Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE30C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACBC20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACBC20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeGXOGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:06:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60273 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbeGXOGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:06:39 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E0162207B0; Tue, 24 Jul 2018 15:00:13 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id B53A6203D9;
        Tue, 24 Jul 2018 15:00:03 +0200 (CEST)
Date:   Tue, 24 Jul 2018 15:00:04 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] arm64: dts: allwinner: h5: Add SID for H5
Message-ID: <20180724130004.ynaiabshexrrbvo4@flea>
References: <20180724101522.68165-1-manu@freebsd.org>
 <20180724101522.68165-5-manu@freebsd.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n7andq7ge7wxicoh"
Content-Disposition: inline
In-Reply-To: <20180724101522.68165-5-manu@freebsd.org>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n7andq7ge7wxicoh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2018 at 12:15:22PM +0200, Emmanuel Vadot wrote:
> The SID controller on H5 look the same as the one present in the A64.
> But in case we find some difference one day at a compatible string
> of it's own and a fallback to the A64 one.
>=20
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
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

This is still a bit pointless, please remove the common node.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--n7andq7ge7wxicoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltXItMACgkQ0rTAlCFN
r3RA6Q/9FZ93P4fpJVgHH8WVXDIc5wZmYnnNi3RYavhpwuFfDym2AKSSlLBqxaUv
HLnoC9zXL8e2B1GoUUv9R5ijXBF0DbPHA+lPJd190l3RmK5v6lcLEpxz0Qtx8BM1
a4uBVvyt5e4mn3uOyYGCpDAmy1HhOX/bq+/ZnS910FgIC8pnKX+IA5ICVQven1ly
ANOdXwy50XU3wxufO3VgRVcGFndzjjJRJ9b0a/cG8nfNQw3KkrWm6oljhW2x2VZe
5sg3vaovyfOum0u4mML1n3iaYa/oEqrZKKEfAdyD3cGRgZ7W8Ts3pEBgL4bReZYx
S8dF4yQXqwpY+6QskP7NTujnU2trRikW3VNfNPyc1FSk6RmX4b/GOzbX7TEynQR/
AxOquX///1icF95MFfOo2CADAXWp+b52lfuWtXMFspeY2tblKDEp0fa5whwiFjQ5
R0KAFlW9g296Hv0o+qOage08UwzIGSVxlmcjVtvS6IX10MR5V0BABB23Q1l5z6f0
psACGCFQD0qGXL4icTwVibPTgZ/m7aRmuQAXcbsHKkcaTuLuSNYM4qi7X2+mn/Lv
1jtJY634eHpSdOV8N/p9d1qmbXjg46vGtp9J77KUNuwV/YwtRPwS8PGgm4Wl9CfU
i4Lwb+1vVEvqxjRTQ72XKEJR5hH1xhZT4kTkoWjrnBHaFcQh+rs=
=nrHG
-----END PGP SIGNATURE-----

--n7andq7ge7wxicoh--
