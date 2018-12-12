Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD05C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1C82084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1C82084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbeLLXMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:12:35 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:53136 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeLLXMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:12:34 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5E40972CC70;
        Thu, 13 Dec 2018 02:12:28 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 3A32895D253; Thu, 13 Dec 2018 02:12:28 +0300 (MSK)
Date:   Thu, 13 Dec 2018 02:12:28 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        lineprinter@altlinux.org, Eugene Syromiatnikov <esyr@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 13/25] m68k: add asm/syscall.h
Message-ID: <20181212231228.GA24195@altlinux.org>
References: <20181210133025.GG11942@altlinux.org>
 <20181212085516.GA13288@altlinux.org>
 <CAMuHMdXwX57AZuVPdcEt_HZw1LT7tFpczJsqjW6C0VgHkhJ7dw@mail.gmail.com>
 <20181212092712.GD13288@altlinux.org>
 <CAMuHMdVvw3_3rm3v8J8u6ic6Wy3o70mOP1qaWQ=Ltf1XU=nnVQ@mail.gmail.com>
 <20181212120417.GC15561@altlinux.org>
 <CAMuHMdXqJeH0C8FHy=G=ycArdkvjYPy48+3LmACnyS9RuqV30g@mail.gmail.com>
 <20181212123730.GA16479@altlinux.org>
 <CAMuHMdVJGpLYJp7CfvOYOmboRjFauWh1joqk=-kpLw212Oj7aA@mail.gmail.com>
 <20181212130711.GB16479@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20181212130711.GB16479@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Wed, Dec 12, 2018 at 04:07:11PM +0300, Dmitry V. Levin wrote:
> On Wed, Dec 12, 2018 at 01:54:05PM +0100, Geert Uytterhoeven wrote:
> > On Wed, Dec 12, 2018 at 1:37 PM Dmitry V. Levin <ldv@altlinux.org> wrot=
e:
> > > On Wed, Dec 12, 2018 at 01:27:14PM +0100, Geert Uytterhoeven wrote:
> > > > On Wed, Dec 12, 2018 at 1:04 PM Dmitry V. Levin <ldv@altlinux.org> =
wrote:
> > > > > On Wed, Dec 12, 2018 at 10:43:33AM +0100, Geert Uytterhoeven wrot=
e:
> > > > > > On Wed, Dec 12, 2018 at 10:27 AM Dmitry V. Levin <ldv@altlinux.=
org> wrote:
> > > > > > > On Wed, Dec 12, 2018 at 10:01:29AM +0100, Geert Uytterhoeven =
wrote:
> > > > > > > > On Wed, Dec 12, 2018 at 9:55 AM Dmitry V. Levin <ldv@altlin=
ux.org> wrote:
> > > > > > > > > On Mon, Dec 10, 2018 at 04:30:25PM +0300, Dmitry V. Levin=
 wrote:
> > > > > > > > > > On Mon, Dec 10, 2018 at 02:06:28PM +0100, Geert Uytterh=
oeven wrote:
> > > > > > > > > > > On Mon, Dec 10, 2018 at 1:41 PM Dmitry V. Levin <ldv@=
altlinux.org> wrote:
> > > > > > > > > > > > On Mon, Dec 10, 2018 at 09:45:42AM +0100, Geert Uyt=
terhoeven wrote:
> > > > > > > > > > > > > On Mon, Dec 10, 2018 at 5:30 AM Dmitry V. Levin <=
ldv@altlinux.org> wrote:
> > > > > > > > > > > > > > syscall_get_* functions are required to be impl=
emented on all
> > > > > > > > > > > > > > architectures in order to extend the generic pt=
race API with
> > > > > > > > > > > > > > PTRACE_GET_SYSCALL_INFO request.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > This introduces asm/syscall.h on m68k implement=
ing all 5 syscall_get_*
> > > > > > > > > > > > > > functions as documented in asm-generic/syscall.=
h: syscall_get_nr,
> > > > > > > > > > > > > > syscall_get_arguments, syscall_get_error, sysca=
ll_get_return_value,
> > > > > > > > > > > > > > and syscall_get_arch.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > > > > > > > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > > > > > > > > > > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > > > > > > > > > > > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > > > > > > > > > > > > > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > > > > > > > > > > > > > Cc: linux-m68k@lists.linux-m68k.org
> > > > > > > > > > > > > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.or=
g>
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Notes:
> > > > > > > > > > > > > >     v5: added syscall_get_nr, syscall_get_argum=
ents, syscall_get_error,
> > > > > > > > > > > > > >         and syscall_get_return_value
> > > > > > > > > > > > > >     v1: added syscall_get_arch
> > > > > > > > > > > > >
> > > > > > > > > > > > > > --- /dev/null
> > > > > > > > > > > > > > +++ b/arch/m68k/include/asm/syscall.h
> > > > > > > > > > > > > > @@ -0,0 +1,39 @@
> > > > > > > > > > > > >
> > > > > > > > > > > > > > +static inline void
> > > > > > > > > > > > > > +syscall_get_arguments(struct task_struct *task=
, struct pt_regs *regs,
> > > > > > > > > > > > > > +                     unsigned int i, unsigned =
int n, unsigned long *args)
> > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > +       BUG_ON(i + n > 6);
> > > > > > > > > > > > >
> > > > > > > > > > > > > Does this have to crash the kernel?
> > > > > > > > > > > >
> > > > > > > > > > > > This is what most of other architectures do, but we=
 could choose
