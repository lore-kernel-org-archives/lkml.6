Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932496AbeCDXBO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 18:01:14 -0500
Received: from ozlabs.org ([103.22.144.67]:33151 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932403AbeCDXBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 18:01:10 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 5 Mar 2018 10:00:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        David Ahern <dsahern@gmail.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180305100022.066aefa7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/L1SNENcV6P8iK/RV1lWjdAp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L1SNENcV6P8iK/RV1lWjdAp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/ipv6/netfilter/nft_fib_ipv6.c

between commit:

  47b7e7f82802 ("netfilter: don't set F_IFACE on ipv6 fib lookups")

from the net tree and commit:

  b75cc8f90f07 ("net/ipv6: Pass skb to route lookup")

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

diff --cc net/ipv6/netfilter/nft_fib_ipv6.c
index 62fc84d7bdff,3230b3d7b11b..000000000000
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@@ -180,7 -180,9 +180,8 @@@ void nft_fib6_eval(const struct nft_exp
  	}
 =20
  	*dest =3D 0;
- 	rt =3D (void *)ip6_route_lookup(nft_net(pkt), &fl6, lookup_flags);
 - again:
+ 	rt =3D (void *)ip6_route_lookup(nft_net(pkt), &fl6, pkt->skb,
+ 				      lookup_flags);
  	if (rt->dst.error)
  		goto put_rt_err;
 =20

--Sig_/L1SNENcV6P8iK/RV1lWjdAp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqceoYACgkQAVBC80lX
0Gy45wf/XJTzbWirrcEwtDp+66Xf8gGiRaokrUk/vm/B7kTY5h70fEuEhfnhEM8H
RNUSoJxeV2eRu2vNyVnfd0nGPlCdshEoUHIZT7dnCApjdGcIFGmnmzb/jaLSwHjq
bAMaEFEw4y1PnEgQ0nMLJqQAFa4oMZVrk2CuESSXiXjhp1cVKC4QcPStDccrADYd
o/0fTSJUgKNcxZXLISK8XRZwjWbRCeB1ioyngktfzDjZAuqFZOj9I2+3meTcD0FY
NyE4eSDhcMAn7gl7ffa+M8yaWDOz3wNo62JaSKdDS8lu/KBBsOMn2agaT4mY+jzw
atvMI3H6VKwXJn2elFR3niKa8aEOIQ==
=NMvr
-----END PGP SIGNATURE-----

--Sig_/L1SNENcV6P8iK/RV1lWjdAp--
