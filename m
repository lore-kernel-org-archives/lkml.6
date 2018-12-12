Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6E4C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71B620839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71B620839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeLLNHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:07:30 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:59904 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeLLNHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:07:13 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7D3B372CA65;
        Wed, 12 Dec 2018 16:07:11 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 71A907CFF89; Wed, 12 Dec 2018 16:07:11 +0300 (MSK)
Date:   Wed, 12 Dec 2018 16:07:11 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        lineprinter@altlinux.org, Eugene Syromiatnikov <esyr@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 13/25] m68k: add asm/syscall.h
Message-ID: <20181212130711.GB16479@altlinux.org>
References: <CAMuHMdW8ejp4gm2Xh-8inSQngQ5zRQ9bfsg1SG+BAD8RFV8xcA@mail.gmail.com>
 <20181210133025.GG11942@altlinux.org>
 <20181212085516.GA13288@altlinux.org>
 <CAMuHMdXwX57AZuVPdcEt_HZw1LT7tFpczJsqjW6C0VgHkhJ7dw@mail.gmail.com>
 <20181212092712.GD13288@altlinux.org>
 <CAMuHMdVvw3_3rm3v8J8u6ic6Wy3o70mOP1qaWQ=Ltf1XU=nnVQ@mail.gmail.com>
 <20181212120417.GC15561@altlinux.org>
 <CAMuHMdXqJeH0C8FHy=G=ycArdkvjYPy48+3LmACnyS9RuqV30g@mail.gmail.com>
 <20181212123730.GA16479@altlinux.org>
 <CAMuHMdVJGpLYJp7CfvOYOmboRjFauWh1joqk=-kpLw212Oj7aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVJGpLYJp7CfvOYOmboRjFauWh1joqk=-kpLw212Oj7aA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Wed, Dec 12, 2018 at 01:54:05PM +0100, Geert Uytterhoeven wrote:
> On Wed, Dec 12, 2018 at 1:37 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > On Wed, Dec 12, 2018 at 01:27:14PM +0100, Geert Uytterhoeven wrote:
> > > On Wed, Dec 12, 2018 at 1:04 PM Dmitry V. Levin <ldv@altlinux.org> wr=
ote:
> > > > On Wed, Dec 12, 2018 at 10:43:33AM +0100, Geert Uytterhoeven wrote:
> > > > > On Wed, Dec 12, 2018 at 10:27 AM Dmitry V. Levin <ldv@altlinux.or=
g> wrote:
> > > > > > On Wed, Dec 12, 2018 at 10:01:29AM +0100, Geert Uytterhoeven wr=
ote:
> > > > > > > On Wed, Dec 12, 2018 at 9:55 AM Dmitry V. Levin <ldv@altlinux=
=2Eorg> wrote:
> > > > > > > > On Mon, Dec 10, 2018 at 04:30:25PM +0300, Dmitry V. Levin w=
rote:
> > > > > > > > > On Mon, Dec 10, 2018 at 02:06:28PM +0100, Geert Uytterhoe=
ven wrote:
> > > > > > > > > > On Mon, Dec 10, 2018 at 1:41 PM Dmitry V. Levin <ldv@al=
tlinux.org> wrote:
> > > > > > > > > > > On Mon, Dec 10, 2018 at 09:45:42AM +0100, Geert Uytte=
rhoeven wrote:
> > > > > > > > > > > > On Mon, Dec 10, 2018 at 5:30 AM Dmitry V. Levin <ld=
v@altlinux.org> wrote:
> > > > > > > > > > > > > syscall_get_* functions are required to be implem=
ented on all
> > > > > > > > > > > > > architectures in order to extend the generic ptra=
ce API with
> > > > > > > > > > > > > PTRACE_GET_SYSCALL_INFO request.
> > > > > > > > > > > > >
> > > > > > > > > > > > > This introduces asm/syscall.h on m68k implementin=
g all 5 syscall_get_*
> > > > > > > > > > > > > functions as documented in asm-generic/syscall.h:=
 syscall_get_nr,
