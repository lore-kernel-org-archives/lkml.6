Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEEFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75532184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfBLNrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:47:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38977 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLNrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:47:07 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C2FB88031C; Tue, 12 Feb 2019 14:46:57 +0100 (CET)
Date:   Tue, 12 Feb 2019 14:47:04 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3 02/11] dt-bindings: power: supply: add DT bindings for
 max77650
Message-ID: <20190212134703.GA2425@amd>
References: <20190201094736.32057-1-brgl@bgdev.pl>
 <20190201094736.32057-3-brgl@bgdev.pl>
 <20190212115420.GA24296@amd>
 <CAMRc=MdCXfPh6g4u-v4GkQJxNDA+v1dqRChcEHdauczrVywkDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <CAMRc=MdCXfPh6g4u-v4GkQJxNDA+v1dqRChcEHdauczrVywkDg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-02-12 14:28:10, Bartosz Golaszewski wrote:
> wt., 12 lut 2019 o 12:54 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
> >
> > Hi!
> >
> > > diff --git a/Documentation/devicetree/bindings/power/supply/max77650-=
charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charg=
er.txt
> > > new file mode 100644
> > > index 000000000000..f3e00d41e299
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger=
=2Etxt
> > > @@ -0,0 +1,27 @@
> > > +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> > > +
> > > +This module is part of the MAX77650 MFD device. For more details
> > > +see Documentation/devicetree/bindings/mfd/max77650.txt.
> > > +
> > > +The charger is represented as a sub-node of the PMIC node on the dev=
ice tree.
> > > +
> > > +Required properties:
> > > +--------------------
> > > +- compatible:                Must be "maxim,max77650-charger"
> > > +
> > > +Optional properties:
> > > +--------------------
> > > +- maxim,vchgin-min:  Minimum CHGIN regulation voltage (in microvolts=
). Must be
> > > +                     one of: 4000000, 4100000, 4200000, 4300000, 440=
0000,
> > > +                     4500000, 4600000, 4700000.
> > > +- maxim,ichgin-lim:  CHGIN input current limit (in microamps). Must =
be one of:
> > > +                     95000, 190000, 285000, 380000, 475000.
> >
> > We already have richtek,min-input-voltage-regulation and
> > ti,minimum-sys-voltage and ti,in-dpm-voltage.
> >
> > This is not too consistent with with the rest.. and perhaps common
> > name should be used for those?
> >
> > See also ti,current-limit. That seems to be direct match.
> >
>=20
> Well I can't really use a TI-specific property name on a maxim part, can =
I?

Well, I'm saying that you should introduce common names for common
stuff. "current-limit" sounds like reasonable name.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxizlcACgkQMOfwapXb+vLTDQCguf6KwZx3lEDsWuevyePEE4T6
zVkAn1McG5biQ9sHy8ZNRtNJk/Xlui5x
=dd4W
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
