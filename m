Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EC6C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892E2218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfBFWcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:32:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54572 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFWcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:32:36 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B74B0802D1; Wed,  6 Feb 2019 23:32:25 +0100 (CET)
Date:   Wed, 6 Feb 2019 23:32:31 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     =?utf-8?B?0K/RgNC+0YHQu9Cw0LIg0KHQtdC80YfQtdC90LrQvg==?= 
        <ukrkyi@gmail.com>, Greg KH <greg@kroah.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Martitz <kugel@rockbox.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: REGRESSION - System does not resume from suspend
Message-ID: <20190206223231.GA13324@amd>
References: <CAAuoowhNsaXjBSHM9ZGeO_uwGVXprc8TS0SENGA3fKbg1xCWMQ@mail.gmail.com>
 <20190206212023.GA5353@amd>
 <CAJZ5v0gZmSfN2pk50sKYr-exbJy8m3dY4Xnz6pcKMcbAX92yfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gZmSfN2pk50sKYr-exbJy8m3dY4Xnz6pcKMcbAX92yfA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-02-06 23:19:18, Rafael J. Wysocki wrote:
> On Wed, Feb 6, 2019 at 10:20 PM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hi!
> >
> > > Since kernel version 4.19, my computer is unable to resume from suspe=
nd to
> > > RAM. I've run git bisect and filed bug report at
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D201519
> > > three months ago, however, I received no reaction. Bug is still prese=
nt in
> > > 5.0-rc5 kernel version. Is there any possibility to fix this?
> >
> > Thanks for all the work bisecting / etc... Note that you can get patch
> > reverted if it causes regression, but it needs to be done over
> > email. (If maintainer does not reply, up-to Linus).
> >
> > For the record, patch is:
> >
> > git bisect output:
> > c62ec4610c40bcc44f2d3d5ed1c312737279e2f3 is the first bad commit
> > commit c62ec4610c40bcc44f2d3d5ed1c312737279e2f3
> > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Date:   Tue May 22 13:02:17 2018 +0200
> >
> >     PM / core: Fix direct_complete handling for devices with no
> >     callbacks
> > ...
> >     Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D199693
> >         Fixes: 08810a4119aa (PM / core: Add NEVER_SKIP and
> >         SMART_PREPARE driver flags)
> >  Reported-by: Thomas Martitz <kugel@rockbox.org>
> >  Tested-by: Thomas Martitz <kugel@rockbox.org>
> >                     Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
> >  Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >  Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >  Reviewed-by: Johan Hovold <johan@kernel.org>
> >
> > And the patch was tagged for stable, which sounds like a lot of fun.
>=20
> Not really.  This just restored previous behavior as the commit log says.
>=20
> If the system breaks after this one, it most likely didn't work before
> commit 08810a4119aa which was in 4.15 and c62ec4610c40bcc44f2 first
> appeared in 4.17-rc1.
>=20
> Unfortunately, it cannot be reverted without breaking other systems
> that used to work before commit 08810a4119aa.

So what is going on there?

If some devices need one behaviour and other devices need second
behaviour, we can just add the flag for the driver, right?

Because we know that Jaroslav's system can suspend, so this is fixable.

Jaroslav -- can you find out which device has problem?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxbYH8ACgkQMOfwapXb+vKSsQCgrpWjeMJYtzHaNcIaDz1o22L3
11sAoJZWB+iZTwJHRwKRHyvhYrnt91N6
=x7gl
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
