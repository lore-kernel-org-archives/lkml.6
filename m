Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF30EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8B020882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfA3Jc4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:32:56 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:47325 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbfA3Jcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:32:55 -0500
X-Originating-IP: 90.88.147.226
Received: from xps13 (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A026C40007;
        Wed, 30 Jan 2019 09:32:51 +0000 (UTC)
Date:   Wed, 30 Jan 2019 10:32:50 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Colin King <colin.king@canonical.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] mtd: rawnand: meson: fix missing assignment of
 ret on a call to meson_chip_buffer_init
Message-ID: <20190130103250.4080a3b3@xps13>
In-Reply-To: <aeadd16e-ed46-28f2-15de-66d1d9f1ed11@amlogic.com>
References: <20190129105757.19138-1-colin.king@canonical.com>
        <aeadd16e-ed46-28f2-15de-66d1d9f1ed11@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang, Colin,

Liang Yang <liang.yang@amlogic.com> wrote on Wed, 30 Jan 2019 17:26:49
+0800:

> Hi Colin,
> 
> On 2019/1/29 18:57, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The call to meson_chip_buffer_init is not assigning ret, however, ret
> > is being checked for failure. Fix this by adding in the missing assignment.
> > 
> > Fixes: 2d570b34b41a ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >   drivers/mtd/nand/raw/meson_nand.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> > index e858d58d97b0..b9c543d1054c 100644
> > --- a/drivers/mtd/nand/raw/meson_nand.c
> > +++ b/drivers/mtd/nand/raw/meson_nand.c
> > @@ -1206,7 +1206,7 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
> >   		dev_err(nfc->dev, "16bits bus width not supported");
> >   		return -EINVAL;
> >   	}
> > -	meson_chip_buffer_init(nand);
> > +	ret = meson_chip_buffer_init(nand);  
> 
> Looks good to me:
> 
> Acked-by: Liang Yang <liang.yang@amlogic.com>

This is nand/next material, so if you don't mind I would like to squash
the two fixes you sent into the original commit inserting the driver.


Thanks,
Miquèl
