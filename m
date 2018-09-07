Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FEEC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DD820652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvJm/XKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DD820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeIHAAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:00:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42372 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIHAAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:00:40 -0400
Received: by mail-io1-f65.google.com with SMTP id n18-v6so2368264ioa.9;
        Fri, 07 Sep 2018 12:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dyrn0kZBPiAM48Q1sWNxVY70irBBEC68FYhtEN2TZYs=;
        b=bvJm/XKSGXHb1s6qAtA4pCU2Oy/X0LbnKn/TLXYHwrYVJWeTD4QnzeNi/600AVzUH6
         YPBJ+XFacsxKNkiTUFHPtI1ssh/bslfo1+tZ8T0ez2xfTKHZ4f/q0mDsMpheex8Z0jNn
         XjYlfMw1kl+TE57ZndHqLZV1JkFpJbckbcZws2EICkpxxoCi1kBoMIItQFQlg8FYFCCY
         rKZK0tP8MayI7e/Luxlk0sRbn+FUtu5hkc+dicy7onXQL0Lr0QMVWnK0rN009ffmKdOT
         3jUCocsjX0yF8QQwFsoxPr32bg9817HVuT8EJfaaxzVxgnmjc0yYVyEdFt6ys+mH3CN+
         dTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dyrn0kZBPiAM48Q1sWNxVY70irBBEC68FYhtEN2TZYs=;
        b=Yt6icsISzZfl1uRUEMqEFqj3peObkmPu31Fv0NOT8OTmCA6GMl4LmpaF23NUrwIZPl
         eB/gLvh6hlffNgiG7bGNXRsUa513Mcqq/uOXnHqHlSgFksvD0UwfEWDCDV3GI6QtxpTn
         GU+3EQy3Rp1wMXC9jUrzbG8g/SFrkTIT5t9JyV1O+HEFwUxLoq1n3n/C3uNO69qHAEg+
         AHDwMMZWsyO5jDrqT7imZ6kkTo0PMNqQThgxVN+nXx2Uadk4A5dhBtKolq8fOKFTHcqr
         sbn5rwjWs1NC18yrK4tLFEAcH2BLSJ9pwlKeDhbDXBRICLAssSyT4b3vvY/d8mUxnMKi
         YObg==
X-Gm-Message-State: APzg51Bu//+5TM9qzOMNjvJTheXHdnUoJjgpDwcjRQAXWEE+RQLEfWBJ
        ZGZTpDM+DGqpiK6142cf1CPEGYVcjhJsBf/rdBM=
X-Google-Smtp-Source: ANB0VdY36bEk3MXsp6pe2V2D5OTlji8RjZLLMuB230BtQR3QIg7Gcf4i8EBbAM1Rz4SFbLic18hVfr5lLWnBtiHwwE0=
X-Received: by 2002:a6b:c389:: with SMTP id t131-v6mr8018890iof.157.1536347899242;
 Fri, 07 Sep 2018 12:18:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:159b:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 12:18:18 -0700 (PDT)
In-Reply-To: <20180906211045.29055-6-dennisszhou@gmail.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com> <20180906211045.29055-6-dennisszhou@gmail.com>
From:   Liu Bo <obuil.liubo@gmail.com>
Date:   Fri, 7 Sep 2018 12:18:18 -0700
Message-ID: <CANQeFDAx=mVKL-Zxey04V4LfiHDpoEcUiBg=rQXFoAn947UmSg@mail.gmail.com>
Subject: Re: [PATCH 05/12] blkcg: consolidate bio_issue_init to be a part of core
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 2:10 PM, Dennis Zhou <dennisszhou@gmail.com> wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
>
> bio_issue_init among other things initializes the timestamp for an IO.
> Rather than have this logic handled by policies, this consolidates it to
> be on the init paths (normal, clone, bounce clone).
>

Looks good.
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>

thanks,
liubo

> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
> v2: Association path consolidation was moved to the prior patch.
>
>  block/bio.c                | 2 ++
>  block/blk-iolatency.c      | 2 --
>  block/blk-throttle.c       | 8 --------
>  block/bounce.c             | 2 ++
>  include/linux/blk-cgroup.h | 9 +++++++++
>  5 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index b2b3fddfcd6f..a05997bdb967 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -610,6 +610,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
>         bio->bi_io_vec = bio_src->bi_io_vec;
>
>         bio_clone_blkcg_association(bio, bio_src);
> +
> +       blkcg_bio_issue_init(bio);
>  }
>  EXPORT_SYMBOL(__bio_clone_fast);
>
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index 79a7549e2062..9d7052bad6f7 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -401,8 +401,6 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio,
>         if (!blk_iolatency_enabled(blkiolat))
>                 return;
>
> -       bio_issue_init(&bio->bi_issue, bio_sectors(bio));
> -
>         while (blkg && blkg->parent) {
>                 struct iolatency_grp *iolat = blkg_to_lat(blkg);
>                 if (!iolat) {
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index b7b5cc4defc2..f2b355338894 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -2126,13 +2126,6 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
>  }
>  #endif
>
> -static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
> -{
> -#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
> -       bio_issue_init(&bio->bi_issue, bio_sectors(bio));
> -#endif
> -}
> -
>  bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
>                     struct bio *bio)
>  {
> @@ -2156,7 +2149,6 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
>         if (unlikely(blk_queue_bypass(q)))
>                 goto out_unlock;
>
> -       blk_throtl_assoc_bio(tg, bio);
>         blk_throtl_update_idletime(tg);
>
>         sq = &tg->service_queue;
> diff --git a/block/bounce.c b/block/bounce.c
> index bc63b3a2d18c..7a08703b1204 100644
> --- a/block/bounce.c
> +++ b/block/bounce.c
> @@ -259,6 +259,8 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
>
>         bio_clone_blkcg_association(bio, bio_src);
>
> +       blkcg_bio_issue_init(bio);
> +
>         return bio;
>  }
>
> diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
> index 6e33ad1d92b4..a6b6e741a75e 100644
> --- a/include/linux/blk-cgroup.h
> +++ b/include/linux/blk-cgroup.h
> @@ -897,6 +897,12 @@ static inline bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg
>                                   struct bio *bio) { return false; }
>  #endif
>
> +
> +static inline void blkcg_bio_issue_init(struct bio *bio)
> +{
> +       bio_issue_init(&bio->bi_issue, bio_sectors(bio));
> +}
> +
>  static inline bool blkcg_bio_issue_check(struct request_queue *q,
>                                          struct bio *bio)
>  {
> @@ -922,6 +928,8 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
>                 blkg_rwstat_add(&blkg->stat_ios, bio->bi_opf, 1);
>         }
>
> +       blkcg_bio_issue_init(bio);
> +
>         rcu_read_unlock();
>         return !throtl;
>  }
> @@ -1034,6 +1042,7 @@ static inline void blk_put_rl(struct request_list *rl) { }
>  static inline void blk_rq_set_rl(struct request *rq, struct request_list *rl) { }
>  static inline struct request_list *blk_rq_rl(struct request *rq) { return &rq->q->root_rl; }
>
> +static inline void blkcg_bio_issue_init(struct bio *bio) { }
>  static inline bool blkcg_bio_issue_check(struct request_queue *q,
>                                          struct bio *bio) { return true; }
>
> --
> 2.17.1
>
