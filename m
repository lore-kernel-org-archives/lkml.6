Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753156AbeEIETM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 00:19:12 -0400
Received: from ozlabs.org ([203.11.71.1]:54287 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbeEIETK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 00:19:10 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 9 May 2018 14:19:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180509141908.7b07df43@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mGMZxklIsX=1ObZ3DWZTI/p"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mGMZxklIsX=1ObZ3DWZTI/p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  tools/testing/selftests/net/Makefile

between commit:

  1751eb42ddb5 ("selftests: net: use TEST_PROGS_EXTENDED")

from the net tree and commits:

  a7b15ab887e5 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/=
net")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/net/Makefile
index 3ff81a478dbe,73af45773938..000000000000
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@@ -5,10 -5,13 +5,13 @@@ CFLAGS =3D  -Wall -Wl,--no-as-needed -O2=20
  CFLAGS +=3D -I../../../../usr/include/
 =20
  TEST_PROGS :=3D run_netsocktests run_afpackettests test_bpf.sh netdevice.=
sh rtnetlink.sh
- TEST_PROGS +=3D fib_tests.sh fib-onlink-tests.sh pmtu.sh
+ TEST_PROGS +=3D fib_tests.sh fib-onlink-tests.sh in_netns.sh pmtu.sh udpg=
so.sh
+ TEST_PROGS +=3D udpgso_bench.sh
 -TEST_GEN_PROGS_EXTENDED :=3D in_netns.sh
 +TEST_PROGS_EXTENDED :=3D in_netns.sh
  TEST_GEN_FILES =3D  socket
  TEST_GEN_FILES +=3D psock_fanout psock_tpacket msg_zerocopy
+ TEST_GEN_FILES +=3D tcp_mmap tcp_inq
+ TEST_GEN_FILES +=3D udpgso udpgso_bench_tx udpgso_bench_rx
  TEST_GEN_PROGS =3D reuseport_bpf reuseport_bpf_cpu reuseport_bpf_numa
  TEST_GEN_PROGS +=3D reuseport_dualstack reuseaddr_conflict
 =20

--Sig_/mGMZxklIsX=1ObZ3DWZTI/p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrydrwACgkQAVBC80lX
0GzplQf/XpNaBqBALzYNKnKA+i1UxBSAiscCNJ+hY9nGaFLvRTpjYi+P3I1UvsnA
1ROJMKv+FAQljIkhijWvd2jojrfjfqp6R9l0qNmbnNhLqMwG0AZv4Qbqe0LyqadJ
OKMALH0wxE49nEgnwArrJPAEN810ZgkZ4q0V99z52LFrQm2BMkG/vsJM8aOANF8D
lzhCUSXw56IRM19K+Rv95DwXn8LO/aw/u1KF5jnkzpyOoFUgquWe4PHPmclQyS4h
pp7DWRQ3QILGxWDMxvvbwYDr7DMhEI0HyufX4aAAlQbIh98/TqxI/gVIvnywDWIh
hAbp7mgBYNMLTK2gF3VBXJqaew2Jaw==
=Yu5M
-----END PGP SIGNATURE-----

--Sig_/mGMZxklIsX=1ObZ3DWZTI/p--
