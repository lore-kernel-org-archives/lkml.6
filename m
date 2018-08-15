Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E89C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3468121727
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXU3vAcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3468121727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeHODzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 23:55:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43549 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeHODzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 23:55:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so10012127pfi.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 18:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tz7ZefK1LbrDSKn0DwrEqUV/sh3GPJSqGEK8Q3VVW7I=;
        b=CXU3vAcPGAzUXqQmT2LIrvWhitStQpx+kZjFaAE87N59mwFnNqtFUwHajYnqtkHCBw
         2uQaN0k9HjnyT2e+2QKdYvZ2y+2KfeZw+mpYeFuzirkTED6n8MNV4nTW+lkmEcZswQf1
         rOaby8E2K6sBH1s5EsWrMd/6TWLnX29BUiOrGPprpGIRUONyatVw0PyBIhdZCH4ENqQQ
         adyAdDy5kiO6/BqVN+7KJYil4mDEp8nikXDwU+R701g0h1RJ753mBRTomRbFY7eu2z/Y
         irpzl+XdUvf2CHsF/kfF+3Yghs+T35+/RT9kKlOrXlrBKNICs6EnOHdfwNtY4WMrWKGA
         JYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tz7ZefK1LbrDSKn0DwrEqUV/sh3GPJSqGEK8Q3VVW7I=;
        b=m8Sy/XoCo0yOFsDq6fHm0uINj5mjAe6tQc/CG5V8rWg/D/tVyVpwoPtzvcYnkDcBtT
         fK50tievlKqFxd/CEFI1c0t/D3US1YIfW1UQ5M4xsyUQc59l6jOv43wzUXCH0D52Rdq3
         oiZtOBHFu9zf4H7neuC21D8cJS7rD9QGirA6ASRcMK29zDe6KJuXiiJ+dFB0xPSoA2XD
         4SQtgu9007zHVmDy3QG66hCyUZVuZS1qHL/1rOjZuCLk/WuwX0qVB7a0/9ZQZ7t+KXxq
         a9anPk4bzccqp7Zq2w9Udo8+IKTFQBoesxlBq0qArkUOkULbpehBYAvioRTJxpLOZBOp
         Ur/g==
X-Gm-Message-State: AOUpUlHVtj8ViSq2H9AHjv3vSWjwN6bKlitj2PeCkkKABd7Pqb2tTBcc
        Kce8bKI6vkc1C9VePflNTj+LW+IM
X-Google-Smtp-Source: AA+uWPxdp/J0jiBxkmXAQAVIsAW/MOp8Q42nxoESDpgdQrxilpiZxzIPZBnpjcCDXs+zBvHRn8gvlg==
X-Received: by 2002:a62:3306:: with SMTP id z6-v6mr25054727pfz.85.1534295121572;
        Tue, 14 Aug 2018 18:05:21 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.57? ([2402:f000:1:1501:200:5efe:a66f:4739])
        by smtp.gmail.com with ESMTPSA id n9-v6sm36718418pfg.21.2018.08.14.18.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 18:05:21 -0700 (PDT)
Subject: Re: [BUG] kernel: rcu: a possible sleep-in-atomic-context bug in
 srcu_read_delay()
To:     paulmck@linux.vnet.ibm.com
Cc:     dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4179b4d2-b832-abcd-d407-b865765f28d6@gmail.com>
 <20180813041826.GL24813@linux.vnet.ibm.com>
 <5b3fd721-541c-5165-ef54-d6c476318d92@gmail.com>
 <20180813124232.GM24813@linux.vnet.ibm.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <5a9b96db-07a2-67bb-c2ab-6ee1f5c0e24d@gmail.com>
Date:   Wed, 15 Aug 2018 09:05:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180813124232.GM24813@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/13 20:42, Paul E. McKenney wrote:
> On Mon, Aug 13, 2018 at 05:26:49PM +0800, Jia-Ju Bai wrote:
>>
>> On 2018/8/13 12:18, Paul E. McKenney wrote:
>>> On Mon, Aug 13, 2018 at 11:04:10AM +0800, Jia-Ju Bai wrote:
>>>> The kernel may sleep with holding a spinlock.
>>>>
>>>> The function call paths (from bottom to top) in Linux-4.16 are:
>>>>
>>>> [FUNC] schedule_timeout_interruptible
>>>> kernel/rcu/rcutorture.c, 523: schedule_timeout_interruptible in
>>>> srcu_read_delay
>>>> kernel/rcu/rcutorture.c, 1105: [FUNC_PTR]srcu_read_delay in
>>>> rcu_torture_timer
>>>> kernel/rcu/rcutorture.c, 1104: spin_lock in rcu_torture_timer
>>>>
>>>> Note that [FUNC_PTR] means a function pointer call is used.
>>>>
>>>> I do not find a good way to fix, so I only report.
>>>> This is found by my static analysis tool (DSAC).
>>> Interesting.  I would have expected to have gotten a "scheduling while
>>> atomic" error message, which I do not recall seeing.  And I ran a great
>>> deal of rcutorture on v4.16.
>>>
>>> So let's see...  As you say, the rcu_torture_timer() function does in
>>> fact acquire rand_lock in 4.16 and 4.17, in which case sleeping would
>>> indeed be illegal.  But let's take a look at srcu_read_delay():
>>>
>>> static void
>>> srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
>>> {
>>> 	long delay;
>>> 	const long uspertick = 1000000 / HZ;
>>> 	const long longdelay = 10;
>>>
>>> 	/* We want there to be long-running readers, but not all the time. */
>>>
>>> 	delay = torture_random(rrsp) %
>>> 		(nrealreaders * 2 * longdelay * uspertick);
>>> 	if (!delay && in_task()) {
>>> 		schedule_timeout_interruptible(longdelay);
>>> 		rtrsp->rt_delay_jiffies = longdelay;
>>> 	} else {
>>> 		rcu_read_delay(rrsp, rtrsp);
>>> 	}
>>> }
>>>
>>> The call to schedule_timeout_interruptible() cannot happen unless the
>>> in_task() macro returns true, which it won't if the SOFTIRQ_OFFSET bit
>>> is set:
>>>
>>> #define in_task()		(!(preempt_count() & \
>>> 				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
>>>
>>> And the SOFTIRQ_OFFSET bit will be set if srcu_read_delay()
>>> is invoked from a timer handler, which is the case for the
>>> call from rcu_torture_timer().  So if that lock is held,
>>> schedule_timeout_interruptible() won't ever be invoked.
>> Thanks for your reply :)
>> My tool does not track this bit...
>> Sorry for this false report.
> Not a problem, a few false positives are to be expected.  And it looks
> like you have some work to do on your tool -- which is good, because I
> would not want you to be bored.  ;-)
>
> 							Thanx, Paul
>

Thanks for your advice.
I will improve my tool to produce less false positives :)


Best wishes,
Jia-Ju Bai
