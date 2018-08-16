Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD8EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4369120A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="p1PLapX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4369120A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbeHPDGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 23:06:15 -0400
Received: from ozlabs.org ([203.11.71.1]:51493 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbeHPDGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 23:06:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41rRZv5v88z9s7c;
        Thu, 16 Aug 2018 10:11:35 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534378296;
        bh=e+oScRqp+rsavdFdU2D/oL1uD1cl2faRMRT7JBGeIOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p1PLapX/sCgEqsH9DNDSxolp/oqW8yjOSjrFNVdgvWdN/jnUe7WVqE8uvrnnaqEfD
         EwIFAYcxmLj5q18Zr0Z8LxJJMx0R1Xtjhab+SqLcMr9HuM/ik7LVqZxGvHKc3na2Z0
         AjVuBdKQG0+Lje4Yvw4etACJDChqj4+a3a3PTfG2M8mfK7HxQjgVqtPLoXC+4ysDrI
         1ggz+1krs8U2nVRH4gLpz/CzHrYsgdSIWbU7oabq67zoftlFg2oKD8jvCvUmy2VvFA
         nFb5vllucoZ3toRW4r89pEOqcePYSRwvXxJeK6dikCzqT/7m2mwdsuv/chaCzZhZrU
         g3rj7LW/3IuxQ==
Date:   Thu, 16 Aug 2018 10:11:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 arm64 tree
Message-ID: <20180816101135.39a1a344@canb.auug.org.au>
In-Reply-To: <20180727205532.28de3353@canb.auug.org.au>
References: <20180727205532.28de3353@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/u19SvlrAvGd.pz6edCsx8gA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u19SvlrAvGd.pz6edCsx8gA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 27 Jul 2018 20:55:32 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the akpm-current tree got a conflict in:
>=20
>   drivers/firmware/efi/libstub/Makefile
>=20
> between commit:
>=20
>   0b3e336601b8 ("arm64: Add support for STACKLEAK gcc plugin")
>=20
> from the arm64 tree and commit:
>=20
>   08cc64a7109b ("module: allow symbol exports to be disabled")
>=20
> from the akpm-current tree.
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
> diff --cc drivers/firmware/efi/libstub/Makefile
> index 25dd2a14560d,0d0d3483241c..000000000000
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@@ -21,7 -21,7 +21,8 @@@ KBUILD_CFLAGS			:=3D $(cflags-y) -DDISABL
>   				   -D__NO_FORTIFY \
>   				   $(call cc-option,-ffreestanding) \
>   				   $(call cc-option,-fno-stack-protector) \
> - 				   $(DISABLE_STACKLEAK_PLUGIN)
> ++				   $(DISABLE_STACKLEAK_PLUGIN) \
> + 				   -D__DISABLE_EXPORTS
>  =20
>   GCOV_PROFILE			:=3D n
>   KASAN_SANITIZE			:=3D n

This is now a conflict between Linus' tree and the akpm-current tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/u19SvlrAvGd.pz6edCsx8gA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt0wTcACgkQAVBC80lX
0Gw/0wf+OtvMceJoBJYvCid/cAlozmHf6Qcr/xtP1XSgxbr/GniHAG/UEuIRcZox
FWCAx2WNgdDmakjlrDRoGRe3buQ/vKoTBYsxiNDu8LR+QOCN6BPnp7HeL7iMKN9W
okpO8Ax4WOmyTQrkwnKYpT7rmVWtliNS9PJw9Li5WCnZg0sOA835I6eBawJJkpQm
XZtRb5Zy2us29vM2ePqvVzVqD0XAmydPA1aeepTXghScjz6trA14GO0A992yTdt4
/wJWU5itTSa4oNFh+E+96OESMV6XNZYt31gq85wCheYM3WAIb1Y19ElN6+07v2mV
7KiUzbU5SJQuN/Bn9BP3Pgaky/mmfw==
=Umbt
-----END PGP SIGNATURE-----

--Sig_/u19SvlrAvGd.pz6edCsx8gA--
