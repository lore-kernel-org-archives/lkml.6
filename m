Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E4AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6042A20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6042A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeLDT3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:29:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45798 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeLDT3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:29:30 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AC2D18089F; Tue,  4 Dec 2018 20:29:23 +0100 (CET)
Date:   Tue, 4 Dec 2018 20:29:26 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chanho Min <chanho.min@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181204192926.GA28651@amd>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com>
 <20181203074700.GA21240@gmail.com>
 <20181203083942.GF31738@dhcp22.suse.cz>
 <20181203123149.GB31795@redhat.com>
 <20181203123857.GS31738@dhcp22.suse.cz>
 <20181203131006.GA10054@amd>
 <20181203135351.GU31738@dhcp22.suse.cz>
 <20181203141459.GA14789@amd>
 <20181203141737.GY31738@dhcp22.suse.cz>
 <20181204090228.GC73770@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20181204090228.GC73770@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * Michal Hocko <mhocko@kernel.org> wrote:
>=20
> > > Do we actually have reports of this happening for people outside
> > > Android?
> >=20
> > Not that I am aware of.
>=20
> I'd say outside of Android 99% of the use of hibernation is the fail-safe=
=20
> that distributions offer on laptops with very low battery levels: the=20
> emergency hibernation when there's almost no power left anymore.

Android does not use hibernation AFAICT. Just s2ram.

> Do these hibernation failure messages typically make it to persistent=20
> logs before the system uses power?

I'd say so. If you have enough energy left for hibernation, you also
have enough energy left to write the logs and sync.

> In practice if that is buggy the kernel won't hibernate and the laptop=20
> will run out of power and the user will conclude "ugh, I shouldn't have=
=20
> left my laptop turned on" - without looking into the logs and reporting,=
=20
> as they'll perceive it as a user failure not a system failure.
>=20
> I certainly saw random Linux laptops fail to hibernate over the years and=
=20
> didn't report it, so if the distribution doesn't do the reporting=20
> automatically then chances are we'll never see it.

There are many reasons while hibernation can fail. Buggy drivers,
tasks in D state... And there are some when hibernation can fail "by
design". If you swap does not have enough space to store the data, for
example.

Hibernation was designed to be non-intrusive, and reliable as in "if
it hibernates it will also resume ok", but not reliable as in "it will
always hibernate".

I see that is problematic for "hibernate on battery low".

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwG1ZYACgkQMOfwapXb+vJeRQCgsyAz8KRczaAiDegP3s4cu2Qr
ffUAnR3HMlIQ34Orrj2Ym3BCTAz18/4j
=SvLS
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
