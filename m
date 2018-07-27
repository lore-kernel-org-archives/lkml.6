Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA1FC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4482089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4482089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbeG0Mxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:53:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46095 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbeG0Mxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:53:51 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D424D805CB; Fri, 27 Jul 2018 13:32:18 +0200 (CEST)
Date:   Fri, 27 Jul 2018 13:32:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com,
        mpartap@gmx.net, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: Droid 4: suspend to RAM?
Message-ID: <20180727113214.GA32069@amd>
References: <20180725200205.GA29594@amd>
 <CAOf5uwkyPoDT8TZe9V24p+nQMiee9XfD=943xwx0ThGi9_cPng@mail.gmail.com>
 <20180725212853.GA1965@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20180725212853.GA1965@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> > > high even before modem (and thus USB) is enabled.
> > >
> > > Interestingly, CyanogenMod and Jolla seem to have higher power
> > > consumption than stock operating system.
> > >
> > > (My Linux can survive for 10 hours, stock system could survive for 4
> > > days if I'm not mistaken).
> > >
> > > I thought I would experiment with suspend to RAM.. and it indeed
> > > seemed to suspend ok, but I could not wake it up. Do I need to set up
> > > wakeup with button somehow? Is suspend to RAM required for good power
> > > consumption?
> >=20
> > Sorry but pm subsystem has debug mode that you can test in a easy way.
> > You can even wakeup by any rtc alarm easily.
>=20
> Yes, that is how it works on PC (but there power button works,
> too). Is it expected to work on Droid in v4.18?

I tried setting up wakeup using RTC, but no, it does not seem to work:

root@devuan:/my/tui/d4# rtcwake -m no -s 5
rtcwake: wakeup using /dev/rtc0 at Fri Jul 27 11:28:44 2018
root@devuan:/my/tui/d4# echo mem > /sys/power/state

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAltbAr4ACgkQMOfwapXb+vKMYgCcD0rd87jKWp3Ro7qsE0rJb06q
omEAl3HBUYdy1It1rDlYXaHVs/gbSjI=
=rs/z
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
