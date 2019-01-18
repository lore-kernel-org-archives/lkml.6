Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565EDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 06:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2594A2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 06:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547792373;
	bh=L0hcXLWboVxbebYY+QO8RZp3MMEjZK7FjCy6m/7Z25Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=w/K+cqISouXPYx31UXqFOTh6Vn46HTqRgIIa5Gat4xriGjTkcJx4yxOFXaCfNpf7Q
	 cHlF2ViVxQpQqAEOcmH1Ex7fS2dP8bEv6J7C/jp3AFOc87YeqnXYE9LoY30TUPFMFp
	 z6ESiTLzPbJqJwsfVXtD+ksc2130vAxjWn0HUH5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfARGTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 01:19:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfARGT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 01:19:29 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBA9E2086D;
        Fri, 18 Jan 2019 06:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547792368;
        bh=L0hcXLWboVxbebYY+QO8RZp3MMEjZK7FjCy6m/7Z25Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HL7oGQKljHAmg9xImIo+BF+RQIMRzRK7ClyDNp2sGsWwiYqjuEhiBir67EVacw2tv
         xh3oOo7tjsxTaeYf4D/ld2w61ikDmYIzhr36sKEp3T/69ZvH7LyGGNJLr1B+pzd5eO
         JLgc8T0vTB4rXZ4InJWWlTxn/LnOQ7/SH+rHFe0s=
Date:   Fri, 18 Jan 2019 07:19:19 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        "linux-stable # v4 . 20" <stable@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: rawnand: denali: get ->setup_data_interface()
 working again
Message-ID: <20190118071919.5c4015f6@bbrezillon>
In-Reply-To: <1547789438-11899-1-git-send-email-yamada.masahiro@socionext.com>
References: <1547789438-11899-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 14:30:38 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Commit 7a08dbaedd36 ("mtd: rawnand: Move ->setup_data_interface() to
> nand_controller_ops") missed to invert the if-conditonal for denali.
> Since then, the Denali NAND driver cannnot invoke setup_data_interface.
> 
> Fixes: 7a08dbaedd36 ("mtd: rawnand: Move ->setup_data_interface() to nand_controller_ops")
> Cc: linux-stable <stable@vger.kernel.org> # v4.20

Commit 7a08dbaedd36 was merged in 5.0, I'll drop Cc stable when
applying.

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/mtd/nand/raw/denali.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
> index eebac35..6e8edc9 100644
> --- a/drivers/mtd/nand/raw/denali.c
> +++ b/drivers/mtd/nand/raw/denali.c
> @@ -1322,7 +1322,7 @@ int denali_init(struct denali_nand_info *denali)
>  	}
>  
>  	/* clk rate info is needed for setup_data_interface */
> -	if (denali->clk_rate && denali->clk_x_rate)
> +	if (!denali->clk_rate || !denali->clk_x_rate)
>  		chip->options |= NAND_KEEP_TIMINGS;
>  
>  	chip->legacy.dummy_controller.ops = &denali_controller_ops;

