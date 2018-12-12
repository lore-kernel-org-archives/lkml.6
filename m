Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF2BC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A231320870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A231320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeLLMEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:04:23 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:40860 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeLLMEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:04:22 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4932772CA65;
        Wed, 12 Dec 2018 15:04:17 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 3EC0D7CFF3E; Wed, 12 Dec 2018 15:04:17 +0300 (MSK)
Date:   Wed, 12 Dec 2018 15:04:17 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        lineprinter@altlinux.org, Eugene Syromiatnikov <esyr@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 13/25] m68k: add asm/syscall.h
Message-ID: <20181212120417.GC15561@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
 <20181210043010.GM6131@altlinux.org>
 <CAMuHMdVYq_2P=gb_zbSGFkPWASTds6uSPTyyhyNAgp2Qm5+feQ@mail.gmail.com>
 <20181210124059.GA11942@altlinux.org>
 <CAMuHMdW8ejp4gm2Xh-8inSQngQ5zRQ9bfsg1SG+BAD8RFV8xcA@mail.gmail.com>
 <20181210133025.GG11942@altlinux.org>
 <20181212085516.GA13288@altlinux.org>
 <CAMuHMdXwX57AZuVPdcEt_HZw1LT7tFpczJsqjW6C0VgHkhJ7dw@mail.gmail.com>
 <20181212092712.GD13288@altlinux.org>
 <CAMuHMdVvw3_3rm3v8J8u6ic6Wy3o70mOP1qaWQ=Ltf1XU=nnVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVvw3_3rm3v8J8u6ic6Wy3o70mOP1qaWQ=Ltf1XU=nnVQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Wed, Dec 12, 2018 at 10:43:33AM +0100, Geert Uytterhoeven wrote:
> On Wed, Dec 12, 2018 at 10:27 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > On Wed, Dec 12, 2018 at 10:01:29AM +0100, Geert Uytterhoeven wrote:
> > > On Wed, Dec 12, 2018 at 9:55 AM Dmitry V. Levin <ldv@altlinux.org> wr=
ote:
> > > > On Mon, Dec 10, 2018 at 04:30:25PM +0300, Dmitry V. Levin wrote:
> > > > > On Mon, Dec 10, 2018 at 02:06:28PM +0100, Geert Uytterhoeven wrot=
e:
> > > > > > On Mon, Dec 10, 2018 at 1:41 PM Dmitry V. Levin <ldv@altlinux.o=
rg> wrote:
> > > > > > > On Mon, Dec 10, 2018 at 09:45:42AM +0100, Geert Uytterhoeven =
wrote:
> > > > > > > > On Mon, Dec 10, 2018 at 5:30 AM Dmitry V. Levin <ldv@altlin=
ux.org> wrote:
> > > > > > > > > syscall_get_* functions are required to be implemented on=
 all
