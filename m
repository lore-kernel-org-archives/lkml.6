Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D10C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A1921872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbfBAUgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:36:18 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41672 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfBAUgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:36:18 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 303BD8025E; Fri,  1 Feb 2019 21:36:10 +0100 (CET)
Date:   Fri, 1 Feb 2019 21:36:16 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     ofono@ofono.org, kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Droid 4 modem support in kernel & ofono
Message-ID: <20190201203616.GA2087@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Ok, so I got calls and smses somehow working in kernel&ofono ... which
is really all I need.

I pushed the tree to git@github.com:pavelmachek/ofono.git , branch
d4... But I had to do some "rather interesting" hacks. D4 modem
expects packets and current kernel drivers rely on write() boundaries
and flush(). .. which is a bit of problem for in ofonod, as it expects
to work with bytestream with no explicit packet boundaries.

However D4 still uses normal AT commands, so... it would be good to be
able to use AT parsing framework in ofono.

I believe easiest solution would be to automatically do the packet
splitting in kernel, it should be as easy as splitting on \r and
^Z. (Currently packets are only generated when \r or ^Z is seen on
write boundary, but that does not work well for ofono).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxUrb8ACgkQMOfwapXb+vL9DQCgr4uvxr+ygZ6U/zYLogeQqdV3
6AIAn0lWzuae8f5IrQQWfPp2WFP3He0p
=CqWQ
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
