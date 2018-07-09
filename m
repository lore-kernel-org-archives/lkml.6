Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD173C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 01:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3725C208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 01:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Tqt3FWof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3725C208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933559AbeGIBvV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 21:51:21 -0400
Received: from ozlabs.org ([203.11.71.1]:43377 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933504AbeGIBvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 21:51:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41P7bT7493z9s19;
        Mon,  9 Jul 2018 11:51:15 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531101078;
        bh=wtHKLlO6SIw2YRbi1VIvsaYBFcvmcbFqNnRYUgKk8bE=;
        h=Date:From:To:Cc:Subject:From;
        b=Tqt3FWof9HEm8X8kaTpUpiC3csT2O2ZdbGkrZRL5KXzYHdwS3Vm8XUjyr69qLNmo3
         7FShx+InKVDANpTG2vzkJ3bG2UnAVZRCX84Rt9C4kTK8IHsyvJhFN0SUzHHozAc3p2
         BY//ZVNHEgwe8JwO3um+ymIjxYJGvpGeYL15J2XlicYlBR3ZGD6aHYiYOsMO6Jlxhg
         pGRuZnEnTdP0ltm4Q6fkZw4FJohqga0XrDSEAd4lNn66hfZ2ZLE0TubPVJ5OezQ29d
         /YEMPmNvgXBTe6XhQU8g3BZ110ZVkZ4UulpngX1YYwXO9JuQlHFDIyB51QgiIp8+Wm
         owxy4nXyjm5Sg==
Date:   Mon, 9 Jul 2018 11:51:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: linux-next: build warning after merge of the nand tree
Message-ID: <20180709115115.354d625f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/i_a.lkinMZ57zMQzJgIFBZR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i_a.lkinMZ57zMQzJgIFBZR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Boris,

After merging the nand tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/mtd/nand/raw/davinci_nand.c: In function 'nand_davinci_hwcontrol':
drivers/mtd/nand/raw/davinci_nand.c:115:21: warning: cast to pointer from i=
nteger of different size [-Wint-to-pointer-cast]
   nand->IO_ADDR_W =3D (void __iomem __force *)addr;
                     ^
drivers/mtd/nand/raw/davinci_nand.c: In function 'nand_davinci_select_chip':
drivers/mtd/nand/raw/davinci_nand.c:132:25: warning: cast to pointer from i=
nteger of different size [-Wint-to-pointer-cast]
  info->chip.IO_ADDR_W =3D (void __iomem __force *)addr;
                         ^
In file included from arch/x86/include/asm/bug.h:83:0,
                 from include/linux/bug.h:5,
                 from include/linux/thread_info.h:12,
                 from arch/x86/include/asm/preempt.h:7,
                 from include/linux/preempt.h:81,
                 from include/linux/spinlock.h:51,
                 from include/linux/seqlock.h:36,
                 from include/linux/time.h:6,
                 from include/linux/stat.h:19,
                 from include/linux/module.h:10,
                 from drivers/mtd/nand/raw/davinci_nand.c:27:
drivers/mtd/nand/raw/davinci_nand.c: In function 'nand_davinci_correct_4bit=
':
drivers/mtd/nand/raw/davinci_nand.c:322:21: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
  if (WARN_ON(0x01 & (unsigned) ecc_code))
                     ^
include/asm-generic/bug.h:112:25: note: in definition of macro 'WARN_ON'
  int __ret_warn_on =3D !!(condition);    \
                         ^~~~~~~~~
drivers/mtd/nand/raw/davinci_nand.c: In function 'nand_davinci_read_buf':
drivers/mtd/nand/raw/davinci_nand.c:444:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
  if ((0x03 & ((unsigned)buf)) =3D=3D 0 && (0x03 & len) =3D=3D 0)
               ^
drivers/mtd/nand/raw/davinci_nand.c:446:20: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
  else if ((0x01 & ((unsigned)buf)) =3D=3D 0 && (0x01 & len) =3D=3D 0)
                    ^
drivers/mtd/nand/raw/davinci_nand.c: In function 'nand_davinci_write_buf':
drivers/mtd/nand/raw/davinci_nand.c:457:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
  if ((0x03 & ((unsigned)buf)) =3D=3D 0 && (0x03 & len) =3D=3D 0)
               ^
drivers/mtd/nand/raw/davinci_nand.c:459:20: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
  else if ((0x01 & ((unsigned)buf)) =3D=3D 0 && (0x01 & len) =3D=3D 0)
                    ^
drivers/mtd/nand/raw/davinci_nand.c: In function 'nand_davinci_probe':
drivers/mtd/nand/raw/davinci_nand.c:683:18: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
  info->ioaddr  =3D (uint32_t __force) vaddr;
                  ^
drivers/mtd/nand/raw/atmel/nand-controller.c: In function 'atmel_smc_nand_c=
ontroller_init':
drivers/mtd/nand/raw/atmel/nand-controller.c:2053:21: warning: cast from po=
inter to integer of different size [-Wpointer-to-int-cast]
  nc->ebi_csa_offs =3D (unsigned int)match->data;
                     ^
drivers/mtd/nand/raw/sunxi_nand.c: In function 'sunxi_nfc_hw_ecc_read_chunk=
s_dma':
drivers/mtd/nand/raw/sunxi_nand.c:130:22: warning: large integer implicitly=
 truncated to unsigned type [-Woverflow]
 #define NFC_PAGE_OP  (2 << 30)
                      ^
drivers/mtd/nand/raw/sunxi_nand.c:1040:9: note: in expansion of macro 'NFC_=
PAGE_OP'
  writel(NFC_PAGE_OP | NFC_DATA_SWAP_METHOD | NFC_DATA_TRANS,
         ^~~~~~~~~~~
drivers/mtd/nand/raw/sunxi_nand.c: In function 'sunxi_nfc_hw_ecc_write_page=
_dma':
drivers/mtd/nand/raw/sunxi_nand.c:130:22: warning: large integer implicitly=
 truncated to unsigned type [-Woverflow]
 #define NFC_PAGE_OP  (2 << 30)
                      ^
drivers/mtd/nand/raw/sunxi_nand.c:1406:9: note: in expansion of macro 'NFC_=
PAGE_OP'
  writel(NFC_PAGE_OP | NFC_DATA_SWAP_METHOD |
         ^~~~~~~~~~~

Presumably exposed by commits

  347af8918e8a ("mtd: rawnand: davinci: Allow selection of this driver when=
 COMPILE_TEST=3Dy")
  b3d926a3d6e0 ("mtd: rawnand: sunxi: Allow selection of this driver when C=
OMPILE_TEST=3Dy")

--=20
Cheers,
Stephen Rothwell

--Sig_/i_a.lkinMZ57zMQzJgIFBZR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltCv5MACgkQAVBC80lX
0GyO/gf+NT2k46jcLeQD7Gq6Lnim2lRhq4I3PTHceLvqQ0k9lccX7Ptj2GKxsrim
Tru91HOwjfGcUkWV4hfv5BTKr/CZzhti1Zg2yAh6FGxo+g4yiX9ac5kiLcWdenGl
+0vPW0rpKalOnQCARPbG1qnZgCe6NBaazkM7Ycx919Yf8B325NtyNdjSPvnI9R5L
kKac0UFFXGFvsRlEeM7BfOsgrgTxqzuZXbi9e8L2OulxWgiNDmfa95CPx9Z1r5pj
RbFhf801PCBHdpl6myAjytngBZWnChTbdLD0UDVKmRxdOLXgKXISTs3PEw8jvdRz
/kWqFOhd/2XNmu+km+MsjMccnBxIJg==
=wuB2
-----END PGP SIGNATURE-----

--Sig_/i_a.lkinMZ57zMQzJgIFBZR--
