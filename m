Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D863BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F82C208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DuzrtcqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F82C208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933418AbeGIA3M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 20:29:12 -0400
Received: from ozlabs.org ([203.11.71.1]:55053 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933155AbeGIA3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 20:29:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41P5mh6CJ8z9s01;
        Mon,  9 Jul 2018 10:29:08 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531096149;
        bh=niSRGvmpH7RxtFRErcRsXXZDyl+u15chjLwR6ruhOn4=;
        h=Date:From:To:Cc:Subject:From;
        b=DuzrtcqOrMfd9ZysA+y1FqVH67Yle4X6W8muimbZuSTGsTr8S/WE+k+w6QB5khLYm
         3ol51FeJWFZmY+zPYGLGp574zW+M1LgmmlrYm8njZc3bB1ms2QpNGCV37z+Y+vlO//
         IpH9CFuajNtL1lOlXqtcvlOQwoqU8fk0Ultev64p8/heJT08t4mlKcyQ4vREwjHoG1
         PSGCuhqDDQ5L5GczFbYScU1IhK63NdTgIGuLTfPqZ/XqVLOp9P+aeeNCcaSAc164e1
         a+FNzYi0wGei/X7iMpNw4eNLs+tcedxQ0ZB4ImRZiiidU9mkY1xerazBrkwwkbfLDH
         B2owJhJqK/5dA==
Date:   Mon, 9 Jul 2018 10:28:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anton Mikaev <amikaev@aquantia.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180709102847.214c31d5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6Y7hqhR_ZAi=/8EfbWwa6n9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6Y7hqhR_ZAi=/8EfbWwa6n9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/aquantia/atlantic/aq_hw.h

between commit:

  94b3b542303f ("net: aquantia: vlan unicast address list correct handling")

from the net tree and commit:

  c1af5427954b ("net: aquantia: Ethtool based ring size configuration")

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

diff --cc drivers/net/ethernet/aquantia/atlantic/aq_hw.h
index 2c6ebd91a9f2,1a51152029c3..000000000000
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
@@@ -98,8 -100,9 +100,11 @@@ struct aq_stats_s=20
  #define AQ_HW_MEDIA_TYPE_TP    1U
  #define AQ_HW_MEDIA_TYPE_FIBRE 2U
 =20
 +#define AQ_HW_MULTICAST_ADDRESS_MAX     32U
 +
+ #define AQ_HW_TXD_MULTIPLE 8U
+ #define AQ_HW_RXD_MULTIPLE 8U
+=20
  struct aq_hw_s {
  	atomic_t flags;
  	u8 rbl_enabled:1;

--Sig_/6Y7hqhR_ZAi=/8EfbWwa6n9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltCrD8ACgkQAVBC80lX
0Gw2mAf8DaLNprLEBug2cwtVjrJvqe5vJ6CxF3lCr0QPX0jVYhM0invbbtsvuoXE
b9y1ieWTPb+4Y9huDg8hpf2kPfHQqYh2VhGUmU37d3XfbmPmKpN7DqQDDzr16mzU
adNMHeGZGo4YeAzDFvkofIfK8nSbp+yQ6OJjzzgv5I3LR0tn4NvKjOf2SZQvALVk
ksI0wywhTMq/WQVqQO/AmCEa3KiVCRSJiiGxypgJJiiiFyCELXwMDkQQqiIpqtuw
LfvXDzOszvi5RnTRsXuZbWxrh8rXJs8BPVb+hWYl6wONkYrQ8OJ1xI2Ddm8flAJl
mZskpyeEWB536A4w60DmBCfvwP+Ckg==
=sI/h
-----END PGP SIGNATURE-----

--Sig_/6Y7hqhR_ZAi=/8EfbWwa6n9--
