Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbeEBBwt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:52:49 -0400
Received: from ozlabs.org ([203.11.71.1]:44065 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751175AbeEBBwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:52:47 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 2 May 2018 11:52:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>,
        David Ahern <dsahern@gmail.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180502115243.699a789a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qhvTbt=eys8S7VCgYrkRad="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qhvTbt=eys8S7VCgYrkRad=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  include/net/ip6_route.h

between commit:

  edd7ceb78296 ("ipv6: Allow non-gateway ECMP for IPv6")

from the net tree and commit:

  93c2fb253d17 ("net/ipv6: Rename fib6_info struct elements")

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

diff --cc include/net/ip6_route.h
index abceb5864d99,8df4ff798b04..000000000000
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@@ -66,9 -66,10 +66,9 @@@ static inline bool rt6_need_strict(cons
  		(IPV6_ADDR_MULTICAST | IPV6_ADDR_LINKLOCAL | IPV6_ADDR_LOOPBACK);
  }
 =20
- static inline bool rt6_qualify_for_ecmp(const struct rt6_info *rt)
+ static inline bool rt6_qualify_for_ecmp(const struct fib6_info *f6i)
  {
- 	return (rt->rt6i_flags & (RTF_ADDRCONF | RTF_DYNAMIC)) =3D=3D 0;
 -	return (f6i->fib6_flags & (RTF_GATEWAY|RTF_ADDRCONF|RTF_DYNAMIC)) =3D=3D
 -	       RTF_GATEWAY;
++	return (f6i->fib6_flags & (RTF_ADDRCONF | RTF_DYNAMIC)) =3D=3D 0;
  }
 =20
  void ip6_route_input(struct sk_buff *skb);

--Sig_/qhvTbt=eys8S7VCgYrkRad=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrpGesACgkQAVBC80lX
0Gyeswf/SMixHMHXWNENscUWeT2y3vGXJ9IucibMxyKBfftnK1vSA2Ga+1oAZRFM
gcBReRGycfcz+6a/VUJXHE409F/CDBt+0j6/nSvuNI+VfsDvp8PuJ5V2nweKG/mV
+D7jzUFhfNXmrZI7eNrrIS1CAQelyuiHpj5dVq46z27Pd19It/89V8Xs4LOP1Iiu
G7oN9ozklkIaKZjxOSBqRD+0vvMOqYs8XeI1FS1mRSqfHzQGoZ6xFKvK7wHuh6Sy
7iCAcb1IAA/yGJPyMm9Xh9pdcusRdjGNZC+JXDxJ3sSez56iaCklvlwrMwRqWFHQ
3xPrqqWPGWHB4b/3QUHLvSkOLyuvmw==
=QSx6
-----END PGP SIGNATURE-----

--Sig_/qhvTbt=eys8S7VCgYrkRad=--
