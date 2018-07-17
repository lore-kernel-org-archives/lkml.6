Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C848ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBF020BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Vi222zU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBF020BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbeGQDDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 23:03:40 -0400
Received: from ozlabs.org ([203.11.71.1]:44115 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbeGQDDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 23:03:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41V48K5MbKz9s0n;
        Tue, 17 Jul 2018 12:33:21 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531794802;
        bh=RLAoqQ/ZPpg9VQ6aD/aQxw5l0h+DLvyNuHRP8oEAKSU=;
        h=Date:From:To:Cc:Subject:From;
        b=Vi222zU1co6jtGIZNn17t0CB0PmkEQNOw4VznShKEMKS6VQMJ/dySXS63O49KMbwg
         yOQxb/uv6ipOvacMWlZ0wmk6MzrF64cP9L/48eXAN2v1I8jJoy/ELHiOHeaKaoVoWy
         9iD5msNbSlLQyt/Jgi0xEZS0ny58bydrbD8fTcLSEIqwLxm4zJZoTjF895+Mft29dG
         TEPlkHiSSHjaou5eSQVH2SVAXXq4QWpbuqDUfXBvTllwTEgQOpSn/wFiAEKqVBWSIk
         crf4Znc5/pjnZmFt8iotRG9p1eXSFKoPrJ2bH3XTiCKNKRe+e8ZRFRD8G/qem6gUtD
         Ni9xNVhusJlTw==
Date:   Tue, 17 Jul 2018 12:33:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Boris Pismenny <borisp@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180717123306.3e030fde@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/R2RZjPx4TyHgkOtDzbO5d0i"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R2RZjPx4TyHgkOtDzbO5d0i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  include/linux/skbuff.h

between commit:

  8b7008620b84 ("net: Don't copy pfmemalloc flag in __copy_skb_header()")

from the net tree and commit:

  784abe24c903 ("net: Add decrypted field to skb")

from the net-next tree.

I fixed it up (see below - maybe not the best resolution) and can carry
the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/skbuff.h
index 610a201126ee,3ceb8dcc54da..000000000000
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@@ -630,7 -630,7 +630,8 @@@ typedef unsigned char *sk_buff_data_t
   *	@hash: the packet hash
   *	@queue_mapping: Queue mapping for multiqueue devices
   *	@xmit_more: More SKBs are pending for this queue
 + *	@pfmemalloc: skbuff was allocated from PFMEMALLOC reserves
+  *	@decrypted: Decrypted SKB
   *	@ndisc_nodetype: router type (from link layer)
   *	@ooo_okay: allow the mapping of a socket to a queue to be changed
   *	@l4_hash: indicate hash is a canonical 4-tuple hash over transport
@@@ -736,7 -737,11 +738,11 @@@ struct sk_buff=20
  				peeked:1,
  				head_frag:1,
  				xmit_more:1,
 +				pfmemalloc:1;
+ #ifdef CONFIG_TLS_DEVICE
 -				decrypted:1;
 -#else
 -				__unused:1;
++	__u8			decrypted:1,
++				__unused:7;
+ #endif
 =20
  	/* fields enclosed in headers_start/headers_end are copied
  	 * using a single memcpy() in __copy_skb_header()

--Sig_/R2RZjPx4TyHgkOtDzbO5d0i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltNVWIACgkQAVBC80lX
0GxJDAf7BW5N4RmxlnCIm57PBOKM4axQk+io2wG99dwG3gUaGmUPaS0yV+Jwl6KY
yT4Y5wJAiFXliGifiy/p4HvfLujqpfrl8GWHuTfejrT3/GKxLg4XDg5W/3+m77n6
gE8/lZeDk+PShNNGVhVuT8bb9VdaaAlHzA1ukiHNBe1Gbb2pW3C/ZqFLWIztz7BV
LIM0iglWaz+8Fcg/WxVwm9Ie3pP4DIs+jhK5IG1GBARVd1zR5h9LhPqHm/iJQN1r
49GdluWKOV2om1wM87EpU/eknmGcuzgF3lNm1F906vqtLYwZXRH/Igbxi3QdGt4T
CSu2MMtpio7y6UHa6QmeU4nlT+x5Mg==
=gDxA
-----END PGP SIGNATURE-----

--Sig_/R2RZjPx4TyHgkOtDzbO5d0i--
