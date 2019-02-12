Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF693C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD0420821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbfBLNyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:54:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39164 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbfBLNya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:54:30 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A9EA080340; Tue, 12 Feb 2019 14:54:20 +0100 (CET)
Date:   Tue, 12 Feb 2019 14:54:26 +0100
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
Subject: Re: [PATCH v3 07/11] power: supply: max77650: add support for
 battery charger
Message-ID: <20190212135426.GA2723@amd>
References: <20190201094736.32057-1-brgl@bgdev.pl>
 <20190201094736.32057-8-brgl@bgdev.pl>
 <20190212120742.GA25613@amd>
 <CAMRc=Mf4Mx2ojbpxvF+Qej3oMHdB8hBwtZ85A5+pTj_ZhBij3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <CAMRc=Mf4Mx2ojbpxvF+Qej3oMHdB8hBwtZ85A5+pTj_ZhBij3A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-02-12 14:31:52, Bartosz Golaszewski wrote:
> wt., 12 lut 2019 o 13:07 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
> >
> > Hi!
> >
> > > +#define MAX77650_CHARGER_ENABLED             BIT(0)
> > > +#define MAX77650_CHARGER_DISABLED            0x00
> > > +#define MAX77650_CHARGER_CHG_EN_MASK         BIT(0)
> > > +
> > > +#define MAX77650_CHARGER_CHG_DTLS_MASK               GENMASK(7, 4)
> > > +#define MAX77650_CHARGER_CHG_DTLS_BITS(_reg) \
> > > +             (((_reg) & MAX77650_CHARGER_CHG_DTLS_MASK) >> 4)
> > > +
> > > +#define MAX77650_CHARGER_CHG_OFF             0x00
> > > +#define MAX77650_CHARGER_CHG_PREQ            0x01
> > > +#define MAX77650_CHARGER_CHG_ON_CURR         0x02
> > > +#define MAX77650_CHARGER_CHG_ON_JCURR                0x03
> > > +#define MAX77650_CHARGER_CHG_ON_VOLT         0x04
> > > +#define MAX77650_CHARGER_CHG_ON_JVOLT                0x05
> > > +#define MAX77650_CHARGER_CHG_ON_TOPOFF               0x06
> > > +#define MAX77650_CHARGER_CHG_ON_JTOPOFF              0x07
> > > +#define MAX77650_CHARGER_CHG_DONE            0x08
> > > +#define MAX77650_CHARGER_CHG_JDONE           0x09
> > > +#define MAX77650_CHARGER_CHG_SUSP_PF         0x0a
> > > +#define MAX77650_CHARGER_CHG_SUSP_FCF                0x0b
> > > +#define MAX77650_CHARGER_CHG_SUSP_BTF                0x0c
> >
> > These are really bad define names. We are in charger driver, so
> > MAX77650_CHARGER_ really should be shortened/ommited. OTOH
> > more space should be given to "CHG_SUSP_BTF" as it is impossible to dec=
ipher.
> >
>=20
> I disagree about the prefix bit. I prefer to use common prefixes for
> all symbols in a driver. I would rather add comments to every
> definition here.

So what about shortened? (And what about UVL/OVL below?)

And... what you prefer is not quite important. It is important that
other people can read your code. And what "PF" is is
important... unlike MAX77650_CHARGER_ which is long but unimportant.



> > > +#define MAX77650_CHARGER_CHGIN_DTLS_MASK     GENMASK(3, 2)
> > > +#define MAX77650_CHARGER_CHGIN_DTLS_BITS(_reg) \
> > > +             (((_reg) & MAX77650_CHARGER_CHGIN_DTLS_MASK) >> 2)
> > > +
> > > +#define MAX77650_CHARGER_CHGIN_UVL           0x00
> > > +#define MAX77650_CHARGER_CHGIN_OVL           0x01
> > > +#define MAX77650_CHARGER_CHGIN_OKAY          0x11
> >
> > UVL -> UNDERVOLTAGE, OVL -> OVERVOLTAGE?
> >
> >
> > --
> > (english) http://www.livejournal.com/~pavelmachek
> > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxi0BIACgkQMOfwapXb+vIaagCgk6DlnW3/xbOCbPYyCrnh2T7N
1bIAoJVMj262FTNdBE3Hoc3T17lu2iCz
=Csmp
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
