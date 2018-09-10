Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C78C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 04:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0181A20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 04:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZYlez+Ns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0181A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeIJI6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:58:20 -0400
Received: from ozlabs.org ([203.11.71.1]:35751 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeIJI6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:58:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 427vc95vW9z9sBs;
        Mon, 10 Sep 2018 14:06:17 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536552378;
        bh=bs6/jl4+5WTX3y4bN/CDimYZE3YzD3LcyDXQwyp3EkE=;
        h=Date:From:To:Cc:Subject:From;
        b=ZYlez+NsTD/bWbIa6cZOCSrlCJAln/gHe8KV7xzd4GRSTd+m+wHs1+0gQmMArVheW
         UIxL8NEySltdVMxmo0GkLVZjDQyt9vXMb/AGxJE1EKCWWM/Yx2eOWqRHznpUV+2Ehx
         l7wzT9MKcPWl5dobaaS8ja8U5G4zELSbO5kX5HmPZRiFq7oKybU2TzOXRSXjjoLUhj
         NfTLryp5lUTvPOZyPb44fArBgucOsDI8niAJMRB0sIA3nrTHZ3CFIUz+gJgyxnsEFB
         R4cNNgZSti5jZl3kKyCQZu7aWCSwy4t3ANFh67eCFim2zj5TN2PurGeEX9YYye1DLi
         +gBIrwOb6VYAQ==
Date:   Mon, 10 Sep 2018 14:06:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the akpm-current tree with the
 dma-mapping tree
Message-ID: <20180910140617.5bf45eb5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qjT27Ffv+XKr0c2p/jocOfQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qjT27Ffv+XKr0c2p/jocOfQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/hexagon/Kconfig

between commit:

  e0a9317d9004 ("hexagon: use generic dma_noncoherent_ops")

from the dma-mapping tree and commit:

  365c1f4922a4 ("hexagon: switch to NO_BOOTMEM")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/hexagon/Kconfig
index 6cee842a9b44,f7934998913a..000000000000
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@@ -30,7 -29,9 +30,10 @@@ config HEXAGO
  	select GENERIC_CLOCKEVENTS_BROADCAST
  	select MODULES_USE_ELF_RELA
  	select GENERIC_CPU_DEVICES
 +	select DMA_NONCOHERENT_OPS
+ 	select HAVE_MEMBLOCK
+ 	select ARCH_DISCARD_MEMBLOCK
+ 	select NO_BOOTMEM
  	---help---
  	  Qualcomm Hexagon is a processor architecture designed for high
  	  performance and low power across a wide variety of applications.

--Sig_/qjT27Ffv+XKr0c2p/jocOfQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluV7bkACgkQAVBC80lX
0GxBGAf9H2hBvda9VDsbzlZmsPxQKhQchweVcxp/bUmOjzBX409ijF8OaW6UD1GZ
1C/pfh88O26qwdXMKl0xNx0vbXRMDVGY4eUY3XV/erHifas5k5jvtNCinUZzHcgB
CHofD+i3Hs43gjAfh033rfzrZQC9zd8ApOE6cDVYqKlf9PWGl2NyIdirJSUSMhFG
ZgKlLl1GBzsv3/1fT1Fy+yfkt1D4mrmPt4p6clpm8DaiKfSlW0uCmZ51/61YsPgk
MbEfs5HEw9tVkCr4EbKcFlpgZ3hGP1G0sLrRMixwjdq6MIVb/LOLZINWsp++Xa6K
FOOpxjzQ9TywMGVQO/WjCYoqKNIu6Q==
=IH7B
-----END PGP SIGNATURE-----

--Sig_/qjT27Ffv+XKr0c2p/jocOfQ--
