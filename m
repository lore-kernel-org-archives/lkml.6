Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61599C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC6B24906
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WHj3MsbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC6B24906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753554AbeGCArZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 20:47:25 -0400
Received: from ozlabs.org ([203.11.71.1]:38973 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753281AbeGCArY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 20:47:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41KQST4V8Pz9s29;
        Tue,  3 Jul 2018 10:47:21 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530578842;
        bh=GnPK9roTtaQ04M1r7/U5rIGN0/Zu8IYT9NeC2CarZus=;
        h=Date:From:To:Cc:Subject:From;
        b=WHj3MsbUAnvhpfMw3WLNKeyB1guew46IMzbx503HjollWTCtcWeRVNlH8pRGm3zsH
         4Y1zk0mrd+/2RRQq7Dl0TwrGbwo7EOvEJABOzOayIFGMXDmmmHlw+b3lNjMIArOT2x
         oVIbCE8gLlc71kNFPh2wYNG0gP1nzVjKgCK4deRfcWrATdzTpJduOyZ3rEFCTz8xuX
         ArHsp4aFVMBLqZsiW0ANSlRUYQg6qRgBMD8Tl/PThBUj/1KH9pQn9QJu3SPbQBwIFN
         mvP4+1G8EV4EDp7XVwSBNsakPPn0KE4omrUBZ6BLunmt4hIIyIXo0nxF0obq83LQ5f
         w8VyUX1ye5MTw==
Date:   Tue, 3 Jul 2018 10:47:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sabrina Dubroca <sd@queasysnail.net>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20180703104712.30a36f1a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UcNzjmxphxljKWWSpn/O1qz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UcNzjmxphxljKWWSpn/O1qz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

net/ipv4/fou.c: In function 'gue_gro_receive':
net/ipv4/fou.c:451:35: error: passing argument 2 of 'skb_gro_flush_final_re=
mcsum' from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  skb_gro_flush_final_remcsum(skb, pp, flush, &grc);
                                   ^~
In file included from include/net/inet_sock.h:23:0,
                 from include/linux/udp.h:20,
                 from net/ipv4/fou.c:6:
include/linux/netdevice.h:2799:20: note: expected 'struct sk_buff **' but a=
rgument is of type 'struct sk_buff *'
 static inline void skb_gro_flush_final_remcsum(struct sk_buff *skb,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/vxlan.c: In function 'vxlan_gro_receive':
drivers/net/vxlan.c:627:35: error: passing argument 2 of 'skb_gro_flush_fin=
al_remcsum' from incompatible pointer type [-Werror=3Dincompatible-pointer-=
types]
  skb_gro_flush_final_remcsum(skb, pp, flush, &grc);
                                   ^~
In file included from include/net/inet_sock.h:23:0,
                 from include/linux/udp.h:20,
                 from drivers/net/vxlan.c:17:
include/linux/netdevice.h:2799:20: note: expected 'struct sk_buff **' but a=
rgument is of type 'struct sk_buff *'
 static inline void skb_gro_flush_final_remcsum(struct sk_buff *skb,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  d4546c2509b1 ("net: Convert GRO SKB handling to list_head.")

from the net-next tree interacting with commit

  603d4cf8fe09 ("net: fix use-after-free in GRO with ESP")

from Linus' tree.

I took a guess and aplied the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 3 Jul 2018 10:37:05 +1000
Subject: [PATCH] net: update for conversion of GRO SKB handling

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/netdevice.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e1d4084c0651..64480a0f2c16 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2797,7 +2797,7 @@ static inline void skb_gro_flush_final(struct sk_buff=
 *skb, struct sk_buff *pp,
 		NAPI_GRO_CB(skb)->flush |=3D flush;
 }
 static inline void skb_gro_flush_final_remcsum(struct sk_buff *skb,
-					       struct sk_buff **pp,
+					       struct sk_buff *pp,
 					       int flush,
 					       struct gro_remcsum *grc)
 {
@@ -2813,7 +2813,7 @@ static inline void skb_gro_flush_final(struct sk_buff=
 *skb, struct sk_buff *pp,
 	NAPI_GRO_CB(skb)->flush |=3D flush;
 }
 static inline void skb_gro_flush_final_remcsum(struct sk_buff *skb,
-					       struct sk_buff **pp,
+					       struct sk_buff *pp,
 					       int flush,
 					       struct gro_remcsum *grc)
 {
--=20
2.17.1

--=20
Cheers,
Stephen Rothwell

--Sig_/UcNzjmxphxljKWWSpn/O1qz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls6x5AACgkQAVBC80lX
0Gyirwf+N2tlY1eLSPdJC+Nsg5OXWD0uXLtpyQzNYwKmGEBTGL86oabLV5VkcJZ0
3d92vYhKxlhrqj8I3LLpw+9xjjtB6RImV596hJZjnDIpBUxwVG2WX3PH/4BMpyRp
u914A9R1C0NuVADc7mZk1EdVRu4Ai7H2L0tvEbIkzQj5zIAAKsZu726syOwlwN9x
FnCziI5zABGk//RTVDtxhuhfuUb6DHgjDQNUC2xOl9/cVEmxoJiw7fTXjTYu6/kX
ooxzKE5lMfEWXPUN4gaId/KUnMJaOGTYKhRxVivWmPo3NJOiVPLyRcXeoqtMM6dy
+Toy0V4SnEUm5e3L1snuuN6kjjyTMA==
=UgTG
-----END PGP SIGNATURE-----

--Sig_/UcNzjmxphxljKWWSpn/O1qz--
