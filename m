Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3595C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325CE20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325CE20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbeKTVYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:24:42 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52935 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbeKTVYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:24:42 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 329A7206D8; Tue, 20 Nov 2018 11:56:08 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id F19E22037D;
        Tue, 20 Nov 2018 11:55:57 +0100 (CET)
Date:   Tue, 20 Nov 2018 11:55:57 +0100
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
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v4 03/26] clk: sunxi-ng: Add check for maximum rate to
 NKM PLLs
Message-ID: <20181120105557.3mysirc3ga2h2334@flea>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-4-jagan@amarulasolutions.com>
 <20181113132658.niwy6bqdqzaeqpv2@flea>
 <CAMty3ZBTaeMBFYwyJ+8HqHBDAfEOPEYBt01jho1H4c3SBKbvEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a27mgq4savd3egd2"
Content-Disposition: inline
In-Reply-To: <CAMty3ZBTaeMBFYwyJ+8HqHBDAfEOPEYBt01jho1H4c3SBKbvEw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a27mgq4savd3egd2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 08:51:04PM +0530, Jagan Teki wrote:
> > >  drivers/clk/sunxi-ng/ccu_nkm.c | 3 +++
> > >  drivers/clk/sunxi-ng/ccu_nkm.h | 1 +
> > >  2 files changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/cc=
u_nkm.c
> > > index 6b5ad990f802..b8b66cdd30bf 100644
> > > --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> > > +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> > > @@ -128,6 +128,9 @@ static unsigned long ccu_nkm_round_rate(struct cc=
u_mux_internal *mux,
> > >       if (rate < nkm->min_rate)
> > >               return nkm->min_rate;
> > >
> > > +     if (nkm->max_rate && rate > nkm->max_rate)
> > > +             return nkm->max_rate;
> > > +
> >
> > I would expect the test to be the same for the minimum and maximum case=
s.
>=20
> I don't have proper use-case for max rate test, I do verify by using
> higher the rate on dclock, but nor sure.  May be I can skip the
> max_rate patch?

So you're sending more patches that you haven't really tested?
Why are you sending them then?

> Apart from this, any idea about this issue where SUN4I_TCON0_DCLK_REG
> will only work with div upto 6 on A64 DSI panels[1], did you find the
> same issue on A33?

IIRC my panel was falling into the case where the divider was 4, so
I've not fallen into that case.

> With parent rate 330MHz, the resulting tcon divider for 30MHz [2]
> clock is 11 and for the same for 55MHz [3] clock is 6.

I'm not sure what the question is?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--a27mgq4savd3egd2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/PoPQAKCRDj7w1vZxhR
xSLGAP9Qr44NyVb197rOJlOKTTntni3+46QV9pevbQM76nN3TgEAgaYjL5W+4KIG
hTGncT/uJU90x586s+G6e7AB/3s8/A4=
=07n9
-----END PGP SIGNATURE-----

--a27mgq4savd3egd2--
