Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033649AbeE2DAH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 23:00:07 -0400
Received: from ozlabs.org ([203.11.71.1]:46925 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033342AbeE2DAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 23:00:03 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 29 May 2018 13:00:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: linux-next: manual merge of the net-next tree with the s390 tree
Message-ID: <20180529130001.02d3cdde@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/roaZ5u8C1Leq=F9cwqIJ16w"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/roaZ5u8C1Leq=F9cwqIJ16w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  arch/s390/net/Makefile

between commit:

  866f4c8e0e26 ("s390/net: add pnetid support")

from the s390 tree and commit:

  e1cf4befa297 ("bpf, s390x: remove ld_abs/ld_ind")

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

diff --cc arch/s390/net/Makefile
index e2b85ffdbb0c,d4663b4bf509..000000000000
--- a/arch/s390/net/Makefile
+++ b/arch/s390/net/Makefile
@@@ -2,5 -2,4 +2,5 @@@
  #
  # Arch-specific network modules
  #
- obj-$(CONFIG_BPF_JIT) +=3D bpf_jit.o bpf_jit_comp.o
+ obj-$(CONFIG_BPF_JIT) +=3D bpf_jit_comp.o
 +obj-$(CONFIG_HAVE_PNETID) +=3D pnet.o

--Sig_/roaZ5u8C1Leq=F9cwqIJ16w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsMwjEACgkQAVBC80lX
0GzV+Qf8DwPinRjfUGxs69LJu4aWn1Cszl3B/Jvt2hc0WSvd0b66oHRstb8vGPkZ
VJFAhnTikb0dSZZMckxMuVNQk9veXHLJE9w7N8G006AeNHCL/fmqlHv8YCXotevy
7aH412g9BFImtt5y0KeVeYxM9gWy+8oz+c+5UNBMj1QfeDHy0YkhXLxQ7YmkGZpO
iV0pv0e5Ap9P0P5p37RxxqjMPQwb6rHgCut8eear0q33cCi2quoo/Fayci9+zKuX
GFp+WcxSy4zRsnIyhGWQ9jn8C2dMHz0t493ry/iz/gzkB+QN/naQvYCvLRqn6ODI
gy47PL0hp8T68Pc0IXPpEATh5H8nZw==
=aKfL
-----END PGP SIGNATURE-----

--Sig_/roaZ5u8C1Leq=F9cwqIJ16w--
