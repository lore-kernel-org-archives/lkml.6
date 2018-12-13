Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EAAC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27906208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BLQRB51G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27906208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeLMVE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:04:58 -0500
Received: from ozlabs.org ([203.11.71.1]:38045 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbeLMVE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:04:57 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43G5m72wYyz9s4s;
        Fri, 14 Dec 2018 08:04:55 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544735095;
        bh=1qJ2iZRPjDKWLbFS5yNMdcDzHRkfyxRK/aN5PTODbMo=;
        h=Date:From:To:Cc:Subject:From;
        b=BLQRB51GOvd9eBUd316TzXJXDdlCdBQKOcWq1RUKZT0CnQo9jUTMPgX9dgMWDE5Vb
         u7raBaNLsug6r8ibZRtz28x5OFHeRU+eoFT0ebj4QhXjGnJwwpSdsdMrLtV8IVHHzF
         knPHa7P+7XEzbacaEtpjy5YqGWWi2fe+hx7J6Erx1F2qlWqLXBKQXvqmBAL5ByVE6r
         cx8xYXCKFJZm+fzxGqjSPBfkx65Ac58UXwIBUIu8OxmBtEngNJWvpMfE+Fb2TggC3f
         FrW9atBYhXzGNo6ryOCKV0iwGWWgPH2vUHqNmAWQU93w0N/E35Qaefz6QQEnh6p9io
         qd4Zypzo9AC0g==
Date:   Fri, 14 Dec 2018 08:04:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the dma-mapping tree with the kbuild
 tree
Message-ID: <20181214080449.58ae1659@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=bp.B2DC8GW/IgtKGCq8q77"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=bp.B2DC8GW/IgtKGCq8q77
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the dma-mapping tree got a conflict in:

  arch/alpha/Kconfig

between commit:

  6630a8e50105 ("eisa: consolidate EISA Kconfig entry in drivers/eisa")

from the kbuild tree and commit:

  3731c3d4774e ("dma-mapping: always build the direct mapping code")

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

diff --cc arch/alpha/Kconfig
index 5e7a44e6110f,5da6ff54b3e7..000000000000
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@@ -5,10 -5,8 +5,11 @@@ config ALPH
  	select ARCH_MIGHT_HAVE_PC_PARPORT
  	select ARCH_MIGHT_HAVE_PC_SERIO
  	select ARCH_NO_PREEMPT
+ 	select ARCH_NO_SG_CHAIN
  	select ARCH_USE_CMPXCHG_LOCKREF
 +	select FORCE_PCI if !ALPHA_JENSEN
 +	select PCI_DOMAINS if PCI
 +	select PCI_SYSCALL if PCI
  	select HAVE_AOUT
  	select HAVE_IDE
  	select HAVE_OPROFILE
@@@ -208,8 -203,6 +209,7 @@@ config ALPHA_EIGE
  config ALPHA_JENSEN
  	bool "Jensen"
  	depends on BROKEN
- 	select DMA_DIRECT_OPS
 +	select HAVE_EISA
  	help
  	  DEC PC 150 AXP (aka Jensen): This is a very old Digital system - one
  	  of the first-generation Alpha systems. A number of these systems

--Sig_/=bp.B2DC8GW/IgtKGCq8q77
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwSyXEACgkQAVBC80lX
0GzprQgAlZR+iqFngtITN4FqOT/Y1uaA3ye+D9+USvi37GPWr6mgZDHJN7k+q4PR
pGPlWn5muyB2EItOC3mfQ7Ncn5tp0Eh8lw2HoU7QMeKmQppi4L6U4OATASshvlFa
us2/qyuefLJotDdwExuV8qKhJDi1g6Fd2GsHtjBuE4Jc6pBk+/1blDamgJSbywev
q1vZ6yNAmup2KtnqJWORrTpeynigMEWCioBL6l2H5MfyXZeiziVTXiYSGfSsvGPD
C0iJ4OsMleETmabdnU+Nm++pHgT+DyjqA5FvkpaO9d3rLO/2KCiibIQBU7cVrgPq
J/GDJTS+IzaraPDEe9nekjMuph1hjw==
=LFyO
-----END PGP SIGNATURE-----

--Sig_/=bp.B2DC8GW/IgtKGCq8q77--
