Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B036FECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C84120861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C84120861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeINToP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:44:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44393 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeINToP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:44:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F3535206FF; Fri, 14 Sep 2018 16:29:27 +0200 (CEST)
Received: from xps13 (unknown [37.170.158.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 235C520379;
        Fri, 14 Sep 2018 16:29:27 +0200 (CEST)
Date:   Fri, 14 Sep 2018 16:29:23 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: rawnand: denali: fix a race condition when DMA is
 kicked
Message-ID: <20180914162923.05c44fcc@xps13>
In-Reply-To: <1536818329-11068-1-git-send-email-yamada.masahiro@socionext.com>
References: <1536818329-11068-1-git-send-email-yamada.masahiro@socionext.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Thu, 13 Sep
2018 14:58:49 +0900:

> I thought the read-back of the DMA_ENABLE register was unnecessary
> (at least it is working on my boards), then deleted it in commit
> 586a2c52909d ("mtd: nand: denali: squash denali_enable_dma() helper
> into caller").  Sorry, I was wrong - it caused a timing issue on
> Cyclone5 SoCFPGAs.
> 
> Revive the register read-back, commenting why this is necessary.
> 
> Fixes: 586a2c52909d ("mtd: nand: denali: squash denali_enable_dma() helper into caller")
> Reported-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
