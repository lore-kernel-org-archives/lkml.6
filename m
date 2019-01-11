Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B83AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334262084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfAKWVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:21:52 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37109 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfAKWVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:21:51 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 32964809EC; Fri, 11 Jan 2019 23:21:43 +0100 (CET)
Date:   Fri, 11 Jan 2019 23:21:48 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, NeilBrown <neilb@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-tip-commits@vger.kernel.org, jsimmons@infradead.org
Subject: Re: in_compat_syscall() returns from kernel thread for X86_32.
Message-ID: <20190111222148.GA3855@amd>
References: <1460987025-30360-1-git-send-email-dsafonov@virtuozzo.com>
 <tip-abfb9498ee1327f534df92a7ecaea81a85913bae@git.kernel.org>
 <87h8hkc9fd.fsf@notabene.neil.brown.name>
 <CALCETrXB8PE4Ue0BeD0wUS9psLLjpv_pt+nj=SEaj+Nb_dZzUA@mail.gmail.com>
 <871s8ndg6a.fsf@notabene.neil.brown.name>
 <CALCETrWH342Y7jKHsYdT=_3fuyDkWhvQLK9z4PTs9jzbfoCVwg@mail.gmail.com>
 <871s8g6roy.fsf@notabene.neil.brown.name>
 <20181024131534.GD11606@thunk.org>
 <20181024143237.GA27168@thunk.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20181024143237.GA27168@thunk.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-24 10:32:37, Theodore Y. Ts'o wrote:
> On Wed, Oct 24, 2018 at 09:15:34AM -0400, Theodore Y. Ts'o wrote:
> > At least for ext4, the primary problem is that we want to use a 64-bit
> > telldir/seekdir cookie if all 64-bits will make it to user space, and
> > a 32-bit telldir cookie if only 32 bits will make it userspace.  This
> > impacts NFS as well because if there are people who are still using
> > NFSv2, which has 32-bit directory offsets, we need to constrain the
> > telldir/seekdir cookies we give to NFS to be a 32 has as opposed to a
> > 64-bit hash.
>=20
> Are there anyone still using NFSv2, BTW?  One way of making the
> problem *much* easier to sovle would be to drop NFSv2 support.  :-)

NFSv2 is now in "unexcpected" places such as U-Boot bootloader. I'm
pretty sure someone still uses it...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw5FvsACgkQMOfwapXb+vJyrACdFtNgxe2J3DJ0kvIFzQK2ypqH
UQEAn0fZdH4FrJ88mO9723PMoXrcU+SI
=0hbb
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
