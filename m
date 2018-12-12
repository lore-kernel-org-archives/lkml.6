Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3B2C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A6F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A6F2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeLLMhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:37:35 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:55170 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeLLMhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:37:34 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id ED6A872CA65;
        Wed, 12 Dec 2018 15:37:30 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id B9ED37CFF70; Wed, 12 Dec 2018 15:37:30 +0300 (MSK)
Date:   Wed, 12 Dec 2018 15:37:30 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        lineprinter@altlinux.org, Eugene Syromiatnikov <esyr@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 13/25] m68k: add asm/syscall.h
Message-ID: <20181212123730.GA16479@altlinux.org>
References: <CAMuHMdVYq_2P=gb_zbSGFkPWASTds6uSPTyyhyNAgp2Qm5+feQ@mail.gmail.com>
 <20181210124059.GA11942@altlinux.org>
 <CAMuHMdW8ejp4gm2Xh-8inSQngQ5zRQ9bfsg1SG+BAD8RFV8xcA@mail.gmail.com>
 <20181210133025.GG11942@altlinux.org>
 <20181212085516.GA13288@altlinux.org>
 <CAMuHMdXwX57AZuVPdcEt_HZw1LT7tFpczJsqjW6C0VgHkhJ7dw@mail.gmail.com>
 <20181212092712.GD13288@altlinux.org>
 <CAMuHMdVvw3_3rm3v8J8u6ic6Wy3o70mOP1qaWQ=Ltf1XU=nnVQ@mail.gmail.com>
 <20181212120417.GC15561@altlinux.org>
 <CAMuHMdXqJeH0C8FHy=G=ycArdkvjYPy48+3LmACnyS9RuqV30g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXqJeH0C8FHy=G=ycArdkvjYPy48+3LmACnyS9RuqV30g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Wed, Dec 12, 2018 at 01:27:14PM +0100, Geert Uytterhoeven wrote:
> On Wed, Dec 12, 2018 at 1:04 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > On Wed, Dec 12, 2018 at 10:43:33AM +0100, Geert Uytterhoeven wrote:
> > > On Wed, Dec 12, 2018 at 10:27 AM Dmitry V. Levin <ldv@altlinux.org> w=
rote:
> > > > On Wed, Dec 12, 2018 at 10:01:29AM +0100, Geert Uytterhoeven wrote:
> > > > > On Wed, Dec 12, 2018 at 9:55 AM Dmitry V. Levin <ldv@altlinux.org=
> wrote:
> > > > > > On Mon, Dec 10, 2018 at 04:30:25PM +0300, Dmitry V. Levin wrote:
> > > > > > > On Mon, Dec 10, 2018 at 02:06:28PM +0100, Geert Uytterhoeven =
wrote:
> > > > > > > > On Mon, Dec 10, 2018 at 1:41 PM Dmitry V. Levin <ldv@altlin=
ux.org> wrote:
> > > > > > > > > On Mon, Dec 10, 2018 at 09:45:42AM +0100, Geert Uytterhoe=
ven wrote:
> > > > > > > > > > On Mon, Dec 10, 2018 at 5:30 AM Dmitry V. Levin <ldv@al=
tlinux.org> wrote:
> > > > > > > > > > > syscall_get_* functions are required to be implemente=
d on all
> > > > > > > > > > > architectures in order to extend the generic ptrace A=
PI with
> > > > > > > > > > > PTRACE_GET_SYSCALL_INFO request.
> > > > > > > > > > >
> > > > > > > > > > > This introduces asm/syscall.h on m68k implementing al=
l 5 syscall_get_*
> > > > > > > > > > > functions as documented in asm-generic/syscall.h: sys=
call_get_nr,
> > > > > > > > > > > syscall_get_arguments, syscall_get_error, syscall_get=
_return_value,
> > > > > > > > > > > and syscall_get_arch.
> > > > > > > > > > >
> > > > > > > > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > > > > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > > > > > > > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > > > > > > > > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > > > > > > > > > > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > > > > > > > > > > Cc: linux-m68k@lists.linux-m68k.org
> > > > > > > > > > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > Notes:
> > > > > > > > > > >     v5: added syscall_get_nr, syscall_get_arguments, =
syscall_get_error,
> > > > > > > > > > >         and syscall_get_return_value
> > > > > > > > > > >     v1: added syscall_get_arch
> > > > > > > > > >
> > > > > > > > > > > --- /dev/null
> > > > > > > > > > > +++ b/arch/m68k/include/asm/syscall.h
> > > > > > > > > > > @@ -0,0 +1,39 @@
> > > > > > > > > >
> > > > > > > > > > > +static inline void
> > > > > > > > > > > +syscall_get_arguments(struct task_struct *task, stru=
ct pt_regs *regs,
> > > > > > > > > > > +                     unsigned int i, unsigned int n,=
 unsigned long *args)
