Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1qlqOsHEGVtRYAAAmS7hNA
	; Thu, 07 Jun 2018 23:52:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3B9A46089E; Thu,  7 Jun 2018 23:52:52 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XShpZVHc"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B965F60290;
	Thu,  7 Jun 2018 23:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B965F60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeFGXwu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 19:52:50 -0400
Received: from ozlabs.org ([203.11.71.1]:53159 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752129AbeFGXws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 19:52:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4122R2270Xz9s01;
        Fri,  8 Jun 2018 09:52:46 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528415566;
        bh=hu3v3P+hg6or39FELywIBLCwl0TzlGEa6/4nTk6TlwE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XShpZVHcJk0h/CaArTFppAr/BuV64NIKRSXW2u3LHngoKrNBDCb3Cgnniy2cU9lFZ
         6UhRjJvf7rh/aIjPT8hWh+VRCmY9ZtguEDZY3n9O7W+yXRjDjhuZjwFp8pURl3IOoz
         EJ5K4ova8XWckROTij+JrgMfcOqJ5g62bONQQro1zx92kP7LcDCXU+FdCMBNUj+Uae
         S7HY9WoIympLiqDMFX1bo6ESclMu8RkSg5WqwXhl7OtVTiGXmAeErFe0FltBReVx5d
         RQJexZpXywPc+UxsV0pz8h153jzWJpvb+llAYGJ9gdZjMLyXTdrJSEauoQMepxxRRN
         IKQXhcvmb9lVg==
Date: Fri, 8 Jun 2018 09:52:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: linux-next: manual merge of the powerpc tree with the kbuild
 tree
Message-ID: <20180608095220.20b85912@canb.auug.org.au>
In-Reply-To: <20180531093216.5c91aa2b@canb.auug.org.au>
References: <20180531093216.5c91aa2b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yJu_K3LFBM2YxfOxmOM6LA+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yJu_K3LFBM2YxfOxmOM6LA+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 31 May 2018 09:32:16 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the powerpc tree got a conflict in:
>=20
>   arch/powerpc/kernel/module_64.c
>=20
> between commit:
>=20
>   06aeb9e3f2bc ("powerpc/kbuild: move -mprofile-kernel check to Kconfig")
>=20
> from the kbuild tree and commit:
>=20
>   250122baed29 ("powerpc64/module: Tighten detection of mcount call sites=
 with -mprofile-kernel")
>=20
> from the powerpc tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/powerpc/kernel/module_64.c
> index 55bccc315e1a,f7667e2ebfcb..000000000000
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@@ -462,9 -466,12 +466,12 @@@ static unsigned long stub_for_addr(cons
>   	return (unsigned long)&stubs[i];
>   }
>  =20
>  -#ifdef CC_USING_MPROFILE_KERNEL
>  +#ifdef CONFIG_MPROFILE_KERNEL
> - static bool is_early_mcount_callsite(u32 *instruction)
> + static bool is_mprofile_mcount_callsite(const char *name, u32 *instruct=
ion)
>   {
> + 	if (strcmp("_mcount", name))
> + 		return false;
> +=20
>   	/*
>   	 * Check if this is one of the -mprofile-kernel sequences.
>   	 */

This is now a conflict between the kbuild tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/yJu_K3LFBM2YxfOxmOM6LA+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsZxTQACgkQAVBC80lX
0GzdkQgAo7Py6BrGkGFA/KxklVAutZ/Izxa4Iv0l2mGK1SjNX1xU8+WIfjF+bmy2
kTdudvPJj5HbWxWisYKiChTSzQrXsH8abckx/s5vq9hvWPF1IbQ5WK2iaTehzfvw
um7Dvkm9sTeDmTPZzEZ3nhsFOeyYp2ukkBP2TUseZQ95/Nvr4d0pvF0ZWl/dMm6T
cQqmP2/ZYZaTk6N9XRvowaPdy5HuWy+nGr9Y8tuNukGmpfF6GciDvwR+RifSSZq0
pw6GfbgcvolFOUxezRhJsWzaXQyPMlnAgdzPSF5x/g15PvUwjZ8XNhvvwL8D9n4I
PxqALtRLOqWW34uTmDmmUeufcAGzEQ==
=ZRqp
-----END PGP SIGNATURE-----

--Sig_/yJu_K3LFBM2YxfOxmOM6LA+--
