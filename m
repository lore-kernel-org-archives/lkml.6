Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8664EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568E42084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568E42084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeLJNa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:30:29 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:41572 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbeLJNa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:30:28 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id CAADB72CC66;
        Mon, 10 Dec 2018 16:30:25 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id BF0CC7CF1FC; Mon, 10 Dec 2018 16:30:25 +0300 (MSK)
Date:   Mon, 10 Dec 2018 16:30:25 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        lineprinter@altlinux.org, Eugene Syromiatnikov <esyr@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 13/25] m68k: add asm/syscall.h
Message-ID: <20181210133025.GG11942@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
 <20181210043010.GM6131@altlinux.org>
 <CAMuHMdVYq_2P=gb_zbSGFkPWASTds6uSPTyyhyNAgp2Qm5+feQ@mail.gmail.com>
 <20181210124059.GA11942@altlinux.org>
 <CAMuHMdW8ejp4gm2Xh-8inSQngQ5zRQ9bfsg1SG+BAD8RFV8xcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <CAMuHMdW8ejp4gm2Xh-8inSQngQ5zRQ9bfsg1SG+BAD8RFV8xcA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Mon, Dec 10, 2018 at 02:06:28PM +0100, Geert Uytterhoeven wrote:
> On Mon, Dec 10, 2018 at 1:41 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > On Mon, Dec 10, 2018 at 09:45:42AM +0100, Geert Uytterhoeven wrote:
> > > On Mon, Dec 10, 2018 at 5:30 AM Dmitry V. Levin <ldv@altlinux.org> wr=
ote:
> > > > syscall_get_* functions are required to be implemented on all
> > > > architectures in order to extend the generic ptrace API with
> > > > PTRACE_GET_SYSCALL_INFO request.
> > > >
> > > > This introduces asm/syscall.h on m68k implementing all 5 syscall_ge=
t_*
> > > > functions as documented in asm-generic/syscall.h: syscall_get_nr,
> > > > syscall_get_arguments, syscall_get_error, syscall_get_return_value,
> > > > and syscall_get_arch.
> > > >
> > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > > > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > > > Cc: linux-m68k@lists.linux-m68k.org
> > > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > > ---
> > > >
> > > > Notes:
> > > >     v5: added syscall_get_nr, syscall_get_arguments, syscall_get_er=
ror,
> > > >         and syscall_get_return_value
> > > >     v1: added syscall_get_arch
> > >
> > > > --- /dev/null
> > > > +++ b/arch/m68k/include/asm/syscall.h
> > > > @@ -0,0 +1,39 @@
> > >
> > > > +static inline void
> > > > +syscall_get_arguments(struct task_struct *task, struct pt_regs *re=
gs,
> > > > +                     unsigned int i, unsigned int n, unsigned long=
 *args)
> > > > +{
> > > > +       BUG_ON(i + n > 6);
> > >
> > > Does this have to crash the kernel?
> >
> > This is what most of other architectures do, but we could choose
> > a softer approach, e.g. use WARN_ON_ONCE instead.
> >
> > > Perhaps you can return an error code instead?
> >
> > That would be problematic given the signature of this function
> > and the nature of the potential bug which would most likely be a usage =
error.
>=20
> Of course to handle that, the function's signature need to be changed.
> Changing it has the advantage that the error handling can be done at the
> caller, in common code, instead of duplicating it for all
> architectures, possibly
> leading to different semantics.

Given that *all* current users of syscall_get_arguments specify i =3D=3D 0
(and there is an architecture that has BUG_ON(i)),=20
it should be really a usage error to get into situation where i + n > 6,
I wish a BUILD_BUG_ON could be used here instead.

I don't think it worths pushing the change of API just to convert
a "cannot happen" assertion into an error that would have to be dealt with
on the caller side.


--=20
ldv

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcDmpxAAoJEAVFT+BVnCUI3DcP/j4lZGNykTpZLphxgSp27Zaa
VWC5E6e/HM1tH0RqIfRsYAmS1m15cYDG1MaoohsIMKUi0gzfXhJm/LCTbRlwQBKT
KA3c+NL7i0DYX5wo08BZbe33LkeHZxPrLbDV5lrJvEHV7M1U2QUSSZqvyqpcDes1
B3UGaYtnngHgK9E/WntEoPCibtVi7ThGWHohZQcoBtwvc9PX5t5wW3CDFsOxwMol
U1mGpMoyP8UYLF7WRfCBR+ESTTO9FB/Q0EBSfZXBjACAjQl4Ut2+VpgiBvJe/WDg
YbluyEoTDntS+tirjr5heZOSqq5RgjszRjiw4R86pgsZhZ6xg9SNKcUA0h3AQvVg
6DGQvgW3clt7po37gyJhqJww0FzOrZYLz9z2fy03koHwxY5hY3oDJzXcrSrxqRNB
VeNri5epY2mHIwgiOrjvqfnAN8A783PA1it/+S7ENj8SNgdDi1gJXLJMskOvvBWE
kxecuPGb+M9BvU2dKo1VpD6oRIKZYIDq3s+w9sFo7nCgINNE7Eo0I/ljRVwMNEOQ
rBcSVpMHr/EoWrGUpt6/EG3MsDsM0FoNuF3PObXsyYo7uE6yMeGU3AVJd7hpIzcC
TF+PVtAUP4IOIjSqu4N+GA3vGrqUjzc09xTKtNAj9m27gLteik+2oOhzY28wWchZ
f5P8a3qjNTe6/pFWd18w
=iMqD
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