> > > > > > > > > architectures in order to extend the generic ptrace API w=
ith
> > > > > > > > > PTRACE_GET_SYSCALL_INFO request.
> > > > > > > > >
> > > > > > > > > This introduces asm/syscall.h on m68k implementing all 5 =
syscall_get_*
> > > > > > > > > functions as documented in asm-generic/syscall.h: syscall=
_get_nr,
> > > > > > > > > syscall_get_arguments, syscall_get_error, syscall_get_ret=
urn_value,
> > > > > > > > > and syscall_get_arch.
> > > > > > > > >
> > > > > > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > > > > > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > > > > > > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > > > > > > > > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > > > > > > > > Cc: linux-m68k@lists.linux-m68k.org
> > > > > > > > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > Notes:
> > > > > > > > >     v5: added syscall_get_nr, syscall_get_arguments, sysc=
all_get_error,
> > > > > > > > >         and syscall_get_return_value
> > > > > > > > >     v1: added syscall_get_arch
> > > > > > > >
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/arch/m68k/include/asm/syscall.h
> > > > > > > > > @@ -0,0 +1,39 @@
> > > > > > > >
> > > > > > > > > +static inline void
> > > > > > > > > +syscall_get_arguments(struct task_struct *task, struct p=
t_regs *regs,
> > > > > > > > > +                     unsigned int i, unsigned int n, uns=
igned long *args)
> > > > > > > > > +{
> > > > > > > > > +       BUG_ON(i + n > 6);
> > > > > > > >
> > > > > > > > Does this have to crash the kernel?
> > > > > > >
> > > > > > > This is what most of other architectures do, but we could cho=
ose
> > > > > > > a softer approach, e.g. use WARN_ON_ONCE instead.
> > > > > > >
> > > > > > > > Perhaps you can return an error code instead?
> > > > > > >
> > > > > > > That would be problematic given the signature of this function
> > > > > > > and the nature of the potential bug which would most likely b=
e a usage error.
> > > > > >
> > > > > > Of course to handle that, the function's signature need to be c=
hanged.
> > > > > > Changing it has the advantage that the error handling can be do=
ne at the
> > > > > > caller, in common code, instead of duplicating it for all
> > > > > > architectures, possibly
> > > > > > leading to different semantics.
> > > > >
> > > > > Given that *all* current users of syscall_get_arguments specify i=
 =3D=3D 0
> > > > > (and there is an architecture that has BUG_ON(i)),
> > > > > it should be really a usage error to get into situation where i +=
 n > 6,
> > > > > I wish a BUILD_BUG_ON could be used here instead.
> > > > >
> > > > > I don't think it worths pushing the change of API just to convert
> > > > > a "cannot happen" assertion into an error that would have to be d=
ealt with
> > > > > on the caller side.
> > > >
> > > > I suggest the following BUG_ON replacement for syscall_get_argument=
s:
> > > >
> > > > #define SYSCALL_MAX_ARGS 6
> > > >
> > > > static inline void
> > > > syscall_get_arguments(struct task_struct *task, struct pt_regs *reg=
s,
> > > >                       unsigned int i, unsigned int n, unsigned long=
 *args)
> > > > {
> > > >         /*
> > > >          * Ideally there should have been
> > > >          * BUILD_BUG_ON(i + n > SYSCALL_MAX_ARGS);
> > > >          * instead of these checks.
> > > >          */
> > > >         if (unlikely(i > SYSCALL_MAX_ARGS)) {
> > > >                 WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
> > > >                 return;
> > >
> > > Does this have security implications, as args is an output parameter?
> > > I.e. if you don't fill the array, the caller will use whatever is on =
the stack.
> > > Can this ever be passed to userspace, leaking data?
> >
> > In the current kernel code n is always less or equal to 6,
> > but in theory future changes can potentially break the assertion
> > and this could lead to leaking data to userspace.
>=20
> OK.
>=20
> > Do you think we should rather be defensive and add some memsets, e.g.
> >
> >         if (unlikely(i > SYSCALL_MAX_ARGS)) {
> >                 WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
> >                 memset(args, 0, n * sizeof(args[0]));
> >                 return;
> >         }
> >         if (unlikely(n > SYSCALL_MAX_ARGS - i)) {
> >                 unsigned int extra =3D n - (SYSCALL_MAX_ARGS - i);
> >
> >                 WARN_ONCE(1, "i + n > SYSCALL_MAX_ARGS");
> >                 n =3D SYSCALL_MAX_ARGS - i;
> >                 memset(&args[n], 0, extra * sizeof(args[0]));
> >         }
> > ?
>=20
> Yes please.
>=20
> But please handle all of that in the generic code, so it doesn't have to =
be
> replicated across all architectures.
>=20
> E.g. make syscall_get_arguments() a wrapper in generic code, calling
> __syscall_get_arguments() in architecture-specific code.
>=20
> And make the latter return int, so it can indicate other failures.

Other failures?  What syscall_get_arguments is expected to do
if __syscall_get_arguments returned, say, -1?

Anyway, as asm-generic/syscall.h is used for documentation purposes only,
I can try to prepare it for inclusion in other files without risk of
starting a big refactoring that would affect all architectures -- a thing
I'd rather not include into this series which is all about adding
PTRACE_GET_SYSCALL_INFO API.

I suppose there is no rush and arch-specific asm/syscall.h can switch
to use asm-generic/syscall.h gradually.


--=20
ldv

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcEPlAAAoJEAVFT+BVnCUIeCgP/Az/LQ6KIH3YJpJeGNYKG3jr
oL1Wmo2WROPVFLDRRZPNVA+AhPDPK28Za1eLCZg8oSUzZOn24QbnW0lzGNUeZZ9h
PFmUmOFVKlR+fQUqkXesw7o/Cct1NZiuCHJ1x7TXLPLBJUgYCiUunKYYjk5AI006
XBdToz4Q9cWX5q+XMBla6VZc7SYhL10FOClJjW2iF1PfqUSGGMDlXB9RG7ASDSmJ
Daz5+6uK/7SoVHcfwYy54ZMmP2hI8XBZo9j/rer/t4BTQffLiiWV6mFuWtnnTbnf
IvIeqDBXzsIiFUN0O1XSwytbZhQoMK/7+f6i9xODtRqVwnUQ/fvjD+WcRFi/RP4l
HMbZnHS/0daLMYGTiq9yF950WQhvUhIMO77QOEoDgRvEinDk2m4ykawNQDm3Pgd0
HPNV2Gmf3L8ioil6tAO+lW7MX1ThMUmAMZD9Ek5UxW5FZvElv8doSM8/9DS8HoDy
eS2WLxW7DjMHZ9ZlsYJP65XqV/FrA7lCn2142N6KmUSRM+oHofRHiSJNdRXgTEYg
SMWw9t5i9Fhz5Xzgv2IjwsLDvYRkUJ3SfCytTk+XyCemXP0bYUy8QYmeDNgnwlNz
7+85H5H8i3ff/fLTEVm4pmmuVaOZV+ANFq2jEsT98foxfps+IVbydtnH0zqijI54
RlBevQ3m5gbh5eaXykSR
=Ivzb
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
