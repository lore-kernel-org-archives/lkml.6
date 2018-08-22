Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361ABC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DE5217BE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rBc7DFvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DE5217BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeHVFZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 01:25:22 -0400
Received: from ozlabs.org ([203.11.71.1]:44563 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeHVFZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 01:25:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41w9mD6J75z9s7T;
        Wed, 22 Aug 2018 12:02:36 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534903357;
        bh=3SD80tWFBaOZeCIYXdk9OnJMamPHC88l44mQ3ZEj2DY=;
        h=Date:From:To:Cc:Subject:From;
        b=rBc7DFvC/LeIdM6M0XcwUaZlYGDO625DS4L+zdL1NjY7zvtgSOKKS5T07MbNGjGNW
         husvPEPfBIvsWsFvyuJdru3n7rfyuYLZ/Arwt8afA0fD7uo8otUt1CxV0JR907926X
         f2SRrMb25PIWuuZScEFfKhnYmMpiCG0G45HF8n3VT63Yt6PlYCUAt1Hx8EMRirQ+lI
         wJOh/P+neRgodMxY5drwQz6kGNMuzqu2rkyba2FXRdiIrjSegJbsilLkwjl4lnAozN
         x2R9J3/FWrJT0fp5RhyaiBB8lCQ1rQHv8+LRvQrHPAQIgI99aS6MtUd3VE1jh+j4+j
         TicbH5vSTzIRg==
Date:   Wed, 22 Aug 2018 12:02:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Paul Burton <paul.burton@mips.com>
Subject: linux-next: manual merge of the akpm-current tree with the mips
 tree
Message-ID: <20180822120218.44cecef5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lSM8G+AX3PUCj_QUMvAERIk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lSM8G+AX3PUCj_QUMvAERIk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/Kconfig

between commit:

  04f264d3a8b0 ("compiler.h: Allow arch-specific asm/compiler.h")

from the mips tree and commit:

  7358e371b0ef ("arch: enable relative relocations for arm64, power and x86=
")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/Kconfig
index 526a57457594,4426e9687d89..000000000000
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@@ -848,14 -841,16 +848,24 @@@ config REFCOUNT_FUL
  	  against various use-after-free conditions that can be used in
  	  security flaw exploits.
 =20
 +config HAVE_ARCH_COMPILER_H
 +	bool
 +	help
 +	  An architecture can select this if it provides an
 +	  asm/compiler.h header that should be included after
 +	  linux/compiler-*.h in order to override macro definitions that those
 +	  headers generally provide.
 +
+ config HAVE_ARCH_PREL32_RELOCATIONS
+ 	bool
+ 	help
+ 	  May be selected by an architecture if it supports place-relative
+ 	  32-bit relocations, both in the toolchain and in the module loader,
+ 	  in which case relative references can be used in special sections
+ 	  for PCI fixup, initcalls etc which are only half the size on 64 bit
+ 	  architectures, and don't require runtime relocation on relocatable
+ 	  kernels.
+=20
  source "kernel/gcov/Kconfig"
 =20
  source "scripts/gcc-plugins/Kconfig"

--Sig_/lSM8G+AX3PUCj_QUMvAERIk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt8xCoACgkQAVBC80lX
0Gw61gf/eIO4X3jfg8EVTDUf/Y0wSQ7iI9LAqnfsIVF/97Uv6LFdwMJyy3VDW69b
Od8rZYaX360ZAfpr3PvY2iysGF4oh9A93h59nvAuIGcWAor1H7jvAuWu7dCJ4sF6
d3geWuWdr2TRa8niJa4iSwqnHjr/Q5Vs5eaaYIC6z6LDFemBV840bB3E+Ifcv/ZD
UNlSr7fIwWC0Sd6lFSGdSo3zzeBXuouQnsIDmEBZQibTZY2wuOrQB3cOKqI+dE/F
VnYZ1CYe2oEQXoovjRyVjcjv89CNcb5m9lXiQvCG1bCEy1TwRJGjFDrtylt19ANW
a369BfYYINUV8AXr+GLtou1neLBpDg==
=xHax
-----END PGP SIGNATURE-----

--Sig_/lSM8G+AX3PUCj_QUMvAERIk--
