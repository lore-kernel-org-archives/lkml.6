Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758B5C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5912087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5912087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932789AbeGILKk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:10:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52897 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932431AbeGILKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:10:38 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6ECFC8025C; Mon,  9 Jul 2018 13:10:37 +0200 (CEST)
Date:   Mon, 9 Jul 2018 13:10:37 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>
Subject: Re: droid 4 in v4.18-rc: grep -r adasfasd /sys/ oopses
Message-ID: <20180709111036.GB11785@amd>
References: <20180708174939.GA10002@amd>
 <20180708193720.GA13262@amd>
 <20180709103305.GF112168@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <20180709103305.GF112168@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cvVnyQ+4j833TQvp
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

After some more debugging:

+       printk("3...\n");
        cm_per_dump(s);
+       printk("4...\n");

cm_per_dump seems to be the problem.
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltDQqwACgkQMOfwapXb+vJXvgCgswNW48UUUSLBMhf6OHu1T2WM
WjEAn2s8WDJLmK4D+Iq4D+YP6G1WoOuD
=93/d
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
