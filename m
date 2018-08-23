Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CD3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BBF2152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xbTPTTDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BBF2152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeHXCfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:35:21 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35881 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbeHXCfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:35:21 -0400
Received: by mail-it0-f65.google.com with SMTP id p16-v6so772874itp.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DKAkGS59uuIdBhei/pl5d8nBy+uPEWgCe4pAL4Y5qXw=;
        b=xbTPTTDhgcRMmGGN/GLY86oD2SiIQYFJ97E7gquC6AXDB+m/ArpvbAlgxY5guO8nvT
         btzz/BrjH4bLiG6jPR7cSklkUYNPT2PPgbXj6TZdN2gnK3q037Z0IsTgaBOv58NZNmAT
         y6BOTMOinOAimBMSD1N7KIWRWHp1JvqBgVl1RpBPOv3OX6IfD+HeNgXDN/aAbwNc+R0C
         qLrIifvOhuSMeOdE1XqSJn18xDKH9DSCR2Hvk5D01W2Qb8KO/Cnj+g5IATjGuHIUZJyl
         bkRNx28FXyvTdZzQ887ryBZPY7nMUpNswx1K4tL4VD58kh0n9AA0X+uu22mBUMmGpSZC
         5YyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DKAkGS59uuIdBhei/pl5d8nBy+uPEWgCe4pAL4Y5qXw=;
        b=V1MrjIVfSqHVL9lekkhrgeI8riWvz8krNjP0CyF/fKtGfIqwqxAMuGdy/T1B41Q3HC
         RlWRKblXG27u+ChkBuwz9GD6sYUoqjoQLL+rbd7bmbi3NCcuX/RuqRRzLrJxom1BSoT/
         F55bBV+AEQQULrSdihyU5dXldTPqRRq9hgL/S/yNehTLxfV45S3riP6ivyxTtiChxMa3
         /2ghsFkhW3hVVDVm/d1apXfppH8rcZhkUDPEiZ/yjZ1rOhiqHXqF/3NWGCfKLMG6YJ82
         41k/D5b9oaHUEwnLsZnort+72Vc6aoKhtTKtiU90ECKf4vm6DoGhaJZSzziCXWQs9Vgf
         ed9g==
X-Gm-Message-State: APzg51BVwNMtA784brauEW7PS3WgNwHtYipngbMZ9HItGC9/SxeAez0O
        G4Dx0nrStB/9O5PdN2/hY1Qk4E1HFvo=
X-Google-Smtp-Source: ANB0Vdau5QejwO3arDvf2y5dXFccQFsyRDxlX+kRCW6rpZdM7L9iXs8LudSFx8EhCHKsIntKgVMoYw==
X-Received: by 2002:a24:67cf:: with SMTP id u198-v6mr8147649itc.149.1535065408010;
        Thu, 23 Aug 2018 16:03:28 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id i26-v6sm1821532ioj.33.2018.08.23.16.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 16:03:26 -0700 (PDT)
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To:     Anchal Agarwal <anchalag@amzn.com>,
        "van der Linden, Frank" <fllinden@amazon.com>,
        jianchao.w.wang@oracle.com
