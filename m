Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAB6C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5F32089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EEB55nWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5F32089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeKHLMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:12:52 -0500
Received: from ozlabs.org ([203.11.71.1]:38061 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728372AbeKHLMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 06:12:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42r5Yw0jYnz9sBN;
        Thu,  8 Nov 2018 12:39:48 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541641188;
        bh=AdGGHhKuAVgWB2Bbqg7n9JJfd5clOZe1SuYKufi3Bn8=;
        h=Date:From:To:Cc:Subject:From;
        b=EEB55nWtzJmTEqL5zXQBw/rqyDM251gng0tALr14344m1OWxbhfqfRcnKaXJYZ2ku
         2Pg38HhzrzEL2D0f3bCdbD0urA0jXGQv3KEQ9RR325hmFWByuqb2VtSfluWettkE9f
         cW/N6GNrBZWyZPAYT+bYg+Sn4J4kgnDSErcl/j7lNSejvsRxbfGRs4JWFPy4swc0jx
         F7co9y1lmaI6xOWC+qZfmo/qDZo608+dt9xhaIzwF2PHFGEwQBFAjLHyWVawUidiIc
         6aF1lNQm+ll8UaIL7m1BM7Cb93xQzVzeota1noOx9iCpPEJjBtI69crg9tUklV6pOp
         7kSMhCTzwinUw==
Date:   Thu, 8 Nov 2018 12:39:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: linux-next: build warning after merge of the iommu tree
Message-ID: <20181108123938.2026559e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XJ6_I/BrYhA1mqYw6ycAalV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XJ6_I/BrYhA1mqYw6ycAalV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joerg,

After merging the iommu tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

In file included from include/linux/bitmap.h:10,
                 from drivers/iommu/intel-iommu.c:24:
drivers/iommu/intel-iommu.c: In function 'iommu_calculate_agaw':
include/linux/kernel.h:845:29: warning: comparison of distinct pointer type=
s lacks a cast
   (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
                             ^~
include/linux/kernel.h:859:4: note: in expansion of macro '__typecheck'
   (__typecheck(x, y) && __no_side_effects(x, y))
    ^~~~~~~~~~~
include/linux/kernel.h:869:24: note: in expansion of macro '__safe_cmp'
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
include/linux/kernel.h:878:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/iommu/intel-iommu.c:668:9: note: in expansion of macro 'min'
  mgaw =3D min(cap_mgaw(iommu->cap), DEFAULT_DOMAIN_ADDRESS_WIDTH);
         ^~~

Introduced by commit

  248808a0fad0 ("iommu/vt-d: Respect max guest address width in agaw")

--=20
Cheers,
Stephen Rothwell

--Sig_/XJ6_I/BrYhA1mqYw6ycAalV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvjk9oACgkQAVBC80lX
0GwzKwf/ZC9aPWq4mHaEAeRTQCRYNVGK/B3AEpmdVb3gFt7vAXBr0SZNc04+Tupt
B8/LCRjjVA1YBp5haLUZ8bRls40jXimemFLGwRWKKTg6c6efkNDtCsiqzlwTRzd8
i6+1pZPvZoyOlPP4C20Qbu/LrQX6l7/4BvbB0fZGmDUSfQ/ooaqtIqlhE1cXJECf
jnqzCi2zJ/DL++3CKVa6bAbAgt7ca1bcOCWglKaAFShmLKkX9FNlnbn6x75U/xfa
3S2YG0Cglu9gbT0pM7oFOnaaE7eTd9N3IfQL1YdWWuzN9fZ6QwB1+5fznDwuXHSP
rFKB3eL2nCMOzjQz96Ci8ayrIhWrIw==
=2Zdh
-----END PGP SIGNATURE-----

--Sig_/XJ6_I/BrYhA1mqYw6ycAalV--
