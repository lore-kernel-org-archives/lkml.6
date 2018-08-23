Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A275C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FDD208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GF0eLVZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FDD208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbeHWTH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:07:28 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38267 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeHWTH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:07:28 -0400
Received: by mail-it0-f68.google.com with SMTP id p129-v6so6455780ite.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uZT+MTjSC3CvC3jlZ4jG2rQhh3+JG2Qc933rA4rI6WQ=;
        b=GF0eLVZaC7zKcMIUKH59zYNO82QfJB0kcaRqxHgAxeaPC8Is8g2prepOAr0wb0BBNW
         eqQos4ycc7OYL0lId3K/Tuk9l7GODB/F6IzM/JKHfPbXCk4fBq28ffSd8JiWvU7Rc4Cx
         qaFaQe69L+vOT21T4jTG4yO4v5D8A7WAX3xovamMD0G3Yhdo6tWMujhkKb+vKcFGvB7R
         UsVy0LMKNl0SHvctizMT5m+GT5kd4PKPbL+xhBdq7sfYlONUDZUNTcV8k19dkjiYr/AF
         gGcTkLUjqZngwTUDsKh7H6IPdoOObsACoQqRyfxhnAP+3HlbZhFZHiJPfIcTxsWhfgTU
         eNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uZT+MTjSC3CvC3jlZ4jG2rQhh3+JG2Qc933rA4rI6WQ=;
        b=c+3rNAP9NsaHQThmA2sGcanhRvDdy+UuDCsUf/IW8/tebQUgdUiWbfpieIm1SWa95v
         V9vr90OA4RHBFOfiMQZBGmmdy28u8idKez9XihBoOFXWJhfzvGeqkkIOiDteXZ9krnmG
         dwMdElYNnKNODmIET8ER1i9OG/ZzSIkznf/P7ls0xJa1sB+O5ioI/TW+eLn1MnjXLoCk
         ePTTL6ZaOxeFpgIAV1PmwUH4FT6t1BawL8YcWq/GQi0/Sm+2vdRxtbBaqDSp1+5DkaQW
         hjtFG2m3JXDRtqjh8riuPuD062gOfJlJDDwWHp4FQnJ4BDRtPVdLjAyyZMOAW3XKIyKQ
         l3NA==
X-Gm-Message-State: AOUpUlE0fdc0kqXqjGbGQmJEy4O1iZhg2JnKXj5DYnP/BGq9dpKu+het
        4yADeULAVHmUZtDQFguIrBGZYw==
X-Google-Smtp-Source: AA+uWPzD+aeady3vhPE7PfFzyD4eOGJlZdDQg1K/IkRiYq4Dr0QYf4ujQjJXUJXCdy/IGX05w149QA==
X-Received: by 2002:a02:54c7:: with SMTP id t190-v6mr15787496jaa.92.1535038636482;
        Thu, 23 Aug 2018 08:37:16 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r18-v6sm2558301iob.16.2018.08.23.08.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 08:37:15 -0700 (PDT)
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        anchalag@amazon.com, van der Linden <fllinden@amazon.com>,
        Frank <fllinden@amazon.com>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
Date:   Thu, 23 Aug 2018 09:37:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/18 7:08 AM, Jianchao Wang wrote:
> 2887e41 (blk-wbt: Avoid lock contention and thundering herd
> issue in wbt_wait) introduces two cases that could miss wakeup:
>  - __wbt_done only wakes up one waiter one time. There could be
>    multiple waiters and (limit - inflight) > 1 at the moment.
> 
>  - When the waiter is waked up, it is still on wait queue and set
>    to TASK_UNINTERRUPTIBLE immediately, so this waiter could be
>    waked up one more time. If a __wbt_done comes and wakes up
>    again, the prevous waiter may waste a wakeup.
> 
> To fix them and avoid to introduce too much lock contention, we
> introduce our own wake up func wbt_wake_function in __wbt_wait and
> use wake_up_all in __wbt_done. wbt_wake_function will try to get
> wbt budget firstly, if sucesses, wake up the process, otherwise,
> return -1 to interrupt the wake up loop.