Cc:     "mlinux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
Date:   Thu, 23 Aug 2018 17:03:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/18 3:01 PM, Anchal Agarwal wrote:
> On Thu, Aug 23, 2018 at 10:24:00AM -0600, van der Linden, Frank wrote:
>> On 8/23/18 8:37 AM, Jens Axboe wrote:
>>> On 8/23/18 7:08 AM, Jianchao Wang wrote:
>>>> 2887e41 (blk-wbt: Avoid lock contention and thundering herd
>>>> issue in wbt_wait) introduces two cases that could miss wakeup:
>>>>  - __wbt_done only wakes up one waiter one time. There could be
>>>>    multiple waiters and (limit - inflight) > 1 at the moment.
>>>>
>>>>  - When the waiter is waked up, it is still on wait queue and set
>>>>    to TASK_UNINTERRUPTIBLE immediately, so this waiter could be
>>>>    waked up one more time. If a __wbt_done comes and wakes up
>>>>    again, the prevous waiter may waste a wakeup.
>>>>
>>>> To fix them and avoid to introduce too much lock contention, we
>>>> introduce our own wake up func wbt_wake_function in __wbt_wait and
>>>> use wake_up_all in __wbt_done. wbt_wake_function will try to get
>>>> wbt budget firstly, if sucesses, wake up the process, otherwise,
>>>> return -1 to interrupt the wake up loop.
>>> I really like this approach, since it'll naturally wake up as many
>>> as we can instead of either being single wakeups, or wake all.
>>>
>>> BTW, you added Anchal and Frank to the CC in the patch, but they 
>>> are not actually CC'ed. Doing that now - can you guys give this
>>> a whirl? Should still solve the thundering herd issue, but be
>>> closer to the original logic in terms of wakeup. Actually better,
>>> since we remain on list and remain ordered.
>>>
>>> Leaving the patch below for you guys.
>>>
>>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>>> Fixes: 2887e41 (blk-wbt: Avoid lock contention and thundering herd issue in wbt_wait)
>>>> Cc: Anchal Agarwal <anchalag@amazon.com>
>>>> Cc: Frank van der Linden <fllinden@amazon.com>
>>>> ---
>>>>  block/blk-wbt.c | 78 +++++++++++++++++++++++++++++++++++++++------------------
>>>>  1 file changed, 54 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
>>>> index c9358f1..2667590 100644
>>>> --- a/block/blk-wbt.c
>>>> +++ b/block/blk-wbt.c
>>>> @@ -166,7 +166,7 @@ static void __wbt_done(struct rq_qos *rqos, enum wbt_flags wb_acct)
>>>>  		int diff = limit - inflight;
>>>>  
>>>>  		if (!inflight || diff >= rwb->wb_background / 2)
>>>> -			wake_up(&rqw->wait);
>>>> +			wake_up_all(&rqw->wait);
>>>>  	}
>>>>  }
>>>>  
>>>> @@ -481,6 +481,40 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
>>>>  	return limit;
>>>>  }
>>>>  
>>>> +struct wbt_wait_data {
>>>> +	struct task_struct *curr;
>>>> +	struct rq_wb *rwb;
>>>> +	struct rq_wait *rqw;
>>>> +	unsigned long rw;
>>>> +};
>>>> +
>>>> +static int wbt_wake_function(wait_queue_entry_t *curr, unsigned int mode,
>>>> +		int wake_flags, void *key)
>>>> +{
>>>> +	struct wbt_wait_data *data = curr->private;
>>>> +
>>>> +	/*
>>>> +	 * If fail to get budget, return -1 to interrupt the wake up
>>>> +	 * loop in __wake_up_common.
>>>> +	 */
>>>> +	if (!rq_wait_inc_below(data->rqw, get_limit(data->rwb, data->rw)))
>>>> +		return -1;
>>>> +
>>>> +	wake_up_process(data->curr);
>>>> +
>>>> +	list_del_init(&curr->entry);
>>>> +	return 1;
>>>> +}
>>>> +
>>>> +static inline void wbt_init_wait(struct wait_queue_entry *wait,
>>>> +		struct wbt_wait_data *data)
>>>> +{
>>>> +	INIT_LIST_HEAD(&wait->entry);
>>>> +	wait->flags = 0;
>>>> +	wait->func = wbt_wake_function;
>>>> +	wait->private = data;
>>>> +}
>>>> +
>>>>  /*
>>>>   * Block if we will exceed our limit, or if we are currently waiting for
>>>>   * the timer to kick off queuing again.
>>>> @@ -491,31 +525,27 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
>>>>  	__acquires(lock)
>>>>  {
>>>>  	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
>>>> -	DECLARE_WAITQUEUE(wait, current);
>>>> -	bool has_sleeper;
>>>> -
>>>> -	has_sleeper = wq_has_sleeper(&rqw->wait);
>>>> -	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
>>>> +	struct wait_queue_entry wait;
>>>> +	struct wbt_wait_data data = {
>>>> +		.curr = current,
>>>> +		.rwb = rwb,
>>>> +		.rqw = rqw,
>>>> +		.rw = rw,
>>>> +	};
>>>> +
>>>> +	if (!wq_has_sleeper(&rqw->wait) &&
>>>> +			rq_wait_inc_below(rqw, get_limit(rwb, rw)))
>>>>  		return;
>>>>  
>>>> -	add_wait_queue_exclusive(&rqw->wait, &wait);
>>>> -	do {
>>>> -		set_current_state(TASK_UNINTERRUPTIBLE);
>>>> -
>>>> -		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
>>>> -			break;
>>>> -
>>>> -		if (lock) {
>>>> -			spin_unlock_irq(lock);
>>>> -			io_schedule();
>>>> -			spin_lock_irq(lock);
>>>> -		} else
>>>> -			io_schedule();
>>>> -		has_sleeper = false;
>>>> -	} while (1);
>>>> -
>>>> -	__set_current_state(TASK_RUNNING);
>>>> -	remove_wait_queue(&rqw->wait, &wait);
>>>> +	wbt_init_wait(&wait, &data);
>>>> +	prepare_to_wait_exclusive(&rqw->wait, &wait,
>>>> +			TASK_UNINTERRUPTIBLE);
>>>> +	if (lock) {
>>>> +		spin_unlock_irq(lock);
>>>> +		io_schedule();
>>>> +		spin_lock_irq(lock);
>>>> +	} else
>>>> +		io_schedule();
>>>>  }
>>>>  
>>>>  static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)
>>>>
>>>
>> I like it, this combines some of the ideas outlined in our previous
>> thread in to a good solution.
>>
>> One comment, though: I think we need to set the task state back to
>> TASK_RUNNING after being woken up, right?
>>
>> Frank
>>
>>
> 
> Hi Jens,
> This patch looks much cleaner for sure as Frank pointed out too. Basically this looks similar
> to wake_up_nr only making sure that those woken up requests won't get reordered. This does 
> solves the thundering herd issue. However, I tested the patch against my application and 
> lock contention numbers rose to around 10 times from what I had from your last 3 patches. 
> Again this did add to drop in of total files read by 0.12% and rate at which they were read by
> 0.02% but this is not a very significant drop. Is lock contention worth the tradeoff?
> I also added missing  __set_current_state(TASK_RUNNING) to the patch for testing.

Can you try this variant? I don't think we need a __set_current_state() after
io_schedule(), should be fine as-is.

I'm not surprised this will raise contention a bit, since we're now waking N tasks
potentially, if N can queue. With the initial change, we'd always just wake one.
That is arguably incorrect. You say it's 10 times higher contention, how does
that compare to before your patch?

Is it possible to run something that looks like your workload?


diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 84507d3e9a98..00a57aa160b8 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -166,7 +166,7 @@ static void __wbt_done(struct rq_qos *rqos, enum wbt_flags wb_acct)
 		int diff = limit - inflight;
 
 		if (!inflight || diff >= rwb->wb_background / 2)
-			wake_up(&rqw->wait);
+			wake_up_all(&rqw->wait);
 	}
 }
 
@@ -481,6 +481,40 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
 	return limit;
 }
 
+struct wbt_wait_data {
+	struct task_struct *curr;
+	struct rq_wb *rwb;
+	struct rq_wait *rqw;
+	unsigned long rw;
+};
+
+static int wbt_wake_function(wait_queue_entry_t *curr, unsigned int mode,
+		int wake_flags, void *key)
+{
+	struct wbt_wait_data *data = curr->private;
+
+	/*
+	 * If fail to get budget, return -1 to interrupt the wake up
+	 * loop in __wake_up_common.
+	 */
+	if (!rq_wait_inc_below(data->rqw, get_limit(data->rwb, data->rw)))
+		return -1;
+
+	wake_up_process(data->curr);
+
+	list_del_init(&curr->entry);
+	return 1;
+}
+
+static inline void wbt_init_wait(struct wait_queue_entry *wait,
+				 struct wbt_wait_data *data)
+{
+	INIT_LIST_HEAD(&wait->entry);
+	wait->flags = 0;
+	wait->func = wbt_wake_function;
+	wait->private = data;
+}
+
 /*
  * Block if we will exceed our limit, or if we are currently waiting for
  * the timer to kick off queuing again.
@@ -491,31 +525,33 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 	__acquires(lock)
 {
 	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
-	DECLARE_WAITQUEUE(wait, current);
+	struct wait_queue_entry wait;
+	struct wbt_wait_data data = {
+		.curr = current,
+		.rwb = rwb,
+		.rqw = rqw,
+		.rw = rw,
+	};
 	bool has_sleeper;
 
 	has_sleeper = wq_has_sleeper(&rqw->wait);
 	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
 		return;
 
-	add_wait_queue_exclusive(&rqw->wait, &wait);
-	do {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+	wbt_init_wait(&wait, &data);
+	prepare_to_wait_exclusive(&rqw->wait, &wait, TASK_UNINTERRUPTIBLE);
 
-		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
-			break;
+	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw))) {
+		finish_wait(&rqw->wait, &wait);
+		return;
+	}
 
-		if (lock) {
-			spin_unlock_irq(lock);
-			io_schedule();
-			spin_lock_irq(lock);
-		} else
-			io_schedule();
-		has_sleeper = false;
-	} while (1);
-
-	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&rqw->wait, &wait);
+	if (lock) {
+		spin_unlock_irq(lock);
+		io_schedule();
+		spin_lock_irq(lock);
+	} else
+		io_schedule();
 }
 
 static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)

-- 
Jens Axboe

