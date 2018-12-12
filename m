Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBA7C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A358F20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A358F20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeLLJ1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:27:15 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:53086 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeLLJ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:27:14 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id EFEFB72CA56;
        Wed, 12 Dec 2018 12:27:12 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id E23457CFE6C; Wed, 12 Dec 2018 12:27:12 +0300 (MSK)
Date:   Wed, 12 Dec 2018 12:27:12 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        lineprinter@altlinux.org, Eugene Syromiatnikov <esyr@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 13/25] m68k: add asm/syscall.h
Message-ID: <20181212092712.GD13288@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
 <20181210043010.GM6131@altlinux.org>
 <CAMuHMdVYq_2P=gb_zbSGFkPWASTds6uSPTyyhyNAgp2Qm5+feQ@mail.gmail.com>
 <20181210124059.GA11942@altlinux.org>
 <CAMuHMdW8ejp4gm2Xh-8inSQngQ5zRQ9bfsg1SG+BAD8RFV8xcA@mail.gmail.com>
 <20181210133025.GG11942@altlinux.org>
 <20181212085516.GA13288@altlinux.org>
 <CAMuHMdXwX57AZuVPdcEt_HZw1LT7tFpczJsqjW6C0VgHkhJ7dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXwX57AZuVPdcEt_HZw1LT7tFpczJsqjW6C0VgHkhJ7dw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 10:01:29AM +0100, Geert Uytterhoeven wrote:
