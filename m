Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987CCC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8C3218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfBFVU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:20:26 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52084 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfBFVU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:20:26 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 345D48030C; Wed,  6 Feb 2019 22:20:17 +0100 (CET)
Date:   Wed, 6 Feb 2019 22:20:23 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     =?utf-8?B?0K/RgNC+0YHQu9Cw0LIg0KHQtdC80YfQtdC90LrQvg==?= 
        <ukrkyi@gmail.com>, Greg KH <greg@kroah.com>,
        kernel list <linux-kernel@vger.kernel.org>, kugel@rockbox.org,
        ulf.hansson@linaro.org, johan@kernel.org,
        rafael.j.wysocki@intel.com
Cc:     rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org
Subject: Re: REGRESSION - System does not resume from suspend
Message-ID: <20190206212023.GA5353@amd>
References: <CAAuoowhNsaXjBSHM9ZGeO_uwGVXprc8TS0SENGA3fKbg1xCWMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <CAAuoowhNsaXjBSHM9ZGeO_uwGVXprc8TS0SENGA3fKbg1xCWMQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Since kernel version 4.19, my computer is unable to resume from suspend to
> RAM. I've run git bisect and filed bug report at
> https://bugzilla.kernel.org/show_bug.cgi?id=3D201519
> three months ago, however, I received no reaction. Bug is still present in
> 5.0-rc5 kernel version. Is there any possibility to fix this?

Thanks for all the work bisecting / etc... Note that you can get patch
reverted if it causes regression, but it needs to be done over
email. (If maintainer does not reply, up-to Linus).

For the record, patch is:

git bisect output:
c62ec4610c40bcc44f2d3d5ed1c312737279e2f3 is the first bad commit
commit c62ec4610c40bcc44f2d3d5ed1c312737279e2f3
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Tue May 22 13:02:17 2018 +0200

    PM / core: Fix direct_complete handling for devices with no
    callbacks
=2E..
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D199693
        Fixes: 08810a4119aa (PM / core: Add NEVER_SKIP and
        SMART_PREPARE driver flags)
 Reported-by: Thomas Martitz <kugel@rockbox.org>
 Tested-by: Thomas Martitz <kugel@rockbox.org>
		    Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
 Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
 Reviewed-by: Johan Hovold <johan@kernel.org>

And the patch was tagged for stable, which sounds like a lot of fun.

I added Ccs to people involved with the patch.

									Pavel



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxbT5YACgkQMOfwapXb+vJy9ACfZtp1V+wP4pmoLWtVw7u4H0ka
PS8AnRFvZNV9/mltGDcJjsYQ8XigGigV
=zr7S
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
