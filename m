Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A978C46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED672084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED672084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbeJ2RtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:49:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54330 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbeJ2RtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:49:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A7C4F20970; Mon, 29 Oct 2018 10:01:28 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id 721A4208F3;
        Mon, 29 Oct 2018 10:01:18 +0100 (CET)
Date:   Mon, 29 Oct 2018 10:01:18 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 14/15] arm64: dts: allwinner: a64: Add DSI pipeline
Message-ID: <20181029090118.mqha2wgghtqhnyyd@flea>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-15-jagan@amarulasolutions.com>
 <20181024181048.w4iwebtac6wzmgt4@flea>
 <CAMty3ZC1jCfuP8tFKvgcdJ5R_Ou0ejAT_VYv=fV1Kh4UanLWcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="toi655vty4vxbvxk"
Content-Disposition: inline
In-Reply-To: <CAMty3ZC1jCfuP8tFKvgcdJ5R_Ou0ejAT_VYv=fV1Kh4UanLWcg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--toi655vty4vxbvxk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2018 at 06:51:14PM +0530, Jagan Teki wrote:
> On Wed, Oct 24, 2018 at 11:40 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Tue, Oct 23, 2018 at 09:20:34PM +0530, Jagan Teki wrote:
> > > The A64 has a MIPI-DSI block which is similar to A31
> > > without mod clock.
> > >
> > > So, add dsi node with A64 compatible, dphy node with
> > > A31 compatible and finally connect dsi to tcon0 to
> > > make proper DSI pipeline.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v2:
> > > - use A64 dphy compatible
> > >
> > >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 45 +++++++++++++++++=
++
> > >  1 file changed, 45 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm=
64/boot/dts/allwinner/sun50i-a64.dtsi
> > > index f3a66f888205..f82e6b165d57 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > @@ -320,6 +320,11 @@
> > >                                       #address-cells =3D <1>;
> > >                                       #size-cells =3D <0>;
> > >                                       reg =3D <1>;
> > > +
> > > +                                     tcon0_out_dsi: endpoint@1 {
> > > +                                             reg =3D <1>;
> > > +                                             remote-endpoint =3D <&d=
si_in_tcon0>;
> >
> > You need to set the allwinner,channel property there.
>=20
> Are you referring to allwinner,tcon-channel =3D <1> ?

Yep

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--toi655vty4vxbvxk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW9bMXgAKCRDj7w1vZxhR
xcjTAQDaP8hWntIu9NM9a6unCvdoBT4qksv2mjEU5/br0C49+gEA99MDZDzx9D0c
vDmYn9UOBNoJDOFz9AGCTaWD7x//8Q8=
=qqsH
-----END PGP SIGNATURE-----

--toi655vty4vxbvxk--
