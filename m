Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeCOBz7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:55:59 -0400
Received: from ozlabs.org ([103.22.144.67]:54525 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751362AbeCOBz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:55:57 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 12:55:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sabrina Dubroca <sd@queasysnail.net>, David Ahern <dsahern@gmail.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180315125525.110a3d7c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CVnpJA+3Bo0knTH5218AAtT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CVnpJA+3Bo0knTH5218AAtT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/ipv4/xfrm4_policy.c

between commit:

  d52e5a7e7ca4 ("ipv4: lock mtu in fnhe when received PMTU < net.ipv4.route=
.min_pmtu")

from the net tree and commit:

  68e813aa4307 ("net/ipv4: Remove fib table id from rtable")

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

diff --cc net/ipv4/xfrm4_policy.c
index fbebda67ac1b,0c752dc3f93b..000000000000
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@@ -100,10 -100,7 +100,9 @@@ static int xfrm4_fill_dst(struct xfrm_d
  	xdst->u.rt.rt_gateway =3D rt->rt_gateway;
  	xdst->u.rt.rt_uses_gateway =3D rt->rt_uses_gateway;
  	xdst->u.rt.rt_pmtu =3D rt->rt_pmtu;
 +	xdst->u.rt.rt_mtu_locked =3D rt->rt_mtu_locked;
- 	xdst->u.rt.rt_table_id =3D rt->rt_table_id;
  	INIT_LIST_HEAD(&xdst->u.rt.rt_uncached);
 +	rt_add_uncached_list(&xdst->u.rt);
 =20
  	return 0;
  }

--Sig_/CVnpJA+3Bo0knTH5218AAtT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqp0o0ACgkQAVBC80lX
0GzYPAf/SbKjgqlPGyMtfzb6MN2RFW+5dLQLLUg1ojk96i0B+2Gs4vTr5xAkwpCt
j3IA3CLlAyyQWYvmvmeG6rwPbc6gReCzqTC4JWIpCi4E3EaPQoep6YK+bMTXEZS8
9RO4vxdLRvCrvBHl28BtidTOAvbD94ToJ04cIBA1L3uAsyYYuKGh0dhGqEoNMzUA
+3g84D0i9nvxaILjITM9HS8IMHweoo+ioeqCOBGF2VvLok3S0ZU+4W2zzRqUWFqG
+mbJthVNixB7r6gkXvypknFXxOkJeoNuyaGRfuJKjXth46aD1FIZYurcxAS9ICkO
rzchUhrjPwxJuRgMXBNsxBzl4yDDKg==
=9gTS
-----END PGP SIGNATURE-----

--Sig_/CVnpJA+3Bo0knTH5218AAtT--
