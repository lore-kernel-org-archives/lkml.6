Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3310C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8790F206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pulXZEhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbfBMANb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:13:31 -0500
Received: from ozlabs.org ([203.11.71.1]:44537 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732626AbfBMANb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:13:31 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43zg3X34LGz9sMr;
        Wed, 13 Feb 2019 11:13:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550016808;
        bh=ffEYlM1l72Ic5J13H9rV5xjLYPbJLww2rVJPhGEzGyU=;
        h=Date:From:To:Cc:Subject:From;
        b=pulXZEhl3V8ymBtvsGLkX/0mVwopmZpHKWT0mZ5KpscwwlRN2zXWERUoq41f+0Ok0
         GKd4HlZvt6dLBa+iQR743Xjwa1pIVgJMtc2gVmT9CvP1kEpsESWFs3i9mgj6X2g86b
         PrX0v4yilquJ7tA3q2GumXjXIFgr3dg3BmsY3cr9fc6y2C7BT/SDdqeNZzB+tj1mmu
         lykiTD66Ubhl/SYyhdC6zEySJ842/a7uHvcqtc0dI6T7M8ZcK9D8nCe/hmEMvWoJst
         9YOgylgr2L7Twkkvl1BO7/KczUzSHsO0WDz23Pxn6CdVHvm5/JNhSA3oqmm5EsHrnM
         pCbRWk/gd/pbw==
Date:   Wed, 13 Feb 2019 11:13:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Vlad Buslov <vladbu@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20190213111325.30cfc931@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/e1bzDPTGv3EFI.geS+VAeWk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e1bzDPTGv3EFI.geS+VAeWk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/sched/cls_tcindex.c

between commits:

  8015d93ebd27 ("net_sched: fix a race condition in tcindex_destroy()")
  033b228e7f26 ("net_sched: fix a memory leak in cls_tcindex")

from the net tree and commit:

  12db03b65c2b ("net: sched: extend proto ops to support unlocked classifie=
rs")

from the net-next tree.

I fixed it up (see the final resolution when linux-next is published)
and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/sched/cls_tcindex.c
index 38bb882bb958,14d6b4058045..000000000000
--- a/net/sched/cls_tcindex.c
+++ b/net/sched/cls_tcindex.c

--Sig_/e1bzDPTGv3EFI.geS+VAeWk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxjYSUACgkQAVBC80lX
0Gxv2Af9G8F2PMhER1FlSc/JpRwDJWHm6gFCJcBxPG0aKhIlr8vHXRGOjpMo/fTc
I7zlzIMMWdQtHnrylJrMOmEMYwhslPQ5FvqFIEWJQiYxDAhlbVmFCC8BJz1wCKXe
n1X49pjYE8/QnuqpINMrzh2RlNmPJ87qLESfdRHusBuVI5xGSS90ZeFkAvWM714m
Pi7QkC2NDd9HtIPLyATwQ1K5Nc0pVLwIKmJ5KDcfoC2/nGlwDYHUKy50W8QfaTRP
1kUWDLYGLoC3Amo33aHS8ptCVqQYFBIf0I8hJlvP+K+tX29Rq3xmRsxJ1S6+b335
TY1Vjgi36ADBzxVkMqqG81czxYMpZg==
=VSfd
-----END PGP SIGNATURE-----

--Sig_/e1bzDPTGv3EFI.geS+VAeWk--
