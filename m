Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7442EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 23:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3391920C01
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 23:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3391920C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeKXKFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 05:05:40 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:50052 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeKXKFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 05:05:39 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8B0DA72CC61;
        Sat, 24 Nov 2018 02:19:24 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 5DFD17CD0D5; Sat, 24 Nov 2018 02:19:24 +0300 (MSK)
Date:   Sat, 24 Nov 2018 02:19:24 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>, Willy Tarreau <w@1wt.eu>,
        Vlastimil Babka <vbabka@suse.cz>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Official Linux system wrapper library?
Message-ID: <20181123231924.GA15954@altlinux.org>
Mail-Followup-To: Daniel Colascione <dancol@google.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>, Willy Tarreau <w@1wt.eu>,
        Vlastimil Babka <vbabka@suse.cz>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
 <877ehjx447.fsf@oldenburg.str.redhat.com>
 <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <875zx2vhpd.fsf@oldenburg.str.redhat.com>
 <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com>
 <87efbbvrx9.fsf@oldenburg.str.redhat.com>
 <CAKOZuesFZqstO-9K2tLQ1sOOmYsN73QdTHNG0De0a=eq5BT99w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <CAKOZuesFZqstO-9K2tLQ1sOOmYsN73QdTHNG0De0a=eq5BT99w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 12:15:39PM -0800, Daniel Colascione wrote:
> On Fri, Nov 23, 2018 at 5:34 AM Florian Weimer wrote:
> > > On Mon, Nov 12, 2018 at 12:11 AM, Florian Weimer wrote:
> > >>
> > >>> If the kernel provides a system call, libc should provide a C wrapp=
er
> > >>> for it, even if in the opinion of the libc maintainers, that system
> > >>> call is flawed.
> > >>
> > >> It's not that simple, I think.  What about bdflush?  socketcall?
> > >> getxpid?  osf_gettimeofday?  set_robust_list?
> > >
> > > What about them? Mentioning that these system calls exist is not in
> > > itself an argument.
> >
> > But socketcall does not exist on all architectures.  Neither does
> > getpid, it's called getxpid on some architectures.
>=20
> So what? On systems on which a given system call does not exist,
> attempts to link against that system call should fail, or attempts to
> make that system call should fail at runtime with ENOSYS. That's
> completely expected and unsurprising behavior, not some unavoidable
> source of catastrophic confusion.

I'm sorry but you've just said that getpid() must either be unavailable or
fail on those architectures that provide no syscall with exactly the same
semantics as getpid syscall.  Nobody is going to use a libc that doesn't
provide getpid() in a reliable way.

If you really need a 1-1 correspondence between syscalls and C wrappers,
there is syscall(3) with all associated portability issues.

If you need something else, please be more specific, i.e. be ready to give
a detailed answer about every syscall ever supported by the kernel,
on every supported architecture.

My first trivial question is, do you need C wrappers for
__NR_epoll_create, __NR_eventfd, __NR_inotify_init,
and __NR_signalfd syscalls?


--=20
ldv

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJb+Ir8AAoJEAVFT+BVnCUI9jUQAJxPxURTe4+lhlpMh+pinvW0
PNzhRbRHJqPClAoJxlSwV+60dKckTt4c3cMEa8jKgLEYG4cXNrEmmlzJ00I9p0k0
qIw5soU65FkXh+HAfYAL6ujwJI3oxfTse79Q5PvD5WggaKIRKD8cQ0OvxlL8NU2k
UJoVj2Js4RWybxQdgcaPIg+ciJltCVT+PXmK1h8fvJmXBgq3MefA88MKTDBEY8vz
3hFOBt4K33anedsyMRiD7IJ50ml93AFtJCko9eGNiLQH1XjyczRg9JkkiKS9aFkQ
ly/07mAM3qC7xqTJDONA50eOSS94NC30luHri7bVnfG0e7T4uxaXFeJeyxa+r4fP
DUnKcQc+9lThYqVHHArJNY2sscKLILuhMdfM5d/d9XftSTImJv2fqJ5cRzhgz/7Z
P8WkL9QFBY7TxOmtFh4V2KjVQswt8CDnfAcZr5cTvogsrW9JFChbDK0MBlMqOWQc
0SB5Wl/prVR4XHReMjpuf6A/vC5hoDEIW7XR865wmA4/+N+7mvRGcU74RRuom+TL
9JE9fyM+7g86Sf9IiCWBf96GbYJr9+YbU7kYJ7BZgQMgwrIwWheJoWI7Q8dAVC1y
pj/uE3cqW9UzDCYnkYmRmieyhfdVyBwWyw8USTGGdrRO62aU3sDf9LHVr8hArOU5
30L4FgEAHpngDSk2MNUN
=0Jgr
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
