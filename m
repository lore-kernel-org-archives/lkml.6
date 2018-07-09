Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B25FC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A642087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A642087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932597AbeGILJJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:09:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52857 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754447AbeGILJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:09:07 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id ED10280354; Mon,  9 Jul 2018 13:09:05 +0200 (CEST)
Date:   Mon, 9 Jul 2018 13:09:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>
Subject: Re: droid 4 in v4.18-rc: grep -r adasfasd /sys/ oopses
Message-ID: <20180709110905.GA11785@amd>
References: <20180708174939.GA10002@amd>
 <20180708193720.GA13262@amd>
 <20180709103305.GF112168@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20180709103305.GF112168@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-07-09 03:33:05, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180708 19:40]:
> > Ok, so it seems to be:
> >=20
> > user@devuan:~$ cat /sys/kernel/debug/pm_debug/count
> > (oops).
> >=20
> > The file seems to be world-readable.
> >=20
> > user@devuan:~$ ls -al /sys/kernel/debug/pm_debug/count
> > -r--r--r-- 1 root root 0 Jan  1  1970 /sys/kernel/debug/pm_debug/count
> >=20
> > But on PC, that file does not exist.
> >=20
> > Any ideas?
>=20
> I'm not seeing this as tested with omap2plus_defconfig and
> not seeing any unclocked module interrupts here.. Can you
> see if the script below produces something for you?
>=20
> I had to filter out some trace pipes as they seem to hang.

Do you have /sys/kernel/debug mounted?

I did, and /sys/kernel/debug/pm_debug/count seems to be a
problem. (And no, it is probably not world-readable on your normal
systems, sorry about that).

I can still run the script :-).
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltDQlEACgkQMOfwapXb+vI7FgCgnmruO78g+ee4j6NX7XF7R7P/
0b8An07lnACzu+1dea5Pl9RnotZ1UF1B
=e8N0
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
