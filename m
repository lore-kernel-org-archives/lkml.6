Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B1BC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C60D20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fZ/PnAOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C60D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeLDBFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:05:33 -0500
Received: from ozlabs.org ([203.11.71.1]:53047 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbeLDBFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 20:05:33 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4383ZK65Lrz9sBQ;
        Tue,  4 Dec 2018 12:05:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543885530;
        bh=600Kp/Omey3kPRDfno+eRQx2v4svF/J4t4gnY8YWabM=;
        h=Date:From:To:Cc:Subject:From;
        b=fZ/PnAOTeiFRrDKXl0bpEmWJNsHd8md2SdnGCWrQSPfxe1cbEs5c8XIV6T3ctpJYR
         ZvZfd3VLHYlCUSyJVPZbbhcpsCX4liM3O3fJxY0SKA7b89nPUpa8lwsZBxtRgGf9H2
         PkXFCTF9GY2CPYbu6ue/Y/8inYXJ8t4PR1xYiLJl9RnrVJ+yaIsQGyJ+YK0jqVkKZ3
         bOfgYkpdoBD9oynbeu2zxO1hE1jPmuiJGULIkUZr850/VTdeVQtU5kr6bEJsGyG2wa
         yRzGy0uSHYfiNhHcwzN+AhqTz+nLjPL0+1NL1F7f40cYXDU8ixjp7a9d90mJ4KMfEQ
         1XN935+8vROaQ==
Date:   Tue, 4 Dec 2018 12:05:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Joe Stringer <joe@wand.net.nz>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <20181204120529.222e65c7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0qiwlbuaXAD=8/ujjDA16IF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0qiwlbuaXAD=8/ujjDA16IF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got conflicts in:

  include/uapi/linux/bpf.h

between commit:

  d74286d2c25a ("bpf: Improve socket lookup reuseport documentation")

from the bpf tree and commit:

  90b1023f68c7 ("bpf: fix documentation for eBPF helpers")

from the bpf-next tree.

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
index ec8b40ff386e,572eb2d42768..000000000000
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@@ -2209,11 -2210,11 +2212,11 @@@ union bpf_attr=20
   *		This helper is available only if the kernel was compiled with
   *		**CONFIG_NET** configuration option.
   *	Return
-  *		Pointer to *struct bpf_sock*, or NULL in case of failure.
-  *		For sockets with reuseport option, the *struct bpf_sock*
-  *		result is from reuse->socks[] using the hash of the tuple.
+  *		A pointer to *struct bpf_sock*, or **NULL** in case of failure.
 - *		For sockets with reuseport option, **struct bpf_sock**
++ *		For sockets with reuseport option, the **struct bpf_sock**
+  *		return is from **reuse->socks**\ [] using hash of the packet.
   *
 - * struct bpf_sock *bpf_sk_lookup_udp(void *ctx, struct bpf_sock_tuple *t=
uple, u32 tuple_size, u32 netns, u64 flags)
 + * struct bpf_sock *bpf_sk_lookup_udp(void *ctx, struct bpf_sock_tuple *t=
uple, u32 tuple_size, u64 netns, u64 flags)
   *	Description
   *		Look for UDP socket matching *tuple*, optionally in a child
   *		network namespace *netns*. The return value must be checked,
@@@ -2245,14 -2244,15 +2248,16 @@@
   *		This helper is available only if the kernel was compiled with
   *		**CONFIG_NET** configuration option.
   *	Return
-  *		Pointer to *struct bpf_sock*, or NULL in case of failure.
-  *		For sockets with reuseport option, the *struct bpf_sock*
-  *		result is from reuse->socks[] using the hash of the tuple.
+  *		A pointer to **struct bpf_sock**, or **NULL** in case of
 - *		failure. For sockets with reuseport option, **struct bpf_sock**
 - *		return is from **reuse->socks**\ [] using hash of the packet.
++ *		failure. For sockets with reuseport option, the
++ *		**struct bpf_sock** return is from **reuse->socks**\ []
++ *		using hash of the packet.
   *
-  * int bpf_sk_release(struct bpf_sock *sk)
+  * int bpf_sk_release(struct bpf_sock *sock)
   *	Description
-  *		Release the reference held by *sock*. *sock* must be a non-NULL
-  *		pointer that was returned from bpf_sk_lookup_xxx\ ().
+  *		Release the reference held by *sock*. *sock* must be a
+  *		non-**NULL** pointer that was returned from
+  *		**bpf_sk_lookup_xxx**\ ().
   *	Return
   *		0 on success, or a negative error in case of failure.
   *
@@@ -2494,8 -2495,9 +2509,9 @@@ struct __sk_buff=20
  	/* ... here. */
 =20
  	__u32 data_meta;
 -	struct bpf_flow_keys *flow_keys;
 +	__bpf_md_ptr(struct bpf_flow_keys *, flow_keys);
  	__u64 tstamp;
+ 	__u32 wire_len;
  };
 =20
  struct bpf_tunnel_key {

--Sig_/0qiwlbuaXAD=8/ujjDA16IF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwF0tkACgkQAVBC80lX
0Gy1Twf/XiYWV15vq6amV99G6gvuypSEAWDCrJ9MWQQ4Pm40S+S4LNdcHOcgEc3r
Z0HCVcfxFVuvW3WUBvH+o6f0VKoiPUqXvQZpB7je6XfJdHzNQa4JdPbkBhtrTWu5
+OIOvi+L/GrzemVkJZholLvmaIW0hztC3p5ycLScpp7cpRN3IqJ3uypMI/wMWcjr
hiOGL1ZtpItmQF9vB/cxntTheUbkk3OtmmeppHKk+P/GFbm/652QFdOp0oDKszmR
BewEvHQu6AMSg1okNSBV+kgTu6RcEPgLO3M0d98EGOOJy8eI+PZhykzfw4SyCwFg
HoZqKacm81NON1+cihJyHDyINB0bYA==
=ybMQ
-----END PGP SIGNATURE-----

--Sig_/0qiwlbuaXAD=8/ujjDA16IF--
