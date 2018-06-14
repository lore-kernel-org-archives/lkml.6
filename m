Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 748B8C004E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AD12087E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eIQpc4aR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AD12087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935995AbeFNBgS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:36:18 -0400
Received: from ozlabs.org ([203.11.71.1]:49163 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935929AbeFNBgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:36:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 415mRd5BPvz9s2g;
        Thu, 14 Jun 2018 11:36:13 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528940174;
        bh=BFmH6xhA3bVBqs2k5o2eDrGtIYXDTgcXKJWhduJvpcQ=;
        h=Date:From:To:Cc:Subject:From;
        b=eIQpc4aRNbzlysI2tqDn3FHjXa/E9eSBzJo5KLPtZ+hvsPb/hNOZZXfAUaMlMcESa
         WeSsWXA4cUCYWY9W/rByfr6oU/wmtihfx0VSiY0qoQs4/aolsvkGRHXU9O/XcNC9VJ
         t88NIZ5kOtStlgqMyb356M8VVN/+jEIiOqstUZKyobceOdFjZT/I1C5LWgMO1pbW99
         PYDcWIavOsyG85DFgMyvBM1F5oXPxm7NiW6IU12QzFy6Bxqroc3wZ1VcgTilZpm1CP
         hH+6TqAPgA1px9YyM/WLAe/h/VeLskRTc9tfIxoXfkwgE1Ii0inQcn++hOmi8+k6zk
         CkG06bc50Bs9A==
Date:   Thu, 14 Jun 2018 11:36:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: manual merge of the akpm-current tree with Linus' tree
Message-ID: <20180614113612.14dbbe6a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/x6fEeW5MREffoTit27wXdY0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/x6fEeW5MREffoTit27wXdY0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Today's linux-next merge of the akpm-current tree got a conflict in:

  fs/binfmt_elf.c

between commit:

  42bc47b35320 ("treewide: Use array_size() in vmalloc()")

from Linus' tree and commit:

  1d5239111f52 ("coredump: fix spam with zero VMA process")

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

diff --cc fs/binfmt_elf.c
index 070b6184642d,8676bb01b5a9..000000000000
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@@ -2294,8 -2294,8 +2294,8 @@@ static int elf_core_dump(struct coredum
 =20
  	if (segs - 1 > ULONG_MAX / sizeof(*vma_filesz))
  		goto end_coredump;
- 	vma_filesz =3D vmalloc(array_size(sizeof(*vma_filesz), (segs - 1)));
- 	if (!vma_filesz)
 -	vma_filesz =3D kvmalloc((segs - 1) * sizeof(*vma_filesz), GFP_KERNEL);
++	vma_filesz =3D kvmalloc(array_size(sizeof(*vma_filesz), (segs - 1)), GFP=
_KERNEL);
+ 	if (ZERO_OR_NULL_PTR(vma_filesz))
  		goto end_coredump;
 =20
  	for (i =3D 0, vma =3D first_vma(current, gate_vma); vma !=3D NULL;

--Sig_/x6fEeW5MREffoTit27wXdY0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlshxowACgkQAVBC80lX
0GzOMwf7BmzDaYGonseWEytuGruqxr6XBLGnQyN9um+6k7P+tR0ifXpEnZ7Rd+Rr
snMiDMs25PL/wVwV2z0vRU+qDTgKRJ6d+eAtOZbmAIDGAUNeyID9aBGKQkqfhdPS
wbvKlhSpwSm6Eqo7uZQbQSSZqP2/J0P0jrpEz1KTUwCdG1XpOWLHue4RYJyWt/tR
JqG4y+cpusaqc+ZLRyaqSFNF/Kl7kEL9ldssXJUlX9Dsq4k39ip4y0zLePURSXg2
uzTDw7F/yDPRNIwqIoYJ6dbhT+3SfzAxy5Zoi8hWo8jdWylX90jlQKC0Sz/CZf3g
HJSdk9FV2P3cgX+1J+71OeWaiLI0bQ==
=RlxI
-----END PGP SIGNATURE-----

--Sig_/x6fEeW5MREffoTit27wXdY0--
