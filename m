Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8468C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B171720664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B171720664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbeJaXAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:00:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34188 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728849AbeJaXAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:00:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 12DAE207D4; Wed, 31 Oct 2018 15:02:35 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id D2A9C20756;
        Wed, 31 Oct 2018 15:02:24 +0100 (CET)
Date:   Wed, 31 Oct 2018 15:02:25 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Huijin Park <huijin.park@samsung.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbanghj.park@gmail.com
Subject: Re: [PATCH] mtd: change len type from signed to unsigned type
Message-ID: <20181031150225.175ec1d4@bbrezillon>
In-Reply-To: <1535013819-1646-1-git-send-email-huijin.park@samsung.com>
References: <CGME20180823084348eucas1p2157ab1089290298cf43647e522b8be4f@eucas1p2.samsung.com>
        <1535013819-1646-1-git-send-email-huijin.park@samsung.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huijin,

On Thu, 23 Aug 2018 04:43:39 -0400
Huijin Park <huijin.park@samsung.com> wrote:

> From: "huijin.park" <huijin.park@samsung.com>
> 
> assign of a signed value which has type 'int' to a variable of
> a bigger unsigned integer type 'uint64_t'.

Why are you mentioning u64? AFAICT, the len passed to erase_write() is
always an unsigned int.

> this is ok most of the time, but can lead to unexpectedly large
> resulting value if the original signed value is negative.
> in addtion, the callers of the erase_write() pass the len parameter

  ^In addition,

> as unsigned type.
> 
> Signed-off-by: huijin.park <huijin.park@samsung.com>
> ---
>  drivers/mtd/mtdblock.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
> index a5b1933..b2d5ed1 100644
> --- a/drivers/mtd/mtdblock.c
> +++ b/drivers/mtd/mtdblock.c
> @@ -56,7 +56,7 @@ struct mtdblk_dev {
>   */
>  
>  static int erase_write (struct mtd_info *mtd, unsigned long pos,
> -			int len, const char *buf)
> +			unsigned int len, const char *buf)

The diff looks good, but the commit message is not clear at all. Can
you reword it?

Thanks,

Boris

>  {
>  	struct erase_info erase;
>  	size_t retlen;

