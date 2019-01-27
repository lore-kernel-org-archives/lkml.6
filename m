Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D86FC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 16:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBD92148D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 16:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfA0QAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 11:00:30 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46803 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfA0QAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 11:00:30 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2F557806E1; Sun, 27 Jan 2019 17:00:21 +0100 (CET)
Date:   Sun, 27 Jan 2019 17:00:27 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     valdis.kletnieks@vt.edu,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, vbabka@suse.cz,
        aarcange@redhat.com, rientjes@google.com, mhocko@kernel.org,
        zi.yan@cs.rutgers.edu, hannes@cmpxchg.org, jack@suse.cz
Subject: Re: [regression -next0117] What is kcompactd and why is he eating
 100% of my cpu?
Message-ID: <20190127160027.GA9340@amd>
References: <20190126200005.GB27513@amd>
 <12171.1548557813@turing-police.cc.vt.edu>
 <20190127141556.GB9565@techsingularity.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20190127141556.GB9565@techsingularity.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > top - 13:38:51 up  1:42, 16 users,  load average: 1.41, 1.93, 1.62
> > > Tasks: 182 total,   3 running, 138 sleeping,   0 stopped,   0 zombie
> > > %Cpu(s):  2.3 us, 57.8 sy,  0.0 ni, 39.9 id,  0.0 wa,  0.0 hi,  0.0 s=
i,  0.0 st
> > > KiB Mem:   3020044 total,  2429420 used,   590624 free,    27468 buff=
ers
> > > KiB Swap:  2097148 total,        0 used,  2097148 free.  1924268 cach=
ed Mem
> > >
> > >   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ C=
OMMAND
> > >   608 root      20   0       0      0      0 R  99.6  0.0  11:34.38 k=
compactd0
> > >  9782 root      20   0       0      0      0 I   7.9  0.0   0:59.02 k=
worker/0:
> > >  2971 root      20   0   46624  23076  13576 S   4.3  0.8   2:50.22 X=
org
> >=20
> > I've noticed this as well on earlier kernels (next-20181224 to 20190115)
> >=20
> > Some more info:
> >=20
> > 1) echo 3 > /proc/sys/vm/drop_caches  unwedges kcompactd in 1-3 seconds.
> >=20
>=20
> This aspect is curious as it indicates that kcompactd could potentially
> be infinite looping but it's not something I've experienced myself. By
> any chance is there a preditable reproduction case for this?

I seen it exactly once, so not sure how reproducible this is. x86-32
machine, running chromium browser, so yes, there was some swapping
involved.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxN1ZoACgkQMOfwapXb+vJuTgCgwpjtZ7XQM8ZpFRDsMQ0d1STa
ojoAoKnruHRBMNcofPvK9++RZExVUG6O
=7i05
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
