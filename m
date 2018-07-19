Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7C8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC89206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Y/7SSQVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC89206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbeGSCF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 22:05:59 -0400
Received: from ozlabs.org ([203.11.71.1]:52103 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730349AbeGSCF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 22:05:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41WGXy6BzVz9s3x;
        Thu, 19 Jul 2018 11:25:22 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531963522;
        bh=8NdMqtd0GGVlIWvW0cSamrEwNUS9iTncV7Vvml3EfXU=;
        h=Date:From:To:Cc:Subject:From;
        b=Y/7SSQVZewW+GQql01oUVSK5LCvcZmDpEq2oz27Ya61egY/32RfI4BtP/Q07k5eUF
         uxYUrJ7IfogBJflej+9C1HjzJRB39foBxrkd5amsM3otUIy23yv9+ggqssQy+TtVbD
         wT3W7AMLoAMLZdU1kfnhgqO8hZVQYtDjKA/yQ736NMbMtD+Ew2sjlIrxDx5XIArRQh
         +FPAipgcKmMyeMn2vCJz4+mvl0v9iuGbPoWLNHhqbEXgCENyWOfZ5lzEcoAtdTCciq
         w4PyRaMxqYTHsnQE2kFWwfDF1Wwj7BFL13FovHNlLr9+9r5EFCMYI84eTCKv7IHxr8
         QA9Wfc95i6yaQ==
Date:   Thu, 19 Jul 2018 11:25:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Ilya Lesokhin <ilyal@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180719112502.14cbe80a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CXRQpIDxX.rJEPn13Ifp4Bi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CXRQpIDxX.rJEPn13Ifp4Bi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  include/linux/skbuff.h

between commit:

  8b7008620b84 ("net: Don't copy pfmemalloc flag in __copy_skb_header()")

from the net tree and commits:

  784abe24c903 ("net: Add decrypted field to skb")
  a48d189ef531 ("net: Move skb decrypted field, avoid explicity copy")

from the net-next tree.

The conflict only occurs because a48d189ef531 didn't put the comment
back on the __unused field that was there before 784abe24c903.

I fixed it up (I used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/CXRQpIDxX.rJEPn13Ifp4Bi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltP6G4ACgkQAVBC80lX
0GyYXQf+KHuepdh2fKjGtP2B3ts1dGIoiJyMZDukUKpEt59KCiJ5Qazyv0Sif3av
ndHMEzoiZYBK5o37pYYb/uoYRWnf1WGWW/0eDFI/cjidRbY4sJRYR1jy9h+o9wEF
LFjIxrdvSKg2iRHOg7bQNUiDSNklickI1mPbZ7uAczwVod9V806zTxD1G4G9mB1f
0EyM/Qu0Y66P1k0xUrWAay2ur4gzAfmUhw2VxoErk20YpF5Ad7ZajGtG2RAf/vRy
DEI/q9iZHQGfZxLbafRZIamcvFLdwA2ivY83bZOyq3Szul8MrIEzk8VQwxiUi2lC
OrxRPXuEmh5xuCDNu1d6MivTM/ccIw==
=YhjJ
-----END PGP SIGNATURE-----

--Sig_/CXRQpIDxX.rJEPn13Ifp4Bi--
