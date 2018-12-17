Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22855C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 00:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA27206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 00:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MM+cL7Og"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbeLQANb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 19:13:31 -0500
Received: from ozlabs.org ([203.11.71.1]:57187 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731169AbeLQANb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 19:13:31 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43J1pJ6mRqz9sD4;
        Mon, 17 Dec 2018 11:13:28 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545005609;
        bh=9SvCBK5JN6TRnQejKl7HP7vcEiYtujXFikKV0Y2QfYk=;
        h=Date:From:To:Cc:Subject:From;
        b=MM+cL7OgiHUNQcB8bC21IG1IELKBbMEXo/aP5IIS3Vl+PmerliEj9GRRzrnVrjZbQ
         9dAqktdqoDyqWnSFgOP9iRaxBk7EmvJmEYPKvddqzdWONPvTXrdo/UIxPvrDDx+YZM
         YL4dseUrhumestaXocwUkZhdAIKrvx6/RDlpARHjNLsvUwgp6B8DjQJgRzPXgqsW4n
         gTNJI4S2uUNqbDsShmQE8DUCI/VHM7kzBaKYUTcLVt7/hJyoO2XW5maI2iw8bmO8YU
         Ff8DMi3d7xkBWfvzBLAzBnVq0SNBVhJCJ7A51A3PQ7uogzzuYoJ9IxVHZvGxktmDyH
         +sfUpdzuEPwtw==
Date:   Mon, 17 Dec 2018 11:13:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Atul Gupta <atul.gupta@chelsio.com>,
        Santosh Rastapur <santosh@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20181217111328.220b2827@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/q8.eSqx1J_GEU5DOsNGz2_F"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q8.eSqx1J_GEU5DOsNGz2_F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/crypto/chelsio/chtls/chtls_cm.c

between commit:

  0c3a16be700e ("crypto/chelsio/chtls: send/recv window update")

from the net tree and commit:

  02d805dc5fe3 ("cxgb4: use new fw interface to get the VIN and smt index")

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

diff --cc drivers/crypto/chelsio/chtls/chtls_cm.c
index 931b96c220af,228b91b7d6b5..000000000000
--- a/drivers/crypto/chelsio/chtls/chtls_cm.c
+++ b/drivers/crypto/chelsio/chtls/chtls_cm.c
@@@ -1079,11 -1074,10 +1079,10 @@@ static struct sock *chtls_recv_sock(str
  	csk->txq_idx =3D (rxq_idx < cdev->lldi->ntxq) ? rxq_idx :
  			port_id * step;
  	csk->sndbuf =3D newsk->sk_sndbuf;
- 	csk->smac_idx =3D cxgb4_tp_smt_idx(cdev->lldi->adapter_type,
- 					 cxgb4_port_viid(ndev));
+ 	csk->smac_idx =3D ((struct port_info *)netdev_priv(ndev))->smt_idx;
 -	tp->rcv_wnd =3D select_rcv_wnd(csk);
  	RCV_WSCALE(tp) =3D select_rcv_wscale(tcp_full_space(newsk),
 -					   WSCALE_OK(tp),
 +					   sock_net(newsk)->
 +						ipv4.sysctl_tcp_window_scaling,
  					   tp->window_clamp);
  	neigh_release(n);
  	inet_inherit_port(&tcp_hashinfo, lsk, newsk);

--Sig_/q8.eSqx1J_GEU5DOsNGz2_F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwW6igACgkQAVBC80lX
0GwlZwgAiVlyeC6woMsnwzRjXR9oiS1AUffMkAZ1nTVy/hIVPd088AbOBBpv38Wq
NtpIlMS1fGK4eJix6NPcNqqrMNhSnIRi2l7lyaJBCWIsz8tdWfnr7kpTTxv5GwZT
u785sTxgs2Qjs0W0J6BFPCmbXy9+sq29zR9BLsOfKquo/HUmJSW1DHCQY0TcedrM
Scq1GX0ESEjAqU9xtZyYVtGpJOafjd5AEUAAZJgJ2zCuzUTHRwFcyc74dufdlmdY
exGu1TuU4c8ycocr3OZdK7PMAKwuMMvZ7crifNsWSQf/eNbaWGdU9+hsB1wTU+rR
CXBBF0ZKR76sUZbRAazfzeF0Sas9Rw==
=lWkU
-----END PGP SIGNATURE-----

--Sig_/q8.eSqx1J_GEU5DOsNGz2_F--
