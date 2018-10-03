Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCA5C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F35920684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qk5el4Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F35920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeJCMYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:24:34 -0400
Received: from ozlabs.org ([203.11.71.1]:35245 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbeJCMYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:24:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Q4Y24HHwz9s7W;
        Wed,  3 Oct 2018 15:37:42 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538545062;
        bh=4Qolw7ugbXBhZ81y8Dm2vyi+MmYCXrTVlH2TF3wHTCo=;
        h=Date:From:To:Cc:Subject:From;
        b=qk5el4LuFV/OWJ2HuL85FvYyZNOyyrbTqMnKYGX/pUV8CvaTvG3ZJe4GTEo2Koeuf
         dG5+4YpzHfs2/BPAib2BO2ujv98i8L/xCTL8+5Y5mmA71y6ULNs+7a4vbe5VgTGE+K
         1MWn0m2WSXHluoxn1Ye0kNIFm6opPks7gdHuUpowASTFfSVtBu6PYVjiCCfCv2/7ak
         ng7Pc6qqSJ5LuVZIVrvz0o3X/w/T5wHgWjQI64QDokSsF4g6njW0EeTDpfXYzEz/8Y
         obgM4qPDp70sL9pUqzBJQQoxmnouIRhGNBaviLjA5eTO/LqtjvE4q+ZRxKNnSsqVpy
         btGR/0b5IA+BQ==
Date:   Wed, 3 Oct 2018 15:37:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>,
        Mark Salter <msalter@redhat.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the devicetree tree with the c6x tree
Message-ID: <20181003153733.6c332851@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FWM3=nW36cr3FNcbzwyBFcC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FWM3=nW36cr3FNcbzwyBFcC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  arch/c6x/kernel/setup.c

between commit:

  31b02fe54206 ("c6x: switch to NO_BOOTMEM")

from the c6x tree and commit:

  be7cd2df1d22 ("c6x: use common built-in dtb support")

from the devicetree tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/c6x/kernel/setup.c
index cc74cb9d349b,05d96a9541b5..000000000000
--- a/arch/c6x/kernel/setup.c
+++ b/arch/c6x/kernel/setup.c
@@@ -352,7 -348,17 +347,7 @@@ void __init setup_arch(char **cmdline_p
  	init_mm.end_data   =3D memory_start;
  	init_mm.brk        =3D memory_start;
 =20
- 	unflatten_device_tree();
 -	/*
 -	 * Give all the memory to the bootmap allocator,  tell it to put the
 -	 * boot mem_map at the start of memory
 -	 */
 -	bootmap_size =3D init_bootmem_node(NODE_DATA(0),
 -					 memory_start >> PAGE_SHIFT,
 -					 PAGE_OFFSET >> PAGE_SHIFT,
 -					 memory_end >> PAGE_SHIFT);
 -	memblock_reserve(memory_start, bootmap_size);
 -
+ 	unflatten_and_copy_device_tree();
 =20
  	c6x_cache_init();
 =20

--Sig_/FWM3=nW36cr3FNcbzwyBFcC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu0VZ4ACgkQAVBC80lX
0GyucwgAhj1e6eMoCNKwjYlfDGE/XJtjG9HYCaj0xxAFvBEmuFHBVS+vE4H6TiTs
co6dzZJAWva/ZEnhMYz5KNNEfPWWWVhGgZoBDmHxZYH594MW3fpV3wVmlCMRmdCs
Z95tP0mQnYDvvN06ZsTQnbjW1sS9NMpbw+c7YW3U/ZNPmVjXAT+SX0TFcVAl9ycl
p44y0Titjsjp8eGakc3/OC4IX7fcUfA4XqmMocCsYMZf+7i3A4uhQeitBXmB74dJ
BXrqxBkDAO/DwOLSOYCkmC9xShh5/zOsz7Mgy6r9o+iiNUCvOvVQ+M7MPJ1zXCWn
1W42JOKUK/HYBPiOzAcXfUFcFBZtBA==
=9pEw
-----END PGP SIGNATURE-----

--Sig_/FWM3=nW36cr3FNcbzwyBFcC--
