Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751711AbeCOJBj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:01:39 -0400
Received: from ozlabs.org ([103.22.144.67]:60349 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbeCOJBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:01:36 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 20:00:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>
Subject: linux-next: manual merge of the akpm-current tree with the
 asm-generic tree
Message-ID: <20180315200015.63d54b51@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YgfL4y/AkGSkM47vpcQ+unT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YgfL4y/AkGSkM47vpcQ+unT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/sparse.c

between commit:

  123d3239fb65 ("mm: remove obsolete alloc_remap()")

from the asm-generic tree and commit:

  9c6a14b65e50 ("mm/sparse.c: optimize memmap allocation during sparse_init=
()")

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

diff --cc mm/sparse.c
index 65bb52599f90,873617fab5ff..000000000000
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@@ -441,7 -454,21 +450,8 @@@ void __init sparse_mem_maps_populate_no
  	void *map;
  	unsigned long pnum;
  	unsigned long size =3D sizeof(struct page) * PAGES_PER_SECTION;
+ 	int idx_present;
 =20
 -	map =3D alloc_remap(nodeid, size * map_count);
 -	if (map) {
 -		idx_present =3D 0;
 -		for (pnum =3D pnum_begin; pnum < pnum_end; pnum++) {
 -			if (!present_section_nr(pnum))
 -				continue;
 -			map_map[idx_present] =3D map;
 -			map +=3D size;
 -			idx_present++;
 -		}
 -		return;
 -	}
 -
  	size =3D PAGE_ALIGN(size);
  	map =3D memblock_virt_alloc_try_nid_raw(size * map_count,
  					      PAGE_SIZE, __pa(MAX_DMA_ADDRESS),

--Sig_/YgfL4y/AkGSkM47vpcQ+unT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqqNh8ACgkQAVBC80lX
0Gz/GQf8CDoUOZLqIDTKKNvUWee0AQGPRFnUbWBRJuvOnUvNMrjcM32XFKytNGp3
dKBKVbjedSMXOJH5j4rRiTOWmfRH8ozDOL/+Etc4GvZQSf4ic7roND+jhdzBhQZD
GgQeNEsA/EHjfNzbBe5pfK9mYff7h754Zhuwb/A24phmmfGO/DFrl9sqO3MFvjaW
DXiDFvHrR5A7B4raoilD17QryYksEUrPsRxExgOMMQVjM/Y3sWJGmFJfB5JRd161
+n1vw0zTPeJRgE9Bi+buiKFcH23ywczEbizTE8eHDJWYLZyqswEtMwVelYYaaqL8
PzS3MX3cEqB6P0gBydQFoNQDVkRNYg==
=ycLm
-----END PGP SIGNATURE-----

--Sig_/YgfL4y/AkGSkM47vpcQ+unT--
