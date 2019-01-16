Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225ABC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33F020651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/E/iqfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfAPSnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:43:02 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:35636 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbfAPSnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:43:00 -0500
Received: by mail-wr1-f53.google.com with SMTP id 96so8167316wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pz0x4DswU3KQ/K04FJsZl7tYMThTiZp3S7SV6rToIm8=;
        b=J/E/iqfTsSh2H68d9tMErhMI7mv4fbJEWNEXfgZb6qncBQabv3/RDCQHn2DSmVM8i8
         QwlASZ8p8i06k9BbXJxyKKnjURmRq5O3z9yPebv8ZEXwhkkALCXdiac8gsxEhvvtxR2V
         B4kHDGnHoq1N9Brz0MMTOzIKOck3bNIh7i9nn2asDyNYviLz2SUFkFT1c174MR2HrAoz
         mKdIwtL04h3pZVtsJ80tCGxVH6ZJHMLS2l/oppWtbY0zb8dau0rFk3DbJoQSl5IhkwGR
         unZ6YrfCTa3237RTEVjPtXNVY+dTJ5bOf2tyIjNHKzElQawRpgZyQ2NWxwrKsBPBcPIS
         f0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pz0x4DswU3KQ/K04FJsZl7tYMThTiZp3S7SV6rToIm8=;
        b=pFftOBV8lT5ifLyhcjP5VyjyLkWpJJGKGjQEZ5eDv7eb3VO6fzMOoPJPOTQOkpLlBm
         QMyBWZ3etG721EX9DGTGI2CbYQ44FUr+iuYdKTxu00kNgz8GQRqncaz1sq9/YPeU/dMs
         Jo4Zz3hDEC8a+inzO2iv/U9GneQrfn01DEmuYl0CYO0k25EuDC8W1HA3Pft+PiNoAL12
         GKVRHvK1CZrXePYszxn7XcNUsWxuhLA3Fp6dqIUPaZpJ3Vb9/KcyoFIk4JDiFVu/1qt+
         tPevdjs8pngo4ycDRTxektWNPrSKyV/Gn0oUn7jXVmhV/DFFgmXNalRx50HKM4iuUL3P
         aTcQ==
X-Gm-Message-State: AJcUukelXW5yf8bj7KOiOtbfz1w9zhk5GTgthovAOtub/q6U+JTqOfj9
        6QjRAGSOK8urDQnv7+eiYaO6A7S1
X-Google-Smtp-Source: ALg8bN7L1lxqHjmTG8P7YyL5moEYMXdtCNtWKE0oi8sxBpjBm+rd/egyZjHR3/4gRHK6P4dRr2vGOg==
X-Received: by 2002:adf:fa90:: with SMTP id h16mr3992454wrr.326.1547664177270;
        Wed, 16 Jan 2019 10:42:57 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:75ce:7fb:35bc:2da7? (p200300EA8BF1E20075CE07FB35BC2DA7.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:75ce:7fb:35bc:2da7])
        by smtp.googlemail.com with ESMTPSA id f2sm69782046wru.14.2019.01.16.10.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 10:42:56 -0800 (PST)
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
 <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de>
 <20180824143056.GC2730@lerouge>
 <d8fd3322-e982-2c9c-85e3-9b1770357520@gmail.com>
 <20180828022545.GA25943@lerouge>
 <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de>
 <20180928131855.GB8795@lerouge>
 <c472b6bf-e4af-d807-e63f-75211ce295bd@gmail.com>
 <20181227065321.GA3749@lerouge>
 <e838fa7f-f43f-7b3c-aae6-edb4f6734964@gmail.com>
 <20190116062408.GA26169@lenoir>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <fb9c1fe7-dfea-44cb-1865-64f4962a07b5@gmail.com>
