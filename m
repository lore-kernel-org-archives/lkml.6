Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 86098C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E2E208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E2E208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755275AbeFNNuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:50:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33940 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755102AbeFNNuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:50:01 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id DBD91803A9; Thu, 14 Jun 2018 15:49:59 +0200 (CEST)
Date:   Thu, 14 Jun 2018 15:49:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Florian Weimer <fweimer@redhat.com>, carlos <carlos@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
Subject: Re: Restartable Sequences system call merged into Linux
Message-ID: <20180614134959.GA4084@amd>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com>
 <31fc101a-295b-067b-1a82-7e9e509fc92f@redhat.com>
 <305409897.10888.1528747473727.JavaMail.zimbra@efficios.com>
 <091061df-3482-8762-30e4-feaf3417be11@redhat.com>
 <417742741.11550.1528821084084.JavaMail.zimbra@efficios.com>
 <20180614122759.GB8798@amd>
 <894222691.12973.1528981314012.JavaMail.zimbra@efficios.com>
 <20180614132557.GA15201@amd>
 <956816108.13001.1528983496098.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <956816108.13001.1528983496098.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> - rseq_preempt(): on preemption, the scheduler sets the TIF_NOTIFY_RES=
UME thread
> >>   flag, so rseq_handle_notify_resume() can check whether it's in a rse=
q critical
> >>   section when returning to user-space,
> >> - rseq_signal_deliver(): on signal delivery, rseq_handle_notify_resume=
() checks
> >>   whether it's in a rseq critical section,
> >> - rseq_migrate: on migration, the scheduler sets TIF_NOTIFY_RESUME as =
well,
> >=20
> > Yes, this is not likely to be noticeable.
> >=20
> > But the proposal wanted to add a syscall to thread creation, right?
> > And I believe that may be noticeable.
>=20
> Fair point! Do we have a standard benchmark that would stress this ?

Web server performance benchmarks basically test clone() performance
in many cases.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsicocACgkQMOfwapXb+vIPEACgs1vuWmzWdUvcvy34IY9uH7Rv
aykAniy6xAOHIGIG+3DTiZI+Z+spFshk
=CzEe
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
