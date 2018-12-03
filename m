Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E229CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBC320851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LBLiXPq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBC320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbeLCCDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 21:03:20 -0500
Received: from ozlabs.org ([203.11.71.1]:48909 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbeLCCDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 21:03:20 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 437SvP118wz9s7W;
        Mon,  3 Dec 2018 13:03:13 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543802596;
        bh=ComY6Wa0XlJd7uzJf0mpBfEvWktDRBXmM8NGfVn84Hk=;
        h=Date:From:To:Cc:Subject:From;
        b=LBLiXPq3LvUEh3w5R6SksslQyISM0f/8gPrO5v5hKloeBILPm66cP/EzBpT0G5In2
         ZlKbZnWif9xnmjo+wCUHZTQS7ji+YlTUIC2OtiudNB8sXZsWT5iKaxLpyluD5Md6yU
         qtep3FQOGv9BcMnxNKjU6bbsxm0fGj+aWSX0TbvAWD3TmlNrBKaqvI8uH7Uirfa+AU
         fcI6gX5uATzdaTQgJiMlIT4sUc/WCxO/5R8jvcYP7YCsnfe9slrTPf4/JL7v39BnrQ
         uAxYXtYzdpfd46/xSgJaoT+b0p3a1lGMP1L/H2gcft+jfU4xZUjTXqZrUnhW1DCf9Q
         CnnWYjaSYpkzQ==
Date:   Mon, 3 Dec 2018 13:03:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        Nitin Hande <nitin.hande@gmail.com>,
        Vlad Dumitrescu <vladum@google.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: linux-next: manual merge of the net-next tree with the bpf tree
Message-ID: <20181203130312.687d560d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/y.u.TdzF9tv3osKnhYSq8=L"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/y.u.TdzF9tv3osKnhYSq8=L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  include/uapi/linux/bpf.h
  tools/include/uapi/linux/bpf.h

between commits:

  b7df9ada9a77 ("bpf: fix pointer offsets in context for 32 bit")
  d74286d2c25a ("bpf: Improve socket lookup reuseport documentation")

from the bpf tree and commits:

  c8123ead13a5 ("bpf: Extend the sk_lookup() helper to XDP hookpoint.")
  608114e441ad ("tools: sync linux/bpf.h")
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

diff --cc include/uapi/linux/bpf.h
index 72c453a8bf50,597afdbc1ab9..000000000000
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@@ -2473,7 -2481,8 +2494,8 @@@ struct __sk_buff=20
  	/* ... here. */
 =20
  	__u32 data_meta;
 -	struct bpf_flow_keys *flow_keys;
 +	__bpf_md_ptr(struct bpf_flow_keys *, flow_keys);
+ 	__u64 tstamp;
  };
 =20
  struct bpf_tunnel_key {
diff --cc tools/include/uapi/linux/bpf.h
index 72c453a8bf50,597afdbc1ab9..000000000000
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@@ -2473,7 -2481,8 +2494,8 @@@ struct __sk_buff=20
  	/* ... here. */
 =20
  	__u32 data_meta;
 -	struct bpf_flow_keys *flow_keys;
 +	__bpf_md_ptr(struct bpf_flow_keys *, flow_keys);
+ 	__u64 tstamp;
  };
 =20
  struct bpf_tunnel_key {

--Sig_/y.u.TdzF9tv3osKnhYSq8=L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwEjuAACgkQAVBC80lX
0Gzmsgf/QLhwS2EGNugxz+/PMVyr4jmNVjekgM9mG8X8gdxm/ZItN7jIdnfqwkvz
JxB3ZlBd3H8LXtaFvLLANcgjweJzozJYdfH25FKPOznrXGO+m/coqkKmYerxFeaZ
j+/9h5psMh9ZQ/KNTCaC55YmR8hGWRAFizRAxmRUPqkrNdTjn5BUsUck32si5lmA
Cx5+3YTSbCHGDkoJwHERBkfxTz8ugPwuFlIFA32wfUrFd4MJqA0X/c4IwEQBVbj2
AhaQoZuK6k0dk2a37e+fBdCfaImQzWAxZer+cPqd+jfsuRC1znjheg55+Ewii9Ck
Uv8SfjVnaWUIb8PttkT9WQ4uNodcwA==
=n4+G
-----END PGP SIGNATURE-----

--Sig_/y.u.TdzF9tv3osKnhYSq8=L--