> Hi Dmitry,
>=20
> On Wed, Dec 12, 2018 at 9:55 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > On Mon, Dec 10, 2018 at 04:30:25PM +0300, Dmitry V. Levin wrote:
> > > On Mon, Dec 10, 2018 at 02:06:28PM +0100, Geert Uytterhoeven wrote:
> > > > On Mon, Dec 10, 2018 at 1:41 PM Dmitry V. Levin <ldv@altlinux.org> =
wrote:
> > > > > On Mon, Dec 10, 2018 at 09:45:42AM +0100, Geert Uytterhoeven wrot=
e:
> > > > > > On Mon, Dec 10, 2018 at 5:30 AM Dmitry V. Levin <ldv@altlinux.o=
rg> wrote:
> > > > > > > syscall_get_* functions are required to be implemented on all
> > > > > > > architectures in order to extend the generic ptrace API with
> > > > > > > PTRACE_GET_SYSCALL_INFO request.
> > > > > > >
> > > > > > > This introduces asm/syscall.h on m68k implementing all 5 sysc=
all_get_*
> > > > > > > functions as documented in asm-generic/syscall.h: syscall_get=
_nr,
> > > > > > > syscall_get_arguments, syscall_get_error, syscall_get_return_=
value,
> > > > > > > and syscall_get_arch.
> > > > > > >
> > > > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > > > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > > > > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > > > > > > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > > > > > > Cc: linux-m68k@lists.linux-m68k.org
> > > > > > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Notes:
> > > > > > >     v5: added syscall_get_nr, syscall_get_arguments, syscall_=
get_error,
> > > > > > >         and syscall_get_return_value
> > > > > > >     v1: added syscall_get_arch
> > > > > >
> > > > > > > --- /dev/null
> > > > > > > +++ b/arch/m68k/include/asm/syscall.h
> > > > > > > @@ -0,0 +1,39 @@
> > > > > >
> > > > > > > +static inline void
> > > > > > > +syscall_get_arguments(struct task_struct *task, struct pt_re=
gs *regs,
> > > > > > > +                     unsigned int i, unsigned int n, unsigne=
d long *args)
> > > > > > > +{
> > > > > > > +       BUG_ON(i + n > 6);
> > > > > >
> > > > > > Does this have to crash the kernel?
> > > > >
> > > > > This is what most of other architectures do, but we could choose
> > > > > a softer approach, e.g. use WARN_ON_ONCE instead.
> > > > >
> > > > > > Perhaps you can return an error code instead?
> > > > >
> > > > > That would be problematic given the signature of this function
> > > > > and the nature of the potential bug which would most likely be a =
usage error.
> > > >
> > > > Of course to handle that, the function's signature need to be chang=
ed.
> > > > Changing it has the advantage that the error handling can be done a=
t the
> > > > caller, in common code, instead of duplicating it for all
> > > > architectures, possibly
> > > > leading to different semantics.
> > >
> > > Given that *all* current users of syscall_get_arguments specify i =3D=
=3D 0
> > > (and there is an architecture that has BUG_ON(i)),
> > > it should be really a usage error to get into situation where i + n >=
 6,
> > > I wish a BUILD_BUG_ON could be used here instead.
> > >
> > > I don't think it worths pushing the change of API just to convert
> > > a "cannot happen" assertion into an error that would have to be dealt=
 with
> > > on the caller side.
> >
> > I suggest the following BUG_ON replacement for syscall_get_arguments:
> >
> > #define SYSCALL_MAX_ARGS 6
> >
> > static inline void
> > syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
> >                       unsigned int i, unsigned int n, unsigned long *ar=
gs)
> > {
> >         /*
> >          * Ideally there should have been
> >          * BUILD_BUG_ON(i + n > SYSCALL_MAX_ARGS);
> >          * instead of these checks.
> >          */
> >         if (unlikely(i > SYSCALL_MAX_ARGS)) {
> >                 WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
> >                 return;
>=20
> Does this have security implications, as args is an output parameter?
> I.e. if you don't fill the array, the caller will use whatever is on the =
stack.
> Can this ever be passed to userspace, leaking data?

In the current kernel code n is always less or equal to 6,
but in theory future changes can potentially break the assertion
and this could lead to leaking data to userspace.

Do you think we should rather be defensive and add some memsets, e.g.

	if (unlikely(i > SYSCALL_MAX_ARGS)) {
		WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
		memset(args, 0, n * sizeof(args[0]));
		return;
	}
	if (unlikely(n > SYSCALL_MAX_ARGS - i)) {
		unsigned int extra =3D n - (SYSCALL_MAX_ARGS - i);

		WARN_ONCE(1, "i + n > SYSCALL_MAX_ARGS");
		n =3D SYSCALL_MAX_ARGS - i;
		memset(&args[n], 0, extra * sizeof(args[0]));
	}
?


--=20
ldv

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcENRwAAoJEAVFT+BVnCUIk3sP/2rxHFN0Xx6tm1fFkvpKCh3m
OwDhOEyvdBBbU7X7hGUCENtUoSytf8bpEFjokpxYWUOhFcjIYf/FQnuPAScl19Zx
3JwAGTFEk5l5ClfW5KYfdJvO5xj/JqcvKE5OQzmF8mUVV2yrwmnGEaXZkvxViKQg
NEBa0lGH1wAUzXqwezMKtsALez/u9YM0eFNSBUkOOitPpxlUPRYqJ1RGSAPvQQNz
vtSxJFvZ22CB1jr20a/lbLaXQc+75q1tgVUYFxuebdBgk0urXDkWj79FBNFLQQbb
st7XMzWvf28cd6UFk7rQj3lS/tG7/aSqCuJM6Wke94rAfgVccaq13a4uL0b1uhJ+
vQjA2Kh37U4r+yNX0zSBukA3IfEJphrURYzOIYhy1TmVP6yG9bdf46sDGYAQ7KiP
Jo6XxZdYjVYGULHQN83NcXD5s8hMgbF3BbdOURKr1OlriQeZ5XknAw3ce6ww8QAZ
bCq2R60nDZjUe6CCAMEIvuy3Qubz2gbErNg7b+wXARxJw9XVli2CiAQqzfoiRmtX
6Uh/2oaedtBO4c/V8MuGhKyP3bnx0VamBx1qW/8Er4KojaXw6Oe39RyEbaeu4VIX
hJnx+SjIA0+I8IocjhUJiBZ4dCSss3zkVjEQVX8cn0/co8aimoVxbSgPLmG2529n
gpmQd64c57KB9aQwEd8n
=nTHl
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
