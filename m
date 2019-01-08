Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4A5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111BB2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfAHSrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:47:20 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59655 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbfAHSrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:47:19 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E2CF1808F7; Tue,  8 Jan 2019 19:47:09 +0100 (CET)
Date:   Tue, 8 Jan 2019 19:47:14 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Sameer Nanda <snanda@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Adam.Thomson.Opensource@diasemi.com, kernel@collabora.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v3 1/2] power: supply: add input voltage limit property
Message-ID: <20190108184714.GA11289@amd>
References: <20181213120944.30967-1-enric.balletbo@collabora.com>
 <20181213222000.GA12302@amd>
 <2fcfc863-3218-55e8-2a0f-75d7cb2d55db@collabora.com>
 <CAFqH_53E1ori_b69XkpAafaAZKZE3GzbN5eFvU9FbUTgjHbi+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <CAFqH_53E1ori_b69XkpAafaAZKZE3GzbN5eFvU9FbUTgjHbi+g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >> For folks hacking on Pixel Cs (which is now outside of Google's offi=
cial
> > >> support window for Android) and customizing their own kernel and use=
rspace
> > >> this would be acceptable, but we wanted to expose this feature in the
> > >> power supply properties because the feature does exist in the Emedded
> > >> Controller firmware of the Pixel C and all of Google's Chromebooks w=
ith
> > >> USB-C made since 2015 in case someone running an up to date kernel w=
anted
> > >> to limit the charging power for thermal or other reasons.
> > >>
> > >> This patch exposes a new property, similar to input current limit, to
> > >> re-configure the maximum voltage from the external supply at runtime
> > >> based on system-level knowledge or user input.
> > >
> > > Could we get power input limit, instead?
> > >
> >
> > I'm open but I have some concerns, so lets discuss a bit about it :)
> >
> > According to the USB PD 2.0 specs if we limit the source at 15W we can =
get 5V/3A
> > or 9V/1.67A, if I am not mistaken the higher voltage caused problem sin=
ce the
> > conversion to lower internal voltages generated more heat, so in this c=
ase
> > 9V/1.67A is not a valid value for us (maybe someone from ChromeOS can c=
onfirm
> > this?).

> Around Xmas are bad dates to start a discussion. I don't want this
> patch will be forgotten, so a gentle ping on your thoughts on this :)
> (just in case)

If someone can indeed confirm it is _voltage_ that is problematic,
then approach is ok with me. [But I'd not expect buck convertor
efficiency to differ greatly based on input voltage.]

Best regards,
									Pavel
								=09

> > >> +What:               /sys/class/power_supply/<supply_name>/input_vol=
tage_limit
> > >> +Date:               Nov 2018
> > >> +Contact:    linux-pm@vger.kernel.org
> > >> +Description:
> > >> +            This entry configures the incoming VBUS voltage limit c=
urrently
> > >> +            set in the supply. Normally this is configured based on
> > >> +            system-level knowledge or user input (e.g. This is part=
 of the
> > >> +            Pixel C's thermal management strategy to effectively li=
mit the
> > >> +            input power to 5V when the screen is on to meet Google'=
s skin
> > >> +            temperature targets). Note that this feature should not=
 be
> > >> +            used for safety critical things.


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw08DIACgkQMOfwapXb+vKW6wCghA+1ikUGqjLf99j1wZRH6Iac
OB0AnROGmZU1+WiqOg7Bmk/EoWE3hSkk
=2G+L
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
