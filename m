Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E7AC65BB0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C7020848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C7020848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbeLCJGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:06:39 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52716 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbeLCJGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:06:39 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3623220787; Mon,  3 Dec 2018 10:06:28 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id EEA002071D;
        Mon,  3 Dec 2018 10:06:17 +0100 (CET)
Date:   Mon, 3 Dec 2018 10:06:18 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     alexandre.belloni@bootlin.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rtc@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 04/15] dt-bindings: rtc: sun6i-rtc: Export internal RC
 oscillator
Message-ID: <20181203090618.u4bi3owfpk2kcqik@flea>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-5-wens@csie.org>
 <20181128103219.b625lttcgoluhgz5@flea>
 <CAGb2v67jPi-RFFkVrzHeh2XHeZV7ZN0tPCE=cOTpd6RQayH_Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="krs5icnvo4odeegk"
Content-Disposition: inline
In-Reply-To: <CAGb2v67jPi-RFFkVrzHeh2XHeZV7ZN0tPCE=cOTpd6RQayH_Kg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--krs5icnvo4odeegk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 07:18:26PM +0800, Chen-Yu Tsai wrote:
> On Wed, Nov 28, 2018 at 6:33 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Wed, Nov 28, 2018 at 05:30:01PM +0800, Chen-Yu Tsai wrote:
> > > Experiments showed that on at least the H3/H5/A64 the RTC's internal
> > > oscillator also feeds the CPUS mux in the PRCM.
> > >
> > > Export this clock through the device tree, instead of having to use
> > > a dummy fixed-clock device node, for the PRCM to consume. This will
> > > properly describe the relationship between the clocks.
> > >
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > ---
> > >  Documentation/devicetree/bindings/rtc/sun6i-rtc.txt | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Do=
cumentation/devicetree/bindings/rtc/sun6i-rtc.txt
> > > index 78c4fb472eb7..1bd37faadecb 100644
> > > --- a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
> > > +++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
> > > @@ -24,7 +24,7 @@ Required properties:
> > >
> > >  Required properties for new device trees
> > >  - clocks     : phandle to the 32kHz external oscillator
> > > -- clock-output-names : names of the two clock outputs. See below.
> > > +- clock-output-names : names of the three clock outputs. See below.
> > >  - #clock-cells  : must be equal to 1.
> > >
> > >  The RTC provides the following clocks at the given indices:
> > > @@ -32,6 +32,7 @@ The RTC provides the following clocks at the given =
indices:
> > >  - 1: LOSC external output, known as X32KFOUT in the datasheet.
> > >       This clock is not available on the A31 and is deprecated for old
> > >       device trees still using the "allwinner,sun6i-a31-rtc" compatib=
le.
> > > +- 2: InternalOSC, or internal RC oscillator
> >
> > It seems to be required only for a few RTC though (H3, H5 and R40?)
>=20
> IMO there's no harm in exporting it for all SoCs. I still don't know
> if it's needed for the A31 either. And we don't have documents for the
> PRCM stuff for any of the SoCs involved.

I'm still a bit worried about this, since that means that we can't
ever remove it from the DT interface, even though we find out it might
cause some issues in the future.

If we don't really have a need for it right now, I'd prefer not to
expose it.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--krs5icnvo4odeegk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXATyCgAKCRDj7w1vZxhR
xTq/AP9WIRb7HtqNFrFkdfV6uGu037o83NPO7KzWey4u31t85QEAvW7U3/PGul6i
mu4yDZZYaKjr9keZ6pW1XNH0scK/MwY=
=nsv4
-----END PGP SIGNATURE-----

--krs5icnvo4odeegk--
