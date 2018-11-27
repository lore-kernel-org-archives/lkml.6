Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67C2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D722133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D722133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeK0ORg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 09:17:36 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:35470 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbeK0ORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 09:17:36 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1E84172CC59;
        Tue, 27 Nov 2018 06:21:09 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 09D287CD0D7; Tue, 27 Nov 2018 06:21:09 +0300 (MSK)
Date:   Tue, 27 Nov 2018 06:21:09 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Elvira Khabirova <lineprinter@altlinux.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org, strace-devel@lists.strace.io,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH RESEND v3 3/3] ptrace: add PTRACE_EVENT_SECCOMP
 support to PTRACE_GET_SYSCALL_INFO
Message-ID: <20181127032108.GA4154@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20181127040732.1c9f7965@akathisia>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 04:07:32AM +0100, Elvira Khabirova wrote:
> On Mon, 26 Nov 2018 15:35:24 +0100, Oleg Nesterov wrote:
> > On 11/25, Elvira Khabirova wrote:
> > >
> > > Extend PTRACE_GET_SYSCALL_INFO to support PTRACE_EVENT_SECCOMP stops.
> > > The information returned is the same as for syscall-enter-stops. =20
> >=20
> > Oh, this is not nice ;) there must be a better option, I hope... Plus
> >=20
> > Can't ptrace_get_syscall() check
> >=20
> > 	child->exit_code =3D=3D (PTRACE_EVENT_SECCOMP << 8) | SIGTRAP;
> >=20
> > to detect the PTRACE_EVENT_SECCOMP case?
>=20
> Nope; looks like exit_code is zeroed after wait().

It's explicitly reset to zero in wait_task_stopped() unless WNOWAIT wait
option is set.  When strace requests PTRACE_GET_SYSCALL_INFO after
wait4(), child->exit_code is already set to zero.


--=20
ldv

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJb/LgkAAoJEAVFT+BVnCUIKhoP/i5BX4tsokC30O4I3zGET2SV
7GDu6jbhCAYRFoXe7xNoRPQvSh8gfAziWHb6IExqHxdrqf7kj8jjrQS/bNGN/X/h
FBRNUJrRcXVKgQagnSIU1jJ30W8WtdDz5C21O7IF9MOSouqqLNvmsKxpPmLap472
1xp7cYszGVKw0KBc8MVCazWc+YjdTP1ws9Gfc2MfOmlZ3RVq4eEkBTylmKc5fo+X
UbZCp04VdN2QrdlpPNQZlyjz/Fyz1gC70Sr+hsQKh2P4ZQhBq4/p511J115l52+y
+/5bzT17NdTKRrt5R9UhXSyKiPT+24Sar5SyvCRXAdFbtcZHZk0AzbC9kExa1P+a
I0kN2YPdOlUckpKV5LX63dgQfDtSGWit46dSqHJcG9dSI2lF3kTnbpDOS13tdlsd
a+LobSdZUuVnAujQ+uouYF5+i6xtoj4AANEzhUk0w5xTwMG3gDzItiiVdjGukf4z
UHcLgaRAK8TOpm5fXpB3zzqzaza12f10EHFCK+YZQNBUlzS2x6QcDnsbc/Mfhzbz
/ph9RgedCKK2q1r1Ctz4Mr5lln5J4bQWIpf2tejraiPe/Nk3Vz6jEYUGpsTBcSWd
CndSGYHcXxXwmR8Bi39mT6isn6NSWYUOkM6oTI4KN4n9cSbGWY3tLVtxkL/yUQcP
hRzqjz5vbmXEbhytAi1V
=dIFr
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
