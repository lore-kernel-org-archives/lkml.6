Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B03C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73FF2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfBLNr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:47:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38994 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLNr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:47:27 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C6A7380341; Tue, 12 Feb 2019 14:47:17 +0100 (CET)
Date:   Tue, 12 Feb 2019 14:47:24 +0100
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
Subject: Re: [PATCH v3 10/11] input: max77650: add onkey support
Message-ID: <20190212134723.GB2425@amd>
References: <20190201094736.32057-1-brgl@bgdev.pl>
 <20190201094736.32057-11-brgl@bgdev.pl>
 <20190212121745.GE25613@amd>
 <CAMRc=Md57e93vCV+uJ4WSma2AefdN89iWXCyKiY7yLsWFGUihg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <CAMRc=Md57e93vCV+uJ4WSma2AefdN89iWXCyKiY7yLsWFGUihg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-02-12 14:29:49, Bartosz Golaszewski wrote:
> wt., 12 lut 2019 o 13:17 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
> >
> > Hi!
> >
> > > +     error =3D device_property_read_string(dev,
> > > +                                         "maxim,onkey-mode", &mode_p=
rop);
> > > +     if (error)
> > > +             mode_prop =3D "push";
> > > +
> > > +     if (strcmp(mode_prop, "push") =3D=3D 0)
> > > +             mode =3D MAX77650_ONKEY_MODE_PUSH;
> > > +     else if (strcmp(mode_prop, "slide") =3D=3D 0)
> > > +             mode =3D MAX77650_ONKEY_MODE_SLIDE;
> > > +     else
> > > +             return -EINVAL;
> > ...
> > > +     onkey->input->name =3D "max77650_onkey";
> > > +     onkey->input->phys =3D "max77650_onkey/input0";
> > > +     onkey->input->id.bustype =3D BUS_I2C;
> > > +     input_set_capability(onkey->input, EV_KEY, onkey->code);
> >
> > Is EV_KEY correct for mode=3D=3Dslide?
> >
>=20
> Others are not really documented. Does EV_SW stand for switch event?
> In that case it would probably be better.

I believe so.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxizmsACgkQMOfwapXb+vLR6QCeI2RXewGs3QJAnWRDSUsD8jzj
O5EAniOlgqbmyKDu9bO6p59wqyuT3WJZ
=gFLR
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
