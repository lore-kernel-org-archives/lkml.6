Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754321AbeCVAqL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 20:46:11 -0400
Received: from ozlabs.org ([103.22.144.67]:34769 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753931AbeCVAqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 20:46:09 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 22 Mar 2018 11:45:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Wise <swise@opengridcomputing.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: linux-next: manual merge of the rdma tree with the rdma-fixes tree
Message-ID: <20180322114528.471e30fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Jtw.tT1Ukc2S1Gu+T4_ghvo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Jtw.tT1Ukc2S1Gu+T4_ghvo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rdma tree got a conflict in:

  drivers/infiniband/core/ucma.c

between commit:

  e8980d67d601 ("RDMA/ucma: Ensure that CM_ID exists prior to access it")

from the rdma-fixes tree and commit:

  00313983cda6 ("DMA/nldev: provide detailed CM_ID information")

from the rdma tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/core/ucma.c
index e5a1e7d81326,4bb5bed596c9..000000000000
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@@ -477,10 -476,10 +477,10 @@@ static ssize_t ucma_create_id(struct uc
  		return -ENOMEM;
 =20
  	ctx->uid =3D cmd.uid;
- 	cm_id =3D rdma_create_id(current->nsproxy->net_ns,
- 			       ucma_event_handler, ctx, cmd.ps, qp_type);
 -	ctx->cm_id =3D __rdma_create_id(current->nsproxy->net_ns,
 -			      ucma_event_handler, ctx, cmd.ps, qp_type, NULL);
 -	if (IS_ERR(ctx->cm_id)) {
 -		ret =3D PTR_ERR(ctx->cm_id);
++	cm_id =3D __rdma_create_id(current->nsproxy->net_ns,
++				ucma_event_handler, ctx, cmd.ps, qp_type, NULL);
 +	if (IS_ERR(cm_id)) {
 +		ret =3D PTR_ERR(cm_id);
  		goto err1;
  	}
 =20

--Sig_/Jtw.tT1Ukc2S1Gu+T4_ghvo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqy/KgACgkQAVBC80lX
0GyTXggAoa6hdCtLkjvn4JAf+C4syeEAN/W/eCn2eJk7S4Ec9s3felKMF5v3C41q
ytwC3tYIDcj/svP+hRQwAhDLl6+d0TuYFrUlKItgOe1ch7sDzYOt+tE/wXpQQN13
FwTX3vGmVfwpqM51Pl3X4bhrv6fmk8HThDhYIDWBtWPec3hSaiadrgI4TDnqFFBg
o5sdUGMU3A0kVyqzymNoHiLnxfBIzj/9aEC8A1kP/Uf/+7bYDUoor9K/ptddJmbv
ELJ7krr7tSWfrcc7Bpy/pgcu5KxjD1Zng2o5CZchoInsLOyPiP+fXGWQO9h1iq4C
Kq5iMoexAJwDuKlaDvPxN9pIbW+tqQ==
=sEwo
-----END PGP SIGNATURE-----

--Sig_/Jtw.tT1Ukc2S1Gu+T4_ghvo--
