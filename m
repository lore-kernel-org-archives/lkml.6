Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeCUG1q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 02:27:46 -0400
Received: from ozlabs.org ([103.22.144.67]:43921 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbeCUG1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 02:27:41 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 21 Mar 2018 17:26:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the userns tree with the fuse tree
Message-ID: <20180321172658.45b892a3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iy/.I4KvP.Gk.uKk1+ldxAv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iy/.I4KvP.Gk.uKk1+ldxAv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the userns tree got a conflict in:

  fs/fuse/dev.c

between commits:

  dbf107b2a7f3 ("fuse: Remove the buggy retranslation of pids in fuse_dev_d=
o_read")
  c9582eb0ff7d ("fuse: Fail all requests with invalid uids or gids")
  8cb08329b080 ("fuse: Support fuse filesystems outside of init_user_ns")

from the fuse tree and commits:

  dbf107b2a7f3 ("fuse: Remove the buggy retranslation of pids in fuse_dev_d=
o_read")
  c9582eb0ff7d ("fuse: Fail all requests with invalid uids or gids")
  8cb08329b080 ("fuse: Support fuse filesystems outside of init_user_ns")

from the userns tree.

These commits seem to have been rebased in the fuse tree on top of

  3b7008b226f3 ("fuse: return -ECONNABORTED on /dev/fuse read after abort")

and modified a bit.

I fixed it up (I used the fuse tree version, but please come to
some arrangement about which is correct) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/iy/.I4KvP.Gk.uKk1+ldxAv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqx+zIACgkQAVBC80lX
0Gzwsgf9EePQMmSSMJ67jqC2T5H/txCLpHUvXWjkyhKIEmilQzlo2Vl0lCC521eH
Q1sa6kf2rINNOhis0HAE5vtvJYGqUI9DQCGtHRM/TbxilemM0zt41xaIQB9Fg7MZ
ESkDhFnsKQMUin3FKjoM2f537BOw8Fy6Lb1up2IJlAH2mNuGTrQ0QigPlBzzFvwx
GIm5fnog5vy86O2H1qkEf2U+9iR8uOU1NH2Ad7nKtQ/PQ8BV0gRkULG5uuayPinU
otrFKTbLk5Znm2Fpr1+8chf1aqOtdJCZCgR4HCYakdN6Cqb8bHhvUIx394B8z2Ai
M4N7MaHx+2rNwgTHkUQfQ3/BxSZzsA==
=PK/j
-----END PGP SIGNATURE-----

--Sig_/iy/.I4KvP.Gk.uKk1+ldxAv--
