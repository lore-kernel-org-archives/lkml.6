Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeEFXlE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 19:41:04 -0400
Received: from ozlabs.org ([203.11.71.1]:59105 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751625AbeEFXlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 19:41:02 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 7 May 2018 09:40:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Wise <swise@opengridcomputing.com>
Subject: linux-next: build warning after merge of the rdma tree
Message-ID: <20180507094043.41c94283@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EPzoP.kVSswkps8.oUtLJOO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EPzoP.kVSswkps8.oUtLJOO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rdma tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

drivers/infiniband/hw/cxgb4/restrack.c: In function 'fill_res_qp_entry':
drivers/infiniband/hw/cxgb4/restrack.c:162:6: warning: 'last_rq_idx' may be=
 used uninitialized in this function [-Wmaybe-uninitialized]
  if (fill_swrqe(msg, rq, last_idx, last_rqe))
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/cxgb4/restrack.c:180:20: note: 'last_rq_idx' was decl=
ared here
  u16 first_rq_idx, last_rq_idx;
                    ^~~~~~~~~~~
drivers/infiniband/hw/cxgb4/restrack.c:158:6: warning: 'first_rq_idx' may b=
e used uninitialized in this function [-Wmaybe-uninitialized]
  if (fill_swrqe(msg, rq, first_idx, first_rqe))
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/cxgb4/restrack.c:180:6: note: 'first_rq_idx' was decl=
ared here
  u16 first_rq_idx, last_rq_idx;
      ^~~~~~~~~~~~
drivers/infiniband/hw/cxgb4/restrack.c:129:6: warning: 'last_sq_idx' may be=
 used uninitialized in this function [-Wmaybe-uninitialized]
  if (fill_swsqe(msg, sq, last_idx, last_sqe))
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/cxgb4/restrack.c:179:20: note: 'last_sq_idx' was decl=
ared here
  u16 first_sq_idx, last_sq_idx;
                    ^~~~~~~~~~~
drivers/infiniband/hw/cxgb4/restrack.c:125:6: warning: 'first_sq_idx' may b=
e used uninitialized in this function [-Wmaybe-uninitialized]
  if (fill_swsqe(msg, sq, first_idx, first_sqe))
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/cxgb4/restrack.c:179:6: note: 'first_sq_idx' was decl=
ared here
  u16 first_sq_idx, last_sq_idx;
      ^~~~~~~~~~~~

Introduced by commit

  056f9c7f39bf ("iw_cxgb4: dump detailed driver-specific QP information")

--=20
Cheers,
Stephen Rothwell

--Sig_/EPzoP.kVSswkps8.oUtLJOO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrvknsACgkQAVBC80lX
0Gz+ywgAh/sweQU7EoS9ti7tF3PtQRvn+ZK6u9C+2DmPH1V17pUI86ARAjL7AvGN
SHboY9yJ6ngYGxZgFk7174/2u+XjLY/yo40GpajQe4pHOMAsyzuEZeMgEHDKmDZx
MU2Cqd3MDJ7atwMz/+meIUY58w6NPCTDMBOqm6tiumiQ+Ub3/4o7Gg5s537NPPSD
HtG3XRff9fyLbmd8qQ1IojWpqw1PcJRdTXDTwgm6MDzIm3Z1wv4Bp7ww2Dulzb2X
PvTDHv7K7GjdfYe3c4TK2OVgMM6L0ll2xj5vUnuU0+Zbp6hhpVvTrnvvTWvbfgVS
GSTqMORzsjjXmGk0ghob/WNbK5T6tg==
=i8HX
-----END PGP SIGNATURE-----

--Sig_/EPzoP.kVSswkps8.oUtLJOO--
