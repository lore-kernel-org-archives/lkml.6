Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C55C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4740C20878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4740C20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbeLCNLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:11:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46010 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeLCNLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:11:06 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AB2EA8093E; Mon,  3 Dec 2018 14:10:03 +0100 (CET)
Date:   Mon, 3 Dec 2018 14:10:06 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chanho Min <chanho.min@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181203131006.GA10054@amd>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com>
 <20181203074700.GA21240@gmail.com>
 <20181203083942.GF31738@dhcp22.suse.cz>
 <20181203123149.GB31795@redhat.com>
 <20181203123857.GS31738@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20181203123857.GS31738@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-12-03 13:38:57, Michal Hocko wrote:
> On Mon 03-12-18 13:31:49, Oleg Nesterov wrote:
> > On 12/03, Michal Hocko wrote:
> > >
> > > Now, I wouldn't mind to revert this because the code is really old and
> > > we haven't seen many bug reports about failing suspend yet. But what =
is
> > > the actual plan to make this work properly?
> >=20
> > I don't see a simple solution...
> >=20
> > But we need to fix exec/de_thread anyway, then we can probably reconsid=
er
> > this patch.
>=20
> My concern is that de_thread fix might be too disruptive for stable
> kernels while we might want to have a simple enough fix for the the
> suspend issue in the meantime. That was actually the primary reason I've
> acked the hack even though I didn't like it.

Do we care about failing sleep in stable? Does someone hit the issue there?

This sounds like issue only Android is hitting, and they run very
heavily patched kernels, far away from mainline or stable.

> So can we find a way to shut the lockdep up when this is not really a
> deadlock?  Or maybe this really is one and then we need a real fix for
> stable as well.

Shutting up the lockdep is of course possible...

=2E..but lets first see what good solution looks like.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwFKy4ACgkQMOfwapXb+vIHmQCfax4puvNs55ec30fwpXKGZeXT
ABkAoK2bf+R1El02tgKgtabd8QW7xWeP
=QJyo
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
