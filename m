Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8ECC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641922133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfB0OND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:13:03 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:40058 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfB0ONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:13:02 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4578472CCB8;
        Wed, 27 Feb 2019 17:13:00 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 37A4D7CC72E; Wed, 27 Feb 2019 17:13:00 +0300 (MSK)
Date:   Wed, 27 Feb 2019 17:13:00 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] Prepare syscall_get_arch for
 PTRACE_GET_SYSCALL_INFO
Message-ID: <20190227141259.GA22352@altlinux.org>
References: <20190109124044.GA11935@altlinux.org>
 <20190117203444.jrnaoqnpuztcjfx3@madcap2.tricolour.ca>
 <20190208222219.GA12864@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20190208222219.GA12864@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 09, 2019 at 01:22:19AM +0300, Dmitry V. Levin wrote:
> On Thu, Jan 17, 2019 at 03:34:44PM -0500, Richard Guy Briggs wrote:
> > On 2019-01-09 15:40, Dmitry V. Levin wrote:
> > > syscall_get_arch() is required to be implemented on all architectures=
 in order
> > > to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO request:
> > > syscall_get_arch() is going to be called from ptrace_request() along =
with
> > > syscall_get_nr(), syscall_get_arguments(), syscall_get_error(), and
> > > syscall_get_return_value() functions with a tracee as their argument.
> > >=20
> > > The primary intent is that the triple (audit_arch, syscall_nr, arg1..=
arg6)
> > > should describe what system call is being called and what its argumen=
ts are.
> > >=20
> > > This patchset began as a series called "Prepare for PTRACE_GET_SYSCAL=
L_INFO",
> > > then I merged it into a series called "ptrace: add PTRACE_GET_SYSCALL=
_INFO request"
> > > that also contains ptrace-specific changes.
> > >=20
> > > The ptrace-specific part, however, needs more attention to workaround=
 problems
> > > on niche architectures like alpha, while the syscall_get_arch() part =
is
> > > straightforward, so I decided to split it out into a separate patchse=
t that
> > > just prepares syscall_get_arch() for PTRACE_GET_SYSCALL_INFO: it adds
> > > syscall_get_arch() to those architectures that haven't implemented it=
 yet,
> > > and then adds "struct task_struct *" argument to syscall_get_arch()
> > > on all architectures.
> >=20
> > Glad to see syscall_get_arch() added to the remaining arches.  As Paul
> > said, it gets us closer to auditing syscalls on those remaining
> > unsupported arches and getting rid of the extra CONFIG_AUDITSYSCALL.
> > A little ironic that Eric (Paris) and I purged task_struct from
> > syscall_get_arch() 5 years ago since everything could use current.
> >=20
> > > All patches from this patchset have been already reviewed, so it's re=
ady
> > > to be merged without waiting for the ptrace-specific part.  As it's a=
ll
> > > about syscall_get_arch(), it should probably go via audit tree.
> >=20
> > ACK.
> >=20
> > Thanks Dmitry.
>=20
> Thanks.
> Please let me know if some action related to this patch series is expecte=
d from me.
>=20
> > > Dmitry V. Levin (14):
> > >   Move EM_ARCOMPACT and EM_ARCV2 to uapi/linux/elf-em.h
> > >   arc: define syscall_get_arch()
> > >   c6x: define syscall_get_arch()
> > >   h8300: define syscall_get_arch()
> > >   Move EM_HEXAGON to uapi/linux/elf-em.h
> > >   hexagon: define syscall_get_arch()
> > >   m68k: define syscall_get_arch()
> > >   Move EM_NDS32 to uapi/linux/elf-em.h
> > >   nds32: define syscall_get_arch()
> > >   nios2: define syscall_get_arch()
> > >   riscv: define syscall_get_arch()
> > >   Move EM_UNICORE to uapi/linux/elf-em.h
> > >   unicore32: define syscall_get_arch()
> > >   syscall_get_arch: add "struct task_struct *" argument

This is just a gentle ping of the series which is still applicable
to v5.0-rc8 with one exception: "riscv: define syscall_get_arch()"
is no longer needed as riscv already has syscall_get_arch() now.


--=20
ldv

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcdprrAAoJEAVFT+BVnCUInWgQALVCd29o4nuSm/gNVIqAyRyc
urPE13nzPto5+frRPX9J1F23647U4Nn3UV3ck9ezcJXyG0D0j3bklsvACuI6u0g0
plhchq4Dkdu5Cr8sbtm+h06ieXeHfK1/WXWcdRt/IUidN14faPVo7xNUuejNZFMC
RjrIpPy82s+VjpilWfJz6R2bjVtKiqBm3ND4tlSH4oExV+O9JM5JsYetbdB52/HK
7biAVen6R1rV1wplgR/WpVCvgvjzBbudT90075SfEC/2jRDYIXdtapaLO7R0Yrz9
OJwA7A8DOicQAxX3JEuySZoV0m8xVT5G9q6yiv79ns2eOPphitiLnq0WwZr2eY5w
0WSGWqX47GPsSgW6mHioIRNWK7Qs83qWcnIL4skSta3MdyMLtvgHxFqtVIS6rx68
qnSN1PDv3BDmDQsN95qPoIoDa7eU7clY0FHmSI2NFe8xhVyord5RndkyRaU4nX8q
ISPUPlt5MbGsBMrJcmnAW2DfGnSbCeUjBFVY/3OaUzo7PwwoGxBKdrJ499ZPaDgg
xkhKHxa4TnB8x0D0kYwQyV9Mhfg/she8qWXgqD+JIzR5fxJuFY17+HHQj94NqBlf
dOLyDRCKoYGgMxXEKPVKN1StCRkMdbJAhB29dwC6et4er7a3laMHkjH5ZmuCS1IS
HO93VliDMLvh2kokVv6o
=RWLf
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
