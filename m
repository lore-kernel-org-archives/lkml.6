Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C7CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5615720895
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fAENfoe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5615720895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeIZIiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:38:09 -0400
Received: from ozlabs.org ([203.11.71.1]:58169 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbeIZIiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:38:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Khfq45Mpz9s2P;
        Wed, 26 Sep 2018 12:27:31 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537928852;
        bh=345T9O2SGl14zPm68a18iFJlxGN16YoU3/j14FGbp1g=;
        h=Date:From:To:Cc:Subject:From;
        b=fAENfoe63t3x6nCUizLZHmqw9ZomChOpkf9PS0vSDxAPO7T0ewQlTxpFSz4+nSHkj
         0LyDZrT71urzOA7z6uixyCzFE2O43g5Us2+ERx1Knlmnz31ycKV1cPLyA08JDmP8tj
         /yZJvW5mCgRfKkcMBJX1APhVqOeIL2qDxOUDked7BXE59+vlI2ieQgvwkJzoyOLOQk
         Vq49FDc1KSTbGuSzoTxrNxGHPbkXIKw0dxfJXI16uzsS76ckklnkhf4wRJJk+1wR0p
         6WJR431slLangNhni2hYIxoewIw44Nd25w/rZ/MZlK1hY1v+Z8tEZ8OgWFHuTJ7DCi
         4+9F2Nuarwc7Q==
Date:   Wed, 26 Sep 2018 12:27:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Al Viro <aviro@redhat.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: linux-next: manual merge of the vfio tree with the vfs tree
Message-ID: <20180926122621.6645ba87@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/j/ywt3.ERSA/8xN+VGNKMNg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j/ywt3.ERSA/8xN+VGNKMNg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Today's linux-next merge of the vfio tree got a conflict in:

  drivers/vfio/Kconfig

between commit:

  f57d445eb317 ("Make anon_inodes unconditional")

from the vfs tree and commit:

  cf3f98c7f466 ("drivers/vfio: Allow type-1 IOMMU instantiation with all AR=
M/ARM64 IOMMUs")

from the vfio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/vfio/Kconfig
index 9aa91e736023,9de5ed38da83..000000000000
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@@ -21,7 -21,8 +21,7 @@@ config VFIO_VIRQF
  menuconfig VFIO
  	tristate "VFIO Non-Privileged userspace driver framework"
  	depends on IOMMU_API
- 	select VFIO_IOMMU_TYPE1 if (X86 || S390 || ARM_SMMU || ARM_SMMU_V3)
+ 	select VFIO_IOMMU_TYPE1 if (X86 || S390 || ARM || ARM64)
 -	select ANON_INODES
  	help
  	  VFIO provides a framework for secure userspace device drivers.
  	  See Documentation/vfio.txt for more details.

--Sig_/j/ywt3.ERSA/8xN+VGNKMNg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluq7pMACgkQAVBC80lX
0GzHVQf9FCA7dM8faXLz7zOdEbwIawWqow2S5Lfc1GvGM3WBTxn5x/yVzOiyxN0m
azp02wt4w5K6FjXHlZwCxtipuiuo6QVFMcWi7RmQtSY7nKpfmipOxMKi0HP78aIj
7HI3Q9C40sL7Dn7wVgyf/uOTOwvWgodwcAsQKSUzJEappw6JzyRQ4F6sI1xtL3Rb
+XUwvXEFJanRvEhDdcGTCG0hHjtxagfZaC0K6VgkLxQDD/9pcKr2g9+i6WFtfJE8
SffO4ffc05LEN5ME9vIyyWT/vNe9KRceGW9/dyZAVey7LEKYjeNz8F5k/Ra2k37O
Nm71wgSymIV4CL/Mbzyr43k4i2tPBw==
=l2wW
-----END PGP SIGNATURE-----

--Sig_/j/ywt3.ERSA/8xN+VGNKMNg--
