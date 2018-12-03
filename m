Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3036C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8B320892
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qUKSH62V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8B320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbeLCCQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 21:16:36 -0500
Received: from ozlabs.org ([203.11.71.1]:54505 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbeLCCQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 21:16:36 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 437TBk08XBz9sCX;
        Mon,  3 Dec 2018 13:16:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543803390;
        bh=pIuZWNNZUnpt/AGxk7HJSyvk7lB9kbcCGa0v9iGMsd8=;
        h=Date:From:To:Cc:Subject:From;
        b=qUKSH62VlqsYe1zXDtTyimvT5kFDTK4dLaailbOAoJIdHG+3VjV8UxpZzgLFnoSra
         efc2kIQKbmdvXhpUERPBaL11Yn5qfMqHdj/DLgQUTPTXBSfhjZ1lV1n1/a5hyvPJ1O
         WvQ4ruT/fXTi9fi+QLYTxgtz4guRYlWd93B0p40yH6/wHoOc+rAYLepq4YJgTWr2B7
         fo8g+awHOYw4dhJsgvJm01jcqe2yfEZL+X2O4OiuvhzMoiEKjFg/KaqZMi208Spu+c
         cKWDQG6TCGIOrm4eCE7AY5UkqSNMblNFFs7pzeNXc6HnVqMqakOpDsn69KpH2UUvdp
         U7v7eBIgUO46g==
Date:   Mon, 3 Dec 2018 13:16:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        Nitin Hande <nitin.hande@gmail.com>,
        Vlad Dumitrescu <vladum@google.com>
Subject: linux-next: manual merge of the net-next tree with the bpf tree
Message-ID: <20181203131629.085324b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rUAHhD.nx_6ZwCaAp=zUziE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rUAHhD.nx_6ZwCaAp=zUziE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/core/filter.c

between commits:

  b7df9ada9a77 ("bpf: fix pointer offsets in context for 32 bit")
  f71c6143c203 ("bpf: Support sk lookup in netns with id 0")

from the bpf tree and commits:

  c8123ead13a5 ("bpf: Extend the sk_lookup() helper to XDP hookpoint.")
  f11216b24219 ("bpf: add skb->tstamp r/w access from tc clsact and cg skb =
progs")

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

diff --cc net/core/filter.c
index 8d2c629501e2,bd0df75dc7b6..000000000000
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@@ -4887,26 -5067,26 +5067,27 @@@ __bpf_sk_lookup(struct sk_buff *skb, st
  	struct sock *sk =3D NULL;
  	u8 family =3D AF_UNSPEC;
  	struct net *net;
+ 	int sdif;
 =20
  	family =3D len =3D=3D sizeof(tuple->ipv4) ? AF_INET : AF_INET6;
 -	if (unlikely(family =3D=3D AF_UNSPEC || netns_id > U32_MAX || flags))
 +	if (unlikely(family =3D=3D AF_UNSPEC || flags ||
 +		     !((s32)netns_id < 0 || netns_id <=3D S32_MAX)))
  		goto out;
 =20
- 	if (skb->dev)
- 		caller_net =3D dev_net(skb->dev);
+ 	if (family =3D=3D AF_INET)
+ 		sdif =3D inet_sdif(skb);
  	else
- 		caller_net =3D sock_net(skb->sk);
+ 		sdif =3D inet6_sdif(skb);
+=20
 -	if (netns_id) {
 +	if ((s32)netns_id < 0) {
 +		net =3D caller_net;
- 		sk =3D sk_lookup(net, tuple, skb, family, proto);
++		sk =3D sk_lookup(net, tuple, ifindex, sdif, family, proto);
 +	} else {
  		net =3D get_net_ns_by_id(caller_net, netns_id);
  		if (unlikely(!net))
  			goto out;
- 		sk =3D sk_lookup(net, tuple, skb, family, proto);
+ 		sk =3D sk_lookup(net, tuple, ifindex, sdif, family, proto);
  		put_net(net);
 -	} else {
 -		net =3D caller_net;
 -		sk =3D sk_lookup(net, tuple, ifindex, sdif, family, proto);
  	}
 =20
  	if (sk)
@@@ -5436,10 -5737,14 +5738,14 @@@ static bool bpf_skb_is_valid_access(in
  		if (size !=3D size_default)
  			return false;
  		break;
 -	case bpf_ctx_range(struct __sk_buff, flow_keys):
 -		if (size !=3D sizeof(struct bpf_flow_keys *))
 +	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 +		if (size !=3D sizeof(__u64))
  			return false;
  		break;
+ 	case bpf_ctx_range(struct __sk_buff, tstamp):
+ 		if (size !=3D sizeof(__u64))
+ 			return false;
+ 		break;
  	default:
  		/* Only narrow read access allowed for now. */
  		if (type =3D=3D BPF_WRITE) {
@@@ -5465,8 -5770,9 +5771,9 @@@ static bool sk_filter_is_valid_access(i
  	case bpf_ctx_range(struct __sk_buff, data):
  	case bpf_ctx_range(struct __sk_buff, data_meta):
  	case bpf_ctx_range(struct __sk_buff, data_end):
 -	case bpf_ctx_range(struct __sk_buff, flow_keys):
 +	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
  	case bpf_ctx_range_till(struct __sk_buff, family, local_port):
+ 	case bpf_ctx_range(struct __sk_buff, tstamp):
  		return false;
  	}
 =20
@@@ -5531,7 -5841,8 +5842,8 @@@ static bool lwt_is_valid_access(int off
  	case bpf_ctx_range(struct __sk_buff, tc_classid):
  	case bpf_ctx_range_till(struct __sk_buff, family, local_port):
  	case bpf_ctx_range(struct __sk_buff, data_meta):
 -	case bpf_ctx_range(struct __sk_buff, flow_keys):
 +	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
+ 	case bpf_ctx_range(struct __sk_buff, tstamp):
  		return false;
  	}
 =20
@@@ -5959,7 -6271,8 +6272,8 @@@ static bool sk_skb_is_valid_access(int=20
  	switch (off) {
  	case bpf_ctx_range(struct __sk_buff, tc_classid):
  	case bpf_ctx_range(struct __sk_buff, data_meta):
 -	case bpf_ctx_range(struct __sk_buff, flow_keys):
 +	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
+ 	case bpf_ctx_range(struct __sk_buff, tstamp):
  		return false;
  	}
 =20

--Sig_/rUAHhD.nx_6ZwCaAp=zUziE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwEkf0ACgkQAVBC80lX
0Gwetwf/dvafRB9udNV2+nbY1Yb6i+nLj5jP7+08CHrP3TX2V8rlTDaeBxtGU+J9
h/KLMtJq9e+G4mkHiBIFBnsXXaUWFvLMZKiCbAf2t0kT/rl1VY8+FZA9uOD/VAdw
JQypiFZRWWsyBKL9FH0A7KHMGImRJ+qXSEQ5n3FGkyrdJx+Z0Ggy5Fg6jF8Eft/H
Bryi2aaoNwcIceTA1qthPHxKf9d+xji1YS6QAItlMGLH6y3ESq+dP9YmC9IGpiRG
vEPK1JGkJ7Nm5NNUskLrSUrJ0m5JSleEKRRv2MLoVezDsA71WLlf9dSxi9H5PYvW
J1vJG2kxgawoX3X57mqB+p8/naX+EA==
=Y1aZ
-----END PGP SIGNATURE-----

--Sig_/rUAHhD.nx_6ZwCaAp=zUziE--
