Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0589C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D19F218F1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOUywK3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D19F218F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeHQMge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:36:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44316 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeHQMge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:36:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so6506350wrt.11;
        Fri, 17 Aug 2018 02:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p8qZSHsxSCEOIZZ2DpQ6bZwTTmUs5f5A/k0yL+06Hm4=;
        b=dOUywK3R4Tzm6szaeMbOBwfkbVd4meNX2FxSm0LETtiJRajWQO0xxrJOPMwAru9mEd
         QhtWD9EH7JfIDZxGkZBQV5QRHMAKO/LMtifBI4VEx5Wl44AlgkZQv0WToQe1DWsS02mA
         ugxxX7g/iqgX62EDjyED1FhBd7Qwle1LZPdbHN9lNjX8ZQ2oBMNW5lkNUGqtpd5+fICa
         UGYP9C8f7uAP/DBsrA1tZOg7GlKeKmxbwK4ZFifNHvHr8WcBrwfEmjMUvBWKppWZH5xF
         XR5a//Z2UnMFMKF1R6Dc1f30eVQwM/JsUvS51dqF0UpM1BQViVjMLt/sNeaGJeHiHBKW
         yoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p8qZSHsxSCEOIZZ2DpQ6bZwTTmUs5f5A/k0yL+06Hm4=;
        b=EiLSKP2s6ZqVXAj/pHtGtDSH9hl6+36U/dpLdDapcg3IcvwwuEgFEfJNaHLD6CukBF
         aYRYdFOWmJDY58y6qDH+VRJ42zbCOpyQmhXKT0ya3ndiYlgCgpHIey+8UYmXURpfnbpI
         XOMKlDVHHhE0HoXaSs8wwLl/585SHaQlUcI1TcO/eddII84Wlga+K4icJIz1zcdz7AQx
         rpujEpY1o0AUqDWcZRzMkeCLU2qs7fHPmwreENAdRltSy9BJkF+jtAX9z7SDYSfkQdBB
         LBAyjhS2RBWFGqSOmDfJ2OeWXzJqO/a6XQbtridvj2+baQx6yxImXufGv3T/gAd/sFqh
         PKPw==
X-Gm-Message-State: APzg51BNKbBAYAp9TZDDE3kfEutaB/7nB0PgePvUdtiAvPWH0aR6vdc5
        G5Gr8FySiuzw6vcIwBYeTq9M/reoyMijMuNJnHVpmbRlkEk=
X-Google-Smtp-Source: AA+uWPzuGjZiqAP6MxfroCQ3hgMHa2s3P9M2a3nWkoVnhay2UM8AXgf9bpe7oW8yU5Uk7zzFTpoKiDYJrsZiimz/wbo=
X-Received: by 2002:adf:ac38:: with SMTP id v53-v6mr949796wrc.142.1534498431819;
 Fri, 17 Aug 2018 02:33:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:32c1:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 02:33:51
 -0700 (PDT)
