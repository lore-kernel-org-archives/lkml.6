Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3963EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1235A20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfBTMq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:46:28 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:34221 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfBTMq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:46:27 -0500
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id EFDF11BF204;
        Wed, 20 Feb 2019 12:46:23 +0000 (UTC)
Date:   Wed, 20 Feb 2019 13:46:23 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: sun7i: add pinctrl for missing uart mux options
Message-ID: <20190220124623.ayurp2juq7dvxw64@flea>
References: <20190216182132.12895-1-mans@mansr.com>
 <CAGb2v66C6HFKgF8kERfp2UQ5XUyNS0-prgC3sX2iobkz7SjBcw@mail.gmail.com>
 <20190220090617.aprfndnidcamwcvy@flea>
 <yw1x36oiybbl.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gutps5hnjkqh6r63"
Content-Disposition: inline
In-Reply-To: <yw1x36oiybbl.fsf@mansr.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gutps5hnjkqh6r63
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 20, 2019 at 10:59:58AM +0000, M=E5ns Rullg=E5rd wrote:
> Maxime Ripard <maxime.ripard@bootlin.com> writes:
>=20
> > On Wed, Feb 20, 2019 at 04:58:49PM +0800, Chen-Yu Tsai wrote:
> >> On Sun, Feb 17, 2019 at 2:21 AM Mans Rullgard <mans@mansr.com> wrote:
> >> >
> >> > This adds pinctrl settings for various missing uart options.
> >> >
> >> > Signed-off-by: Mans Rullgard <mans@mansr.com>
> >> > ---
> >> >  arch/arm/boot/dts/sun7i-a20.dtsi | 45 +++++++++++++++++++++++++++++=
+++
> >> >  1 file changed, 45 insertions(+)
> >> >
> >> > diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/su=
n7i-a20.dtsi
> >> > index af5b067a5f83..2295ff5adf48 100644
> >> > --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> >> > +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> >> > @@ -944,6 +944,31 @@
> >> >                                 function =3D "uart0";
> >> >                         };
> >> >
> >> > +                       uart0_pf_pins: uart0-pf-pins {
> >> > +                               pins =3D "PF2", "PF4";
> >> > +                               function =3D "uart0";
> >> > +                       };
> >>=20
> >> We've had the policy of not adding pinctrl nodes that aren't used in-t=
ree,
> >> to avoid bloating up the blob size. However DTC 1.4.7 introduced the n=
ew
> >> /omit-if-no-ref/ directive, which would make the compiler discard mark=
ed
> >> nodes if they aren't referenced.
> >>=20
> >> So please add this to all the new nodes. It seems to work regardless w=
hether
> >> you add it before or after the label, though having it after the label=
 seems
> >> to make vim syntax highlighting happier.
>=20
> Should we also add this to existing nodes?

If you want to send an additional patch, then yes sure :)

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--gutps5hnjkqh6r63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXG1MHwAKCRDj7w1vZxhR
xSWWAQDUhhIzuMRsf2NWQ6TaNe4HvPVNtvT0VbRRjTbIKAXklwEAtcjMe4dwfTcu
3IviC/XLZMCLMXzqeo6JJ51w6iE5XQI=
=7rTZ
-----END PGP SIGNATURE-----

--gutps5hnjkqh6r63--
