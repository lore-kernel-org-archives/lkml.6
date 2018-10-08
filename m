Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CE1C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71ADE2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Aw4Gx4mN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71ADE2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeJIG13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:27:29 -0400
Received: from ozlabs.org ([203.11.71.1]:56641 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725759AbeJIG13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:27:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Tbkp6BDtz9vZs;
        Tue,  9 Oct 2018 10:13:22 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539040402;
        bh=4gs6ZxS0VE3qIBsaSyRFKwqsx4kuaqxXZCkazDUTh5o=;
        h=Date:From:To:Cc:Subject:From;
        b=Aw4Gx4mNiPKAU0N17lew7KiVAFtG5ElXDbI1JC7eNj2ibUyZ5BHb1XuF51347rwlb
         Pa1gHcruXpF9++nSv2ATx40A7l4tbTHnxkI09HJkpV1Ypeownryq9PQBuRJIJ2bpbN
         7f71E7pw3N4jZBjT93QJsHzF8vBw+Rjk5bqH7JP1FDgf8+PDrxV7Zx4wmZKNfn82qZ
         vhKy69R5ZKApxhRS1O3roNry7chGpl62Jfr6gKseJ8f20RpPtl/Gc5CdDTls1vBMDg
         PdvKlFeQn9sFwX9ZKpGE4plQ1Qs3dPbpgxpr322Jt/yIHhHc/yTOfnntQyRtAt77PA
         qyrUr2EETDziQ==
Date:   Tue, 9 Oct 2018 10:13:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: linux-next: manual merge of the s390 tree with the
 compiler-attributes tree
Message-ID: <20181009101316.61ab0868@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OZ40gKq.MaOLhvnMPRBW3dI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OZ40gKq.MaOLhvnMPRBW3dI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the s390 tree got a conflict in:

  include/linux/compiler-gcc.h

between commits:

  5c67a52f3da0 ("Compiler Attributes: always use the extra-underscores synt=
ax")
  a3f8a30f3f00 ("Compiler Attributes: use feature checks instead of version=
 checks")

from the compiler-attributes tree and commit:

  65bdf3bbf56e ("compiler: introduce __no_sanitize_address_or_inline")

from the s390 tree.

I fixed it up (see below) and can carry the fix as necessary. This is
now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your
tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/compiler-gcc.h
index cfac027e1625,997ade08a79d..000000000000
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@@ -147,7 -201,27 +147,14 @@@
  #define KASAN_ABI_VERSION 3
  #endif
 =20
 -#if GCC_VERSION >=3D 40902
 -/*
 - * Tell the compiler that address safety instrumentation (KASAN)
 - * should not be applied to that function.
 - * Conflicts with inlining: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=
=3D67368
 - */
 -#define __no_sanitize_address __attribute__((no_sanitize_address))
 -#ifdef CONFIG_KASAN
++#if (GCC_VERSION >=3D 40902) && defined(CONFIG_KASAN)
+ #define __no_sanitize_address_or_inline					\
+ 	__no_sanitize_address __maybe_unused notrace
+ #else
+ #define __no_sanitize_address_or_inline inline
+ #endif
 -#endif
+=20
  #if GCC_VERSION >=3D 50100
 -/*
 - * Mark structures as requiring designated initializers.
 - * https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
 - */
 -#define __designated_init __attribute__((designated_init))
  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
  #endif
 =20

--Sig_/OZ40gKq.MaOLhvnMPRBW3dI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu75IwACgkQAVBC80lX
0GwUcAf9ElqlYEEQKHZtVoRq3hNCyhODoYcgeCLW91emNWo6OKgXIzz02TxfqvXQ
RyvqB02vRGwVd8ju6M/3bhAC1sJHb964x/kE9N7JdvmBhMy5N1Qm8PqmKG83Bzix
+zU1JX6PfWfSxLg3ADzOIzaiw/n+1Zi0O8n2O+tP/PUPa+wQwhM7+PBapEVPhDch
MYL+YanQvDBqkSpvRYq9rsRKawO2ikr6IK/Td9n03PNGWHT1up//elO9dhg+cb51
sJz2z6dVMSrEd5L5UbS/QM1ug+iusZyXwKMTMUFReEHFIwTQ0XynarTxAv2Dan1j
3smBx+d1Q1dmcFQke2xmkFFc1O0zfA==
=9TYY
-----END PGP SIGNATURE-----

--Sig_/OZ40gKq.MaOLhvnMPRBW3dI--
