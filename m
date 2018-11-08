Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA28BC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EE72081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EE72081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeKHSn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:43:57 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59066 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbeKHSn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:43:57 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6675520787; Thu,  8 Nov 2018 10:09:24 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 401D72039F;
        Thu,  8 Nov 2018 10:09:24 +0100 (CET)
Date:   Thu, 8 Nov 2018 10:09:24 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Colin King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][i3c-next] i3c: fix incorrect update to max_read_ds
Message-ID: <20181108100924.2381e9f0@bbrezillon>
In-Reply-To: <20181107204208.7411-1-colin.king@canonical.com>
References: <20181107204208.7411-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Nov 2018 20:42:08 +0000
Hi Colin,

Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently max_read_ds is being updated twice, which is incorrect.
> The second assignment should be to max_write_ds instead. Fix this.
> 
> Detected by CoverityScan, CID#1475379 ("Unused value")
> 
> Fixes: 50cacdabeae1 ("i3c: Add core I3C infrastructure")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/i3c/master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 68d6553dbd75..0ea7bb045fad 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1093,7 +1093,7 @@ static int i3c_master_getmxds_locked(struct i3c_master_controller *master,
>  	}
>  
>  	info->max_read_ds = getmaxds->maxrd;
> -	info->max_read_ds = getmaxds->maxwr;
> +	info->max_write_ds = getmaxds->maxwr;

Thanks for the fix.

Since the I3C driver is not merged yet, would you mind if I squash your
changes in the commit introducing the bug?

Regards,

Boris
