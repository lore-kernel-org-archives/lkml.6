Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCA0C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF8C21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548174466;
	bh=lNb94LlMvk29Pwlw43y6W7QGnz/YG5YHhNI1f7bJR/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KG/7NM3/7dfQKs5fRsxk0mJmZsD6ldQ1+NOaZueVFMz3wAo/0h69eGiIZ20t0hY99
	 4ur9Ie9r9XkN8ZPAqMhZOfnD0ja52R7jrNEce4E9IGLXhvbsXWQ7qG0wydqIjL4V7f
	 x4xP2j/WJbN0sJ5rqN6epo2k1O8R2fROyTF9B/kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfAVQ1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:27:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728580AbfAVQ1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:27:44 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E465A2085A;
        Tue, 22 Jan 2019 16:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548174463;
        bh=lNb94LlMvk29Pwlw43y6W7QGnz/YG5YHhNI1f7bJR/s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q20oaR1YZGO/U/b56cCmuuKPr+yI5cE8yPwQcQoWWAfM0G9I6P6tJBXgCfNX66UnS
         D7hz6bKX54/B3f9hxC7IMzfC9n4m1JNMdOFh6ehFX+PgOHIV94dEfMaX0+U0mqC4Ov
         N3VzuFHyWtVPLsrzYVEEvBmZFq7zVuoR+wYMvAXI=
Date:   Tue, 22 Jan 2019 17:27:32 +0100
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
Subject: Re: [PATCH v2 3/4] mtd: rawnand: ESMT: Also use the last page for
 bad block markers
Message-ID: <20190122172732.6cbcffec@bbrezillon>
In-Reply-To: <20190122112258.20042-4-frieder.schrempf@kontron.de>
References: <20190122112258.20042-1-frieder.schrempf@kontron.de>
        <20190122112258.20042-4-frieder.schrempf@kontron.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 11:23:32 +0000
Schrempf Frieder <frieder.schrempf@kontron.de> wrote:

> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> It is known that some ESMT SLC NANDs have been shipped
> with the factory bad block markers in the first or last page
> of the block, instead of the first or second page. To be on
> the safe side, let's check all three locations.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
>  drivers/mtd/nand/raw/nand_esmt.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_esmt.c b/drivers/mtd/nand/raw/nand_esmt.c
> index 99a8092969a7..b37e0b5af5ae 100644
> --- a/drivers/mtd/nand/raw/nand_esmt.c
> +++ b/drivers/mtd/nand/raw/nand_esmt.c
> @@ -36,7 +36,14 @@ static void esmt_nand_decode_id(struct nand_chip *chip)
>  static int esmt_nand_init(struct nand_chip *chip)
>  {
>  	if (nand_is_slc(chip))
> -		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
> +		/*
> +		 * It is known that some ESMT SLC NANDs have been shipped
> +		 * with the factory bad block markers in the first or last page
> +		 * of the block, instead of the first or second page. To be on
> +		 * the safe side, let's check all three locations.
> +		 */
> +		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE |
> +				 NAND_BBM_LASTPAGE;
>  
>  	return 0;
>  }

