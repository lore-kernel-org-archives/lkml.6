Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F812C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B082073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B082073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeIEM3O convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:29:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36924 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbeIEM3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:29:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A9850208B5; Wed,  5 Sep 2018 10:00:14 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 38512207AB;
        Wed,  5 Sep 2018 10:00:04 +0200 (CEST)
Date:   Wed, 5 Sep 2018 10:00:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Adrian Bunk <bunk@debian.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-mtd@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: onenand: fix parameter list build warning
Message-ID: <20180905100002.1c47f52f@xps13>
In-Reply-To: <561f2078-92e8-290f-626c-ff936b7285c1@infradead.org>
References: <03e45afe-c4f8-e69b-9cba-6a8863296ad4@infradead.org>
        <20180904233449.32e41787@xps13>
        <561f2078-92e8-290f-626c-ff936b7285c1@infradead.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Randy Dunlap <rdunlap@infradead.org> wrote on Tue, 4 Sep 2018 14:49:00
-0700:

> On 09/04/2018 02:34 PM, Miquel Raynal wrote:
> > Hi Randy,
> > 
> > Randy Dunlap <rdunlap@infradead.org> wrote on Mon, 3 Sep 2018 12:32:04
> > -0700:
> >   
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> Fix build warning in <linux/mtd/onenand.h> by adding a "stub" struct
> >> for mtd_oob_ops:
> >>
> >> include/linux/mtd/onenand.h: warning: 'struct mtd_oob_ops' declared inside parameter list [enabled by default]
> >> include/linux/mtd/onenand.h: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
> >>
> >> Fixes: 607d1cb10426 ("[MTD] [OneNAND] proper onenand_bbt_read_oob() prototype")
> >>
> >> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> >> Cc: linux-mtd@lists.infradead.org
> >> Cc: David Woodhouse <dwmw2@infradead.org>
> >> Cc: Brian Norris <computersforpeace@gmail.com>
> >> Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> >> Cc: Marek Vasut <marek.vasut@gmail.com>
> >> Cc: Richard Weinberger <richard@nod.at>
> >> Cc: Adrian Bunk <bunk@kernel.org>
> >> Cc: Adrian Bunk <bunk@debian.org>
> >> ---
> >>  include/linux/mtd/onenand.h |    1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> --- lnx-419-rc2.orig/include/linux/mtd/onenand.h
> >> +++ lnx-419-rc2/include/linux/mtd/onenand.h
> >> @@ -221,6 +221,7 @@ struct onenand_manufacturers {
> >>          char *name;
> >>  };
> >>  
> >> +struct mtd_oob_ops;
> >>  int onenand_bbt_read_oob(struct mtd_info *mtd, loff_t from,
> >>  			 struct mtd_oob_ops *ops);
> >>  unsigned onenand_block(struct onenand_chip *this, loff_t addr);  
> > 
> > That's indeed a working solution, but there are a lot of other
> > structures in this file that come (like mtd_oob_ops) from
> > linux/mtd/mtd.h so I wonder if it would not make more sense to include
> > this header here?
> > 
> > Thanks,
> > Miquèl  
> 
> 
> Hi,
> Have you see this from Linus?
> 
> https://lore.kernel.org/lkml/CA+55aFzMBptQt-QHMR0MM9MA3=1rxcf8ca5qHxrf4Mm0ZobE_A@mail.gmail.com/

I did not know this position, thanks for sharing.

However, I don't think we fall under the same situation here.

On a purely theoretical point of view, onenand is a type of MTD device,
and almost all the core structures it uses are from linux/mtd/mtd.h so
for me it seems an error not to include it.

After looking more closely at the code, the following files include
onenand.h:

$ ~/linux [master]$ git grep -l onenand.h
arch/arm/mach-mmp/ttc_dkb.c
arch/arm/mach-pxa/saar.c
arch/arm/mach-pxa/vpac270.c
arch/arm/plat-samsung/devs.c
arch/sh/boards/mach-kfr2r09/setup.c
drivers/mtd/nand/onenand/generic.c
drivers/mtd/nand/onenand/omap2.c
drivers/mtd/nand/onenand/onenand_base.c
drivers/mtd/nand/onenand/onenand_bbt.c
drivers/mtd/nand/onenand/samsung.c
include/linux/mtd/onenand.h

And the following files also already include mtd.h (before including onenand.h):

$ ~/linux [master]$ git grep -l onenand.h|xargs grep mtd.h
arch/arm/mach-mmp/ttc_dkb.c:#include <linux/mtd/mtd.h>
arch/arm/mach-pxa/saar.c:#include <linux/mtd/mtd.h>
arch/arm/mach-pxa/vpac270.c:#include <linux/mtd/mtd.h>
arch/arm/plat-samsung/devs.c:#include <linux/mtd/mtd.h>
drivers/mtd/nand/onenand/generic.c:#include <linux/mtd/mtd.h>
drivers/mtd/nand/onenand/omap2.c:#include <linux/mtd/mtd.h>
drivers/mtd/nand/onenand/onenand_base.c:#include <linux/mtd/mtd.h>
drivers/mtd/nand/onenand/onenand_bbt.c:#include <linux/mtd/mtd.h>
drivers/mtd/nand/onenand/samsung.c:#include <linux/mtd/mtd.h>

The only file not already including directly mtd.h is:
arch/sh/boards/mach-kfr2r09/setup.c

So I suppose your issue comes from this file?

However, mtd.h is included by physmap.h, itself included by
mach-kfr2r09/setup.c after onenand.h; so all this files would be
recompiled anyway when touching mtd.h.

From what I have seen, mach-kfr2r09/setup.c has no reason to include
onenand.h, so I would rather prefer to remove the inclusion.

Thanks,
Miquèl
