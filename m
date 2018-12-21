Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D0AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94A3218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390880AbeLUCgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 21:36:44 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:54618 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732366AbeLUCgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 21:36:44 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E123572CC53;
        Fri, 21 Dec 2018 05:36:41 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id D8067964EB0; Fri, 21 Dec 2018 05:36:41 +0300 (MSK)
Date:   Fri, 21 Dec 2018 05:36:41 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/27] csky: define syscall_get_arch()
Message-ID: <20181221023641.GC5396@altlinux.org>
References: <20181213171833.GA5240@altlinux.org>
 <20181213172207.GH6024@altlinux.org>
 <20181214044412.GB15793@guoren-Inspiron-7460>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <20181214044412.GB15793@guoren-Inspiron-7460>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 14, 2018 at 12:44:12PM +0800, Guo Ren wrote:
> Thx Dmitry,
>=20
> Reviewed-by: Guo Ren <guoren@kernel.org>

Given that the whole series is going to be pinged for quite some
time yet, would you mind taking this patch into the csky tree?
=20
Thanks.

> On Thu, Dec 13, 2018 at 08:22:07PM +0300, Dmitry V. Levin wrote:
> > syscall_get_arch() is required to be implemented on all architectures
> > in order to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO
> > request.
> >=20
> > Cc: Guo Ren <guoren@kernel.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Eric Paris <eparis@redhat.com>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > Cc: linux-audit@redhat.com
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > ---
> >=20
> > Notes:
> >     v6: unchanged
> >=20
> >  arch/csky/include/asm/syscall.h | 7 +++++++
> >  include/uapi/linux/audit.h      | 1 +
> >  2 files changed, 8 insertions(+)
> >=20
> > diff --git a/arch/csky/include/asm/syscall.h b/arch/csky/include/asm/sy=
scall.h
> > index 926a64a8b4ee..d637445737b7 100644
> > --- a/arch/csky/include/asm/syscall.h
> > +++ b/arch/csky/include/asm/syscall.h
> > @@ -6,6 +6,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/err.h>
> >  #include <abi/regdef.h>
> > +#include <uapi/linux/audit.h>
> > =20
> >  static inline int
> >  syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
> > @@ -68,4 +69,10 @@ syscall_set_arguments(struct task_struct *task, stru=
ct pt_regs *regs,
> >  	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
> >  }
> > =20
> > +static inline int
> > +syscall_get_arch(void)
> > +{
> > +	return AUDIT_ARCH_CSKY;
> > +}
> > +
> >  #endif	/* __ASM_SYSCALL_H */
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index 72aeea0a740d..55904a40d768 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -384,6 +384,7 @@ enum {
> >  #define AUDIT_ARCH_C6X		(EM_TI_C6000|__AUDIT_ARCH_LE)
> >  #define AUDIT_ARCH_C6XBE	(EM_TI_C6000)
> >  #define AUDIT_ARCH_CRIS		(EM_CRIS|__AUDIT_ARCH_LE)
> > +#define AUDIT_ARCH_CSKY		(EM_CSKY|__AUDIT_ARCH_LE)
> >  #define AUDIT_ARCH_FRV		(EM_FRV)
> >  #define AUDIT_ARCH_I386		(EM_386|__AUDIT_ARCH_LE)
> >  #define AUDIT_ARCH_IA64		(EM_IA_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> > --=20
> > ldv

--=20
ldv

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcHFG5AAoJEAVFT+BVnCUI+1YP/jny0alvZu6bq3QSFaOUBu04
G68bAjATbAj7ZK/JLAkkUj2IP9DdBHCEgRu+TJR5fk8zP5Hkvdlift4mgritWRsV
tjVYmp54GXYTP4aV/W81/7Q9G2Kb4uUV7KSFGJpdNJx5WMGeYE7M9uK/fcJkQB/U
3AOTEIBL/uPgEsvZgX0HRBi2JE5obMO0Odc0ypW8uFuWQW2o+Q2zEJzywKFi+mok
ISl1TTHxwaxnrWrkZ2qH6Ci8uXloq5GS9j8UuRpL16C7wKEoawefKxiwg6RBf1wa
jFa/niuNTjHHhDt7CcTtXmJWcmTenIzEnIAvGhCyQy6Zy73SpZKvt9dT3W9X+MpI
PjRFFEprNAX/jLz+YD/yGl6yqz/gL6alQxZbCst5P1EoX5LPPmY64vlka1QPBxsx
pJmKpULXkAsotOCauYHga7JkGBsZ5zi/rgNNTqAgfGpDQCY+BozXefPgl+Od2WlJ
I3wUyh2X7D/PtC0f3dezgBOr+fA4rz9orCLkG9CKYAbEmj6WUnzrqwQWOfnvVSb9
zyIh9g7AIWkkIuJS6F9DxPyW4qGL6LgsY59aZLc/xtZsI1dybKQgAlz7PQ1N49Ea
3ouE6CtbxFRp4W3s637uDXDUR/ZiSnCSl3hJz//sNy9yR4zpNFaH8h6K3cFh5+Al
B2UHlD35OhPt18WatEIA
=kgr4
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
