Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB97C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A93E21924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBHWWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:22:23 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:39278 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBHWWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:22:23 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 88FA572CC53;
        Sat,  9 Feb 2019 01:22:19 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 6BBF07CCE4E; Sat,  9 Feb 2019 01:22:19 +0300 (MSK)
Date:   Sat, 9 Feb 2019 01:22:19 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 00/14] Prepare syscall_get_arch for
 PTRACE_GET_SYSCALL_INFO
Message-ID: <20190208222219.GA12864@altlinux.org>
References: <20190109124044.GA11935@altlinux.org>
 <20190117203444.jrnaoqnpuztcjfx3@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20190117203444.jrnaoqnpuztcjfx3@madcap2.tricolour.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 03:34:44PM -0500, Richard Guy Briggs wrote:
> On 2019-01-09 15:40, Dmitry V. Levin wrote:
> > syscall_get_arch() is required to be implemented on all architectures i=
n order
> > to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO request:
> > syscall_get_arch() is going to be called from ptrace_request() along wi=
th
> > syscall_get_nr(), syscall_get_arguments(), syscall_get_error(), and
> > syscall_get_return_value() functions with a tracee as their argument.
> >=20
> > The primary intent is that the triple (audit_arch, syscall_nr, arg1..ar=
g6)
> > should describe what system call is being called and what its arguments=
 are.
> >=20
> > This patchset began as a series called "Prepare for PTRACE_GET_SYSCALL_=
INFO",
> > then I merged it into a series called "ptrace: add PTRACE_GET_SYSCALL_I=
NFO request"
> > that also contains ptrace-specific changes.
> >=20
> > The ptrace-specific part, however, needs more attention to workaround p=
roblems
> > on niche architectures like alpha, while the syscall_get_arch() part is
> > straightforward, so I decided to split it out into a separate patchset =
that
> > just prepares syscall_get_arch() for PTRACE_GET_SYSCALL_INFO: it adds
> > syscall_get_arch() to those architectures that haven't implemented it y=
et,
> > and then adds "struct task_struct *" argument to syscall_get_arch()
> > on all architectures.
>=20
> Glad to see syscall_get_arch() added to the remaining arches.  As Paul
> said, it gets us closer to auditing syscalls on those remaining
> unsupported arches and getting rid of the extra CONFIG_AUDITSYSCALL.
> A little ironic that Eric (Paris) and I purged task_struct from
> syscall_get_arch() 5 years ago since everything could use current.
>=20
> > All patches from this patchset have been already reviewed, so it's ready
> > to be merged without waiting for the ptrace-specific part.  As it's all
> > about syscall_get_arch(), it should probably go via audit tree.
>=20
> ACK.
>=20
> Thanks Dmitry.

Thanks.
Please let me know if some action related to this patch series is expected =
=66rom me.

