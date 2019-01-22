Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0FCC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384562084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548174536;
	bh=ZI+xnBU5OJzwlF+oyj/gaqOn1LGJeEAsSOJfjTpm780=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vCEIIcu1d3dBQS6tpZXR/h4qb3VUQATnMsek5pjj6rNfuejJIC9pzTDvwITMUqyyW
	 VCkOmOq9qAZTDksqpPhicgu0UooWCs/5Me3GejKoroNNp81QPcGBNSrTJwnhSh0nHb
	 XxI9B2vpCz1EheIoLsbisjDsfuDybxGncLYKu17E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbfAVQ2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:28:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729272AbfAVQ2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:28:54 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2E0A2085A;
        Tue, 22 Jan 2019 16:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548174533;
        bh=ZI+xnBU5OJzwlF+oyj/gaqOn1LGJeEAsSOJfjTpm780=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lhBF2L5PZ/xYEHwP5t3tfjbWIRIPQsdyA9tWr3X+SeUfKnB7eru/rLrch2Sk6xo/v
         YXnKQhOJ69LrB2OJbQuax+JRenVZu/ooiS2xhIl5enoqFFLLX0xTax8lfDeSAlud4j
         ZL4mjT2l2b3Ili2qd6lXTy989HLXuyogwfZ99dps=
Date:   Tue, 22 Jan 2019 17:28:42 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2 4/4] mtd: rawnand: AMD: Also use the last page for
 bad block markers
Message-ID: <20190122172842.0c36876f@bbrezillon>
In-Reply-To: <20190122112258.20042-5-frieder.schrempf@kontron.de>
References: <20190122112258.20042-1-frieder.schrempf@kontron.de>
        <20190122112258.20042-5-frieder.schrempf@kontron.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 11:23:33 +0000
Schrempf Frieder <frieder.schrempf@kontron.de> wrote:

> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> According to the datasheet of some Cypress SLC NANDs, the bad
> block markers can be in the first, second or last page of a block.
> So let's check all three locations.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
>  drivers/mtd/nand/raw/nand_amd.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_amd.c b/drivers/mtd/nand/raw/nand_amd.c
> index 6202cbf7ee8d..2ffcddff3e27 100644
> --- a/drivers/mtd/nand/raw/nand_amd.c
> +++ b/drivers/mtd/nand/raw/nand_amd.c
> @@ -40,7 +40,13 @@ static void amd_nand_decode_id(struct nand_chip *chip)
>  static int amd_nand_init(struct nand_chip *chip)
>  {
>  	if (nand_is_slc(chip))
> -		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
> +		/*
> +		 * According to the datasheet of some Cypress SLC NANDs,
> +		 * the bad block markers can be in the first, second or last
> +		 * page of a block. So let's check all three locations.
> +		 */
> +		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE |
> +				 NAND_BBM_LASTPAGE;
>  
>  	return 0;
>  }

