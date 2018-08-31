Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959E6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499A720661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="eUtCchfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499A720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbeHaTiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:38:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36619 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbeHaTiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:38:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id 93-v6so1641783qks.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r4xlJrCOyIDs6oSO9a8eot+HhJ0UKStNZvu7TqaUHHI=;
        b=eUtCchfLR28qwPaFKR1o0VGLHzliYbHEoXgYVmNPog1b8I6I5HpHcSkIiC1JmRF7NN
         /paBfy4M1KgUCcznVTxR7/0yA2vw0H+sp3z9ql4ZvtkejTzpf6CTIrS0sdUHAKZ5+UcO
         l2R++nsfrw672Ef2svHQ4IoLEaGxTzO7VLGdCNsnxk0uU0+iyI11/JZ+o8c4mVpMOHg5
         iRUnG/hgXArTezrHSAZVk5zPPe35b88NxVHNTEgbHPGAQPQzF4cycysMjuvJDbdq0LKF
         sPLkLn0GFDHnYe2jdXeVtYwV4gHZm6xCgpK5/E/1yRbLBFYMgcqUtMyWc/Y8uygNX5+k
         5cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r4xlJrCOyIDs6oSO9a8eot+HhJ0UKStNZvu7TqaUHHI=;
        b=VZOndENu7zlBwYRcBiwqE9PUI4UWyL7/iLTqWu2YDo69/2jWfLTUJp8gcGS6FlkEDm
         U3yl60bB68X4MTyQ3KXSCynD8EVsVhZ+o5o92DAbk4LET3bxPU9zUONyFDkd3MEHgGZO
         isudQvDBbEb0N64X67luNnnomCqlhD9QJizuMLMOzedxesVlSVwL2uu7qVaK+Hyx6uLN
         eubNLTpdvQQCrn9L+iIen1ER8VXhWk1FwQVlzrAxlcg2r3ghxoxbMfNsK5qLov4s7Mfj
         QnWMHyJY+lJKC3YxHXv6jG4BxfQdCH+J+b5VSHzKZoxkK+zRmt4oqQyMj/TofyP2XI3Y
         83rA==
X-Gm-Message-State: APzg51C7JlOyqoloS/Qr7zSTftH5fdzsydgIDqpROdYEIPE/1xKxnd/m
        xkLga9qva9Y0+2iqYVVXISz9QQ==
X-Google-Smtp-Source: ANB0Vdb0HwBN4NwL748C20tnSpyu7oqYZN3VDdu+0D4ahRERpjVKaAHVJ6EPwfxl7opOd/RcmdxGew==
X-Received: by 2002:a37:6c87:: with SMTP id h129-v6mr15341104qkc.280.1535729410313;
        Fri, 31 Aug 2018 08:30:10 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j10-v6sm7246576qka.94.2018.08.31.08.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:30:09 -0700 (PDT)
Date:   Fri, 31 Aug 2018 11:30:08 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 03/15] blkcg: use tryget logic when associating a blkg
 with a bio
Message-ID: <20180831153007.nybnuyx43adn76rm@destiny>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-4-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-4-dennisszhou@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:44PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> There is a very small change a bio gets caught up in a really
> unfortunate race between a task migration, cgroup exiting, and itself
> trying to associate with a blkg. This is due to css offlining being
> performed after the css->refcnt is killed which triggers removal of
> blkgs that reach their blkg->refcnt of 0.
> 
> To avoid this, association with a blkg should use tryget and fallback to
> using the root_blkg.
> 
> Fixes: 08e18eab0c579 ("block: add bi_blkg to the bio for cgroups")
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
> Cc: Jiufei Xue <jiufei.xue@linux.alibaba.com>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> ---
>  block/bio.c          | 3 ++-
>  block/blk-throttle.c | 5 +++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 04969b392c72..4473ccd22987 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1987,7 +1987,8 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
>  {
>  	if (unlikely(bio->bi_blkg))
>  		return -EBUSY;
> -	blkg_get(blkg);
> +	if (!blkg_try_get(blkg))
> +		return -ENODEV;
>  	bio->bi_blkg = blkg;
>  	return 0;
>  }
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index a3eede00d302..c626e1f7cdcd 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -2129,8 +2129,9 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
>  static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
>  {
>  #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
> -	if (bio->bi_css)
> -		bio_associate_blkg(bio, tg_to_blkg(tg));
> +	/* fallback to root_blkg if we fail to get a blkg ref */
> +	if (bio->bi_css && bio_associate_blkg(bio, tg_to_blkg(tg)))
> +		bio_associate_blkg(bio, bio->bi_disk->queue->root_blkg);

Except if we've already assocated a blkg this is just extra, can we do

if (bio->bi_css && (bio_associate_blkg(bio, tg_to_blkg(tg)) == -ENODEV))

to make it clear that we're only attaching it to the root if we failed to attach
a blkg at all?  Thanks,

Josef