> > Dmitry V. Levin (14):
> >   Move EM_ARCOMPACT and EM_ARCV2 to uapi/linux/elf-em.h
> >   arc: define syscall_get_arch()
> >   c6x: define syscall_get_arch()
> >   h8300: define syscall_get_arch()
> >   Move EM_HEXAGON to uapi/linux/elf-em.h
> >   hexagon: define syscall_get_arch()
> >   m68k: define syscall_get_arch()
> >   Move EM_NDS32 to uapi/linux/elf-em.h
> >   nds32: define syscall_get_arch()
> >   nios2: define syscall_get_arch()
> >   riscv: define syscall_get_arch()
> >   Move EM_UNICORE to uapi/linux/elf-em.h
> >   unicore32: define syscall_get_arch()
> >   syscall_get_arch: add "struct task_struct *" argument
> >=20
> >  arch/alpha/include/asm/syscall.h      |  2 +-
> >  arch/arc/include/asm/elf.h            |  6 +-----
> >  arch/arc/include/asm/syscall.h        | 11 +++++++++++
> >  arch/arm/include/asm/syscall.h        |  2 +-
> >  arch/arm64/include/asm/syscall.h      |  4 ++--
> >  arch/c6x/include/asm/syscall.h        |  7 +++++++
> >  arch/csky/include/asm/syscall.h       |  2 +-
> >  arch/h8300/include/asm/syscall.h      |  6 ++++++
> >  arch/hexagon/include/asm/elf.h        |  6 +-----
> >  arch/hexagon/include/asm/syscall.h    |  8 ++++++++
> >  arch/ia64/include/asm/syscall.h       |  2 +-
> >  arch/m68k/include/asm/syscall.h       | 12 ++++++++++++
> >  arch/microblaze/include/asm/syscall.h |  2 +-
> >  arch/mips/include/asm/syscall.h       |  6 +++---
> >  arch/mips/kernel/ptrace.c             |  2 +-
> >  arch/nds32/include/asm/elf.h          |  3 +--
> >  arch/nds32/include/asm/syscall.h      |  9 +++++++++
> >  arch/nios2/include/asm/syscall.h      |  6 ++++++
> >  arch/openrisc/include/asm/syscall.h   |  2 +-
> >  arch/parisc/include/asm/syscall.h     |  4 ++--
> >  arch/powerpc/include/asm/syscall.h    | 10 ++++++++--
> >  arch/riscv/include/asm/syscall.h      | 10 ++++++++++
> >  arch/s390/include/asm/syscall.h       |  4 ++--
> >  arch/sh/include/asm/syscall_32.h      |  2 +-
> >  arch/sh/include/asm/syscall_64.h      |  2 +-
> >  arch/sparc/include/asm/syscall.h      |  5 +++--
> >  arch/unicore32/include/asm/elf.h      |  3 +--
> >  arch/unicore32/include/asm/syscall.h  | 12 ++++++++++++
> >  arch/x86/include/asm/syscall.h        |  8 +++++---
> >  arch/x86/um/asm/syscall.h             |  2 +-
> >  arch/xtensa/include/asm/syscall.h     |  2 +-
> >  include/asm-generic/syscall.h         |  5 +++--
> >  include/uapi/linux/audit.h            | 14 ++++++++++++++
> >  include/uapi/linux/elf-em.h           |  6 ++++++
> >  kernel/auditsc.c                      |  4 ++--
> >  kernel/seccomp.c                      |  4 ++--
> >  36 files changed, 148 insertions(+), 47 deletions(-)
> >  create mode 100644 arch/m68k/include/asm/syscall.h
> >  create mode 100644 arch/unicore32/include/asm/syscall.h

--=20
ldv

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcXgEbAAoJEAVFT+BVnCUInboP/Ay0iSoETIokLbNzBzSXzXlr
erwpBUOIzJG9ZxQ3Tu+mhTQZbgb4EbjWku9Iquvuy9sOg3JfQ61pDD4/pVCUYo/r
DEdGnAKde0O+VFe65VJgzG0L37zljkmVutDJG6K6B7+8AXt7NJ4XUIhoGDijAPrG
xkv/lMEwwafKhYZUzNMGVNhIhhK9qpRDbmsl7qb4TAI6cV4K8XmT37e5Deyyxucl
tl1UniBfO/Q+8IEJWt5ozBkjoxdQAM/v/QnTGEHGvebkGy4tKEFS/P+TXOK1OSG/
lWjXnGLqdZV73JNNF7FhrrwXukwi2wN7z8Hfk8PoDA6/V6kcz7w+KXhC8td0I6Op
n9NWgaIO0/Yc/uoSbZqlyh4pMtO5fFf+4ldVplahP/XPJxHpQwTCFuey0z+lCaDu
mJ24/95QoCk9+6FFlO3BndrCAKeAANuDDG+2PwafaYrN5uIwTD7+nliJFjnj1S3m
j8GI6ePElyBqgtGz1sSRuPr/FE85wY2AGc7uMviC9iRgGgRokCrwa32FvlM6Fwcd
6G6atKmEmuyQEEKWGkPGpywFqgbQkp8ftf455yHCsD9RpCV5/eSh5sbkb7FbkyhT
vdW0hCkyD5vgnS8Sdx9X6HK0RPA2YjHE2Gpl9I8v8C4s9ZR6yfid0fXhM4539Az1
ZBFyB9op9QnrI+6xQZCK
=h2FA
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
