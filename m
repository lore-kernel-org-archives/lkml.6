Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC61C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ADF223A5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46ADF223A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753696AbeGGKDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:03:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51770 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752171AbeGGKDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:03:47 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 08FB5207AB; Sat,  7 Jul 2018 12:03:45 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id BCEAF20741;
        Sat,  7 Jul 2018 12:03:44 +0200 (CEST)
Date:   Sat, 7 Jul 2018 12:03:45 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Colin King <colin.king@canonical.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: cfi_cmdset_0002: remove redundant variable timeo
Message-ID: <20180707120345.2996a124@bbrezillon>
In-Reply-To: <20180703074339.29989-1-colin.king@canonical.com>
References: <20180703074339.29989-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Jul 2018 08:43:39 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable is_local is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'timeo' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.

Thanks,

Boris

> ---
>  drivers/mtd/chips/cfi_cmdset_0002.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
> index 1b64ac8c5bc8..72428b6bfc47 100644
> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> @@ -1216,7 +1216,6 @@ static inline int do_read_secsi_onechip(struct map_info *map,
>  					size_t grouplen)
>  {
>  	DECLARE_WAITQUEUE(wait, current);
> -	unsigned long timeo = jiffies + HZ;
>  
>   retry:
>  	mutex_lock(&chip->mutex);
> @@ -1229,7 +1228,6 @@ static inline int do_read_secsi_onechip(struct map_info *map,
>  
>  		schedule();
>  		remove_wait_queue(&chip->wq, &wait);
> -		timeo = jiffies + HZ;
>  
>  		goto retry;
>  	}

