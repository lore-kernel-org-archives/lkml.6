Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeBRWwB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 17:52:01 -0500
Received: from ozlabs.org ([103.22.144.67]:53829 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbeBRWwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 17:52:00 -0500
Date: Mon, 19 Feb 2018 09:51:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: linux-next: manual merge of the nand tree with Linus' tree
Message-ID: <20180219095147.0e2fbb15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/W2Pq5CX9hyHyJ=/OH7whiW5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W2Pq5CX9hyHyJ=/OH7whiW5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Boris,

Today's linux-next merge of the nand tree got a conflict in:

  drivers/mtd/nand/Kconfig

between commit:

  f23def803861 ("mtd: nand: MTD_NAND_MARVELL should depend on HAS_DMA")

from Linus' tree and commit:

  93db446a424c ("mtd: nand: move raw NAND related code to the raw/ subdir")

from the nand tree.

I fixed it up (I used the latter version of this file and added the
following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 19 Feb 2018 09:48:17 +1100
Subject: [PATCH] mtd: nand: fix up for raw Kconfig move

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/mtd/nand/raw/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index e6b8c59f2c0d..736ac887303c 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -328,7 +328,7 @@ config MTD_NAND_MARVELL
 	tristate "NAND controller support on Marvell boards"
 	depends on PXA3xx || ARCH_MMP || PLAT_ORION || ARCH_MVEBU || \
 		   COMPILE_TEST
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM && HAS_DMA
 	help
 	  This enables the NAND flash controller driver for Marvell boards,
 	  including:
--=20
2.15.1

--=20
Cheers,
Stephen Rothwell

--Sig_/W2Pq5CX9hyHyJ=/OH7whiW5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqKA4MACgkQAVBC80lX
0Gwp/gf+MOhTFyHJt7CeAgIb4Z9VF9qTp5Mt3k7DrIxUQlb7YZ6N0fxBwBnoq0ha
E0cXDcDUnjQpcNsy3YfCj7weGzB3XakyD6zOav3VhrMvgWoZGSX40AtzYIzC2n1s
YqjNz56TCNugGWxLBgfmpywaHMMmk7ynl0xoBhVMkvFr65cTnvPxfdg00QSbdt1A
x6BPcMhM98SPqxtA5SkSCsbE5TpPCJxB1GLLtEFh69933sCo3XXPXYqDZrt16bpj
WMOalQQbFMMNLlYD7fzq5xwmXlY2uin2KFWPVwTrHltmztdwYM0XwU91ZuB3EZeC
VDUWhGQfR5CjnyljZ9s3R1Tt95lB6A==
=f94W
-----END PGP SIGNATURE-----

--Sig_/W2Pq5CX9hyHyJ=/OH7whiW5--
