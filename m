Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbeENCvo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 22:51:44 -0400
Received: from ozlabs.org ([203.11.71.1]:49965 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751984AbeENCvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 22:51:42 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 14 May 2018 12:51:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: build warning after merge of the block tree
Message-ID: <20180514125139.459a058d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vkAwqzOFvi=RYL4MGC/Bm=="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vkAwqzOFvi=RYL4MGC/Bm==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/memstick/core/mspro_block.c: In function 'mspro_block_init_disk':
drivers/memstick/core/mspro_block.c:1173:24: warning: unused variable 'host=
' [-Wunused-variable]
  struct memstick_host *host =3D card->host;
                        ^~~~
drivers/memstick/core/ms_block.c: In function 'msb_init_disk':
drivers/memstick/core/ms_block.c:2097:24: warning: unused variable 'host' [=
-Wunused-variable]
  struct memstick_host *host =3D card->host;
                        ^~~~

Introduced by commit

  7c2d748e8476 ("memstick: don't call blk_queue_bounce_limit")

--=20
Cheers,
Stephen Rothwell

--Sig_/vkAwqzOFvi=RYL4MGC/Bm==
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr4+bsACgkQAVBC80lX
0Gy3Ogf/ZMmpZ7jEVr1JdpXD9VKzSLFUKAhizk+xPukkakGaFHBwbfa30yrZlPv/
6Uy++2VBa3eEnWD+mZAkntQmL9MBYhC3dIxIvJJ5z5WXJ3IVoKouABhlmPIubhi3
YQCx7RBi69IudrPNVhPu0IMsEhLrLM/cZnMJ+rmM4cCibkm116JJWHdojIaV/c5p
SKo/tbYWEmMNpYSMSNAxFRwE80lKh1AMSEefGedTTM2M5g1cjojBF/Me9lDSOi9B
JZHFtsjVkiNBgaSlsQ3w6krNviwMQ+MAR5LJ9Hw0mp3D4D4LKi/K3tzrDCkhLkI7
kdYj0Tko+icXYQKnvYqacNh6Dj5Acg==
=yhI6
-----END PGP SIGNATURE-----

--Sig_/vkAwqzOFvi=RYL4MGC/Bm==--
