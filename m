Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D9BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2B12086B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2B12086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeGLGyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:54:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50476 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbeGLGyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:54:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3A11D2074F; Thu, 12 Jul 2018 08:46:02 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0AAF3206ED;
        Thu, 12 Jul 2018 08:46:02 +0200 (CEST)
Date:   Thu, 12 Jul 2018 08:46:01 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] Re: [PATCH 1/2] ARM: sun8i: h3: enable HDMI output
 on Banana Pi M2 Zero
Message-ID: <20180712064601.m3bdd46wzac5fpgh@flea>
References: <20180711132233.42301-1-icenowy@aosc.io>
 <20180711132233.42301-2-icenowy@aosc.io>
 <20180711150532.6gzm7krouriddreh@flea>
 <8F6CDF5C-2AC1-43EC-858A-5C6345CF279A@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ywglc47lk2k7kfw"
Content-Disposition: inline
In-Reply-To: <8F6CDF5C-2AC1-43EC-858A-5C6345CF279A@aosc.io>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6ywglc47lk2k7kfw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2018 at 11:15:50PM +0800, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2018=E5=B9=B47=E6=9C=8811=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
11:05:32, Maxime Ripard <maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> >Hi,
> >
> >On Wed, Jul 11, 2018 at 09:22:32PM +0800, Icenowy Zheng wrote:
> >> Banana Pi M2 Zero board has a miniHDMI port connected to the HDMI
> >> controller of Allwinner H3 SoC.
> >>=20
> >> Enable the HDMI output in Banana Pi M2 Zero device tree.
> >>=20
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> ---
> >>  .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 25
> >+++++++++++++++++++
> >>  1 file changed, 25 insertions(+)
> >>=20
> >> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >> index 7d01f9322658..eb61dcf32797 100644
> >> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >> @@ -26,6 +26,17 @@
> >>  		stdout-path =3D "serial0:115200n8";
> >>  	};
> >> =20
> >> +	hdmi-connector {
> >> +		compatible =3D "hdmi-connector";
> >> +		type =3D "c";
> >
> >This is not one of the connector type declared in DRM, how is it
> >exposed to the userspace?
>=20
> So just use "A" here (because of single link)?

If the connector type is C, it should be C, and DRM / driver adjusted
to handle it.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--6ywglc47lk2k7kfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltG+Q8ACgkQ0rTAlCFN
r3Q8uQ/+KS0QCSYZWHgdFs7viTA31QUgJIrf4GF1FF6w6rVq9kR2eNFu6jdfTveB
4Jv7jN8Ow2bNezNapbf/JsVB/23wF0vQwfp+kKGz9xYzLYAIWFIMhdM/mSO0BQk0
km0CR1LzJQL1lXnVJNhzLKIqkhKHaGT5W9qCaqCFYy/zUlhoDMXvR8zCUOhxU3GX
KZxZV9j/GsqbSvbri+JRA9Gs34MG5XZJeFPSme+A6oII3Y1AhXXpEFA4Bm8Jqu1o
fogdDffYo/xpNBrgeCy3E2zrnePt4F86yoZazk0bOShi5Mkk/SWrsSEKRl94k2jw
M0Ytk3f0AabFfCtwJ2ps67Uj1SfJGqSOzglAHUYlwZEPtP1D+/mr5Vy+zbI1K7Ff
UUmsEeuwvRGxyMPT0oQBlHSwVgS8VuYhcYkhskfB85Sp/QsUIAEeeHGS18xdGZeP
AXRBvxTcUVkoy4kkvMzqlOmMsLAiKhp9zsNB42ezHfM5KUv+V55sUuJJwFBM8BUt
GiVqxpQd6Qn+3v/EmFicYM4+6Ki+l9AEA6s3ioaFgjF3BC3GmKri8T2UCDmSqpul
O1ROrdTg+l88VlKBczSLcuMQq9AuKmWdARESSuH0AAHIOiI4Khb+pqdZ7NLx2XlW
uTMMp+hdQfgvyL6XGocOtRUzcxx7yQ+BBOuranlP3KtcxFNtovU=
=pHv5
-----END PGP SIGNATURE-----

--6ywglc47lk2k7kfw--
