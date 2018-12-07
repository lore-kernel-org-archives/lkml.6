Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AE8C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24F720837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24F720837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbeLGSvM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:51:12 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44775 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbeLGSvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:51:11 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 766F420750; Fri,  7 Dec 2018 19:51:09 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8E01020717;
        Fri,  7 Dec 2018 19:51:08 +0100 (CET)
Date:   Fri, 7 Dec 2018 19:51:07 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Paul Burton <paul.burton@mips.com>, trivial@kernel.org,
        kernel-janitors@vger.kernel.org,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: jz4780: annotate implicit fall
 throughs
Message-ID: <20181207195107.1b4959e1@xps13>
In-Reply-To: <20181204201057.30733-1-malat@debian.org>
References: <20181203212214.8862-1-malat@debian.org>
        <20181204201057.30733-1-malat@debian.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Mathieu Malaterre <malat@debian.org> wrote on Tue,  4 Dec 2018 21:10:57
+0100:

> There is a plan to build the kernel with -Wimplicit-fallthrough and
> these places in the code produced warnings. Fix them up.
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: fix subject prefix non sense
> 
>  drivers/mtd/nand/raw/jz4780_bch.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/jz4780_bch.c b/drivers/mtd/nand/raw/jz4780_bch.c
> index 731c6051d91e..7201827809e9 100644
> --- a/drivers/mtd/nand/raw/jz4780_bch.c
> +++ b/drivers/mtd/nand/raw/jz4780_bch.c
> @@ -136,8 +136,10 @@ static void jz4780_bch_read_parity(struct jz4780_bch *bch, void *buf,
>  	switch (size8) {
>  	case 3:
>  		dest8[2] = (val >> 16) & 0xff;
> +		/* fall through */
>  	case 2:
>  		dest8[1] = (val >> 8) & 0xff;
> +		/* fall through */
>  	case 1:
>  		dest8[0] = val & 0xff;
>  		break;

Applied to nand/next.


Thanks,
Miquèl
