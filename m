Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDA5C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A5120881
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A5120881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388883AbeGKPKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:10:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58548 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388754AbeGKPKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:10:20 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 25CCA20766; Wed, 11 Jul 2018 17:05:33 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id EB7532072C;
        Wed, 11 Jul 2018 17:05:32 +0200 (CEST)
Date:   Wed, 11 Jul 2018 17:05:32 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/2] ARM: sun8i: h3: enable HDMI output on Banana Pi M2
 Zero
Message-ID: <20180711150532.6gzm7krouriddreh@flea>
References: <20180711132233.42301-1-icenowy@aosc.io>
 <20180711132233.42301-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6lvpsmo4jnvzdq3b"
Content-Disposition: inline
In-Reply-To: <20180711132233.42301-2-icenowy@aosc.io>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6lvpsmo4jnvzdq3b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 11, 2018 at 09:22:32PM +0800, Icenowy Zheng wrote:
> Banana Pi M2 Zero board has a miniHDMI port connected to the HDMI
> controller of Allwinner H3 SoC.
>=20
> Enable the HDMI output in Banana Pi M2 Zero device tree.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/=
arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> index 7d01f9322658..eb61dcf32797 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> @@ -26,6 +26,17 @@
>  		stdout-path =3D "serial0:115200n8";
>  	};
> =20
> +	hdmi-connector {
> +		compatible =3D "hdmi-connector";
> +		type =3D "c";

This is not one of the connector type declared in DRM, how is it
exposed to the userspace?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--6lvpsmo4jnvzdq3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltGHLsACgkQ0rTAlCFN
r3R3sA//WxSxDqm4y84POnUpX8mAI8JnpcGWZHBcgugBWPRqAAoLAaflFx0xH0D2
o3s6CWCRvsNMQrIKvQzqkuWMbmVZkS2yl3JGX0Q17DuLXdFTr+MHJIyveiqiPdky
i2BVSjO3cIloDbj3WTVoeNk2Zgfvh4qAxdMrzZbq5ciDsxKH+TVKH1gsa+p9KW9t
RwID0eyEo5A6ZfLPmohu741oOKiTrQDS1aJgJikd0kNYeZEYg/uItQhq8j+ANFj0
6gZeJeYEXNbc9wqAT7a910F6LI0hSlI9g7A+ak8PTe/fvzN18fctQdcR3TmlJ2ID
3D9e/1GxE5lCi0s5B1AcpiRMLE9qe6fXP1V4Cy8d8UgmslkAnLur2ibpLML5dMEf
QZIm+lhfNGhp7grqrEhBGAigepVk7eGAoLLZ6c+PSy0eOpQzrx7bvpMI/KWrDHc2
SQh6wWqKazPQSWvodEWAF7zflAQpZy8T57RejBErvjlxD/OPAJGnl1xFW/v9yOr1
YsQ2E+CTQEXMQf1VU+RlZypAyR7j+u+oVRMXwRTYuYdZiSaXxjl0AWts8f6VwvNk
7zZXMZ0KnGKlkV51k5pDQ8V4HSK2u1Nsy+0VNc6A2tDeFBYKOCn0aCILCN/fiox3
2XdzOoCrW2SBHIvAhu4pGgFpOKrtV54LWQb5SAIeqdimpFRM4J8=
=4XlZ
-----END PGP SIGNATURE-----

--6lvpsmo4jnvzdq3b--
