Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9853C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B402146E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfAYMgd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:36:33 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49219 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfAYMgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:36:32 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E539C209B6; Fri, 25 Jan 2019 13:36:29 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id A89C5207AD;
        Fri, 25 Jan 2019 13:36:19 +0100 (CET)
Date:   Fri, 25 Jan 2019 13:36:19 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: Annotate implicit fall through in
 nand_command/nand_command_lp
Message-ID: <20190125133619.5991c2d4@xps13>
In-Reply-To: <20190116195004.2499-1-malat@debian.org>
References: <20190116195004.2499-1-malat@debian.org>
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

Mathieu Malaterre <malat@debian.org> wrote on Wed, 16 Jan 2019 20:50:03
+0100:

> There is a plan to build the kernel with -Wimplicit-fallthrough and
> these places in the code produced warnings (W=1).
> 
> This commit removes the following warnings:
> 
>   drivers/mtd/nand/raw/nand_legacy.c:332:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   drivers/mtd/nand/raw/nand_legacy.c:483:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/mtd/nand/raw/nand_legacy.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_legacy.c b/drivers/mtd/nand/raw/nand_legacy.c
> index 43575943f13b..f2526ec616a6 100644
> --- a/drivers/mtd/nand/raw/nand_legacy.c
> +++ b/drivers/mtd/nand/raw/nand_legacy.c
> @@ -331,6 +331,7 @@ static void nand_command(struct nand_chip *chip, unsigned int command,
>  		 */
>  		if (column == -1 && page_addr == -1)
>  			return;
> +		/* fall through */
>  
>  	default:
>  		/*
> @@ -483,7 +484,7 @@ static void nand_command_lp(struct nand_chip *chip, unsigned int command,
>  		chip->legacy.cmd_ctrl(chip, NAND_CMD_NONE,
>  				      NAND_NCE | NAND_CTRL_CHANGE);
>  
> -		/* This applies to read commands */
> +		/* fall through - This applies to read commands */
>  	default:
>  		/*
>  		 * If we don't have access to the busy pin, we apply the given

Applied to nand/next with the subject prefix being "mtd: rawnand:"


Thanks,
Miquèl
