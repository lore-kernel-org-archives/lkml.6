Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09D3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A017D206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A017D206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJKD1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:27:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39577 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeJKD1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:27:16 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1F26C809C2; Wed, 10 Oct 2018 22:03:32 +0200 (CEST)
Date:   Wed, 10 Oct 2018 22:03:32 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Re: -next20181010 regression: thinkpad x60 (32 bit) dies during boot.
Message-ID: <20181010200331.GA13975@amd>
References: <20181010195920.GA13860@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20181010195920.GA13860@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I updated to todays next... and boot crashes with
>=20
> ..
> Call Trace:
> kick_ilb
> trigger_load_balance
> ? active_load..
> scheduler_tick
> update_process_times
> tick_nohz_handler
>=20
> -next20181005 worked ok.

Backtrace indicates problem with nohz, so I added idle=3Dpoll.

Now I have

Run /sbin/init as init process
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted
in: pgd_alloc...
=2E..
dump_stack
=2E...
pgd_alloc
mm_init.isra.
mm_alloc
__do_execve_file
do_execve
=2E..

Good ideas welcome :-).

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlu+WxMACgkQMOfwapXb+vJqygCghKP6OHMzCUzQZZOKOG1NZDuF
S74An36KL2K/ljQKLS3INyNkJeKb97y6
=0CU2
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
