Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF16C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1263C21473
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IKRGwRC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1263C21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbeHCACN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:02:13 -0400
Received: from ozlabs.org ([203.11.71.1]:46491 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbeHCACN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:02:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41hPTX2NNVz9ryt;
        Fri,  3 Aug 2018 08:09:04 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533247744;
        bh=g7deaThr+xTVMisuzD2G68MLCan1skWhtovH6k9EnnE=;
        h=Date:From:To:Cc:Subject:From;
        b=IKRGwRC0s4O94IPzbbukrz1kSi5a6y3dkUVjmeZ3RIpgQsIU2GafKUmqfavc9IQJi
         VRXL+/FLGfGcQkql7800s74/xOx+EocUyhRHlH/O0Z9c09PGq1hVzMkd2D6UtcZSmw
         vsMMDrMDLc8NTqZeifBKMFSBHUXcwN8XJHtgYrTHJ7OY2GmXRNCYL7hc789XYTAg2u
         H0QdsS960EWDecbJjtNgKbvSY2EZy4n/phd4UNYRej5vCXuXJaRCjITyAAyKXVRKW5
         sgs0O+kgtpJ7NDaaswwEy+fUsHsPqKpBZ2l2GmNT73rWaYU4ra1eC/MHPts0N4ip4R
         3rw/ZRlbK9F4Q==
Date:   Fri, 3 Aug 2018 08:08:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the dma-mapping tree with the kbuild
 tree
Message-ID: <20180803080856.3de8af38@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KdiQulIne4Pn_L2DfqYs/rp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KdiQulIne4Pn_L2DfqYs/rp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the dma-mapping tree got a conflict in:

  arch/nios2/Kconfig

between commit:

  17c46a6aff5c ("kconfig: remove duplicate SWAP symbol defintions")

from the kbuild tree and commit:

  25622e045a6a ("nios2: use generic dma_noncoherent_ops")

from the dma-mapping tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/nios2/Kconfig
index cbe1844b0657,92035042cf62..000000000000
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@@ -1,7 -1,9 +1,10 @@@
  # SPDX-License-Identifier: GPL-2.0
  config NIOS2
  	def_bool y
 +	select ARCH_NO_SWAP
+ 	select ARCH_HAS_SYNC_DMA_FOR_CPU
+ 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+ 	select DMA_NONCOHERENT_OPS
  	select TIMER_OF
  	select GENERIC_ATOMIC64
  	select GENERIC_CLOCKEVENTS

--Sig_/KdiQulIne4Pn_L2DfqYs/rp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltjgPgACgkQAVBC80lX
0Gy8WggAhFquIbZt/hEAiTF0o9HpH7W9ZHaUeY/rvPfHaDWHKXNOK4im992vZdCV
elVV9FpwMJTKB2aUtQ1TpxXHzvBzGlJTaep51C6Rzfs+xmkOpU87gh+y8b8oi9ai
AvPnIBOv39HjEYLxWHDov3zFBvOgmuA/+5KzKPuO+ma7b/FhIM9F2kRpi5T6O6RK
W5PdOdb1MY1YOrnQRCnIRLm3K2LZs/XaiO5rgPPlPVxFybMa7aGXuzvM0/IXjAU9
5iqpnzBGgHT0jQ2MFBiDw5y2XhQp/YnzIl3qkjMMwWjfUYf2oDblk9yZOuQODAs8
Ks2bdzBZzQu5pspZOEbEe3jcwaBYEQ==
=WFwa
-----END PGP SIGNATURE-----

--Sig_/KdiQulIne4Pn_L2DfqYs/rp--
