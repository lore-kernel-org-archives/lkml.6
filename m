Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754539AbeE2Ehn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 00:37:43 -0400
Received: from ozlabs.org ([203.11.71.1]:36601 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750871AbeE2Ehg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 00:37:36 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 29 May 2018 14:37:33 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>, Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the block tree with the vfs tree
Message-ID: <20180529143733.66340ef7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=H=PXTdySOdGeNkY3yfEW2r"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=H=PXTdySOdGeNkY3yfEW2r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  drivers/block/drbd/drbd_main.c

between commit:

  004fd11db1d6 ("drbd: switch to proc_create_single")

from the vfs tree and commit:

  5657a819a8d9 ("block drivers/block: Use octal not symbolic permissions")

from the block tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/block/drbd/drbd_main.c
index c2d154faac02,e6ec831ad472..000000000000
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@@ -3010,8 -3010,7 +3010,8 @@@ static int __init drbd_init(void
  		goto fail;
 =20
  	err =3D -ENOMEM;
- 	drbd_proc =3D proc_create_single("drbd", S_IFREG | S_IRUGO , NULL,
 -	drbd_proc =3D proc_create_data("drbd", S_IFREG | 0444 , NULL, &drbd_proc=
_fops, NULL);
++	drbd_proc =3D proc_create_single("drbd", S_IFREG | 0444 , NULL,
 +			drbd_seq_show);
  	if (!drbd_proc)	{
  		pr_err("unable to register proc file\n");
  		goto fail;

--Sig_/=H=PXTdySOdGeNkY3yfEW2r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsM2Q0ACgkQAVBC80lX
0GzS5ggAmnJe9u1mMawq5r4v2/s9QcUsnQy2p10FiseAm9JfAzNBMrUUe0WG4O2u
SWj7mwjOdaHyKCVhyXaXdfbCwZMU549J5+1kIItf4ekqCXPug0T7qpnZRb7fIGl7
vYQFuJkMoinZntocWiXRU3GKuugr3qrlnugbEjx8lEc17eEI8S+ZxieHmc9Bnyq7
/I9/7njHBrv+LVnOsaBAAmGAKLwCH+H7upO5r4l1qfPuuhAoJmpa8icaDpzKrrpv
/nrL/WCBWKWArRujKB987mRarkvXhwwlKPT7CiaAnLWi4F7op9QIcEvysJ8ZUI1D
ikzDC8+m/D+PdBKXfIPlRw6PVpRMNA==
=XrNz
-----END PGP SIGNATURE-----

--Sig_/=H=PXTdySOdGeNkY3yfEW2r--
