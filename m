Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2E6C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E13C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E13C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeLLIzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:55:19 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:33528 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLIzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:55:18 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3C1E672CA56;
        Wed, 12 Dec 2018 11:55:16 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 327137CFE41; Wed, 12 Dec 2018 11:55:16 +0300 (MSK)
Date:   Wed, 12 Dec 2018 11:55:16 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        lineprinter@altlinux.org, Eugene Syromiatnikov <esyr@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 13/25] m68k: add asm/syscall.h
Message-ID: <20181212085516.GA13288@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
 <20181210043010.GM6131@altlinux.org>
 <CAMuHMdVYq_2P=gb_zbSGFkPWASTds6uSPTyyhyNAgp2Qm5+feQ@mail.gmail.com>
 <20181210124059.GA11942@altlinux.org>
 <CAMuHMdW8ejp4gm2Xh-8inSQngQ5zRQ9bfsg1SG+BAD8RFV8xcA@mail.gmail.com>
 <20181210133025.GG11942@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20181210133025.GG11942@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 04:30:25PM +0300, Dmitry V. Levin wrote:
> On Mon, Dec 10, 2018 at 02:06:28PM +0100, Geert Uytterhoeven wrote:
> > On Mon, Dec 10, 2018 at 1:41 PM Dmitry V. Levin <ldv@altlinux.org> wrot=
e:
> > > On Mon, Dec 10, 2018 at 09:45:42AM +0100, Geert Uytterhoeven wrote:
> > > > On Mon, Dec 10, 2018 at 5:30 AM Dmitry V. Levin <ldv@altlinux.org> =
wrote:
> > > > > syscall_get_* functions are required to be implemented on all
> > > > > architectures in order to extend the generic ptrace API with
> > > > > PTRACE_GET_SYSCALL_INFO request.
> > > > >
> > > > > This introduces asm/syscall.h on m68k implementing all 5 syscall_=
get_*
> > > > > functions as documented in asm-generic/syscall.h: syscall_get_nr,
> > > > > syscall_get_arguments, syscall_get_error, syscall_get_return_valu=
e,
> > > > > and syscall_get_arch.
> > > > >
> > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > > > > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > > > > Cc: linux-m68k@lists.linux-m68k.org
> > > > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > > > ---
> > > > >
> > > > > Notes:
> > > > >     v5: added syscall_get_nr, syscall_get_arguments, syscall_get_=
error,
> > > > >         and syscall_get_return_value
> > > > >     v1: added syscall_get_arch
> > > >
> > > > > --- /dev/null
> > > > > +++ b/arch/m68k/include/asm/syscall.h
> > > > > @@ -0,0 +1,39 @@
> > > >
> > > > > +static inline void
> > > > > +syscall_get_arguments(struct task_struct *task, struct pt_regs *=
regs,
> > > > > +                     unsigned int i, unsigned int n, unsigned lo=
ng *args)
> > > > > +{
> > > > > +       BUG_ON(i + n > 6);
> > > >
> > > > Does this have to crash the kernel?
> > >
> > > This is what most of other architectures do, but we could choose
> > > a softer approach, e.g. use WARN_ON_ONCE instead.
> > >
> > > > Perhaps you can return an error code instead?
> > >
> > > That would be problematic given the signature of this function
> > > and the nature of the potential bug which would most likely be a usag=
e error.
> >=20
> > Of course to handle that, the function's signature need to be changed.
> > Changing it has the advantage that the error handling can be done at the
> > caller, in common code, instead of duplicating it for all
> > architectures, possibly
> > leading to different semantics.
>=20
> Given that *all* current users of syscall_get_arguments specify i =3D=3D 0
> (and there is an architecture that has BUG_ON(i)),=20
> it should be really a usage error to get into situation where i + n > 6,
> I wish a BUILD_BUG_ON could be used here instead.
>=20
> I don't think it worths pushing the change of API just to convert
> a "cannot happen" assertion into an error that would have to be dealt with
> on the caller side.

I suggest the following BUG_ON replacement for syscall_get_arguments:

#define SYSCALL_MAX_ARGS 6

static inline void
syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
		      unsigned int i, unsigned int n, unsigned long *args)
{
	/*
	 * Ideally there should have been
	 * BUILD_BUG_ON(i + n > SYSCALL_MAX_ARGS);
	 * instead of these checks.
	 */
	if (unlikely(i > SYSCALL_MAX_ARGS)) {
		WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
		return;
	}
	if (unlikely(n > SYSCALL_MAX_ARGS - i)) {
		WARN_ONCE(1, "i + n > SYSCALL_MAX_ARGS");
		n =3D SYSCALL_MAX_ARGS - i;
	}
	BUILD_BUG_ON(sizeof(regs->d1) !=3D sizeof(args[0]));
	memcpy(args, &regs->d1 + i, n * sizeof(args[0]));
}


--=20
ldv

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcEMzzAAoJEAVFT+BVnCUIJTsQAOmj7OloZvGD8dgggADIyI0s
z5azwyQpfO3yX7sYLZxpg7SrZEmwSiv9wer6S5nQDQ6QXHisZYp7L/aI+h4tuCoe
HlOUxX8etVSCqZgWZMgooylO8D9roSbHjfsSC7hTReunMeY+xv9nLYTvXnyP4TdL
URVu4vLNatpFsXzWiK5qCH9QodBIklZrt0M1OjCeVrn+kV5Ui9gK0lbfcfGK0H0C
445bHjFgmtZVxPgpy6foekRYiLvijoVNMTxOHakEhSOFO3RnStcGHRj8sXlzoiBo
pu9NSx62F6iSLPR/AL8adJKpcNOTp52GT4QNYnXLQezMgWSbi495+54RKjFfui6/
eC2MVBZpPMktYA8XsgMNYdDOW+IbbNvxvfMZ2ZhF3G+9jiI8BaigD4zhI6qU6Ddf
Urx/hRcR/1tCaTDBnALfokI2yioPen6pR4bztzdns7jK+LIGbTzPwO/RZXGd+Z2x
k/TABg0u619M+TQcjkYLeuJ/8Xirpoo3YnIECs9ojuMUkCpZbBRlrqDsDerkRvjm
3TlmRWM7PZou2EvMBnB0+CTID8s/dxBXMRAZuQu5yWoqwWrRTKzx8AMWJv9ymQV9
ocDp7nFiIWy4HpvK1s+dkT3+4FKPy4nq1p9XAVd/a1BB55V3TQILwj2BGLr/FWfp
5Gl+JhJCCcikFhQMuOKt
=mDWX
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
