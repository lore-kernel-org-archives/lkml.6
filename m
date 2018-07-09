Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBD6C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C2C208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C2C208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754334AbeGIGvm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:51:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41974 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751150AbeGIGvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:51:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 67C0020876; Mon,  9 Jul 2018 08:51:39 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3A7E9203EC;
        Mon,  9 Jul 2018 08:51:39 +0200 (CEST)
Date:   Mon, 9 Jul 2018 08:51:38 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the nand tree
Message-ID: <20180709085138.4b28e898@xps13>
In-Reply-To: <20180709081632.0ed241d6@bbrezillon>
References: <20180709115115.354d625f@canb.auug.org.au>
        <20180709081632.0ed241d6@bbrezillon>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Boris,

Boris Brezillon <boris.brezillon@bootlin.com> wrote on Mon, 9 Jul 2018
08:16:32 +0200:

> Hi Stephen,
> 
> On Mon, 9 Jul 2018 11:51:15 +1000
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi Boris,
> > 
> > After merging the nand tree, today's linux-next build (x86_64
> > allmodconfig) produced this warning:
> > 
> > drivers/mtd/nand/raw/davinci_nand.c: In function 'nand_davinci_hwcontrol':
> > drivers/mtd/nand/raw/davinci_nand.c:115:21: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >    nand->IO_ADDR_W = (void __iomem __force *)addr;
> >                      ^
> > drivers/mtd/nand/raw/davinci_nand.c: In function 'nand_davinci_select_chip':
> > drivers/mtd/nand/raw/davinci_nand.c:132:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >   info->chip.IO_ADDR_W = (void __iomem __force *)addr;
> >                          ^
> > In file included from arch/x86/include/asm/bug.h:83:0,
> >                  from include/linux/bug.h:5,
> >                  from include/linux/thread_info.h:12,
> >                  from arch/x86/include/asm/preempt.h:7,
> >                  from include/linux/preempt.h:81,
> >                  from include/linux/spinlock.h:51,
> >                  from include/linux/seqlock.h:36,
> >                  from include/linux/time.h:6,
> >                  from include/linux/stat.h:19,
> >                  from include/linux/module.h:10,
> >                  from drivers/mtd/nand/raw/davinci_nand.c:27:
> > drivers/mtd/nand/raw/davinci_nand.c: In function 'nand_davinci_correct_4bit':
> > drivers/mtd/nand/raw/davinci_nand.c:322:21: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> >   if (WARN_ON(0x01 & (unsigned) ecc_code))
> >                      ^
> > include/asm-generic/bug.h:112:25: note: in definition of macro 'WARN_ON'
> >   int __ret_warn_on = !!(condition);    \
> >                          ^~~~~~~~~
> > drivers/mtd/nand/raw/davinci_nand.c: In function 'nand_davinci_read_buf':
> > drivers/mtd/nand/raw/davinci_nand.c:444:15: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> >   if ((0x03 & ((unsigned)buf)) == 0 && (0x03 & len) == 0)
> >                ^
> > drivers/mtd/nand/raw/davinci_nand.c:446:20: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> >   else if ((0x01 & ((unsigned)buf)) == 0 && (0x01 & len) == 0)
> >                     ^
> > drivers/mtd/nand/raw/davinci_nand.c: In function 'nand_davinci_write_buf':
> > drivers/mtd/nand/raw/davinci_nand.c:457:15: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> >   if ((0x03 & ((unsigned)buf)) == 0 && (0x03 & len) == 0)
> >                ^
> > drivers/mtd/nand/raw/davinci_nand.c:459:20: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> >   else if ((0x01 & ((unsigned)buf)) == 0 && (0x01 & len) == 0)
> >                     ^
> > drivers/mtd/nand/raw/davinci_nand.c: In function 'nand_davinci_probe':
> > drivers/mtd/nand/raw/davinci_nand.c:683:18: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> >   info->ioaddr  = (uint32_t __force) vaddr;
> >                   ^
> > drivers/mtd/nand/raw/atmel/nand-controller.c: In function 'atmel_smc_nand_controller_init':
> > drivers/mtd/nand/raw/atmel/nand-controller.c:2053:21: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> >   nc->ebi_csa_offs = (unsigned int)match->data;
> >                      ^
> > drivers/mtd/nand/raw/sunxi_nand.c: In function 'sunxi_nfc_hw_ecc_read_chunks_dma':
> > drivers/mtd/nand/raw/sunxi_nand.c:130:22: warning: large integer implicitly truncated to unsigned type [-Woverflow]
> >  #define NFC_PAGE_OP  (2 << 30)
> >                       ^
> > drivers/mtd/nand/raw/sunxi_nand.c:1040:9: note: in expansion of macro 'NFC_PAGE_OP'
> >   writel(NFC_PAGE_OP | NFC_DATA_SWAP_METHOD | NFC_DATA_TRANS,
> >          ^~~~~~~~~~~
> > drivers/mtd/nand/raw/sunxi_nand.c: In function 'sunxi_nfc_hw_ecc_write_page_dma':
> > drivers/mtd/nand/raw/sunxi_nand.c:130:22: warning: large integer implicitly truncated to unsigned type [-Woverflow]
> >  #define NFC_PAGE_OP  (2 << 30)
> >                       ^
> > drivers/mtd/nand/raw/sunxi_nand.c:1406:9: note: in expansion of macro 'NFC_PAGE_OP'
> >   writel(NFC_PAGE_OP | NFC_DATA_SWAP_METHOD |
> >          ^~~~~~~~~~~
> > 
> > Presumably exposed by commits
> > 
> >   347af8918e8a ("mtd: rawnand: davinci: Allow selection of this driver when COMPILE_TEST=y")
> >   b3d926a3d6e0 ("mtd: rawnand: sunxi: Allow selection of this driver when COMPILE_TEST=y")
> >   
> 
> Stephen, thanks for this report.
> 
> Miquel, can you drop those 2 commits from the nand tree? I'll resubmit a
> series fixing that.

Both commits dropped from nand/next. The branch is clean, it should
build correctly now.

Thanks,
Miquèl

> 
> Thanks,
> 
> Boris



-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
