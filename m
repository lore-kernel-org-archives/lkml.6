Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3E3C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EAB21EA2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EAB21EA2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbeGGKE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:04:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51801 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752761AbeGGKEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:04:25 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9451E207AB; Sat,  7 Jul 2018 12:04:22 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 550F320741;
        Sat,  7 Jul 2018 12:04:22 +0200 (CEST)
Date:   Sat, 7 Jul 2018 12:04:23 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Colin King <colin.king@canonical.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: nftl: remove redundant variable nb_erases
Message-ID: <20180707120423.17502c7f@bbrezillon>
In-Reply-To: <20180704064609.13369-1-colin.king@canonical.com>
References: <20180704064609.13369-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Jul 2018 07:46:09 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable nb_erases is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'nb_erases' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.

Thanks,

Boris

> ---
>  drivers/mtd/nftlmount.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nftlmount.c b/drivers/mtd/nftlmount.c
> index 27184e3874db..91b7fb326f9a 100644
> --- a/drivers/mtd/nftlmount.c
> +++ b/drivers/mtd/nftlmount.c
> @@ -577,7 +577,7 @@ static int get_fold_mark(struct NFTLrecord *nftl, unsigned int block)
>  int NFTL_mount(struct NFTLrecord *s)
>  {
>  	int i;
> -	unsigned int first_logical_block, logical_block, rep_block, nb_erases, erase_mark;
> +	unsigned int first_logical_block, logical_block, rep_block, erase_mark;
>  	unsigned int block, first_block, is_first_block;
>  	int chain_length, do_format_chain;
>  	struct nftl_uci0 h0;
> @@ -621,7 +621,6 @@ int NFTL_mount(struct NFTLrecord *s)
>  
>  				logical_block = le16_to_cpu ((h0.VirtUnitNum | h0.SpareVirtUnitNum));
>  				rep_block = le16_to_cpu ((h0.ReplUnitNum | h0.SpareReplUnitNum));
> -				nb_erases = le32_to_cpu (h1.WearInfo);
>  				erase_mark = le16_to_cpu ((h1.EraseMark | h1.EraseMark1));
>  
>  				is_first_block = !(logical_block >> 15);

