Return-Path: <kernel-hardening-return-13129-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZqU6NPONjD24da53sRqNf4krRH3hwqgBe9AoAXxlMwbGpFXkN5FSG+cHOmpPXpwQS7Qa/Kr
ARC-Seal: i=1; a=rsa-sha256; t=1524619083; cv=none;
        d=google.com; s=arc-20160816;
        b=p2suPdAimQqQFib4DcbGIZgWfr6lKyHmkAWySdbRDlf2a/UeKlnJrzsY9zXuDSowB2
         X2OBrNzUcosW4chTSu8qFXzu3YSa7LTIVWUKhGoSJodN3bx9Sf+jsqDSFL2tTs4wk79h
         ff7jT9DrlTmjMS7ldzos8z7xO14dJBC+bFZxFsT6ryuROWprUoOWxb2pp56GeCvkbDrn
         zdy9GYvRzW2lMoryvAE6tnjac7JERa+/Us+jE/h7rVYsBm3IkbPpvaMgZYa/WFljjAU9
         E50CNvQ8x5ag2xi0JbyXg5AG55szGTjx2zEP+Ko6mgjJtbJco8UU6Z7iQcO5PvLaq+oz
         YYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=hgxLNEy4+mqKJqmZYSV0FqPgQF9EpKnSrBX8z27Wmtc=;
        b=bSwWAR3vriYPErDpNKcTMMsMvOFzMksGYttdhlddLjK1R+r/9MpoY4ahcpb8luy9Bs
         zPntmvJ1crbCJpKIn6igGM5eaDW/DcW6NtPDWYY9k1/t1bGv7Qu+kScDfz/Y1sN++EjN
         3+hhyBLkrv+6+U94RyzJ/MiF3+sBQoRjl60HQOVUwzUmH9oG7Nbzj3DxYdqxiOaHQkud
         JVRqzcew1kfTJtteD2wi/KhebtZt0f+32Gv8Rqn+b20UUOe2yRWjp5JFi7zQtiLnuaww
         kKWunUrzvLEUc3B1A20L1vjxXzI5ji7aX23p2vE8UOwVBF6PqEDvX2JS9/venNa0o9NY
         ooVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@canb.auug.org.au header.s=201702 header.b=DBU3WeCE;
       spf=pass (google.com: domain of kernel-hardening-return-13129-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13129-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@canb.auug.org.au header.s=201702 header.b=DBU3WeCE;
       spf=pass (google.com: domain of kernel-hardening-return-13129-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13129-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 25 Apr 2018 11:16:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
 Segher Boessenkool <segher@kernel.crashing.org>, Kernel Hardening
 <kernel-hardening@lists.openwall.com>, Andrew Morton
 <akpm@linuxfoundation.org>, Boris Brezillon
 <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>,
 David Woodhouse <dwmw2@infradead.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@redhat.com>, Anton Vorontsov <anton@enomsg.org>,
 Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, Neil
 Brown <neilb@suse.com>
Subject: Re: [patch V3 01/10] rslib: Add GFP aware init function
Message-ID: <20180425111617.2f4dc127@canb.auug.org.au>
In-Reply-To: <20180422162512.363154748@linutronix.de>
References: <20180422162345.004292133@linutronix.de>
	<20180422162512.363154748@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FEjP3biZc_p55XmvXMS7DkJ"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598464733406749436?=
X-GMAIL-MSGID: =?utf-8?q?1598678980420729691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/FEjP3biZc_p55XmvXMS7DkJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Sun, 22 Apr 2018 18:23:46 +0200 Thomas Gleixner <tglx@linutronix.de> wro=
te:
>
> The rslib usage in dm/verity_fec is broken because init_rs() can nest in
> GFP_NOIO mempool allocations as init_rs() is invoked from the mempool all=
oc
> callback.
>=20
> Provide a variant which takes gfp_t flags as argument.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Neil Brown <neilb@suse.com>
> ---
>  include/linux/rslib.h           |   26 +++++++++++++++++++++++---
>  lib/reed_solomon/reed_solomon.c |   36 ++++++++++++++++++++-------------=
---
>  2 files changed, 43 insertions(+), 19 deletions(-)
>=20
> --- a/include/linux/rslib.h
> +++ b/include/linux/rslib.h
> @@ -77,10 +77,30 @@ int decode_rs16(struct rs_control *rs, u
>  #endif
> =20
>  /* Create or get a matching rs control structure */
> -struct rs_control *init_rs(int symsize, int gfpoly, int fcr, int prim,
> -			   int nroots);
> +struct rs_control *init_rs_gfp(int symsize, int gfpoly, int fcr, int pri=
m,
> +			       int nroots, gfp_t gfp);
> +
> +/**
> + * init_rs - Create a RS control struct and initialize it
> + *  @symsize:	the symbol size (number of bits)
> + *  @gfpoly:	the extended Galois field generator polynomial coefficients,
> + *		with the 0th coefficient in the low order bit. The polynomial
> + *		must be primitive;
> + *  @fcr:	the first consecutive root of the rs code generator polynomial
> + *		in index form
> + *  @prim:	primitive element to generate polynomial roots
> + *  @nroots:	RS code generator polynomial degree (number of roots)
> + *
> + * Allocations use GFP_KERNEL.
> + */
> +static inline struct rs_control *init_rs(int symsize, int gfpoly, int fc=
r,
> +					 int prim, int nroots)
> +{
> +	return init_rs_gfp(symsize, gfpoly, fcr, prim, nroots, GFP_KERNEL);
> +}
> +

The version of this patch that Kees has committed to his kspp tree in linux=
-next has

#include <linux/slab.h>

why not just

#include <linux/types.h>	/* for gpf_t */
#include <linux/gpf.h>		/* for GFP_KERNEL */

?
--=20
Cheers,
Stephen Rothwell

--Sig_/FEjP3biZc_p55XmvXMS7DkJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrf1uEACgkQAVBC80lX
0GwdiAgAh2IsI8eH5M4eMgRi4XhtunwTjLxD+o2o1Dsrfa33+uh3y4bzOVJA7Kwq
xaU6+1q40QG6TYZNAK0uLWu/s9kyb6klmUUCxxX3I3+3BxN/qmEwrlQS1gG8uUSE
qxtvRDSbAVZu8BF5l/aWelIao8qMQECZOP+Aj8OgoxMd9YDT2jtJMDqqmdvsckQG
Wtbz1Z6i+W2CAIahQImw5uGiSdeoKwXvWKWd8mzbqM4Ys6p1sAEyz1RZQs36AlyE
T8ApRe9UjU/WHVidHiv6uJAUoC2xLMqIFbyjo5bHY6qe9xgMuu2OfxogQ7Lh0hY5
OUqADjuYkyowdIlYXo0BbJaWGdUHsw==
=oadR
-----END PGP SIGNATURE-----

--Sig_/FEjP3biZc_p55XmvXMS7DkJ--
