Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeB0W5I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:57:08 -0500
Received: from ozlabs.org ([103.22.144.67]:54133 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751748AbeB0W5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:57:06 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 28 Feb 2018 09:56:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>,
        Petr Machata <petrm@mellanox.com>, Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180228095628.4a2f35c2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_Bh/X5UK0usw/Y0dq3AGew/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_Bh/X5UK0usw/Y0dq3AGew/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/ipv4/ip_tunnel.c

between commit:

  4e994776e7bd ("ip_tunnel: Do not use mark in skb by default")

from the net tree and commit:

  b0066da52ea5 ("ip_tunnel: Rename & publish init_tunnel_flow")

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

diff --cc net/ipv4/ip_tunnel.c
index 6d21068f9b55,b2117d89bc83..000000000000
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@@ -710,9 -694,16 +694,9 @@@ void ip_tunnel_xmit(struct sk_buff *skb
  		}
  	}
 =20
- 	init_tunnel_flow(&fl4, protocol, dst, tnl_params->saddr,
- 			 tunnel->parms.o_key, RT_TOS(tos), tunnel->parms.link,
- 			 tunnel->fwmark);
 -	if (tunnel->fwmark) {
 -		ip_tunnel_init_flow(&fl4, protocol, dst, tnl_params->saddr,
 -				    tunnel->parms.o_key, RT_TOS(tos),
 -				    tunnel->parms.link, tunnel->fwmark);
 -	}
 -	else {
 -		ip_tunnel_init_flow(&fl4, protocol, dst, tnl_params->saddr,
 -				    tunnel->parms.o_key, RT_TOS(tos),
 -				    tunnel->parms.link, skb->mark);
 -	}
++	ip_tunnel_init_flow(&fl4, protocol, dst, tnl_params->saddr,
++			    tunnel->parms.o_key, RT_TOS(tos),
++			    tunnel->parms.link, tunnel->fwmark);
 =20
  	if (ip_tunnel_encap(skb, tunnel, &protocol, &fl4) < 0)
  		goto tx_error;

--Sig_/_Bh/X5UK0usw/Y0dq3AGew/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqV4hwACgkQAVBC80lX
0GwrqggAiFjp+LqMKF3TIke4OIluFPCeN/t8IBL/DeYwXhwy5xRU7T30ty4hgZZ2
eSK40TUvDv/doWhK5uZbExMbs93nLo9K3A+kyVLF3sCt7h7cBZj2zgyWK9Tdg32J
hyFjtmUKqePOl2b/P1wa/1mp/IVD1G8DN/ucBiPJsVsdzuBlsc4hmzPbapGv7bgs
aV7yGBMF48xCPXYwDggeRA6xFw6dNbPrzeNXdwo7tg/WsU28pq/Ao0tJeEYgOl2V
Qm/QZLbZeMFhW4COOSGS3lvX8WkbjYkT8jY8NiMU8jxU+RuEXQqbYSgGOXDlwj90
f7eK67fg1bghKAio0N3tv0tzfw29DQ==
=bvIx
-----END PGP SIGNATURE-----

--Sig_/_Bh/X5UK0usw/Y0dq3AGew/--
