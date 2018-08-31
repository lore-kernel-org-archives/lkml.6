Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D202CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831682083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="aR8Nq8od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831682083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbeHaTud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:50:33 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41338 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbeHaTud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:50:33 -0400
Received: by mail-qt0-f194.google.com with SMTP id t39-v6so14982035qtc.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VZqW7BY8aLS7wLcgy5GIo18cFUx2N5hu+eq68a2A2NQ=;
        b=aR8Nq8odWgtBpMpAG/f2/8e/GFgFDSoIHsxvPezWFPplMfNS0BFsP3GwRLY378ry9Z
         oC6FPEtO9HMpjvkbegNyru1wj0IEborWGbyTmrGavhj9L3B6hrjEz3adFJHuPMqgsV/P
         dYnssti1rHI4NBq94Jlbp96sQv31TbKMlXKhItYbSd+3ZW9U8rqI6Jl0io2pEa159aid
         LCer2MT/F3+bPbZ+qNQ3XeKn4QfG4B3fqMYVAieyDgi50dshksEsGJMBpuOndInE0UkN
         cIwl+RqgM0MupZgY/PeY0Rb4LxNW/Q2wUGq8IrgqtYOJbjXKYmoDnkEV5AwRSwg9bT0+
         iXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VZqW7BY8aLS7wLcgy5GIo18cFUx2N5hu+eq68a2A2NQ=;
        b=QWxXqllep5HQEnItnNb/NFPwitGxOfNGK9W4aOerREf2t9SaBTZldx8g62/bUxIJRo
         LenFRYz1OsAEDtaoEG1X6S949wR0Qi6yF5A0yfe3cbUG499a0i7IcdW4RKaBnoSTEazD
         ITHKJ9zrbozWAdsaLg8IdoA9pnCAIed4zrL0SqNIUGJY2ahY5TUSgB61MDSPyFeNzJlY
         JF+lrY/hvvNJiYmGu1f7qYX5VmDtIVT4ylA2IBtuUMDnwG29U1m3UwwZaQ0jpV+KMIux
         mLk9zNTl7pXSml/yVEWai5sUPdTXfNygw/UdJJu0yXISU7+EtEEwHIkb0drNeazYUFeC
         5arQ==
X-Gm-Message-State: APzg51BOsahh/qqz3hwY7gXCaX+20Y04NWidAYdIURpdxvX7N4WibFqZ
        04/qA6D51e/1feYl/n2EBBOfqg==
X-Google-Smtp-Source: ANB0VdZqskZtxMd789qgRtSrJUEcII7Ht4TzuD/u9DUMbTBJJLXaRs/VayxqbwtUPROOpOeMUxm8Zw==
X-Received: by 2002:aed:2e64:: with SMTP id j91-v6mr8167640qtd.318.1535730148677;
        Fri, 31 Aug 2018 08:42:28 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w207-v6sm5391460qka.92.2018.08.31.08.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:42:27 -0700 (PDT)
Date:   Fri, 31 Aug 2018 11:42:26 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/15] blkcg: consolidate bio_issue_init and blkg
 association
Message-ID: <20180831154225.zoiztxvdvcfaat5r@destiny>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-8-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-8-dennisszhou@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:48PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> This removes the now duplicate association logic in blk-throttle and
> blk-iolatency. bio_issue_init is moved into blkcg_bio_issue_check and
> into the bio clone variants to allow for the future addition of a
> latency moving average for IOs.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
> ---
>  block/bio.c                |  2 ++
>  block/blk-iolatency.c      | 24 +-----------------------
>  block/blk-throttle.c       | 13 +------------
>  block/bounce.c             |  2 ++
>  include/linux/blk-cgroup.h |  2 ++
>  5 files changed, 8 insertions(+), 35 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index e937f9681188..ab41f5b7eb1f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -610,6 +610,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
>  	bio->bi_io_vec = bio_src->bi_io_vec;
>  
>  	bio_clone_blkcg_association(bio, bio_src);
> +
> +	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
>  }
>  EXPORT_SYMBOL(__bio_clone_fast);
>  
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index 22b2ff0440cc..9d7052bad6f7 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -395,34 +395,12 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio,
>  				     spinlock_t *lock)
>  {
>  	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
> -	struct blkcg *blkcg;
> -	struct blkcg_gq *blkg;
> -	struct request_queue *q = rqos->q;
> +	struct blkcg_gq *blkg = bio->bi_blkg;
>  	bool issue_as_root = bio_issue_as_root_blkg(bio);
>  
>  	if (!blk_iolatency_enabled(blkiolat))
>  		return;
>  
> -	rcu_read_lock();
> -	bio_associate_blkcg(bio, NULL);
> -	blkcg = bio_blkcg(bio);
> -	blkg = blkg_lookup(blkcg, q);
> -	if (unlikely(!blkg)) {
> -		if (!lock)
> -			spin_lock_irq(q->queue_lock);
> -		blkg = __blkg_lookup_create(blkcg, q);
> -		if (IS_ERR(blkg))
> -			blkg = NULL;
> -		if (!lock)
> -			spin_unlock_irq(q->queue_lock);
> -	}
> -	if (!blkg)
> -		goto out;
> -
> -	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
> -	bio_associate_blkg(bio, blkg);
> -out:
> -	rcu_read_unlock();

Move this removal to the previous patch, so you keep this patch soley about the
bio_issue_init.  Thanks,

Josef