I really like this approach, since it'll naturally wake up as many
as we can instead of either being single wakeups, or wake all.

BTW, you added Anchal and Frank to the CC in the patch, but they 
are not actually CC'ed. Doing that now - can you guys give this
a whirl? Should still solve the thundering herd issue, but be
closer to the original logic in terms of wakeup. Actually better,
since we remain on list and remain ordered.

Leaving the patch below for you guys.

> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> Fixes: 2887e41 (blk-wbt: Avoid lock contention and thundering herd issue in wbt_wait)
> Cc: Anchal Agarwal <anchalag@amazon.com>
> Cc: Frank van der Linden <fllinden@amazon.com>
> ---
>  block/blk-wbt.c | 78 +++++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 54 insertions(+), 24 deletions(-)
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index c9358f1..2667590 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -166,7 +166,7 @@ static void __wbt_done(struct rq_qos *rqos, enum wbt_flags wb_acct)
>  		int diff = limit - inflight;
>  
>  		if (!inflight || diff >= rwb->wb_background / 2)
> -			wake_up(&rqw->wait);
> +			wake_up_all(&rqw->wait);
>  	}
>  }
>  
> @@ -481,6 +481,40 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
>  	return limit;
>  }
>  
> +struct wbt_wait_data {
> +	struct task_struct *curr;
> +	struct rq_wb *rwb;
> +	struct rq_wait *rqw;
> +	unsigned long rw;
> +};
> +
> +static int wbt_wake_function(wait_queue_entry_t *curr, unsigned int mode,
> +		int wake_flags, void *key)
> +{
> +	struct wbt_wait_data *data = curr->private;
> +
> +	/*
> +	 * If fail to get budget, return -1 to interrupt the wake up
> +	 * loop in __wake_up_common.
> +	 */
> +	if (!rq_wait_inc_below(data->rqw, get_limit(data->rwb, data->rw)))
> +		return -1;
> +
> +	wake_up_process(data->curr);
> +
> +	list_del_init(&curr->entry);
> +	return 1;
> +}
> +
> +static inline void wbt_init_wait(struct wait_queue_entry *wait,
> +		struct wbt_wait_data *data)
> +{
> +	INIT_LIST_HEAD(&wait->entry);
> +	wait->flags = 0;
> +	wait->func = wbt_wake_function;
> +	wait->private = data;
> +}
> +
>  /*
>   * Block if we will exceed our limit, or if we are currently waiting for
>   * the timer to kick off queuing again.
> @@ -491,31 +525,27 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
>  	__acquires(lock)
>  {
>  	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
> -	DECLARE_WAITQUEUE(wait, current);
> -	bool has_sleeper;
> -
> -	has_sleeper = wq_has_sleeper(&rqw->wait);
> -	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
> +	struct wait_queue_entry wait;
> +	struct wbt_wait_data data = {
> +		.curr = current,
> +		.rwb = rwb,
> +		.rqw = rqw,
> +		.rw = rw,
> +	};
> +
> +	if (!wq_has_sleeper(&rqw->wait) &&
> +			rq_wait_inc_below(rqw, get_limit(rwb, rw)))
>  		return;
>  
> -	add_wait_queue_exclusive(&rqw->wait, &wait);
> -	do {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> -
> -		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
> -			break;
> -
> -		if (lock) {
> -			spin_unlock_irq(lock);
> -			io_schedule();
> -			spin_lock_irq(lock);
> -		} else
> -			io_schedule();
> -		has_sleeper = false;
> -	} while (1);
> -
> -	__set_current_state(TASK_RUNNING);
> -	remove_wait_queue(&rqw->wait, &wait);
> +	wbt_init_wait(&wait, &data);
> +	prepare_to_wait_exclusive(&rqw->wait, &wait,
> +			TASK_UNINTERRUPTIBLE);
> +	if (lock) {
> +		spin_unlock_irq(lock);
> +		io_schedule();
> +		spin_lock_irq(lock);
> +	} else
> +		io_schedule();
>  }
>  
>  static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)
> 


-- 
Jens Axboe

