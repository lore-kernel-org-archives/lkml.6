Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FDCC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DB72156D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qczUH7xY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DB72156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbeHOOYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 10:24:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32889 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbeHOOYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 10:24:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so868530wrp.0;
        Wed, 15 Aug 2018 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Sl1PRNxhNeUj0twWMbD7wreUn78r+grqo0jRVu0MkOI=;
        b=qczUH7xYsNI1oURTGSlJoi+eiRAIUHivJ/so7HPnj5xtEfU13V5EymZrq/ArnfiTsh
         ruyX9GOsktqcrfzVdVhsb2GR/wKP3QExpiYJ2kdwxAL6kmIzB84M+VMZ3OLYsv/Ngk/j
         qOh5mx5bKDiT5Pn08AScZzWV6rhxPvenYRdtu24zuUDQqx3v6Fc5wqlo7AavD0fWGE72
         FeQo+TOjZKkZt9OL1G2rB/KaDk4FyMUlKM7/Jg6/ESZvl3ZI7oGsqL8rMg0zzqUW40iG
         mYLXWZf5nHzvyrm5F6s3081xczDzY73BPCsK1+xdDTMRnujuBviOnSUXI1JvDNlySFqm
         i6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Sl1PRNxhNeUj0twWMbD7wreUn78r+grqo0jRVu0MkOI=;
        b=VYJG8vm2+c2ZIphYys9kPu0rRBRN/fbtNDs6Nkx/pKuz70A2eDI/JF1p7d3CT2ahVo
         GeDi7J8kCSdgDunJUpI4rW0mverQUKn38ZC9jCGmftvtsKjwXfs6BLJ/kQIm7FLW4jCe
         Bg8FXNYQ2AXGbQOvsg4+B395JF/BGPWGgRc6NwiXHxJbi0MglVtwD2CpzXl2JTUSrdR/
         enIegYMuTYgiIxL58PybDF38F420o0HBU+8OwhcgVWmUrK4Y2ghtUvaEftAG2SK7s286
         cGvqSDBFYPJCL++uVur+ww18nh7+NfTBUbZuuQBzU3CP4gjxiBwDN0Sct+4DYPiFaGxr
         gQcw==
X-Gm-Message-State: AOUpUlGIw+cgp0ktzaaYvhUM8cr1OjgijiS/ApnQ3rM/Uv8K4zYyKlHN
        wYbilYuPfftyYjo5dV4b6VQcmTqm0zUcYX0kBA8=
X-Google-Smtp-Source: AA+uWPyhumxG66Vlz052dvpeq+BToxiDRIadh7Suzpn7klZeOZdsC3aVEJI+gLBhDAbdUhjy1D7JAX5wQhL3ItdSXVw=
X-Received: by 2002:adf:9d1c:: with SMTP id k28-v6mr16279580wre.29.1534332775367;
 Wed, 15 Aug 2018 04:32:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:32c1:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 04:32:54
 -0700 (PDT)
In-Reply-To: <1534317915-5041-2-git-send-email-jianchao.w.wang@oracle.com>
References: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com> <1534317915-5041-2-git-send-email-jianchao.w.wang@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 15 Aug 2018 19:32:54 +0800
Message-ID: <CACVXFVO+NoU2YcuhchYOzAbxu9CfY7VCE5moRrH47kWmX_JD7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] blk-mq: init hctx sched after update cpu &
 nr_hw_queues mapping
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

On Wed, Aug 15, 2018 at 3:25 PM, Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
> Kyber depends on the mapping between cpu and nr_hw_queues. When
> update nr_hw_queues, elevator_type->ops.mq.init_hctx will be
> invoked before the mapping is adapted correctly, this would cause
> terrible result. A simply way to fix this is switch the io scheduler
> to none before update the nr_hw_queues, and then get it back after
> update nr_hw_queues. To achieve this, we add a new member elv_type
> in request_queue to save the original elevator and adapt and export
> elevator_switch_mq.
>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq.c         | 37 +++++++++++++++++++++++++++++--------
>  block/blk.h            |  2 ++
>  block/elevator.c       | 20 ++++++++++++--------
>  include/linux/blkdev.h |  3 +++
>  4 files changed, 46 insertions(+), 16 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5efd789..89904cc 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -112,6 +112,7 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
>         struct mq_inflight mi = { .part = part, .inflight = inflight, };
>
>         inflight[0] = inflight[1] = 0;
> +

Not necessary to do that.

>         blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
>  }
>
> @@ -2147,8 +2148,6 @@ static void blk_mq_exit_hctx(struct request_queue *q,
>         if (set->ops->exit_request)
>                 set->ops->exit_request(set, hctx->fq->flush_rq, hctx_idx);
>
> -       blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
> -
>         if (set->ops->exit_hctx)
>                 set->ops->exit_hctx(hctx, hctx_idx);
>
> @@ -2216,12 +2215,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
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
> @@ -2235,8 +2231,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
>
>   free_fq:
>         kfree(hctx->fq);
> - sched_exit_hctx:
> -       blk_mq_sched_exit_hctx(q, hctx, hctx_idx);

Seems both blk_mq_sched_init_hctx() and blk_mq_sched_exit_hctx() may be
removed now.

>   exit_hctx:
>         if (set->ops->exit_hctx)
>                 set->ops->exit_hctx(hctx, hctx_idx);
> @@ -2913,6 +2907,25 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
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
> +               elevator_switch_mq(q, NULL);
> +               mutex_unlock(&q->sysfs_lock);
> +       }
> +
>         set->nr_hw_queues = nr_hw_queues;
>         blk_mq_update_queue_map(set);
>         list_for_each_entry(q, &set->tag_list, tag_set_list) {
> @@ -2920,6 +2933,14 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>                 blk_mq_queue_reinit(q);
>         }
>
> +       list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +               if (!q->elv_type)
> +                       continue;
> +
> +               mutex_lock(&q->sysfs_lock);
> +               elevator_switch_mq(q, q->elv_type);
> +               mutex_unlock(&q->sysfs_lock);
> +       }

BFQ defines .init_hctx() too, so seems this generic approach is correct way for
this issue.

thanks,
Ming Lei
