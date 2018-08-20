Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB897C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF2421473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3b/Wdvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF2421473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeHTLbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 07:31:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53121 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeHTLbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 07:31:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so13239143wmh.2;
        Mon, 20 Aug 2018 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YbfRqziy2EWLEG1mQ1orqRox2rFRhwJnrGerYoys99Y=;
        b=D3b/WdvjoRpkLJKpjLqaA6ufj4Z8FNGwTbViFaqLxQ6YAE1K6CgF9bZ3WQ6WAQxZrF
         LTxZzhLPYdXoFualnN3nwzWFZpTNG7aMoRSQadVJsmdpqmR6jVxiqw+9e/zSNa+QlQVb
         l9bP/VrkhVHYbez02ukDy6wxb6YMtF2E2JzKueEqotdNodLN9pMYIV1zls+L67//jG/u
         xoPlNt5v+skxSHS0vpZkFQBHATuKkHMCQlajN1XsfVEGoLsRLLRm7gzU4BP+Xl7IH6LE
         tO1Uf6ZpLQS9OVUiIovh3fX6b0jMrc74GTVQ3v/YdeEuMoFFW63+Q8ZVEz0eDSCFn4vS
         KWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YbfRqziy2EWLEG1mQ1orqRox2rFRhwJnrGerYoys99Y=;
        b=KstKNHFOE/DY4pff3TeGX6w8+Iqkiz0JQnWTvo538zfDosxgHIkvpTGb0FaLTAIpZR
         riJLSq7EVGjHpXnl0e7OfddSg+OcKuJtCW6eQDriJRswO5WuxasWzfSXpxES0Rmcc4I0
         Fy31tDa5SkVFbrBJuycD3h41TZ+Zsx7qfPrqVosahTAH7qp0JJWKI57DMsV0yBZJe4+A
         K+TtxyKBxSVJK5OamuTu1fn+f/ZFlETbG7oFcANdc4nDDwg/cg9xcTf0XvTvhuXM+T+S
         0bB00SQpvgj5LPLPyMzO/atq1s2liZ43H/4e+JBvieuV9UIkrFp7QnlY2XTgWe7YHnZV
         yJ9A==
X-Gm-Message-State: AOUpUlFSIrxx/C1+xQjovqscMjoR5d4njqShkkoa9HFWEGSlIUyjasU2
        hXbM4QYW5gdEjVJ1zCbbBtrFrpa1zLfSLX2Lg/M=
X-Google-Smtp-Source: AA+uWPzn98/JroKsCy0eYX8oAl6jJzP+BFKuYv7QjOzpp/z26FVPWSKkLPL9InRvr7rW13gNi/7YAd82O+o9zvB0Fb4=
X-Received: by 2002:a1c:ce0b:: with SMTP id e11-v6mr23964143wmg.47.1534753028377;
 Mon, 20 Aug 2018 01:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <1534749606-7311-1-git-send-email-jianchao.w.wang@oracle.com> <1534749606-7311-3-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1534749606-7311-3-git-send-email-jianchao.w.wang@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 20 Aug 2018 16:16:55 +0800
Message-ID: <CACVXFVMxMf4Ag8CODJ_FPNrNTY-DhUZXV5JGLX-J4zexKF+qzg@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] blk-mq: sync the update nr_hw_queues with blk_mq_queue_tag_busy_iter
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
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

On Mon, Aug 20, 2018 at 3:18 PM Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
>
> For blk-mq, part_in_flight/rw will invoke blk_mq_in_flight/rw to
> account the inflight requests. It will access the queue_hw_ctx and
> nr_hw_queues w/o any protection. When updating nr_hw_queues and
> blk_mq_in_flight/rw occur concurrently, panic comes up.
>
> Before update nr_hw_queues, the q will be frozen. So we could use
> q_usage_counter to avoid the race. percpu_ref_is_zero is used here
> so that we will not miss any in-flight request. The access to
> nr_hw_queues and queue_hw_ctx in blk_mq_queue_tag_busy_iter are
> under rcu critical section, __blk_mq_update_nr_hw_queues could use
> synchronize_rcu to ensure the zeroed q_usage_counter to be globally
> visible.
>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq-tag.c | 14 +++++++++++++-
>  block/blk-mq.c     |  5 ++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index c0c4e63..8c5cc11 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -320,6 +320,18 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>         struct blk_mq_hw_ctx *hctx;
>         int i;
>
> +       /*
> +        * __blk_mq_update_nr_hw_queues will update the nr_hw_queues and
> +        * queue_hw_ctx after freeze the queue. So we could use q_usage_counter
> +        * to avoid race with it. __blk_mq_update_nr_hw_queues will users
> +        * synchronize_rcu to ensure all of the users go out of the critical
> +        * section below and see zeroed q_usage_counter.
> +        */
> +       rcu_read_lock();
> +       if (percpu_ref_is_zero(&q->q_usage_counter)) {
> +               rcu_read_unlock();
> +               return;
> +       }
>
>         queue_for_each_hw_ctx(q, hctx, i) {
>                 struct blk_mq_tags *tags = hctx->tags;
> @@ -335,7 +347,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>                         bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
>                 bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
>         }
> -
> +       rcu_read_unlock();
>  }
>
>  static int bt_alloc(struct sbitmap_queue *bt, unsigned int depth,
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7b99477..fb56bae 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2905,7 +2905,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>
>         list_for_each_entry(q, &set->tag_list, tag_set_list)
>                 blk_mq_freeze_queue(q);
> -
> +       /*
> +        * Sync with blk_mq_in_flight and blk_mq_queue_tag_busy_iter.
> +        */
> +       synchronize_rcu();
>         /*
>          * switch io scheduler to NULL to clean up the data in it.
>          * will get it back after update mapping between cpu and hw queues.
> --
> 2.7.4
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
