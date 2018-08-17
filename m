Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EDBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF70E218AA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1WRyy0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF70E218AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeHQMjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:39:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39208 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeHQMjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:39:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id q8-v6so6834345wmq.4;
        Fri, 17 Aug 2018 02:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wMwWlVrlKHKYNMUD3CZPTXR6rK2niEOr2FBgmRLjO28=;
        b=N1WRyy0Nx1FgZEAJK/gWxvqq4TEOWQV/M8UKYQEnNfdVtMoTq50OAhBmX2Asd8tGJa
         fut3GENl+hoLaKCCcLTsnRbBezYEDtOZ96WAC1uW33R4C+ztXuOeTXLDYd+r4GrqEbxm
         derlYdnfW88W62iyJf/e9QNunCuRdffDSCHQ1P9uNGgqrqpQ8e1X8qCnT6MlZP5793HW
         ndlIF2V+yNUtg9b3v7HLp8QgyHfMSgTgnTD/+6T8Iu5BD6MVH11fsjjqQGNhO3TlgUSq
         2wD4tUlvM9Au/XdJF58xu3DRbfgiYcsfIW+GCKTg/4Emm/LusUYl/Z8tI9i1RB46kgOA
         45hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wMwWlVrlKHKYNMUD3CZPTXR6rK2niEOr2FBgmRLjO28=;
        b=m0I5D/uGzCsM/isOu2QS2catua0O1hZeri2jingKp0YRlQMBGodEpC/1x9mJUExVtb
         gUFGwG2qTDk17BxOhKtsKZurgevRXd6qP8KNhTkv3cfwQ7TMh/gpDe7ttthvFfnVXVM2
         acxKDOxkVKGtvv8HidujBNFJefe3oLDPJu8vBzDHNP1MLj92a2rw1sSaggStYipWQ0kI
         /lGxniraMxOY0iotGibZ/fIkOR63I5MHTkLk/5wIVoopf0jci1b4lDiPM8lDFBOFURze
         yR5BvgJtpJ/ptteBkPxvsQeC29CrlZSeDuKsHwZNW15WK9JJ6gsHKYRTjmoDazCSyvFP
         zJRg==
X-Gm-Message-State: AOUpUlEiWLTTNBzHOHvn1wgHXIn7jZtPvgxN5BJVahx32WQ5OtIpYu/p
        7o5rjIuWFbeHlu42GYwMbK11rlTH3AnbGPouwe8=
X-Google-Smtp-Source: AA+uWPzGxJxm7f8WJx38q55pUF5o1m7xvdXfQ7feofQYoEzKL05cUeAz7zFwIYPDFhLZZ5kxS2BbFf4XTBCE1P2qnoA=
X-Received: by 2002:a1c:aa8f:: with SMTP id t137-v6mr17577907wme.54.1534498579807;
 Fri, 17 Aug 2018 02:36:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:32c1:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 02:36:19
 -0700 (PDT)
In-Reply-To: <1534478043-7170-3-git-send-email-jianchao.w.wang@oracle.com>
References: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com> <1534478043-7170-3-git-send-email-jianchao.w.wang@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 17 Aug 2018 17:36:19 +0800
Message-ID: <CACVXFVMBFwGngLWjf=oT+2=57xWgF38ozf0D3hc_RKOTXbRWVA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] blk-mq: sync the update nr_hw_queues with part_in_flight
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
> For blk-mq, part_in_flight/rw will invoke blk_mq_in_flight/rw to
> account the inflight requests. It will access the queue_hw_ctx and
> nr_hw_queues w/o any protection. When updating nr_hw_queues and
> blk_mq_in_flight/rw occur concurrently, panic comes up.
>
> Before update nr_hw_queues, the q will be frozen. So we could use
> q_usage_counter to avoid the race. percpu_ref_is_zero is used here
> so that we will not miss any in-flight request. And also both the
> check and blk_mq_queue_tag_busy_iter are under rcu critical section,
> then __blk_mq_update_nr_hw_queues could ensure the zeroed q_usage_counter
> to be globally visible.
>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index de7027f..9ec98bd 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -112,7 +112,22 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
>         struct mq_inflight mi = { .part = part, .inflight = inflight, };
>
>         inflight[0] = inflight[1] = 0;
> +
> +       /*
> +        * __blk_mq_update_nr_hw_queues will update the nr_hw_queues and
> +        * queue_hw_ctx after freeze the queue. So we could use q_usage_counter
> +        * to avoid race with it. __blk_mq_update_nr_hw_queues will use
> +        * synchronize_rcu to ensure all of the users of blk_mq_in_flight
> +        * go out of the critical section and see zeroed q_usage_counter.
> +        */
> +       rcu_read_lock();
> +       if (percpu_ref_is_zero(&q->q_usage_counter)) {
> +               rcu_read_unlock();
> +               return;
> +       }
> +
>         blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
> +       rcu_read_unlock();
>  }
>
>  static void blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
> @@ -131,7 +146,18 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
>         struct mq_inflight mi = { .part = part, .inflight = inflight, };
>
>         inflight[0] = inflight[1] = 0;
> +
> +       /*
> +        * See comment of blk_mq_in_flight.
> +        */
> +       rcu_read_lock();
> +       if (percpu_ref_is_zero(&q->q_usage_counter)) {
> +               rcu_read_unlock();
> +               return;
> +       }
> +
>         blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight_rw, &mi);
> +       rcu_read_unlock();

I'd suggest to put the rcu_* and percpu_ref_is_zero() into
blk_mq_queue_tag_busy_iter().


Thanks,
Ming Lei
