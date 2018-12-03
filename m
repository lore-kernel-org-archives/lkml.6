Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BF7C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEA620851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEA620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeLCJ2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:28:35 -0500
Received: from mail.bootlin.com ([62.4.15.54]:53473 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbeLCJ2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:28:35 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6EA76207B0; Mon,  3 Dec 2018 10:28:19 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 37D752039F;
        Mon,  3 Dec 2018 10:28:09 +0100 (CET)
Date:   Mon, 3 Dec 2018 10:28:09 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Hao Zhang <hao5781286@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, wens@csie.org,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, thierry.reding@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add Allwinner
 sun8i.
Message-ID: <20181203092809.mgeaxpwg6u4s23vq@flea>
References: <20181125161859.GA5277@arx-s1>
 <20181127075226.qo3mv3o6etqdjaop@flea>
 <20181127083523.pciie2gyaplrwiey@pengutronix.de>
 <20181127103253.ubbjjy2ji6sxc7xs@flea>
 <CAJeuY79RRzTqLpaXSe5d8TuNKGeQeYLbXraRVrZk9HBMYBf1+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zznxkq7h2qi3betk"
Content-Disposition: inline
In-Reply-To: <CAJeuY79RRzTqLpaXSe5d8TuNKGeQeYLbXraRVrZk9HBMYBf1+A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zznxkq7h2qi3betk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

(Please keep all the recipiens in Cc)

On Sun, Dec 02, 2018 at 12:13:21AM +0800, Hao Zhang wrote:
> Maxime Ripard <maxime.ripard@bootlin.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=
=8827=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:33=E5=86=99=E9=81=93=
=EF=BC=9A
> >
> > On Tue, Nov 27, 2018 at 09:35:23AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello,
> > >
> > > On Tue, Nov 27, 2018 at 08:52:26AM +0100, Maxime Ripard wrote:
> > > > On Mon, Nov 26, 2018 at 12:18:59AM +0800, Hao Zhang wrote:
> > > > > +  - clocks: From common clock binding, handle to the parent cloc=
k.
> > > > > +  - clock-names: Must contain the clock names described just abo=
ve.
> > > >
> > > > [...]
> > > >
> > > > You seem to have used mux-0 and mux-1 for the clock names. I guess =
we
> > > > don't have to use a name there, we can simply use the position to f=
ind
> > > > out (as long as it's documented in the binding)
> > >
> > > I also wondered if the driver relies on the fact that the second clock
> > > is the faster running one. Is this sensible?
> >
> > Not really, I'm not sure we can make those expectations in the DT
> > binding, especially since clock rate can change at runtime.
>
> How about just add one clock on DT, most of the time, 24MHZ is enough
> (apb1 is 100MHZ)
> other one just use as a optional.
> clock rate change at runtime would make the same pair pwm channel
> uncontrollable,
> because previous one would be change by the new one different setting.

The DT is a hardware representation. If the hardware block can use
both clocks, it should be described.

Now, you can totally use only one clock of these 2 in your driver if that's
easier / more reasonable.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zznxkq7h2qi3betk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAT3KQAKCRDj7w1vZxhR
xQeYAQDbnRAmYhwUqiaSbkwrmQzprsqASJeNCuc1rI/hF22HsAD6A/smAChtdem8
w8QGGZGN16H/E9vHXpmuF6xCPL7VDgw=
=gmHJ
-----END PGP SIGNATURE-----

--zznxkq7h2qi3betk--
