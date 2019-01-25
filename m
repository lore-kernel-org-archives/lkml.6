Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC1BC282C7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE16C218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfAYMhl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:37:41 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49293 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfAYMhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:37:40 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 55474209BE; Fri, 25 Jan 2019 13:37:38 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 13225207AD;
        Fri, 25 Jan 2019 13:37:28 +0100 (CET)
Date:   Fri, 25 Jan 2019 13:37:28 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v2] mtd: rawnand: remove ->legacy.erase and
 single_erase()
Message-ID: <20190125133728.07ad39a7@xps13>
In-Reply-To: <1548052327-26483-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548052327-26483-1-git-send-email-yamada.masahiro@socionext.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Mon, 21 Jan
2019 15:32:07 +0900:

> Now that the last user of this hook, denali.c, stopped using it,
> we can remove the erase hook from nand_legacy.
> 
> I squashed single_erase() because only the difference between
> single_erase() and nand_erase_op() is the number of bit shifts.
> 
> The status/ret conversion in nand_erase_nand() is unneeded since
> commit eb94555e9e97 ("mtd: nand: use usual return values for the
> ->erase() hook"). Cleaned it up now.  
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to nand/next.

Thanks,
Miquèl
