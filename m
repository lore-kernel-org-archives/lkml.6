Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeCPF4n (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 01:56:43 -0400
Received: from ozlabs.org ([103.22.144.67]:48051 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752043AbeCPF4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 01:56:41 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 16 Mar 2018 16:56:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: linux-next: manual merge of the akpm-current tree with Linus' tree
Message-ID: <20180316165606.2ad25acc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/E5OOIuyj7zABo6Lg/EmJWgp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/E5OOIuyj7zABo6Lg/EmJWgp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/page_alloc.c

between commit:

  3e04040df6d4 ("Revert "mm/page_alloc: fix memmap_init_zone pageblock alig=
nment"")

from Linus' tree and commit:

  45251b0909dc ("mm: remove unused arg from memblock_next_valid_pfn()")

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

diff --cc mm/page_alloc.c
index b32488f10a46,3f9cb47974ed..000000000000
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@@ -5361,9 -5487,14 +5489,9 @@@ void __meminit memmap_init_zone(unsigne
  			/*
  			 * Skip to the pfn preceding the next valid one (or
  			 * end_pfn), such that we hit a valid pfn (or end_pfn)
 -			 * on our next iteration of the loop. Note that it needs
 -			 * to be pageblock aligned even when the region itself
 -			 * is not. move_freepages_block() can shift ahead of
 -			 * the valid region but still depends on correct page
 -			 * metadata.
 +			 * on our next iteration of the loop.
  			 */
- 			pfn =3D memblock_next_valid_pfn(pfn, end_pfn) - 1;
 -			pfn =3D (memblock_next_valid_pfn(pfn) &
 -					~(pageblock_nr_pages-1)) - 1;
++			pfn =3D memblock_next_valid_pfn(pfn) - 1;
  #endif
  			continue;
  		}

--Sig_/E5OOIuyj7zABo6Lg/EmJWgp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqrXHYACgkQAVBC80lX
0Gy3Sgf+KoMwQFgden4f+ygtlBPQfgvLdQc3XP9tikbq82R1OS2ywAYrvgTOl01+
LhPoFiaCnzbRaO3lT7LRZLVCd+1LYjy/Fk/uicE6nK5cv7bQqixrQu74gWNN5rN9
E9pdj/FPk18wYdaeQ8W/h8Flr4UhVBb13WtRr0I50A4e6sDuojn7vjVCIzb77Hsf
iuNuGS2IwgS+jXEY6SNGdhefBqbr+pZSlLPWjHQov4e3qnoAMalQQsTexjBbLQZb
rL00Zmq2EZGp9xbvuWqTG0f33bpvqzeZXDLZ/ALwPNdBdXiNB8N84aEfXuPmJOrw
m+Tvc+CLa18817cmfvLdUqeTBL4VTg==
=/WD0
-----END PGP SIGNATURE-----

--Sig_/E5OOIuyj7zABo6Lg/EmJWgp--
