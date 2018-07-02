Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C54DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D9425A0D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="SXKwFb1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D9425A0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965689AbeGBL1a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:27:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36566 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965668AbeGBL1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:27:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so1246876wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 04:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PmH8KOHDhy4SXerFSzlY7bmavJS5VHfln5K4cYMb8yo=;
        b=SXKwFb1js5fMxyyW9X/P9moVseNKMH3OG4c6YK9WPibTTMtPlGuZxp1xzB+FqH4aB9
         gj/8SnGYd+ZDr7gh7ZidsrCbowOT/mQoCCYOqsdp2fzP4vDx04H3IHR63zdEBiWRh+pL
         Ew+Mprwb1ecylEBTwNiVoiCF+A/lEZiN1DEezzGudUPBhRzq+mHxWSr6mfX6HBlPflT9
         FHgfoXKC2TR/y6tVh8Xv8vJ2NG6XbIT49J5MmuuDr2A2oQk0uQH3ku0sP1VXe+h3wXyf
         PqCj3MgJJ1XjCQdEN39aMCIxaNJwQbBfKPD6Ayrf1/5wuCmqwwn/Jok6x2iH5WfIvGov
         ns8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=PmH8KOHDhy4SXerFSzlY7bmavJS5VHfln5K4cYMb8yo=;
        b=j/faCtfZY/tnZl0abupvMrtF8HWUyaEfIS63z+IK1dxtZe2vMEdIhvr0WB389pIwn4
         A9mrFCP0dApvXUOx2a/0/T3yaT1N0tZKZq7ym7Owx4cGG8mlM8jNTlcN8YVF2xFnkShg
         oEJJGhi/BIRGxKgBT8pgZ6H9B0wmvHa0XWlCAy0lDCZN8w6brDgLuD0QkhHk4JWz5eHF
         7x9vafOFyuotVbmNcghUKWVVZsX+fIYiyG/oNhV6WfAeuHVApB2pQXAdl61kKSs9u+3O
         CLVPPDefc+IJLeo6PygxHOVST9hc6KKYYYfv5NAYrrI7PCeSdllXa9tgQfiLImf04OLi
         xR4w==
X-Gm-Message-State: APt69E01++7pY8opnB/0W/yjUrrZj2Wju/xn5sE1taXzrsTU2odFvAk/
        2PbijIcCIyjE/afCCsa02dR8sQ==
X-Google-Smtp-Source: AAOMgpe9R0gNBs5ZP82wvWz+jMaJitbVc4mTUCDIqrbR9E2sPWF7u7qrKPWeaXFajSTqDl3/m9WOJg==
X-Received: by 2002:a1c:4885:: with SMTP id v127-v6mr3134334wma.161.1530530842711;
        Mon, 02 Jul 2018 04:27:22 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at. [212.186.191.219])
        by smtp.gmail.com with ESMTPSA id s16-v6sm12451499wrq.20.2018.07.02.04.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 04:27:22 -0700 (PDT)
Date:   Mon, 2 Jul 2018 13:27:21 +0200
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [PATCH] drbd: fix access after free
Message-ID: <20180702112703.GA10994@soda.linbit>
Mail-Followup-To: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>
References: <20180625093952.20220-1-lars.ellenberg@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625093952.20220-1-lars.ellenberg@linbit.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens, I had hoped you'd apply this "oneliner" into 4.18 already?
Did you miss it?

Cheers,

	Lars


On Mon, Jun 25, 2018 at 11:39:52AM +0200, Lars Ellenberg wrote:
>   	bio_put(req->private_bio);
>  -	req->private_bio = ERR_PTR(error);
>  +	req->private_bio = ERR_PTR(bio->bi_error);
> 
> Which introduces an access after free,
> because it was non obvious that req->private_bio == bio.

>   	bio_put(req->private_bio);
>   	req->private_bio = ERR_PTR(blk_status_to_errno(bio->bi_status));

> Should also go into stable since 4.3, with the trivial change around 4.13.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4246a0b63bd8 block: add a bi_error field to struct bio
> Reported-by: Sarah Newman <srn@prgmr.com>
> Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
> ---
>  drivers/block/drbd/drbd_worker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
> index 1476cb3439f4..5e793dd7adfb 100644
> --- a/drivers/block/drbd/drbd_worker.c
> +++ b/drivers/block/drbd/drbd_worker.c
> @@ -282,8 +282,8 @@ void drbd_request_endio(struct bio *bio)
>  		what = COMPLETED_OK;
>  	}
>  
> -	bio_put(req->private_bio);
>  	req->private_bio = ERR_PTR(blk_status_to_errno(bio->bi_status));
> +	bio_put(bio);
>  
>  	/* not req_mod(), we need irqsave here! */
>  	spin_lock_irqsave(&device->resource->req_lock, flags);
> -- 
> 2.17.1
