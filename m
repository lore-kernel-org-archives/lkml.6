Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeEFXo7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 19:44:59 -0400
Received: from ozlabs.org ([203.11.71.1]:50267 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751625AbeEFXo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 19:44:58 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 7 May 2018 09:44:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Wise <swise@opengridcomputing.com>
Subject: linux-next: build warning after merge of the rdma tree
Message-ID: <20180507094454.4a71f8a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/urf6QHI24rbiQ+/LhSOKBh1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/urf6QHI24rbiQ+/LhSOKBh1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rdma tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/infiniband/hw/cxgb4/restrack.c: In function 'fill_res_qp_entry':
drivers/infiniband/hw/cxgb4/restrack.c:140:6: warning: 'last_rq_idx' may be=
 used uninitialized in this function [-Wmaybe-uninitialized]
  if (rdma_nl_put_driver_u32(msg, "idx", idx))
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/cxgb4/restrack.c:180:20: note: 'last_rq_idx' was decl=
ared here
  u16 first_rq_idx, last_rq_idx;
                    ^~~~~~~~~~~
drivers/infiniband/hw/cxgb4/restrack.c:140:6: warning: 'first_rq_idx' may b=
e used uninitialized in this function [-Wmaybe-uninitialized]
  if (rdma_nl_put_driver_u32(msg, "idx", idx))
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/cxgb4/restrack.c:180:6: note: 'first_rq_idx' was decl=
ared here
  u16 first_rq_idx, last_rq_idx;
      ^~~~~~~~~~~~
drivers/infiniband/hw/cxgb4/restrack.c:228:6: warning: 'last_sq_idx' may be=
 used uninitialized in this function [-Wmaybe-uninitialized]
  if (fill_swsqes(msg, &wq.sq, first_sq_idx, fsp, last_sq_idx, lsp))
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/cxgb4/restrack.c:228:6: warning: 'first_sq_idx' may b=
e used uninitialized in this function [-Wmaybe-uninitialized]

Introduced by commit

  056f9c7f39bf ("iw_cxgb4: dump detailed driver-specific QP information")

--=20
Cheers,
Stephen Rothwell

--Sig_/urf6QHI24rbiQ+/LhSOKBh1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrvk3YACgkQAVBC80lX
0GzkqwgAgDEj76kBFUK+GbJnCvrNIYNUoaX6pNBUE1T2Eqzk8z9hqsG5tfcg9vKT
X9zmmXJD+Bh0S61CailM5Ksme1dlccKqKWN8W7XsI3yROZoQ6CTHmTKpBDylvEoS
ofc4z5/QNU5AyB7d2AbTjTmjRqj9+pJ9kR0B1XwR1VPltFOqaVYG7Y38Cyd/ncqV
TbMaVrFfZnzd1F/vQjZsj/uRQpqI5pbTDDWUqoHb1Vf5H0PI9D42PyZ48Tu4I/IF
ZWCErDI4FCO3T9xWIeuv5o4nHZRODam8PDSHOn2JggUZBOpIKLPgk+JWyxQdc+vY
ibzq5d1FWmJ266EjMi9sCvge3nqIlg==
=NuDS
-----END PGP SIGNATURE-----

--Sig_/urf6QHI24rbiQ+/LhSOKBh1--
