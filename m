Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC1316256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA8A204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eClbq9tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA8A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeG3TJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:09:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38395 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeG3TJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:09:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3-v6so7624332pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1/EQT1hoT1PZaVTH5tvePBWVHcfju6zYpJ72teddfJM=;
        b=eClbq9tmmBbUp84f52E77+oY5leNKZw7bMvowXS/PJqVX1oJMv9gb2AV/pjgE880Vq
         AXfai6aZhdmeehhS4eYSw+5R7mZaROO7eiNKz3vse78kcbUyGF2S8bq4/kgLdF4qMNOs
         U8VGvxchFCv1xFuNo1cdsfDPHVvvj5EtORIKTF0AfbFz3VwqZ/AvZyAH/aom2ZrXJcI3
         Hnv3uO0T5o11YgRTqQlznnIvl4c/R8UQWcu3kXYiy2VzSv9QB71+z3n3gqt9JghtB4HN
         fg4wKQHJn/9mcJ6fUle0JLCiV4NpDkLXhIyJ8CshVD7oxFmSMDYfOXRU8YCphaTAkMrC
         nSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=1/EQT1hoT1PZaVTH5tvePBWVHcfju6zYpJ72teddfJM=;
        b=erFtbrenpZWDJOmOVJfTEvSonsGwV7xt1FLo6xYXfTJPuODJrbw4YZW5XdbrvcAh4O
         RudN/lVh2PXwVl425lMRyqZioeLg6Vy1tLzzOtaPUkhqOWcAPX83m8OhmGMEyyEgqr3V
         +BxXI5qXiVFf+X2Y1+pRdmkRmjt1ZbLWkjjF2AfHe2r3g+f6SztR4Uq5gLW5VBexb1sc
         EJPRmjDaigy3ATRrCpoUrnzKyETNUGrF6Br4ZSSROpJrlYNQYWIpaORcLbJ1sWOqW0NV
         cJOtJQlwFLaDVpolarA5a++nbs/l/vlHR/UGVUi8QnrAsZBycIoJKx4XfKYIByZJ3KRM
         9WyQ==
X-Gm-Message-State: AOUpUlHASbF1IRjowsCBEcyI+ON5ZHah1KVaR5pq0KJEmQwoABOCDL7l
        hI2f4/9a1VZGcl61OQaIiWnweQ==
X-Google-Smtp-Source: AAOMgpdfXA6kDnooeQKHF+GB3Fpk8qcuMrqLVrulyhNV7CuK4+dk5W2CVONvxbu2bHy2hRduNNRKIw==
X-Received: by 2002:a65:450a:: with SMTP id n10-v6mr16783392pgq.392.1532971982036;
        Mon, 30 Jul 2018 10:33:02 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cb:201:549c:c572:5008:d36f])
        by smtp.gmail.com with ESMTPSA id w16-v6sm29314113pfi.101.2018.07.30.10.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:33:00 -0700 (PDT)
From:   bsegall@google.com
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org,
        Ben Segall <bsegall@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/fair: sync expires_seq in distribute_cfs_runtime()
References: <20180728002409.5781-1-xiyou.wangcong@gmail.com>
        <ef0e1185-51d6-0707-cda4-6f2ea987b651@linux.alibaba.com>
Date:   Mon, 30 Jul 2018 10:32:58 -0700
In-Reply-To: <ef0e1185-51d6-0707-cda4-6f2ea987b651@linux.alibaba.com> (Xunlei
        Pang's message of "Mon, 30 Jul 2018 13:28:51 +0800")
Message-ID: <xm26k1pc8w8l.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xunlei Pang <xlpang@linux.alibaba.com> writes:

> Hi Cong,
>
> On 7/28/18 8:24 AM, Cong Wang wrote:
>> Each time we sync cfs_rq->runtime_expires with cfs_b->runtime_expires,
>> we should sync its ->expires_seq too. However it is missing
>> for distribute_cfs_runtime(), especially the slack timer call path.
>
> I don't think it's a problem, as expires_seq will get synced in
> assign_cfs_rq_runtime().
>
> Thanks,
> Xunlei

It does seem unlikely to actually come up since the cfs_rq would have to
not run until the period was expired-locally-but-not-globally, but
there's no reason to not fix it.


>
>> 
>> Fixes: 512ac999d275 ("sched/fair: Fix bandwidth timer clock drift condition")
>> Cc: Xunlei Pang <xlpang@linux.alibaba.com>
>> Cc: Ben Segall <bsegall@google.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
>> ---
>>  kernel/sched/fair.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 2f0a0be4d344..910c50db3d74 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4857,7 +4857,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>>  }
>>  
>>  static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
>> -		u64 remaining, u64 expires)
>> +		u64 remaining, u64 expires, int expires_seq)
>>  {
>>  	struct cfs_rq *cfs_rq;
>>  	u64 runtime;
>> @@ -4880,6 +4880,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
>>  
>>  		cfs_rq->runtime_remaining += runtime;
>>  		cfs_rq->runtime_expires = expires;
>> +		cfs_rq->expires_seq = expires_seq;
>>  
>>  		/* we check whether we're throttled above */
>>  		if (cfs_rq->runtime_remaining > 0)
>> @@ -4905,7 +4906,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
>>  static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
>>  {
>>  	u64 runtime, runtime_expires;
>> -	int throttled;
>> +	int throttled, expires_seq;
>>  
>>  	/* no need to continue the timer with no bandwidth constraint */
>>  	if (cfs_b->quota == RUNTIME_INF)
>> @@ -4933,6 +4934,7 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
>>  	cfs_b->nr_throttled += overrun;
>>  
>>  	runtime_expires = cfs_b->runtime_expires;
>> +	expires_seq = cfs_b->expires_seq;
>>  
>>  	/*
>>  	 * This check is repeated as we are holding onto the new bandwidth while
>> @@ -4946,7 +4948,7 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
>>  		raw_spin_unlock(&cfs_b->lock);
>>  		/* we can't nest cfs_b->lock while distributing bandwidth */
>>  		runtime = distribute_cfs_runtime(cfs_b, runtime,
>> -						 runtime_expires);
>> +						 runtime_expires, expires_seq);
>>  		raw_spin_lock(&cfs_b->lock);
>>  
>>  		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
>> @@ -5055,6 +5057,7 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>>  static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>>  {
>>  	u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
>> +	int expires_seq;
>>  	u64 expires;
>>  
>>  	/* confirm we're still not at a refresh boundary */
>> @@ -5068,12 +5071,13 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>>  		runtime = cfs_b->runtime;
>>  
>>  	expires = cfs_b->runtime_expires;
>> +	expires_seq = cfs_b->expires_seq;
>>  	raw_spin_unlock(&cfs_b->lock);
>>  
>>  	if (!runtime)
>>  		return;
>>  
>> -	runtime = distribute_cfs_runtime(cfs_b, runtime, expires);
>> +	runtime = distribute_cfs_runtime(cfs_b, runtime, expires, expires_seq);
>>  
>>  	raw_spin_lock(&cfs_b->lock);
>>  	if (expires == cfs_b->runtime_expires)
>> 
