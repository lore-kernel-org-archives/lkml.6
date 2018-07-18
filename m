Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8CBECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216202075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216202075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbeGRIYp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:24:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39338 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbeGRIYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:24:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EFD8D20798; Wed, 18 Jul 2018 09:48:08 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id A6DD72074F;
        Wed, 18 Jul 2018 09:47:58 +0200 (CEST)
Date:   Wed, 18 Jul 2018 09:47:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nand: ranw: qcom_nand: stop using phys_to_dma()
Message-ID: <20180718094758.785ea21f@xps13>
In-Reply-To: <20180717223359.43dc5dfb@bbrezillon>
References: <20180717202759.2288076-1-arnd@arndb.de>
        <20180717223359.43dc5dfb@bbrezillon>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Boris Brezillon <boris.brezillon@bootlin.com> wrote on Tue, 17 Jul 2018
22:33:59 +0200:

> On Tue, 17 Jul 2018 22:27:42 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > Compile-testing this driver on x86 caused a link error:
> > 
> > ERROR: "__phys_to_dma" [drivers/mtd/nand/raw/qcom_nandc.ko] undefined!
> > 
> > The problem here is that the driver attempts to convert the physical
> > address into the DMA controller as a dma_addr_t and calls phys_to_dma()
> > to do the conversion.
> > 
> > The correct way to do the conversion is using the dma mapping interfaces.
> > 
> > Fixes: c76b78d8ec05 ("mtd: nand: Qualcomm NAND controller driver")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>  
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> 
> Miquel, can you fix the subject prefix when applying?

Applied to nand/next with the subject prefix being:
"mtd: rawnand: qcom:"

Thanks
Miquèl