> > > > > > > > > > > > a softer approach, e.g. use WARN_ON_ONCE instead.
> > > > > > > > > > > >
> > > > > > > > > > > > > Perhaps you can return an error code instead?
> > > > > > > > > > > >
> > > > > > > > > > > > That would be problematic given the signature of th=
is function
> > > > > > > > > > > > and the nature of the potential bug which would mos=
t likely be a usage error.
> > > > > > > > > > >
> > > > > > > > > > > Of course to handle that, the function's signature ne=
ed to be changed.
> > > > > > > > > > > Changing it has the advantage that the error handling=
 can be done at the
> > > > > > > > > > > caller, in common code, instead of duplicating it for=
 all
> > > > > > > > > > > architectures, possibly
> > > > > > > > > > > leading to different semantics.
> > > > > > > > > >
> > > > > > > > > > Given that *all* current users of syscall_get_arguments=
 specify i =3D=3D 0
> > > > > > > > > > (and there is an architecture that has BUG_ON(i)),
> > > > > > > > > > it should be really a usage error to get into situation=
 where i + n > 6,
> > > > > > > > > > I wish a BUILD_BUG_ON could be used here instead.
> > > > > > > > > >
> > > > > > > > > > I don't think it worths pushing the change of API just =
to convert
> > > > > > > > > > a "cannot happen" assertion into an error that would ha=
ve to be dealt with
> > > > > > > > > > on the caller side.
> > > > > > > > >
> > > > > > > > > I suggest the following BUG_ON replacement for syscall_ge=
t_arguments:
> > > > > > > > >
> > > > > > > > > #define SYSCALL_MAX_ARGS 6
> > > > > > > > >
> > > > > > > > > static inline void
> > > > > > > > > syscall_get_arguments(struct task_struct *task, struct pt=
_regs *regs,
> > > > > > > > >                       unsigned int i, unsigned int n, uns=
igned long *args)
> > > > > > > > > {
> > > > > > > > >         /*
> > > > > > > > >          * Ideally there should have been
> > > > > > > > >          * BUILD_BUG_ON(i + n > SYSCALL_MAX_ARGS);
> > > > > > > > >          * instead of these checks.
> > > > > > > > >          */
> > > > > > > > >         if (unlikely(i > SYSCALL_MAX_ARGS)) {
> > > > > > > > >                 WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
> > > > > > > > >                 return;
> > > > > > > >
> > > > > > > > Does this have security implications, as args is an output =
parameter?
> > > > > > > > I.e. if you don't fill the array, the caller will use whate=
ver is on the stack.
> > > > > > > > Can this ever be passed to userspace, leaking data?
> > > > > > >
> > > > > > > In the current kernel code n is always less or equal to 6,
> > > > > > > but in theory future changes can potentially break the assert=
ion
> > > > > > > and this could lead to leaking data to userspace.
> > > > > >
> > > > > > OK.
> > > > > >
> > > > > > > Do you think we should rather be defensive and add some memse=
ts, e.g.
> > > > > > >
> > > > > > >         if (unlikely(i > SYSCALL_MAX_ARGS)) {
> > > > > > >                 WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
> > > > > > >                 memset(args, 0, n * sizeof(args[0]));
> > > > > > >                 return;
> > > > > > >         }
> > > > > > >         if (unlikely(n > SYSCALL_MAX_ARGS - i)) {
> > > > > > >                 unsigned int extra =3D n - (SYSCALL_MAX_ARGS =
- i);
> > > > > > >
> > > > > > >                 WARN_ONCE(1, "i + n > SYSCALL_MAX_ARGS");
> > > > > > >                 n =3D SYSCALL_MAX_ARGS - i;
> > > > > > >                 memset(&args[n], 0, extra * sizeof(args[0]));
> > > > > > >         }
> > > > > > > ?
> > > > > >
> > > > > > Yes please.
> > > > > >
> > > > > > But please handle all of that in the generic code, so it doesn'=
t have to be
> > > > > > replicated across all architectures.
> > > > > >
> > > > > > E.g. make syscall_get_arguments() a wrapper in generic code, ca=
lling
> > > > > > __syscall_get_arguments() in architecture-specific code.
> > > > > >
> > > > > > And make the latter return int, so it can indicate other failur=
es.
> > > > >
> > > > > Other failures?  What syscall_get_arguments is expected to do
> > > > > if __syscall_get_arguments returned, say, -1?
> > > >
> > > > Fail. Just like in case of other generic ill conditions it can dete=
ct itself.
> > >
> > > Sorry, I don't quite follow.  syscall_get_arguments() has no return c=
ode,
> >=20
> > Which may be an indicator for a different problem.
> > What is e.g. populate_seccomp_data() supposed to do if
> > syscall_get_arguments() fails?
>=20
> Well, syscall_get_arguments() is not supposed to fail if invoked properly.
>=20
> Currently populate_seccomp_data() does this:
> 	struct task_struct *task =3D current;
> 	struct pt_regs *regs =3D task_pt_regs(task);
> 	unsigned long args[6];
> 	...
> 	syscall_get_arguments(task, regs, 0, 6, args);
>=20
> I don't see how this could fail.
>=20
> > > so all it can possibly do is to zero out args[], e.g.
> > >
> > >         if (unlikely(__syscall_get_arguments(task, regs, i, n, args) =
< 0)) {
> > >                 memset(args, 0, n * sizeof(args[0]));
> > >                 return;
> > >         }
> > >
> > > Do you mean this?
> >=20
> > Exactly.
>=20
> OK, I'll prepare the change, thanks.

I have the change ready, but I don't like it.  The only architecture
that could benefit from being able of signalling an error condition to
syscall_get_arguments is MIPS, and even in that case the return code is
not suitable because it wouldn't help to distinguish between the first 4
syscall arguments that cannot cause an error and remaining arguments that
can.  It looks like there is no need to make __syscall_get_arguments()
to return int after all.


--=20
ldv

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcEZXbAAoJEAVFT+BVnCUIZ6MQAI484glw6id/flu/J6HanrXH
YXyZ0SktJchbsonGJqf5X1yCXfRcEpqqYcTsiibcEoPgvcTtB9643qZj+H7HloC8
BgxbgUxpNRt7t/xUKf/ezRk7qPw/XvuJo7mTjj1uAOCWR6Br5Cza5U9CnOglOh0q
LTlZ1G1/+5O20KbCZfihON1dHdsOAUaplWEPz3fzpKXKsreI46p0LIQfgOF414J4
npHEOJl/317DecKtsjVHwMaP3mGeFzmuYkHvv2iVPArjXVUi1amJhEHMTs6UKgGZ
gknWIj9y4f1x2me30ayd7YMDRdA4+3+aoJh/xLQDWdBVwOPRGbUkaUq0bW5u6Iit
Bmk7tLufiPEnDmoTqpbVTjdXghifK5V9YbyUuY4zJKbi7g6HKv6ldW6BvNgg6Wpc
U5MKZN6cUIR8dadJXurifEF95V0oSbP1J0RlWF8a/JtVHcfNazKwra0XKwWXqjhZ
OucdBsZuZ1m+3dZZLRUzEqOQySQhppOPYhtc461ksZTRY2EIo1w4v+W/ggBzcNjO
p/OTdn0Ptck+6gjuUGKm/SuMOKS9rQGLCvcyLxk4DiyJDLCsgOmpvBw7Ybc47exF
dQBfCpptXeUDKvLuKyLxC9xVQy/Hn8SEf/PXC0DQMIvFVB03+d28zZ5kBK//rWu4
QVRdxvUH11qU0lE9iVj1
=Ja5k
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
