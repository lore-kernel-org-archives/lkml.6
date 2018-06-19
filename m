Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAA3C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D4C20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n2QCwGW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D4C20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030378AbeFSRtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:49:49 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41144 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966706AbeFSRtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:49:47 -0400
Received: by mail-pg0-f67.google.com with SMTP id l65-v6so199816pgl.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cNZhovn4LHmrOHz7BZE1vj01ZM4bN3C2mny8LpDzaOs=;
        b=n2QCwGW40hfZ+aaKJSNQMh1+zOAWJDEgWVbY1moEb5qvzDcB5TVzGEKFwz1lWkY9uw
         icAwyggfIIl3A/qme58cljJ0HgBtX+eURwVY2mXJpqS9qxleC7m/W+MZW9YMCaWvW9u5
         +KEx1ulbT7ND+e9ZKg1oK+o2yjcdhV7mKxUzDjA7ic4cr6lkoC4wC18RRqUWSrkeJbXx
         hPGckno6WGosWCTEcjme47P7yBGucKLi34jgwnmt3YgAFJBiodIYHeqjLVTUjppDI5Td
         5ozfNzXpDkKclYU+RvNCIwEpTs3igaf2cffScds8PFRh2EV7tjdFvW9Y4nYOORMAms0n
         3GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=cNZhovn4LHmrOHz7BZE1vj01ZM4bN3C2mny8LpDzaOs=;
        b=OlWy2CYUkohbnxQh0dyjWROBI+zaSdpvJs3jQsckJ5GAWKgvbSH0hIFz4igX2FdDuY
         zT3HdwgB3tpThOzP1zfBDfnJOaho7qKbLy+I7E1Vb80gGdy6XTNwat8DL9JRlCgBGTkO
         qaAu4BmBQ5TVKyGBy/RQnOjkfKFVxvOV9FNbXMUNrqNRUXayyjjqvjARo+9s0BoktLo9
         nNTmIqA4CyClVKQI/ZEg995nk6nbt/oBdn8dGG8XqnrYXkwpqvuP3naMkxsi3fNweole
         AgEuw1Wz4XWr0F23gVwa2jpMokVBwM7BaVx7nUurRE40h1lZ+J4s0JinTuE5J69lJxov
         RtpA==
X-Gm-Message-State: APt69E3+x5D/B1CG+O2t1ni2IYWjHTbLhKQHehXNX4a1DgSNMYzzXDgW
        b43QjDPT5G/KsbfUThkJoytG9NLfan4=
X-Google-Smtp-Source: ADUXVKK1cVPdIjiUS2mjbm5u7oUSywxsLrlraMvBUWDZRJ3TpN9COnqolmXmHgW+CkPxQvGf+s/8BA==
X-Received: by 2002:a65:4ecd:: with SMTP id w13-v6mr15874633pgq.214.1529430586252;
        Tue, 19 Jun 2018 10:49:46 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cb:201:549c:c572:5008:d36f])
        by smtp.gmail.com with ESMTPSA id v13-v6sm411311pfa.131.2018.06.19.10.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 10:49:44 -0700 (PDT)
From:   bsegall@google.com
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     bsegall@google.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/fair: Advance global expiration when period timer is restarted
References: <20180618091657.21939-1-xlpang@linux.alibaba.com>
        <xm26o9g7q5ux.fsf@bsegall-linux.svl.corp.google.com>
        <5f5243c0-ff8c-fc11-9320-61313fd40214@linux.alibaba.com>
