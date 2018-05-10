Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756708AbeEJGkD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 02:40:03 -0400
Received: from ozlabs.org ([203.11.71.1]:38229 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751313AbeEJGkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 02:40:02 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 10 May 2018 16:39:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the akpm-current tree with the
 dma-mapping tree
Message-ID: <20180510163959.12a429dc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1Jin8twgnfHwaqIHEKRrC6M"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1Jin8twgnfHwaqIHEKRrC6M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/sh/Kconfig

between commits:

  86596f0a2833 ("scatterlist: move the NEED_SG_DMA_LENGTH config symbol to =
lib/Kconfig")
  f616ab59c294 ("dma-mapping: move the NEED_DMA_MAP_STATE config symbol to =
lib/Kconfig")

from the dma-mapping tree and commit:

  1099dc900e93 ("mm: introduce ARCH_HAS_PTE_SPECIAL")

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

diff --cc arch/sh/Kconfig
index 7d521926041e,a6c75b6806d2..000000000000
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@@ -49,9 -50,7 +49,10 @@@ config SUPER
  	select HAVE_ARCH_AUDITSYSCALL
  	select HAVE_FUTEX_CMPXCHG if FUTEX
  	select HAVE_NMI
 +	select NEED_DMA_MAP_STATE
 +	select NEED_SG_DMA_LENGTH
+ 	select ARCH_HAS_PTE_SPECIAL
 +
  	help
  	  The SuperH is a RISC processor targeted for use in embedded systems
  	  and consumer electronics; it was also used in the Sega Dreamcast

--Sig_/1Jin8twgnfHwaqIHEKRrC6M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrz6T8ACgkQAVBC80lX
0GwVCgf9HY93mmmNLPvvTXaFFal/TO394arvB+V7ex2jVFVTKWiyjY9Ft3ObM74r
Scw9B5aG1ed9c3Onf+KR64SXurqea8/STLAxzJ6ooWOt6abJQWSNqmetnKz95/AF
vVQD7eRLpHyfSWa9wX9ssZ7sTHC+hwfxCWZnN57Nz8A18f0lUfl2TtstLa1Q8TEr
BBckSg6UryezeRL5TYyDK4tEzmn1qbc42JBAbNFfqXS3FUyXzBPTu8PNrM3V+SKx
/ADNkA11G94P4u2dDgy+QMyPVFPmacDTun6sgmkfqNTg+pyxf7UMTOTuhXL1FsPz
EPsVEY5EM0O2XRZG77o8hQuu5LQD9g==
=ZocQ
-----END PGP SIGNATURE-----

--Sig_/1Jin8twgnfHwaqIHEKRrC6M--
