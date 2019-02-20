Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611A4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BD9208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfBTJGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:06:21 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:39073 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfBTJGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:06:21 -0500
Received: from localhost (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 0DAF2240016;
        Wed, 20 Feb 2019 09:06:17 +0000 (UTC)
Date:   Wed, 20 Feb 2019 10:06:17 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Mans Rullgard <mans@mansr.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: sun7i: add pinctrl for missing uart mux options
Message-ID: <20190220090617.aprfndnidcamwcvy@flea>
References: <20190216182132.12895-1-mans@mansr.com>
 <CAGb2v66C6HFKgF8kERfp2UQ5XUyNS0-prgC3sX2iobkz7SjBcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="foh6urmif5xrrhfj"
Content-Disposition: inline
In-Reply-To: <CAGb2v66C6HFKgF8kERfp2UQ5XUyNS0-prgC3sX2iobkz7SjBcw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--foh6urmif5xrrhfj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2019 at 04:58:49PM +0800, Chen-Yu Tsai wrote:
> On Sun, Feb 17, 2019 at 2:21 AM Mans Rullgard <mans@mansr.com> wrote:
> >
> > This adds pinctrl settings for various missing uart options.
> >
> > Signed-off-by: Mans Rullgard <mans@mansr.com>
> > ---
> >  arch/arm/boot/dts/sun7i-a20.dtsi | 45 ++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i=
-a20.dtsi
> > index af5b067a5f83..2295ff5adf48 100644
> > --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> > +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> > @@ -944,6 +944,31 @@
> >                                 function =3D "uart0";
> >                         };
> >
> > +                       uart0_pf_pins: uart0-pf-pins {
> > +                               pins =3D "PF2", "PF4";
> > +                               function =3D "uart0";
> > +                       };
>=20
> We've had the policy of not adding pinctrl nodes that aren't used in-tree,
> to avoid bloating up the blob size. However DTC 1.4.7 introduced the new
> /omit-if-no-ref/ directive, which would make the compiler discard marked
> nodes if they aren't referenced.
>=20
> So please add this to all the new nodes. It seems to work regardless whet=
her
> you add it before or after the label, though having it after the label se=
ems
> to make vim syntax highlighting happier.

It also works (both for dtc and vim) if we put it on the previous
line, so something like:

/omit-if-no-ref/
uart0_pf_pins: uart0-pf-pins {
};

And it does have the advantage of keeping the same line width, which
could get pretty long on some nodes.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--foh6urmif5xrrhfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXG0YiQAKCRDj7w1vZxhR
xXzVAP9ijrsG7dQ9ZkgmVB+wYx/3Y8mdnIpj0J1trQGPtzNyiQD/as1MQ3MQA2eo
/lMgL7JN23+8+YbQ3x8rN3XItEkscAw=
=rn9g
-----END PGP SIGNATURE-----

--foh6urmif5xrrhfj--