Date:   Tue, 19 Jun 2018 10:49:43 -0700
In-Reply-To: <5f5243c0-ff8c-fc11-9320-61313fd40214@linux.alibaba.com> (Xunlei
        Pang's message of "Tue, 19 Jun 2018 11:14:32 +0800")
Message-ID: <xm26k1qupsy0.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xunlei Pang <xlpang@linux.alibaba.com> writes:

> On 6/19/18 2:58 AM, bsegall@google.com wrote:
>> Xunlei Pang <xlpang@linux.alibaba.com> writes:
>> 
>>> I noticed the group frequently got throttled even it consumed
>>> low cpu usage, this caused some jitters on the response time
>>> to some of our business containers enabling cpu quota.
>>>
>>> It's very easy to reproduce:
>>> mkdir /sys/fs/cgroup/cpu/test
>>> cd /sys/fs/cgroup/cpu/test
>>> echo 100000 > cpu.cfs_quota_us
>>> echo $$ > tasks
>>> then repeat:
>>> cat cpu.stat |grep nr_throttled  // nr_throttled will increase
>>>
>>> After some analysis, we found that cfs_rq::runtime_remaining will
>>> be cleared by expire_cfs_rq_runtime() due to two equal but stale
>>> "cfs_{b|q}->runtime_expires" after period timer is re-armed.
>> 
>> If this is after the first patch, then this is no longer what should
>> happen, and instead it would incorrectly /keep/ old local cfs_rq
>> runtime, and not __refill global runtime until the period.
>
> Exactly, I can improve the changelog.
>
>> 
>> 
>>>
>>> The global expiration should be advanced accordingly when the
>>> bandwidth period timer is restarted.
>>>
>>> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
>>> ---
>>>  kernel/sched/fair.c | 15 ++++++++++-----
>>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 9f384264e832..bb006e671609 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -5204,13 +5204,18 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>>>  
>>>  void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>>>  {
>>> +	u64 overrun;
>>> +
>>>  	lockdep_assert_held(&cfs_b->lock);
>>>  
>>> -	if (!cfs_b->period_active) {
>>> -		cfs_b->period_active = 1;
>>> -		hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
>>> -		hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>>> -	}
>>> +	if (cfs_b->period_active)

>>> +		return;
>>> +
>>> +	cfs_b->period_active = 1;
>>> +	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
>>> +	cfs_b->runtime_expires += (overrun + 1) * ktime_to_ns(cfs_b->period);
>> 
>> I think we actually want if (overrun) __refill_cfs_bandwidth_runtime(),
>> much like tg_set_cfs_bandwidth
>
> It's a little different, e.g. periods like below:
>
>            Pm
>            |
>            v
>   |-----|-----|
> Pn-1   Pn    Pn+1
>
> Assuming we start_cfs_bandwidth() at some moment Pm between "Pn" and
> "Pn+1", cfs_b->runtime_expires we want here should be "Pn+1", while
> __refill_cfs_bandwidth_runtime() forces it to be "Pm+period"(hrtimer
> expires at "Pn+1").
>
> Regards,
> Xunlei
>

Hmm, yeah, it would wind up out of sync with the hrtimer unless we
restarted the period boundaries.

Now that I look at it even more closely, I don't see how you're getting
problems like that, besides wasting tiny amounts of cpu time in expire:
we only disable the period timer when there has been a full period with
no activity, so we should have a full cfs_b->runtime, and a
runtime_expires from the period that was spent entirely idle (so it
should always be in the past). But with a working extend-local-deadline
check like after patch 1 it shouldn't /matter/ what the actual value of
runtime_expires is, we'll just waste tiny amounts of cpu time
incrementing runtime_expires every account_cfs_rq_runtime call rather
than aborting early.

Actually, I think arguably the real issue may be in patch 1:

>> @@ -4637,8 +4640,10 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>>  	 * spread between our sched_clock and the one on which runtime was
>>  	 * issued.
>>  	 */
>> -	if ((s64)(expires - cfs_rq->runtime_expires) > 0)
>> +	if ((s64)(expires - cfs_rq->runtime_expires) > 0) {
>>  		cfs_rq->runtime_expires = expires;
>> +		cfs_rq->expires_seq = expires_seq;
>> +	}
>>  
>>  	return cfs_rq->runtime_remaining > 0;
>>  }


We don't want to clobber a tick-extended runtime_expires with the
original one, but we /do/ want update if expires_seq changes, no matter
what (rather than skipping updating both if we've tick-extended past the
/next/ period's runtime_expires).

I think this should actually be

if (cfs_rq->expires_seq != expires_seq) {
	cfs_rq->runtime_expires = expires;
	cfs_rq->expires_seq = expires_seq;
}

Can you easily check and see if this fixes the issue without this second
patch? That would clear up how the actual problem is happening, and I
think it's a change we'd want anyways.

That said, we should also just update runtime_expires like this patch
does regardless, and as mentioned we should have a full cfs_b->runtime
so we don't need a __refill like I was originally thinking.
