Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FBFECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B372147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B372147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbeIQUWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:22:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41512 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728676AbeIQUWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:22:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C57612075C; Mon, 17 Sep 2018 16:55:01 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 94DFB206A7;
        Mon, 17 Sep 2018 16:54:51 +0200 (CEST)
Date:   Mon, 17 Sep 2018 16:54:52 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 5/5] ARM: sun8i: dts: drop A64 HDMI PHY fallback
 compatible from R40 DT
Message-ID: <20180917145452.ewfuqkrxjjosbawd@flea>
References: <20180907072234.48282-1-icenowy@aosc.io>
 <20180907072234.48282-6-icenowy@aosc.io>
 <20180910142354.5ldexkvnan6ohz4x@flea>
 <1926288.mXGsSvSKgU@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ujjjku5u3trhfpa5"
Content-Disposition: inline
In-Reply-To: <1926288.mXGsSvSKgU@jernej-laptop>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ujjjku5u3trhfpa5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2018 at 04:32:30PM +0200, Jernej =C5=A0krabec wrote:
> Dne ponedeljek, 10. september 2018 ob 16:23:54 CEST je Maxime Ripard=20
> napisal(a):
> > On Fri, Sep 07, 2018 at 03:22:34PM +0800, Icenowy Zheng wrote:
> > > The R40 HDMI PHY seems to be different to the A64 one, the A64 one
> > > has no input mux, but the R40 one has.
> > >=20
> > > Drop the A64 fallback compatible from the HDMI PHY node in R40 DT.
> > >=20
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > ---
> > >=20
> > >  arch/arm/boot/dts/sun8i-r40.dtsi | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >=20
> > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > b/arch/arm/boot/dts/sun8i-r40.dtsi index ffd9f00f74a4..5f547c161baf
> > > 100644
> > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > @@ -800,8 +800,7 @@
> > >=20
> > >  		};
> > >  	=09
> > >  		hdmi_phy: hdmi-phy@1ef0000 {
> > >=20
> > > -			compatible =3D "allwinner,sun8i-r40-hdmi-phy",
> > > -				     "allwinner,sun50i-a64-hdmi-phy";
> > > +			compatible =3D "allwinner,sun8i-r40-hdmi-phy";
> >=20
> > If you could use the A64 phy before, you can still use it now.
>=20
> Not exactly. Given that we don't know how to switch between HDMI PHY cloc=
k=20
> parents on A64 (if it is actually connected at all, there is no informati=
on=20
> about that in manual and AW didn't answered our questions, despite asking=
 them=20
> through different channels), A64 compatible will be associated with quirk=
,=20
> which will tell that only one clock parent is usable.
>=20
> However, R40 HDMI PHY has definetly two clock parents, as it was tested b=
y me=20
> and Icenowy and we know how to switch between them without issues.=20
> Technically, we could have A64 compatible there, but that would mean only=
=20
> single PHY parent is considered instead of two.

The DT change above would mean that you can't operate the R40 phy in
the same way than the A64's. From what you're telling me now, this
isn't exactly what is going on: you can operate the R40 phy just like
the A64: with a single PLL instead of two. You operate in a degraded
and non-optimal mode, but it still works.

And it's exactly what the DT is already saying.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ujjjku5u3trhfpa5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlufwDsACgkQ0rTAlCFN
r3QWaA//dPrmhPFXEjb96GM60VBvSnsdszdH8uRdbbz3VtOabA8Uf25Zs9kBoemE
UYXS9GyHNaQnt9CEgRUJPZfLh8t480eXVIVD4U5whNXhjEYui6OXJnYgYjOrDGPX
Br2YQxTkWPZ+JoaSbKMZsqe4fYUlSwkG6i4h+zioMudRTFmwqhUsf8DuBYkmGiL6
AjLnflWl+wt7EoIhUXk4KYEjBZuhWBp+TdQzS4MybVjP21AcjJZYx4jbZWGdtYtD
TECZQV5QysUZZALTcxKj4zztN63K6yOyfFCua6IRI5FjoNATw23ZWMuwWsr/ne9d
ELEPxeI00swW/24mcmQ3EEL+Lvl3DXu3sQBUE91tj5AQbXYhNwDsuYm/gtQrhBV/
7ZZqFSNWs8f1wQ0nt4UA/FYObPEZHWP2qPuMoHR+AjKh/Vk6LsCI9HmHv2cddIqY
e4mz1AwMe8iclk640i2H4xOOqdIwEtEWG1cHAW50sO8RqtjVBr3LVn6N3kEHPHLW
leWFSXCFPLbun7N3jxGduRQEZVdLLG8+IWbewYXvHzt/uNDVwZ7+dvBc2wQCxmvq
xICwqWzKr9dwsNQEz8DDB6jvOvVhNsrRkbgkzYzQHihzo4LKTRchjF4EJ6G5qC9V
FJCE188MzuTaE4202hN/ztOka+VdOmzu32KMOgHIvafwpq/6AKc=
=MnaS
-----END PGP SIGNATURE-----

--ujjjku5u3trhfpa5--