> > > > > > > > > > > +{
> > > > > > > > > > > +       BUG_ON(i + n > 6);
> > > > > > > > > >
> > > > > > > > > > Does this have to crash the kernel?
> > > > > > > > >
> > > > > > > > > This is what most of other architectures do, but we could=
 choose
> > > > > > > > > a softer approach, e.g. use WARN_ON_ONCE instead.
> > > > > > > > >
> > > > > > > > > > Perhaps you can return an error code instead?
> > > > > > > > >
> > > > > > > > > That would be problematic given the signature of this fun=
ction
> > > > > > > > > and the nature of the potential bug which would most like=
ly be a usage error.
> > > > > > > >
> > > > > > > > Of course to handle that, the function's signature need to =
be changed.
> > > > > > > > Changing it has the advantage that the error handling can b=
e done at the
> > > > > > > > caller, in common code, instead of duplicating it for all
> > > > > > > > architectures, possibly
> > > > > > > > leading to different semantics.
> > > > > > >
> > > > > > > Given that *all* current users of syscall_get_arguments speci=
fy i =3D=3D 0
> > > > > > > (and there is an architecture that has BUG_ON(i)),
> > > > > > > it should be really a usage error to get into situation where=
 i + n > 6,
> > > > > > > I wish a BUILD_BUG_ON could be used here instead.
> > > > > > >
> > > > > > > I don't think it worths pushing the change of API just to con=
vert
> > > > > > > a "cannot happen" assertion into an error that would have to =
be dealt with
> > > > > > > on the caller side.
> > > > > >
> > > > > > I suggest the following BUG_ON replacement for syscall_get_argu=
ments:
> > > > > >
> > > > > > #define SYSCALL_MAX_ARGS 6
> > > > > >
> > > > > > static inline void
> > > > > > syscall_get_arguments(struct task_struct *task, struct pt_regs =
*regs,
> > > > > >                       unsigned int i, unsigned int n, unsigned =
long *args)
> > > > > > {
> > > > > >         /*
> > > > > >          * Ideally there should have been
> > > > > >          * BUILD_BUG_ON(i + n > SYSCALL_MAX_ARGS);
> > > > > >          * instead of these checks.
> > > > > >          */
> > > > > >         if (unlikely(i > SYSCALL_MAX_ARGS)) {
> > > > > >                 WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
> > > > > >                 return;
> > > > >
> > > > > Does this have security implications, as args is an output parame=
ter?
> > > > > I.e. if you don't fill the array, the caller will use whatever is=
 on the stack.
> > > > > Can this ever be passed to userspace, leaking data?
> > > >
> > > > In the current kernel code n is always less or equal to 6,
> > > > but in theory future changes can potentially break the assertion
> > > > and this could lead to leaking data to userspace.
> > >
> > > OK.
> > >
> > > > Do you think we should rather be defensive and add some memsets, e.=
g.
> > > >
> > > >         if (unlikely(i > SYSCALL_MAX_ARGS)) {
> > > >                 WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
> > > >                 memset(args, 0, n * sizeof(args[0]));
> > > >                 return;
> > > >         }
> > > >         if (unlikely(n > SYSCALL_MAX_ARGS - i)) {
> > > >                 unsigned int extra =3D n - (SYSCALL_MAX_ARGS - i);
> > > >
> > > >                 WARN_ONCE(1, "i + n > SYSCALL_MAX_ARGS");
> > > >                 n =3D SYSCALL_MAX_ARGS - i;
> > > >                 memset(&args[n], 0, extra * sizeof(args[0]));
> > > >         }
> > > > ?
> > >
> > > Yes please.
> > >
> > > But please handle all of that in the generic code, so it doesn't have=
 to be
> > > replicated across all architectures.
> > >
> > > E.g. make syscall_get_arguments() a wrapper in generic code, calling
> > > __syscall_get_arguments() in architecture-specific code.
> > >
> > > And make the latter return int, so it can indicate other failures.
> >
> > Other failures?  What syscall_get_arguments is expected to do
> > if __syscall_get_arguments returned, say, -1?
>=20
> Fail. Just like in case of other generic ill conditions it can detect its=
elf.

Sorry, I don't quite follow.  syscall_get_arguments() has no return code,
so all it can possibly do is to zero out args[], e.g.

        if (unlikely(__syscall_get_arguments(task, regs, i, n, args) < 0)) {
                memset(args, 0, n * sizeof(args[0]));
                return;
        }

Do you mean this?


--=20
ldv

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcEQEKAAoJEAVFT+BVnCUIKKEP/1ZzlaZ6us8HpKCmygx7UeML
2F31jyNrZgHC8P1y90krvSsmf3MTnDydnIbXd66HMoD90/gilmCETCz1Ssi+65M8
FDd8S2y+sVWVKS2OR9YN64fBGlegJZkRaSgE6X5gz54Q27j43RqUmLz4814nIP06
NrZZzCp7T/lSlb+lTia6LXEyNhlvu8LMfHtJH0NdiZwJhIqbI/g9b+Y2oC56mKQZ
9NcuiGsoAAZUgm5ZBbvxrV0DJTlc3UBbaXz0THk0JhHL3oP3sRrCI9tlV45LvnvD
LA1YBxKHIx1/3ccNq+KutkVwhG4mpnhxWdiz1dyFwFLP4HoJO8fZSxYfK5rG0i1r
KCRYJKscQRC44LNp1H0BHzODii4YiO9bZGdWJK3nnBiww3Xr9k/tXeQNniFgGERQ
p63jv7Lg8vRsFWL0fg+qL6lvvWyMPIoeuKWpR3bGg80JDVyp0DQCdXPK6RBREF8D
FS4B1+OIAKuqWL94Gbl9rcKD94DmM0i50K10TpTYc0iRAcI9qVctdayOeXQU2blW
bvXn7vmprULMoctQIUKgCMivROTuGuqgBBVGpKug9TEIivWjLnY+YAvXzKzcMe8w
4cQ7Rb1qq26cRfzIz+H+FZFuZ+jt6/Xpx/pBZwIWUb78EGyBouNItkDCZSXlpKoh
yE6PT1Lo9/CMjrYKsZ44
=Ictp
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
