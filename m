Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B54C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134A92175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbfBFPwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:52:31 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42333 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfBFPwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:52:31 -0500
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2CD3B60015;
        Wed,  6 Feb 2019 15:52:27 +0000 (UTC)
Date:   Wed, 6 Feb 2019 16:52:27 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Priit Laes <plaes@plaes.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [RFC PATCH] clk: sunxi-ng: sun4i: Use CLK_SET_RATE_PARENT for
 mmc2 clock
Message-ID: <20190206155227.wbkzvsdgykir4wn5@flea>
References: <20190202155209.31617-1-plaes@plaes.org>
 <20190205094529.t7je4ozzu2b4ornc@flea>
 <CAGb2v673ntXn7MTRhU1uecO9q8_i79e+Ovio=tucd6qFf5L84Q@mail.gmail.com>
 <20190206092000.f46nsn4fw2n4crub@flea>
 <20190206100309.dhkm2l73qzkwgjzg@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="icccueyyr555murp"
Content-Disposition: inline
In-Reply-To: <20190206100309.dhkm2l73qzkwgjzg@plaes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--icccueyyr555murp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 06, 2019 at 10:03:09AM +0000, Priit Laes wrote:
> > > I'm concerned for other users of the PLL-PERIPH clock. AFAIK
> > > all of them, except the HRTIMER, expect the clock rate to stay
> > > the same and not change underneath them. And SATA expects it to
> > > be at 600 MHz, as the datasheet says. And while it may not directly
> > > apply to the LIME2, eMMC on newer SoCs / boards run at the slightly
> > > reduced rate of 50 MHz just fine.
> > >=20
> > > In the commit in question, clocks without CLK_SET_RATE_PARENT
> > > should be using the old code (now in the if conditional block),
> > > i.e. the behavior should not have changed.
> > >=20
> > > I don't think this actually "fixes" whatever bug was introduced,
> > > but only papers over the issue, and possible introduces further
> > > issues for other users.
> >=20
> > You're right, I've overlooked that it was pll-periph being
> > affected. I've dropped it for now.
>=20
> Any ideas what could be done. I currently have no time to debug it,
> but it affects existing systems.

I can't find what would change with that commit either if the flag
isn't set, so looking at the register state before and after that
commit would help I guess?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--icccueyyr555murp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFsCuwAKCRDj7w1vZxhR
xTU9AP9g4pbqlt+rpU7LjBo60zkNQyzMukc4S5jIrMWrBFyqpQEAj90+Ygl1XNH0
ouci5HXy93X8iohAAztclWA59L2xzA0=
=1KMn
-----END PGP SIGNATURE-----

--icccueyyr555murp--