Date:   Wed, 16 Jan 2019 19:42:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116062408.GA26169@lenoir>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.01.2019 07:24, Frederic Weisbecker wrote:
> On Fri, Dec 28, 2018 at 12:11:12AM +0100, Heiner Kallweit wrote:
>>
>> # tracer: nop
>> #
>> #                              _-----=> irqs-off
>> #                             / _----=> need-resched
>> #                            | / _---=> hardirq/softirq
>> #                            || / _--=> preempt-depth
>> #                            ||| /     delay
>> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
>> #              | |       |   ||||       |         |
>>           <idle>-0     [001] d.h2  1479.099092: softirq_raise: vec=1 [action=TIMER]
>>           <idle>-0     [001] d.h2  1479.099098: softirq_raise: vec=9 [action=RCU]
>>           <idle>-0     [001] d.h2  1479.099106: softirq_raise: vec=7 [action=SCHED]
>>           <idle>-0     [001] ..s2  1479.099114: softirq_entry: vec=1 [action=TIMER]
>>           <idle>-0     [001] ..s2  1479.099120: softirq_exit: vec=1 [action=TIMER]
>>           <idle>-0     [001] ..s2  1479.099121: softirq_entry: vec=7 [action=SCHED]
>>           <idle>-0     [001] ..s2  1479.099134: softirq_exit: vec=7 [action=SCHED]
>>           <idle>-0     [001] ..s2  1479.099135: softirq_entry: vec=9 [action=RCU]
>>           <idle>-0     [001] ..s2  1479.099141: softirq_exit: vec=9 [action=RCU]
>>           <idle>-0     [001] d.h2  1479.100094: softirq_raise: vec=9 [action=RCU]
>>           <idle>-0     [001] ..s2  1479.100109: softirq_entry: vec=9 [action=RCU]
>>           <idle>-0     [001] ..s2  1479.100116: softirq_exit: vec=9 [action=RCU]
>>           <idle>-0     [001] d.h2  1479.101091: softirq_raise: vec=1 [action=TIMER]
>>           <idle>-0     [001] ..s2  1479.101113: softirq_entry: vec=1 [action=TIMER]
>>           <idle>-0     [001] ..s2  1479.101118: softirq_exit: vec=1 [action=TIMER]
>>           <idle>-0     [001] d.h2  1479.102094: softirq_raise: vec=9 [action=RCU]
>>           <idle>-0     [001] ..s2  1479.102114: softirq_entry: vec=9 [action=RCU]
>>           <idle>-0     [001] ..s2  1479.102121: softirq_exit: vec=9 [action=RCU]
>>           <idle>-0     [001] d.h2  1479.103091: softirq_raise: vec=1 [action=TIMER]
>>           <idle>-0     [001] d.h2  1479.103097: softirq_raise: vec=9 [action=RCU]
>>           <idle>-0     [001] d.h2  1479.103105: softirq_raise: vec=7 [action=SCHED]
>>           <idle>-0     [001] ..s2  1479.103114: softirq_entry: vec=1 [action=TIMER]
>>           <idle>-0     [001] ..s2  1479.103118: softirq_exit: vec=1 [action=TIMER]
>>           <idle>-0     [001] ..s2  1479.103119: softirq_entry: vec=7 [action=SCHED]
>>           <idle>-0     [001] ..s2  1479.103131: softirq_exit: vec=7 [action=SCHED]
>>           <idle>-0     [001] ..s2  1479.103132: softirq_entry: vec=9 [action=RCU]
>>           <idle>-0     [001] ..s2  1479.103138: softirq_exit: vec=9 [action=RCU]
>>           <idle>-0     [001] d.h2  1479.105092: softirq_raise: vec=1 [action=TIMER]
>>           <idle>-0     [001] ..s2  1479.105115: softirq_entry: vec=1 [action=TIMER]
>>           <idle>-0     [001] ..s2  1479.105119: softirq_exit: vec=1 [action=TIMER]
>>           <idle>-0     [001] d.h2  1479.106092: softirq_raise: vec=9 [action=RCU]
>>           <idle>-0     [001] ..s2  1479.106112: softirq_entry: vec=9 [action=RCU]
>>           <idle>-0     [001] .Ns2  1479.106144: softirq_exit: vec=9 [action=RCU]
>>          cpuhp/1-13    [001] d..2  1479.106279: timer_cancel: timer=0000000009a25653
>>           <idle>-0     [001] d.h2  1479.106965: softirq_raise: vec=1 [action=TIMER]
>>           <idle>-0     [001] d.h2  1479.106969: softirq_raise: vec=9 [action=RCU]
>>           <idle>-0     [001] d.h2  1479.106974: softirq_raise: vec=7 [action=SCHED]
>>           <idle>-0     [001] ..s2  1479.106981: softirq_entry: vec=1 [action=TIMER]
>>           <idle>-0     [001] ..s2  1479.106984: softirq_exit: vec=1 [action=TIMER]
>>           <idle>-0     [001] ..s2  1479.106985: softirq_entry: vec=7 [action=SCHED]
>>           <idle>-0     [001] ..s2  1479.106994: softirq_exit: vec=7 [action=SCHED]
>>           <idle>-0     [001] ..s2  1479.106995: softirq_entry: vec=9 [action=RCU]
>>           <idle>-0     [001] ..s2  1479.106999: softirq_exit: vec=9 [action=RCU]
>>           <idle>-0     [001] d.h2  1479.107996: softirq_raise: vec=1 [action=TIMER]
>>           <idle>-0     [001] ..s2  1479.108010: softirq_entry: vec=1 [action=TIMER]
>>           <idle>-0     [001] ..s2  1479.108014: softirq_exit: vec=1 [action=TIMER]
>>           <idle>-0     [001] d.h2  1479.109009: softirq_raise: vec=1 [action=TIMER]
>>           <idle>-0     [001] d.h2  1479.109013: softirq_raise: vec=9 [action=RCU]
>>           <idle>-0     [001] ..s2  1479.109024: softirq_entry: vec=1 [action=TIMER]
>>           <idle>-0     [001] ..s2  1479.109028: softirq_exit: vec=1 [action=TIMER]
>>           <idle>-0     [001] ..s2  1479.109028: softirq_entry: vec=9 [action=RCU]
>>           <idle>-0     [001] ..s2  1479.109033: softirq_exit: vec=9 [action=RCU]
>>           <idle>-0     [001] d.h2  1479.110013: softirq_raise: vec=9 [action=RCU]
>>           <idle>-0     [001] ..s2  1479.110033: softirq_entry: vec=9 [action=RCU]
>>           <idle>-0     [001] ..s2  1479.110040: softirq_exit: vec=9 [action=RCU]
>>           <idle>-0     [001] d.h2  1479.111011: softirq_raise: vec=1 [action=TIMER]
>>           <idle>-0     [001] d.h2  1479.111017: softirq_raise: vec=9 [action=RCU]
>>           <idle>-0     [001] d.h2  1479.111026: softirq_raise: vec=7 [action=SCHED]
>>           <idle>-0     [001] ..s2  1479.111035: softirq_entry: vec=1 [action=TIMER]
>>           <idle>-0     [001] ..s2  1479.111040: softirq_exit: vec=1 [action=TIMER]
>>           <idle>-0     [001] ..s2  1479.111040: softirq_entry: vec=7 [action=SCHED]
>>           <idle>-0     [001] ..s2  1479.111052: softirq_exit: vec=7 [action=SCHED]
>>           <idle>-0     [001] ..s2  1479.111052: softirq_entry: vec=9 [action=RCU]
>>           <idle>-0     [001] .Ns2  1479.111079: softirq_exit: vec=9 [action=RCU]
>>          cpuhp/1-13    [001] dNh2  1479.112930: softirq_raise: vec=1 [action=TIMER]
>>          cpuhp/1-13    [001] dNh2  1479.112935: softirq_raise: vec=9 [action=RCU]
>>           <idle>-0     [001] d..1  1479.113077: <stack trace>
>>  => can_stop_idle_tick.isra.14
>>  => tick_nohz_get_sleep_length
>>  => menu_select
>>  => cpuidle_select
>>  => do_idle
>>  => cpu_startup_entry
>>  => start_secondary
>>  => secondary_startup_64
>>           <idle>-0     [001] .Ns2  1479.113110: softirq_entry: vec=1 [action=TIMER]
>>           <idle>-0     [001] .Ns2  1479.113114: softirq_exit: vec=1 [action=TIMER]
>>           <idle>-0     [001] .Ns2  1479.113115: softirq_entry: vec=9 [action=RCU]
>>           <idle>-0     [001] .Ns2  1479.113139: softirq_exit: vec=9 [action=RCU]
> 
> 
> So, I'm being very doubtful now actually.
> 
> First of all, I realize my patch only fixes things halfway. Only softirq raised from
> hardirqs are going to be handled after ksoftirqd is parked. If it's raised outside
> interrupts, the softirq is going to be ignored. If other smpboot kthreads, following
> ksoftirqd parking, raise softirqs from their park() callback we should at least warn
> that we are ignoring that.
> 
> Also, I'm still not sure if you're running threaded IRQs. Very likely not as
> the softirqs in your traces are executed in idle, which means from an IRQ interrupting
> idle. You haven't passed "threadirqs" in your kernel parameters, right?
> In any case we need to figure out why your softirqs raised at 1479.112930 and
> 1479.112935 don't get handled.
> 
The only softirq I'm aware of is network NAPI processing. And no, I have no kernel
command line parameter "threadirqs" set.

> Finally I don't understand why you have so many timer softirqs and yet no timer traces
> at all, I turned them on in the script I gave you. So something weird is happening with
> the timers code. At best we are wasting lots of CPU cycles with those empty softirqs, at
> worst we are miscalculating some expiration somewhere, possibly ignoring a timer.
> 
> So I'll need to cook up an updated debug patch for you to trigger if you don't
> mind.
> 
I don't mind ..

> Thanks.
> 
Heiner
