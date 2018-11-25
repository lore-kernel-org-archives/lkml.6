Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F69C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F97F2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q8RfHDzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F97F2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeKZKJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 05:09:39 -0500
Received: from ozlabs.org ([203.11.71.1]:58745 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbeKZKJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 05:09:39 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4335YD0N1Gz9s0t;
        Mon, 26 Nov 2018 10:17:19 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543187841;
        bh=j8Zmj/bbdZZKJi/e8CN2KdagEVJ2vRYvfe2FjYnr7+M=;
        h=Date:From:To:Cc:Subject:From;
        b=Q8RfHDztw/Y1XXuF/GzXHzYUQwa/KG4Np/va4Fpy0ip3OmA+OciRBAdA9ToKVgc7u
         ycsMpDh7YIslAWCHD663KWmIZ6HxaPlLRRKUsSPsovMbb9ZUPNHMK3FX0L8fR63Af0
         VaS/1xA4Qxt+hQz4/IXpqWgRrgflc18eMSyP2xcWHdWX3Eg0XbK9cKTlVEvtRySY5c
         vmzqnNcRlFAdA5+BAMJYLxihnPyI7VuH/5nEZzihdKQPiNXO+KEf7/tkffVSe4MpCx
         5BL1A8t8oirITL/2XSb1daxy1RmucLK4eloaqEbnEx1WZyYp//TAk2BAVBbNjAfc0a
         AjtMRYps92rRw==
Date:   Mon, 26 Nov 2018 10:17:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Maksym Kokhan <maksym.kokhan@globallogic.com>,
        Paul Burton <paul.burton@mips.com>,
        Andrii Bordunov <andrew.bordunov@gmail.com>
Subject: linux-next: manual merge of the mips tree with the kbuild tree
Message-ID: <20181126101712.18480f3c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/haoNfPR7z4iR+0uQ+I69930"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/haoNfPR7z4iR+0uQ+I69930
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mips tree got a conflict in:

  arch/mips/Kconfig

between commit:

  eb01d42a7778 ("PCI: consolidate PCI config entry in drivers/pci")

from the kbuild tree and commit:

  47bf2b031754 ("mips: sort list of configs for Malta")

from the mips tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/mips/Kconfig
index f4df8007fddb,e49b5a0c8585..000000000000
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@@ -495,22 -498,23 +499,23 @@@ config MIPS_MALT
  	select BOOT_RAW
  	select BUILTIN_DTB
  	select CEVT_R4K
- 	select CSRC_R4K
  	select CLKSRC_MIPS_GIC
  	select COMMON_CLK
+ 	select CSRC_R4K
  	select DMA_MAYBE_COHERENT
  	select GENERIC_ISA_DMA
- 	select HAVE_PCSPKR_PLATFORM
- 	select IRQ_MIPS_CPU
- 	select MIPS_GIC
 +	select HAVE_PCI
+ 	select HAVE_PCSPKR_PLATFORM
 -	select HW_HAS_PCI
  	select I8253
  	select I8259
+ 	select IRQ_MIPS_CPU
+ 	select LIBFDT
  	select MIPS_BONITO64
  	select MIPS_CPU_SCACHE
+ 	select MIPS_GIC
  	select MIPS_L1_CACHE_SHIFT_6
- 	select PCI_GT64XXX_PCI0
  	select MIPS_MSC
+ 	select PCI_GT64XXX_PCI0
  	select SMP_UP if SMP
  	select SWAP_IO_SPACE
  	select SYS_HAS_CPU_MIPS32_R1

--Sig_/haoNfPR7z4iR+0uQ+I69930
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv7LXgACgkQAVBC80lX
0Gx9qAf/VdPY8ZIFm2DSMjT8ZIuZH2fvsoLAj2FNtLrzeifRSbsmyWXkb+XPgDHG
TmxynpaExAtR2cFIz4WkDUD/cSJVZndqatDkDUMpcfefVPitmPi+g8g8K+14W/2t
WWVTjjnAnut1p7JcoEQl9L2ruLClN4XiNz2Wohla4smUD6xB+JnTsSlOwHDOTfbd
Gkut5b7TGjl6R10ynXqqt9q9eOJ03KlWf69e6S+FveH/DDryrJvBLY+xcj0kK9X+
O1J0bwM/mwAgtYuGxw9RNyS9ixhuF5nma01g/u9ph+DlUC8xSlWY+aTjEJAG67pB
jypymu2v6YqyS6B1+s0JX7whW1iWbA==
=84d5
-----END PGP SIGNATURE-----

--Sig_/haoNfPR7z4iR+0uQ+I69930--
