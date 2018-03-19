Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755266AbeCSGhY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 02:37:24 -0400
Received: from ozlabs.org ([103.22.144.67]:44813 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754531AbeCSGhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 02:37:21 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 19 Mar 2018 17:36:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: linux-next: manual merge of the akpm-current tree with the block
 tree
Message-ID: <20180319173643.38aa4562@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/je+8IFxL0/ng+2=PSN2vjpV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/je+8IFxL0/ng+2=PSN2vjpV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Today's linux-next merge of the akpm-current tree got a conflict in:

  drivers/block/zram/zram_drv.h

between commit:

  233bde21aa43 ("block: Move SECTOR_SIZE and SECTOR_SHIFT definitions into =
<linux/blkdev.h>")

from the block tree and commit:

  5d95e0f3a22b ("zram: drop max_zpage_size and use zs_huge_class_size()")

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

diff --cc drivers/block/zram/zram_drv.h
index 1e9bf65c0bfb,d71c8000a964..000000000000
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@@ -21,22 -21,7 +21,6 @@@
 =20
  #include "zcomp.h"
 =20
- /*-- Configurable parameters */
-=20
- /*
-  * Pages that compress to size greater than this are stored
-  * uncompressed in memory.
-  */
- static const size_t max_zpage_size =3D PAGE_SIZE / 4 * 3;
-=20
- /*
-  * NOTE: max_zpage_size must be less than or equal to:
-  *   ZS_MAX_ALLOC_SIZE. Otherwise, zs_malloc() would
-  * always return failure.
-  */
-=20
- /*-- End of configurable params */
-=20
 -#define SECTOR_SHIFT		9
  #define SECTORS_PER_PAGE_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
  #define SECTORS_PER_PAGE	(1 << SECTORS_PER_PAGE_SHIFT)
  #define ZRAM_LOGICAL_BLOCK_SHIFT 12

--Sig_/je+8IFxL0/ng+2=PSN2vjpV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqvWnsACgkQAVBC80lX
0GxSuwf/aGFNKjgOpURxXfjzzTZoYolneMkGmlB9ma/nuX7iRlynNPgCMUmiS1kg
C6/muBgIWgBU+8T6Z14OozQ6/Euf1fX4kgIOqroBCGxSUu8pkHUKHoTzvn5DkUqC
5ygubgZDlXWWdX34EjukVu3tCe1FzidPs0q+DIPDlZQFGFHa4Gocv5AEMxrYIzsW
CN+aZANAur/ppFYU5PNsSq5KUgwrD3jyG3ZQ7b7F6PJDZOHbxbl/1rN+FJLCkkUf
1RTjbd2QghkP/gydeykpGFjdh8SmRn28lsEq41gViBkHKoed7Hlgv1HK3im25aJW
OpiA1AhFqns7Fm4gq4ehRjQuYJzj9w==
=+WFu
-----END PGP SIGNATURE-----

--Sig_/je+8IFxL0/ng+2=PSN2vjpV--
