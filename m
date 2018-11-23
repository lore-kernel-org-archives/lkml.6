Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8A3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 04:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C97420664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 04:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C97420664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408057AbeKWOoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 09:44:11 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:55562 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbeKWOoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 09:44:11 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7A5C672CC61;
        Fri, 23 Nov 2018 07:01:40 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 4A5727CD20A; Fri, 23 Nov 2018 07:01:40 +0300 (MSK)
Date:   Fri, 23 Nov 2018 07:01:40 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        strace-devel@lists.strace.io
Subject: Re: [RFC PATCH v2] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181123040139.GB2572@altlinux.org>
References: <20181121165806.07da7c98@akathisia>
 <CALCETrV3TPCkYyhoLLcikXVeF-RdZUuLTCvKReK3Qb9LSS9Csw@mail.gmail.com>
 <20181121235634.GA14146@altlinux.org>
 <CALCETrXea_uRAqw_srW5CWgOzeM=RubaDbjnxZ=cUMy5Zv1TsA@mail.gmail.com>
 <20181122191504.GB27204@altlinux.org>
 <CALCETrXvXzRzoEqwEY_VZ7Vpt-sLwaF+rZPg+y_eG2xyzubXtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <CALCETrXvXzRzoEqwEY_VZ7Vpt-sLwaF+rZPg+y_eG2xyzubXtw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 04:19:10PM -0800, Andy Lutomirski wrote:
> On Thu, Nov 22, 2018 at 11:15 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> >
> > On Thu, Nov 22, 2018 at 06:55:29AM -0800, Andy Lutomirski wrote:
> > > On Wed, Nov 21, 2018 at 3:56 PM Dmitry V. Levin wrote:
> > > > On Wed, Nov 21, 2018 at 02:56:57PM -0800, Andy Lutomirski wrote:
> > > > > Please cc linux-api@vger.kernel.org for future versions.
> > > > >
> > > > > On Wed, Nov 21, 2018 at 7:58 AM Elvira Khabirova wrote:
> > > > > >
> > > > > > struct ptrace_syscall_info {
> > > > > >         __u8 op; /* 0 for entry, 1 for exit */
> > > > >
> > > > > Can you add proper defines, like:
> > > > >
> > > > > #define PTRACE_SYSCALL_ENTRY 0
> > > > > #define PTRACE_SYSCALL_EXIT 1
> > > > > #define PTRACE_SYSCALL_SECCOMP 2
> > > > >
> > > > > and make seccomp work from the start?  I'd rather we don't merge =
an
> > > > > implementation that doesn't work for seccomp and then have to rew=
ork
> > > > > it later.
> > > >
> > > > What's the difference between PTRACE_EVENT_SECCOMP and syscall-entr=
y-stop
> > > > with regards to PTRACE_GET_SYSCALL_INFO request?  At least they hav=
e the
> > > > same entry_info to return.
> > >
> > > I'm not sure there's any material difference.
> >
> > In that case we don't really need PTRACE_SYSCALL_SECCOMP: op field
> > describes the structure inside the union to use, not the ptrace stop.
>=20
> Unless we think the structures might diverge in the future.

If these structures ever diverge, then a seccomp structure will be added
to the union, and a portable userspace code will likely look this way:

#include <linux/ptrace.h>
=2E..
struct ptrace_syscall_info info;
long rc =3D ptrace(PTRACE_GET_SYSCALL_INFO, pid, (void *) sizeof(info), &in=
fo);
=2E..
switch (info.op) {
	case PTRACE_SYSCALL_INFO_ENTRY:
		/* handle info.entry */
	case PTRACE_SYSCALL_INFO_EXIT:
		/* handle info.exit */
#ifdef PTRACE_SYSCALL_INFO_SECCOMP
	case PTRACE_SYSCALL_INFO_SECCOMP:
		/* handle info.seccomp */
#endif
	default:
		/* handle unknown info.op */
}

In other words, it would be better if PTRACE_SYSCALL_INFO_* selector
constants were introduced along with corresponding structures in the
union.


--=20
ldv

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJb93ujAAoJEAVFT+BVnCUI2jsQAIepMxxYXPxMW/R7MJz1eL/2
c5Y/scQkQ/JhQBIk8trAhW6iNwfsVcmVy2JnhkkZ+ZPvsFg1QFTgPMySGWAwlUvo
cHwhy4uGsiQ4gwiZTg1YSleIAQccIsq0+R6+dW2oHu9FuN7S72WfBtNnp+wLHdhH
PsOHpHgfhr6vsUrCOrAzsmMNzhxu8+cgPT04y5dUNCREBrr3uoFKKy/5u7WykLqC
6A8ryanu8QJgM3jQ11N0gp0gds0VSzSDk60n8SHvhxaczqn1SEg40ZKfdQ57d/8F
YBiWm3H5sLCodHYPW2cGpgcqNlTPrSAu1dC+p4rKITi3jdlCw6RUPQQ/vhSghEkE
2ioM+BtE180n7qRL1gMlYTXah34qOvW6FDiFjgp5TmXjbaG3FTn0wC4esCz9bGqJ
MEvYiR6d6a6Ow4cpTL0OF5I1dTfy/HyJZToaiN/iYZ0UQAQamYYn4lx0ZX0NZKWj
KxQXATYMmnR0/6W+uq26VwUs6pE8nNoKe2jR/um2QE/AjZe/zbWikIUrL+3s/dz7
znc4kYzzBIU97vEDSIyElVdH7eUbPDY1+ifNK/U/dAUtHfpcTmVmEt/ToDFAFb+V
v6l1M+u1bGuCr6iL7GXgNHldCfCPFhjsF2QrfU/gAKDiqMkGi15V7/xg11czkQf9
FdOM5gtadWSiVdFuGO1m
=+cWe
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
