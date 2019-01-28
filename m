Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51786C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2153820449
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfA1JNt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:13:49 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:57947 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfA1JNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:13:49 -0500
X-Originating-IP: 90.88.29.206
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 754C740007;
        Mon, 28 Jan 2019 09:13:45 +0000 (UTC)
Date:   Mon, 28 Jan 2019 10:13:44 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mtd: rawnand: mark expected switch fall-throughs
Message-ID: <20190128101344.1cc03eed@xps13>
In-Reply-To: <20190126175429.65e6bfd8@bbrezillon>
References: <20190125210950.GA27855@embeddedor>
        <20190126105208.221a2051@bbrezillon>
        <853a267c-807b-c613-6662-93730a0b4c33@embeddedor.com>
        <20190126175429.65e6bfd8@bbrezillon>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Boris Brezillon <bbrezillon@kernel.org> wrote on Sat, 26 Jan 2019
17:54:29 +0100:

> On Sat, 26 Jan 2019 07:48:50 -0600
> "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> 
> > Hey Boris,
> > 
> > On 1/26/19 3:52 AM, Boris Brezillon wrote:  
> > > On Fri, 25 Jan 2019 15:09:50 -0600
> > > "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> > >     
> > >> diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
> > >> index 933d1a629c51..d33e15dc4cdc 100644
> > >> --- a/drivers/mtd/nand/raw/nandsim.c
> > >> +++ b/drivers/mtd/nand/raw/nandsim.c
> > >> @@ -2251,9 +2251,10 @@ static int __init ns_init_module(void)
> > >>  
> > >>  	switch (bbt) {
> > >>  	case 2:
> > >> -		 chip->bbt_options |= NAND_BBT_NO_OOB;
> > >> +		chip->bbt_options |= NAND_BBT_NO_OOB;
> > >> +		/* fall through */
> > >>  	case 1:
> > >> -		 chip->bbt_options |= NAND_BBT_USE_FLASH;
> > >> +		chip->bbt_options |= NAND_BBT_USE_FLASH;    
> > > 
> > > You miss a '/* fall through */' here.
> > >     
> > 
> > Not really.  Notice that in this case the code falls through
> > to a break statement.  
> 
> Still find it weird to mandate fall through comments in all cases but
> this one...

Yes please, even if there is no GCC warning I think you can add one
here.


Thanks,
Miquèl
