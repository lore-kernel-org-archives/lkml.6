Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20520C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD78B21764
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ9uQI0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD78B21764
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbeHMMIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:08:21 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33725 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbeHMMIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:08:20 -0400
Received: by mail-io0-f194.google.com with SMTP id z20-v6so14155707iol.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 02:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PBJdpxCkIB8O/KITji4TYLhR9mVkHsWzavn9fGPf9NE=;
        b=TZ9uQI0UT7m34azqYwpxISBpqznjkY+O7Lhg82SEMKh+bOv8q9LmF9DAn/Oy+x1c2D
         iNy0seC2MSVU7mEISAuX2LcrwvQ5l+Q43r10F/xKnQhra8PoZdMlQqmVGwsWoySkCwVw
         6c2zxyNegVPpTfqkHRu+SZCPwD07Ffwcb0PNV0FqRvvPMyrXbrUFdwB0q8CfV78gn41C
         2x0yM1H/HFZ2Ysp+Y6IsK5Xo/L1BN60OKZDBL0Fw8trnLF8K8sIN/HUvBeqiIJ57ZQqe
         ryI+k40ab1rs5xo4jexyoA5fIVaZHfWmLSYsT0z3GJLxLdJwX3f4p8b08knB7LIu1ZTn
         SASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PBJdpxCkIB8O/KITji4TYLhR9mVkHsWzavn9fGPf9NE=;
        b=ijIc9h8YVd55Lv1OAmAZqqEukOP1uP6eILHtOf7FTdqBVSky6i1jR+pBmJWjnF6SSb
         htsocTBSG9RA7FHBS9Rkx9aKOCV9DFyE5CRzmee5mGqcVQWdbxC5M/OocAPVcwz/WqDP
         C5TuGPW/nHMq2LNohwfLNQkXJt91Opu543JMzsECDeTTH8bGBuRdYiK8a9N9Ij/IoaOa
         I76NkGl3FwfzVXduLXEoOIPXdAUp2aVIkz+sa0SkSfRbhxc9ArTXAQGXgHnj7DXA/qOx
         dX8M7s61tFDwjFsldCR7ysdzq4w/sGVVkSa/EmUoEM1Hv1xh/2VlfSqnDVtfWJ+we7TR
         x1Iw==
X-Gm-Message-State: AOUpUlHENOuQ0zlF/MzK/mHp4x8dxfkniVuTHy7iAf6LrOriNXMBKeYe
        C0FjbHGS+vzcF1D9HXUrivFRSWg+
X-Google-Smtp-Source: AA+uWPwRUZ49UMVIVWVSG2nZOrrunwOQoHfNzKHVnuIJ4Lq9rPnGCIJxgCIWFwp7d8226aowqHvhKw==
X-Received: by 2002:a6b:6c17:: with SMTP id a23-v6mr3142069ioh.72.1534152415444;
        Mon, 13 Aug 2018 02:26:55 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.57? ([2402:f000:1:1501:200:5efe:a66f:4739])
        by smtp.gmail.com with ESMTPSA id r3-v6sm3360098ioo.11.2018.08.13.02.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 02:26:54 -0700 (PDT)
Subject: Re: [BUG] kernel: rcu: a possible sleep-in-atomic-context bug in
 srcu_read_delay()
To:     paulmck@linux.vnet.ibm.com
Cc:     dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4179b4d2-b832-abcd-d407-b865765f28d6@gmail.com>
 <20180813041826.GL24813@linux.vnet.ibm.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <5b3fd721-541c-5165-ef54-d6c476318d92@gmail.com>
Date:   Mon, 13 Aug 2018 17:26:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180813041826.GL24813@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/13 12:18, Paul E. McKenney wrote:
> On Mon, Aug 13, 2018 at 11:04:10AM +0800, Jia-Ju Bai wrote:
>> The kernel may sleep with holding a spinlock.
>>
>> The function call paths (from bottom to top) in Linux-4.16 are:
>>
>> [FUNC] schedule_timeout_interruptible
>> kernel/rcu/rcutorture.c, 523: schedule_timeout_interruptible in
>> srcu_read_delay
>> kernel/rcu/rcutorture.c, 1105: [FUNC_PTR]srcu_read_delay in
>> rcu_torture_timer
>> kernel/rcu/rcutorture.c, 1104: spin_lock in rcu_torture_timer
>>
>> Note that [FUNC_PTR] means a function pointer call is used.
>>
>> I do not find a good way to fix, so I only report.
>> This is found by my static analysis tool (DSAC).
> Interesting.  I would have expected to have gotten a "scheduling while
> atomic" error message, which I do not recall seeing.  And I ran a great
> deal of rcutorture on v4.16.
>
> So let's see...  As you say, the rcu_torture_timer() function does in
> fact acquire rand_lock in 4.16 and 4.17, in which case sleeping would
> indeed be illegal.  But let's take a look at srcu_read_delay():
>
> static void
> srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
> {
> 	long delay;
> 	const long uspertick = 1000000 / HZ;
> 	const long longdelay = 10;
>
> 	/* We want there to be long-running readers, but not all the time. */
>
> 	delay = torture_random(rrsp) %
> 		(nrealreaders * 2 * longdelay * uspertick);
> 	if (!delay && in_task()) {
> 		schedule_timeout_interruptible(longdelay);
> 		rtrsp->rt_delay_jiffies = longdelay;
> 	} else {
> 		rcu_read_delay(rrsp, rtrsp);
> 	}
> }
>
> The call to schedule_timeout_interruptible() cannot happen unless the
> in_task() macro returns true, which it won't if the SOFTIRQ_OFFSET bit
> is set:
>
> #define in_task()		(!(preempt_count() & \
> 				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
>
> And the SOFTIRQ_OFFSET bit will be set if srcu_read_delay()
> is invoked from a timer handler, which is the case for the
> call from rcu_torture_timer().  So if that lock is held,
> schedule_timeout_interruptible() won't ever be invoked.

Thanks for your reply :)
My tool does not track this bit...
Sorry for this false report.


Best wishes,
Jia-Ju Bai
