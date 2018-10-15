Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B71AC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6F12064E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KwXSomyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6F12064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeJOO6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 10:58:52 -0400
Received: from ozlabs.org ([203.11.71.1]:49837 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbeJOO6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 10:58:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42YV7W23bdz9sBq;
        Mon, 15 Oct 2018 18:14:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539587688;
        bh=7Y+HASIfcXTMUKf2N2Y2H4POB8RW8AfbM+BhN+wHW/8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KwXSomyCArIM6M12zRH0lpe/xMP2rQ3itE4laK08lwz4sMu/ot72aWvSyGJK1xMl4
         Tx7rmdMH+WWtgfoX/AIETt5SWJLEDY0IjLabT1TIrIujmSq+ffMVHl98TvzFLJ27we
         hl+2Xzx2TVDf1B8Q+EKHQz2joxXZ78LW64YJIdUt7iOHH16+jjJeRC0rnJKL0RA6Fa
         haVNbw9oXaHDbq9UBoD/kXnDe+tHRpy4tT/5vmNnlK54juzM481fXMzY6ee3k3hnah
         +20bwtn/gWzWUhprchlmB8tav8HF+C/PmzxnHz4eujq+e6ukSioa1qip3oHlmFwvy5
         cmiCfVdUI5Nzw==
Date:   Mon, 15 Oct 2018 18:14:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: linux-next: build failure after merge of the akpm tree
Message-ID: <20181015181445.19448cbc@canb.auug.org.au>
In-Reply-To: <20181008190341.5e396491@canb.auug.org.au>
References: <20181008190341.5e396491@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Kie1_XDqC619D.3pdwWGnec"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Kie1_XDqC619D.3pdwWGnec
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 8 Oct 2018 19:03:41 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the akpm tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> arch/x86/mm/kaslr.c:26:10: fatal error: linux/bootmem.h: No such file or =
directory
>  #include <linux/bootmem.h>
>           ^~~~~~~~~~~~~~~~~
>=20
> Caused by patch
>=20
>   "mm: remove include/linux/bootmem.h"
>=20
> interacting with commit
>=20
>   3a387c6d96e6 ("x86/kaslr, ACPI/NUMA: Fix KASLR build error")
>=20
> from the tip tree.
>=20
> I have added the following patch for today:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 8 Oct 2018 18:57:00 +1100
> Subject: [PATCH] x86/kaslr, ACPI/NUMA: fix for linux/bootmem.h removal
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/x86/mm/kaslr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index b3471388288d..ad80bdc690c1 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -23,7 +23,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/random.h>
> -#include <linux/bootmem.h>
> +#include <linux/memblock.h>
> =20
>  #include <asm/pgalloc.h>
>  #include <asm/pgtable.h>
> --=20

So the above tip tree patch no longer exists, so this one is also no
longer needed and I have removed it from the akpm tree today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Kie1_XDqC619D.3pdwWGnec
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvEPmUACgkQAVBC80lX
0GzNAAf/U0C8LEu3gm0I7KmpVBmGta0IdBWv3u0UBPxHQAY7ITs8RZGyuMtCGMVo
ViFxgQfCJiMVJSnJawtKG6tP84mcoS3vcouIt1+QdeTB4AQDnEx3KSGynfXonktl
Ql1zzciuHt9vVbEESJBHNwU+HHYYraH/Xk1C9KyzB7qjSp+pXXEDP1N6zfcfqNqQ
RWg+IfbFwEeusYs6LnwUMO4NuoQkmGaD1aAr5R5BMqultWoLC4lEY4EnEvXsWFYy
wMQ8TDwo07LoK4f2MPZ7ScqtwlfGqC/3eFg+bwHxZudGqYQ8IxJp6lSLhsTiGCAu
whkNTIQqjtn4GcU/+HijGplJqJOobA==
=Bexk
-----END PGP SIGNATURE-----

--Sig_/Kie1_XDqC619D.3pdwWGnec--