> > > > > > > > > > > > > syscall_get_arguments, syscall_get_error, syscall=
_get_return_value,
> > > > > > > > > > > > > and syscall_get_arch.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > > > > > > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > > > > > > > > > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > > > > > > > > > > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > > > > > > > > > > > > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > > > > > > > > > > > > Cc: linux-m68k@lists.linux-m68k.org
> > > > > > > > > > > > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >
> > > > > > > > > > > > > Notes:
> > > > > > > > > > > > >     v5: added syscall_get_nr, syscall_get_argumen=
ts, syscall_get_error,
> > > > > > > > > > > > >         and syscall_get_return_value
> > > > > > > > > > > > >     v1: added syscall_get_arch
> > > > > > > > > > > >
> > > > > > > > > > > > > --- /dev/null
> > > > > > > > > > > > > +++ b/arch/m68k/include/asm/syscall.h
> > > > > > > > > > > > > @@ -0,0 +1,39 @@
> > > > > > > > > > > >
> > > > > > > > > > > > > +static inline void
> > > > > > > > > > > > > +syscall_get_arguments(struct task_struct *task, =
struct pt_regs *regs,
> > > > > > > > > > > > > +                     unsigned int i, unsigned in=
t n, unsigned long *args)
> > > > > > > > > > > > > +{
> > > > > > > > > > > > > +       BUG_ON(i + n > 6);
> > > > > > > > > > > >
> > > > > > > > > > > > Does this have to crash the kernel?
> > > > > > > > > > >
> > > > > > > > > > > This is what most of other architectures do, but we c=
ould choose
> > > > > > > > > > > a softer approach, e.g. use WARN_ON_ONCE instead.
> > > > > > > > > > >
> > > > > > > > > > > > Perhaps you can return an error code instead?
> > > > > > > > > > >
> > > > > > > > > > > That would be problematic given the signature of this=
 function
> > > > > > > > > > > and the nature of the potential bug which would most =
likely be a usage error.
> > > > > > > > > >
> > > > > > > > > > Of course to handle that, the function's signature need=
 to be changed.
> > > > > > > > > > Changing it has the advantage that the error handling c=
an be done at the
> > > > > > > > > > caller, in common code, instead of duplicating it for a=
ll
> > > > > > > > > > architectures, possibly
> > > > > > > > > > leading to different semantics.
> > > > > > > > >
> > > > > > > > > Given that *all* current users of syscall_get_arguments s=
pecify i =3D=3D 0
> > > > > > > > > (and there is an architecture that has BUG_ON(i)),
> > > > > > > > > it should be really a usage error to get into situation w=
here i + n > 6,
> > > > > > > > > I wish a BUILD_BUG_ON could be used here instead.
> > > > > > > > >
> > > > > > > > > I don't think it worths pushing the change of API just to=
 convert
> > > > > > > > > a "cannot happen" assertion into an error that would have=
 to be dealt with
> > > > > > > > > on the caller side.
> > > > > > > >
> > > > > > > > I suggest the following BUG_ON replacement for syscall_get_=
arguments:
> > > > > > > >
> > > > > > > > #define SYSCALL_MAX_ARGS 6
> > > > > > > >
> > > > > > > > static inline void
> > > > > > > > syscall_get_arguments(struct task_struct *task, struct pt_r=
egs *regs,
> > > > > > > >                       unsigned int i, unsigned int n, unsig=
ned long *args)
> > > > > > > > {
> > > > > > > >         /*
> > > > > > > >          * Ideally there should have been
> > > > > > > >          * BUILD_BUG_ON(i + n > SYSCALL_MAX_ARGS);
> > > > > > > >          * instead of these checks.
> > > > > > > >          */
> > > > > > > >         if (unlikely(i > SYSCALL_MAX_ARGS)) {
> > > > > > > >                 WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
> > > > > > > >                 return;
> > > > > > >
> > > > > > > Does this have security implications, as args is an output pa=
rameter?
> > > > > > > I.e. if you don't fill the array, the caller will use whateve=
r is on the stack.
> > > > > > > Can this ever be passed to userspace, leaking data?
> > > > > >
> > > > > > In the current kernel code n is always less or equal to 6,
> > > > > > but in theory future changes can potentially break the assertion
> > > > > > and this could lead to leaking data to userspace.
> > > > >
> > > > > OK.
> > > > >
> > > > > > Do you think we should rather be defensive and add some memsets=
, e.g.
> > > > > >
> > > > > >         if (unlikely(i > SYSCALL_MAX_ARGS)) {
> > > > > >                 WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
> > > > > >                 memset(args, 0, n * sizeof(args[0]));
> > > > > >                 return;
> > > > > >         }
> > > > > >         if (unlikely(n > SYSCALL_MAX_ARGS - i)) {
> > > > > >                 unsigned int extra =3D n - (SYSCALL_MAX_ARGS - =
i);
> > > > > >
> > > > > >                 WARN_ONCE(1, "i + n > SYSCALL_MAX_ARGS");
> > > > > >                 n =3D SYSCALL_MAX_ARGS - i;
> > > > > >                 memset(&args[n], 0, extra * sizeof(args[0]));
> > > > > >         }
> > > > > > ?
> > > > >
> > > > > Yes please.
> > > > >
> > > > > But please handle all of that in the generic code, so it doesn't =
have to be
> > > > > replicated across all architectures.
> > > > >
> > > > > E.g. make syscall_get_arguments() a wrapper in generic code, call=
ing
> > > > > __syscall_get_arguments() in architecture-specific code.
> > > > >
> > > > > And make the latter return int, so it can indicate other failures.
> > > >
> > > > Other failures?  What syscall_get_arguments is expected to do
> > > > if __syscall_get_arguments returned, say, -1?
> > >
> > > Fail. Just like in case of other generic ill conditions it can detect=
 itself.
> >
> > Sorry, I don't quite follow.  syscall_get_arguments() has no return cod=
e,
>=20
> Which may be an indicator for a different problem.
> What is e.g. populate_seccomp_data() supposed to do if
> syscall_get_arguments() fails?

Well, syscall_get_arguments() is not supposed to fail if invoked properly.

Currently populate_seccomp_data() does this:
	struct task_struct *task =3D current;
	struct pt_regs *regs =3D task_pt_regs(task);
	unsigned long args[6];
	...
	syscall_get_arguments(task, regs, 0, 6, args);

I don't see how this could fail.

> > so all it can possibly do is to zero out args[], e.g.
> >
> >         if (unlikely(__syscall_get_arguments(task, regs, i, n, args) < =
0)) {
> >                 memset(args, 0, n * sizeof(args[0]));
> >                 return;
> >         }
> >
> > Do you mean this?
>=20
> Exactly.

OK, I'll prepare the change, thanks.


--=20
ldv

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcEQf/AAoJEAVFT+BVnCUIlPgQAMGAtI7/42vOKKr/xEQt9okf
3l3K2+wmWCycpBuf1ikUE3qUtCNP2wZoY5AlvCI4MYOQ0AojM46Ijrvm/Uyflkyt
HY9W13ojdKnGnZ6Sj04YIhrmoDr0EIl5t4LqM8+C7ZXRw4nCKuUCPZTaAcWNTGF1
iSlgPuuBs+8wJkyaZX0flZV4RGQsXasVuxsKx+/hqW+cRBny9Jb5EmcDhf7vwmUR
O8r8SEve2ml3lXW6/1QKyt4VzpeXVALleMp9e+uyIz41cU+oD1YB8U6hrICopo/V
StDqgBgCSMyobyDXj6OXerv03swM5xV/rl5XT+p/C6uxjNqSOvnPv9N1Fy+YcYSj
65wIz9LXD3Z6mIZeQtoNLCXP1oSCr8Xz7RpbkECU5ecDv/C0ybqJ57wYTav0o6re
T3SFYQ/uJVG8Y17jmZVlp5ri7xX0BSdhaT7xdvOv2HGz/TIrcOh1T3YTlPiZtrie
qqWmw6AEVg4XgTXZ6GuZ9SHI41+8TohMUnZb/P4SX77WWkmX2zl6txyIH2E4tvRM
re7WOGFdTza7aqBDVSbXgfub7pI3xA1No75wYjvR494/HaBeX3ntceqYQqwNiOW2
Sm0w2RlD3qHfcmj0zINjeNCSX3VsPPFgUuIeAcekbt8LctEgRfWTKTl9k1X7B1lQ
cAedCEzz+vjkM62Zt5hO
=5oRj
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