In-Reply-To: <1534478043-7170-2-git-send-email-jianchao.w.wang@oracle.com>
References: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com> <1534478043-7170-2-git-send-email-jianchao.w.wang@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 17 Aug 2018 17:33:51 +0800
Message-ID: <CACVXFVPZF7ohzUib4Nr1qdHLwjpEWP4+be6h6GmZh1y9-qsVqg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] blk-mq: init hctx sched after update ctx and hctx mapping
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@linux.intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 11:54 AM, Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
> Currently, when update nr_hw_queues, io scheduler's init_hctx will
> be invoked before the mapping between ctx and hctx is adapted
> correctly by blk_mq_map_swqueue. The io scheduler init_hctx (kyber)
> may depend on this mapping and get wrong result and panic finally.
> A simply way to fix this is switch the io scheduler to none before
> update the nr_hw_queues, and then get it back after update nr_hw_queues.
> To achieve this, we add a new member elv_type in request_queue to
> save the original elevator and adapt and export elevator_switch_mq.
> And also blk_mq_sched_init_/exit_hctx are removed due to nobody use
> them any more.
>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq-sched.c   | 44 --------------------------------------------
>  block/blk-mq-sched.h   |  5 -----
>  block/blk-mq.c         | 36 ++++++++++++++++++++++++++++--------
>  block/blk.h            |  2 ++
>  block/elevator.c       | 20 ++++++++++++--------
>  include/linux/blkdev.h |  3 +++
>  6 files changed, 45 insertions(+), 65 deletions(-)
>
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index cf9c66c..29bfe80 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -462,50 +462,6 @@ static void blk_mq_sched_tags_teardown(struct request_queue *q)
>                 blk_mq_sched_free_tags(set, hctx, i);
>  }
>
> -int blk_mq_sched_init_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
> -                          unsigned int hctx_idx)
> -{
> -       struct elevator_queue *e = q->elevator;
> -       int ret;
> -
> -       if (!e)
> -               return 0;
> -
> -       ret = blk_mq_sched_alloc_tags(q, hctx, hctx_idx);
> -       if (ret)
> -               return ret;
> -
> -       if (e->type->ops.mq.init_hctx) {
> -               ret = e->type->ops.mq.init_hctx(hctx, hctx_idx);
> -               if (ret) {
> -                       blk_mq_sched_free_tags(q->tag_set, hctx, hctx_idx);
> -                       return ret;
> -               }
> -       }
> -
> -       blk_mq_debugfs_register_sched_hctx(q, hctx);
> -
> -       return 0;
> -}
> -
> -void blk_mq_sched_exit_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
> -                           unsigned int hctx_idx)
> -{
> -       struct elevator_queue *e = q->elevator;
> -
> -       if (!e)
> -               return;
> -
> -       blk_mq_debugfs_unregister_sched_hctx(hctx);
> -
> -       if (e->type->ops.mq.exit_hctx && hctx->sched_data) {
> -               e->type->ops.mq.exit_hctx(hctx, hctx_idx);
> -               hctx->sched_data = NULL;
> -       }
> -
> -       blk_mq_sched_free_tags(q->tag_set, hctx, hctx_idx);
> -}
> -
>  int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
>  {
>         struct blk_mq_hw_ctx *hctx;
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index 0cb8f93..4e028ee 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -28,11 +28,6 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
>  int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
>  void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
>
> -int blk_mq_sched_init_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
> -                          unsigned int hctx_idx);
> -void blk_mq_sched_exit_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
> -                           unsigned int hctx_idx);
> -
>  static inline bool
>  blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
>  {
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5efd789..de7027f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2147,8 +2147,6 @@ static void blk_mq_exit_hctx(struct request_queue *q,
>         if (set->ops->exit_request)
>                 set->ops->exit_request(set, hctx->fq->flush_rq, hctx_idx);
>
> -       blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
> -
>         if (set->ops->exit_hctx)
>                 set->ops->exit_hctx(hctx, hctx_idx);
>
> @@ -2216,12 +2214,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
>             set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
>                 goto free_bitmap;
>
> -       if (blk_mq_sched_init_hctx(q, hctx, hctx_idx))
> -               goto exit_hctx;
> -
>         hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size);
>         if (!hctx->fq)
> -               goto sched_exit_hctx;
> +               goto exit_hctx;
>
>         if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx, node))
>                 goto free_fq;
> @@ -2235,8 +2230,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
>
>   free_fq:
>         kfree(hctx->fq);
> - sched_exit_hctx:
> -       blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
>   exit_hctx:
>         if (set->ops->exit_hctx)
>                 set->ops->exit_hctx(hctx, hctx_idx);
> @@ -2913,6 +2906,25 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>         list_for_each_entry(q, &set->tag_list, tag_set_list)
>                 blk_mq_freeze_queue(q);
>
> +       /*
> +        * switch io scheduler to NULL to clean up the data in it.
> +        * will get it back after update mapping between cpu and hw queues.
> +        */
> +       list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +               if (!q->elevator) {
> +                       q->elv_type = NULL;
> +                       continue;
> +               }
> +               q->elv_type = q->elevator->type;
> +               mutex_lock(&q->sysfs_lock);
> +               /*
> +                * elevator_release will put it.
> +                */
> +               __module_get(q->elv_type->elevator_owner);

I understand what elevator_release() frees is the 'ref-counter' got in
elevator_get(), but who will be the counter-pair of the above  __module_get()?

Thanks,
Ming Lei
