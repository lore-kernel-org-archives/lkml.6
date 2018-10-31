Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1401EECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB22C20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB22C20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbeJaUv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:51:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51239 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbeJaUv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:51:59 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D7AE58082E; Wed, 31 Oct 2018 12:54:10 +0100 (CET)
Date:   Wed, 31 Oct 2018 12:54:13 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 0/8] OLPC 1.75 Keyboard/Touchpad fixes
Message-ID: <20181031115413.GA14310@amd>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181015195612.GB29649@amd>
 <c4edf9b09e88cd265a0829644aa962c28cbc3d51.camel@v3.sk>
 <20181030100139.GB21529@amd>
 <20181030102610.GC21529@amd>
 <2761d7e31cf7118492e466a5249303c92f68049b.camel@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <2761d7e31cf7118492e466a5249303c92f68049b.camel@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > https://github.com/hackerspace/olpc-xo175-linux/wiki/How-to-run-an-=
up-to-date-Linux-on-a-XO-1.75
> > > >=20
> > > > I didn't test it yet -- will do when I get home in the evening.
> > > > But
> > > > chances are it's good enough and I guess you'd be able to get it
> > > > working even if I messed up some details.
> >=20
> > Instruction say make, but you really need to do make zImage and make
> > mmp2-olpc-xo-1-75.dtb .
>=20
> Have you tried? I'm typically doing just a plain "make".
>=20
> According to "make help", a plain "make" (assuming it's equivalent to
> "make all") includes "zImage" and "dtbs" targets.

I believe I did, but not 100% sure.

> > Instructions say "make -j", which is nice way to crash a machine. I
> > suggest "make -j 8" :-).
>=20
> Holy... what sort of a machine do you have?

Thinkpad X220. Is it too big or too small? :-). 4 threads, so I
usually use -j 5, but -j 8 should be for my notebook and also bigger
servers.


> > Ok, I think I followed the instructions. I am using empty root
> > filesystem, just with /boot -- want to see kernel messages first
> > before I mess with the userland.
> >=20
> > But I don't get kernel messages during boot:
> >=20
> > OLPC 1B1, 512 MiB memory...
> > OpenFirmware Q4C02 EC Frimware 0.3.02
>=20
> "Frimware" -- I assume you don't have a serial console hooked on? :)

Not :-(. Altrough.. maybe I do have that cable somewhere, I just never
used it.

> > Type any key to interrupt...
> > (but keys do not interrupt anything, ouch).
>=20
> In my version of the OLPC OF the routine is replaced with one that only
> accepts the Escape key, because kids like to press random keys without
> really wanting a shell. Maybe try that one?

Ok, will try.

> > And that's it, cursor and no kernel messages.
> >=20
> > Any ideas?
> >=20
> > Could I get prepared binary zImage for testing?
>=20
> https://github.com/hackerspace/olpc-xo175-buildroot/releases
>=20
> Here's a SD card image that works for me. The topmost commit in the
> same repository is the build configuration that was used to generate
> it:

Kernel works for me with this one. (First boot userland boots, then
blinking cursor; next boot filesystem is corrupted. Hmm.) Feel free to
add "Tested-by:" to patches this uses.

> Note it is only going to boot off the SD card, because the root=3D
> argument is hardwired in the devicetree. Sorry about that -- I built
> the image before I noticed you're booting off an USB stick and I don't
> have the resources to regenerate the image at the moment.

No problem, I have SD cards here, too.

> If this won't boot for you, we may need fixes for older FW. Until then
> it might be a good idea if you just update to the latest one (it is as
> easy as booting the last version of the stock distro with a charged
> battery pack).

I'd need more instructions for firmware update. Or maybe ... lets
ignore that. SD card is fine, and I don't want to brick it.

I already broken it enough that keys need to be held during boot (or
it does not boot).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvZl+UACgkQMOfwapXb+vJMVgCfRZWLBhOzRFH6OwGNv/TyiNX2
dIAAnjK6J/WLQO9QyLAeM6KMcRuOUgRC
=KdeG
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
