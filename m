Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716E6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CF921B24
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROKvfF9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405531AbfBNTGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:06:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34717 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfBNTGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:06:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id f14so7750729wrg.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z4I1n/DrgEHDV1PzSPb09g3I/1/XX8wF6U2zDcwZGXY=;
        b=ROKvfF9jpo4vwHJFZnigikZzm0ZDWBByglvCla1IGfPit07AXfHhlMVh6nDMgvLVas
         +JQI+FPRyMtcC+vLVh79cEe5x9Q9o5//Fs5PuAvuvFxcUE/ONAYNw5E/W3ZxAQ8eAiiO
         jMHTMZwDDUeoNsserr6ypPqWTg42RORlBEsB57iwDTn5yxMqxJrmyaMUuhv6Pp2Qr9pe
         TpU7aK2XcVq6caLoMu+uN1mSoohUoxTCyp0bO0HV3kQOb6Y0RthyonP/AloayMlYaScF
         Ix6q0UxDZ8f/vH/HJqzctoiYsOnmpX14cZEndYoTKSd6AYInLnreyeUjodXAK4ytzIDK
         Ea5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z4I1n/DrgEHDV1PzSPb09g3I/1/XX8wF6U2zDcwZGXY=;
        b=cJ6vh14chIxZPmH/gfpCP0scj5CV5/Xiw3Y8lQ1G6b82WmEQs+L5YEKRTgiK5mPqK0
         FEYZre3uQ9QpGXtmHvt/nAUrp6rGRzs/pTGPdHMPhqxJPIi3U3P6WmBI0JA06zL/tLe9
         brOaIUgERalx0Hv/7+Iz93J5A/98UdItOYN7BIWHlXXCjzY/Bxu18WxJCTYNGOC2N7qG
         YZnlsPuZCL8fmndzmtN3dG8np3j1KNl96vL4hGejGGCRgX6TJIYaaRCsO4MqxbG9ia4V
         OLmqOhpeYzVF3F0kQg1IF5BbQEiGHQ8v/JBLJOXQmSxBrKea9SmSYfiMxhMKhQ87wT5M
         yARA==
X-Gm-Message-State: AHQUAubVOdb/hO/68OgL9LzCN568v8D5fqp2lkT9arV9VvGKUH8GfiKv
        KwKoKB4nfBbdeGHJ+aqgyvbdxlqU
X-Google-Smtp-Source: AHgI3IZ0I1aamEPCrRGEGF/JQnegTE+4yO0Im6L1STne818gp+eyeXOcrNc8iBBzeMqSX7VFYz4kKw==
X-Received: by 2002:a5d:4608:: with SMTP id t8mr4182755wrq.186.1550171160324;
        Thu, 14 Feb 2019 11:06:00 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:4185:fd13:4656:451e? (p200300EA8BF1E2004185FD134656451E.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:4185:fd13:4656:451e])
        by smtp.googlemail.com with ESMTPSA id o18sm9138722wrg.40.2019.02.14.11.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:05:59 -0800 (PST)
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
From:   Heiner Kallweit <hkallweit1@gmail.com>
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
 <f60567f7-fa7e-f424-12e6-b3df7a24c0be@gmail.com>
Message-ID: <48a2817e-4133-967e-7e57-eea2f547cb01@gmail.com>
Date:   Thu, 14 Feb 2019 20:05:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <f60567f7-fa7e-f424-12e6-b3df7a24c0be@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.2019 20:37, Heiner Kallweit wrote:
> On 16.01.2019 07:24, Frederic Weisbecker wrote:
>> On Fri, Dec 28, 2018 at 12:11:12AM +0100, Heiner Kallweit wrote:
>>>
>>> # tracer: nop
>>> #
>>> #                              _-----=> irqs-off
>>> #                             / _----=> need-resched
>>> #                            | / _---=> hardirq/softirq
>>> #                            || / _--=> preempt-depth
>>> #                            ||| /     delay
>>> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
>>> #              | |       |   ||||       |         |
>>>           <idle>-0     [001] d.h2  1479.099092: softirq_raise: vec=1 [action=TIMER]
>>>           <idle>-0     [001] d.h2  1479.099098: softirq_raise: vec=9 [action=RCU]
>>>           <idle>-0     [001] d.h2  1479.099106: softirq_raise: vec=7 [action=SCHED]
>>>           <idle>-0     [001] ..s2  1479.099114: softirq_entry: vec=1 [action=TIMER]
>>>           <idle>-0     [001] ..s2  1479.099120: softirq_exit: vec=1 [action=TIMER]
>>>           <idle>-0     [001] ..s2  1479.099121: softirq_entry: vec=7 [action=SCHED]
>>>           <idle>-0     [001] ..s2  1479.099134: softirq_exit: vec=7 [action=SCHED]
>>>           <idle>-0     [001] ..s2  1479.099135: softirq_entry: vec=9 [action=RCU]
>>>           <idle>-0     [001] ..s2  1479.099141: softirq_exit: vec=9 [action=RCU]
>>>           <idle>-0     [001] d.h2  1479.100094: softirq_raise: vec=9 [action=RCU]
>>>           <idle>-0     [001] ..s2  1479.100109: softirq_entry: vec=9 [action=RCU]
>>>           <idle>-0     [001] ..s2  1479.100116: softirq_exit: vec=9 [action=RCU]
>>>           <idle>-0     [001] d.h2  1479.101091: softirq_raise: vec=1 [action=TIMER]
>>>           <idle>-0     [001] ..s2  1479.101113: softirq_entry: vec=1 [action=TIMER]
>>>           <idle>-0     [001] ..s2  1479.101118: softirq_exit: vec=1 [action=TIMER]
>>>           <idle>-0     [001] d.h2  1479.102094: softirq_raise: vec=9 [action=RCU]
>>>           <idle>-0     [001] ..s2  1479.102114: softirq_entry: vec=9 [action=RCU]
>>>           <idle>-0     [001] ..s2  1479.102121: softirq_exit: vec=9 [action=RCU]
>>>           <idle>-0     [001] d.h2  1479.103091: softirq_raise: vec=1 [action=TIMER]
>>>           <idle>-0     [001] d.h2  1479.103097: softirq_raise: vec=9 [action=RCU]
>>>           <idle>-0     [001] d.h2  1479.103105: softirq_raise: vec=7 [action=SCHED]
>>>           <idle>-0     [001] ..s2  1479.103114: softirq_entry: vec=1 [action=TIMER]
>>>           <idle>-0     [001] ..s2  1479.103118: softirq_exit: vec=1 [action=TIMER]
>>>           <idle>-0     [001] ..s2  1479.103119: softirq_entry: vec=7 [action=SCHED]
>>>           <idle>-0     [001] ..s2  1479.103131: softirq_exit: vec=7 [action=SCHED]
>>>           <idle>-0     [001] ..s2  1479.103132: softirq_entry: vec=9 [action=RCU]
>>>           <idle>-0     [001] ..s2  1479.103138: softirq_exit: vec=9 [action=RCU]
>>>           <idle>-0     [001] d.h2  1479.105092: softirq_raise: vec=1 [action=TIMER]
>>>           <idle>-0     [001] ..s2  1479.105115: softirq_entry: vec=1 [action=TIMER]
>>>           <idle>-0     [001] ..s2  1479.105119: softirq_exit: vec=1 [action=TIMER]
>>>           <idle>-0     [001] d.h2  1479.106092: softirq_raise: vec=9 [action=RCU]
>>>           <idle>-0     [001] ..s2  1479.106112: softirq_entry: vec=9 [action=RCU]
>>>           <idle>-0     [001] .Ns2  1479.106144: softirq_exit: vec=9 [action=RCU]
>>>          cpuhp/1-13    [001] d..2  1479.106279: timer_cancel: timer=0000000009a25653
>>>           <idle>-0     [001] d.h2  1479.106965: softirq_raise: vec=1 [action=TIMER]
>>>           <idle>-0     [001] d.h2  1479.106969: softirq_raise: vec=9 [action=RCU]
>>>           <idle>-0     [001] d.h2  1479.106974: softirq_raise: vec=7 [action=SCHED]
>>>           <idle>-0     [001] ..s2  1479.106981: softirq_entry: vec=1 [action=TIMER]
>>>           <idle>-0     [001] ..s2  1479.106984: softirq_exit: vec=1 [action=TIMER]
>>>           <idle>-0     [001] ..s2  1479.106985: softirq_entry: vec=7 [action=SCHED]
>>>           <idle>-0     [001] ..s2  1479.106994: softirq_exit: vec=7 [action=SCHED]
>>>           <idle>-0     [001] ..s2  1479.106995: softirq_entry: vec=9 [action=RCU]
>>>           <idle>-0     [001] ..s2  1479.106999: softirq_exit: vec=9 [action=RCU]
>>>           <idle>-0     [001] d.h2  1479.107996: softirq_raise: vec=1 [action=TIMER]
>>>           <idle>-0     [001] ..s2  1479.108010: softirq_entry: vec=1 [action=TIMER]
>>>           <idle>-0     [001] ..s2  1479.108014: softirq_exit: vec=1 [action=TIMER]
>>>           <idle>-0     [001] d.h2  1479.109009: softirq_raise: vec=1 [action=TIMER]
>>>           <idle>-0     [001] d.h2  1479.109013: softirq_raise: vec=9 [action=RCU]
>>>           <idle>-0     [001] ..s2  1479.109024: softirq_entry: vec=1 [action=TIMER]
>>>           <idle>-0     [001] ..s2  1479.109028: softirq_exit: vec=1 [action=TIMER]
>>>           <idle>-0     [001] ..s2  1479.109028: softirq_entry: vec=9 [action=RCU]
>>>           <idle>-0     [001] ..s2  1479.109033: softirq_exit: vec=9 [action=RCU]
>>>           <idle>-0     [001] d.h2  1479.110013: softirq_raise: vec=9 [action=RCU]
>>>           <idle>-0     [001] ..s2  1479.110033: softirq_entry: vec=9 [action=RCU]
>>>           <idle>-0     [001] ..s2  1479.110040: softirq_exit: vec=9 [action=RCU]
>>>           <idle>-0     [001] d.h2  1479.111011: softirq_raise: vec=1 [action=TIMER]
>>>           <idle>-0     [001] d.h2  1479.111017: softirq_raise: vec=9 [action=RCU]
>>>           <idle>-0     [001] d.h2  1479.111026: softirq_raise: vec=7 [action=SCHED]
>>>           <idle>-0     [001] ..s2  1479.111035: softirq_entry: vec=1 [action=TIMER]
>>>           <idle>-0     [001] ..s2  1479.111040: softirq_exit: vec=1 [action=TIMER]
>>>           <idle>-0     [001] ..s2  1479.111040: softirq_entry: vec=7 [action=SCHED]
>>>           <idle>-0     [001] ..s2  1479.111052: softirq_exit: vec=7 [action=SCHED]
>>>           <idle>-0     [001] ..s2  1479.111052: softirq_entry: vec=9 [action=RCU]
>>>           <idle>-0     [001] .Ns2  1479.111079: softirq_exit: vec=9 [action=RCU]
>>>          cpuhp/1-13    [001] dNh2  1479.112930: softirq_raise: vec=1 [action=TIMER]
>>>          cpuhp/1-13    [001] dNh2  1479.112935: softirq_raise: vec=9 [action=RCU]
>>>           <idle>-0     [001] d..1  1479.113077: <stack trace>
>>>  => can_stop_idle_tick.isra.14
>>>  => tick_nohz_get_sleep_length
>>>  => menu_select
>>>  => cpuidle_select
>>>  => do_idle
>>>  => cpu_startup_entry
>>>  => start_secondary
>>>  => secondary_startup_64
>>>           <idle>-0     [001] .Ns2  1479.113110: softirq_entry: vec=1 [action=TIMER]
>>>           <idle>-0     [001] .Ns2  1479.113114: softirq_exit: vec=1 [action=TIMER]
>>>           <idle>-0     [001] .Ns2  1479.113115: softirq_entry: vec=9 [action=RCU]
>>>           <idle>-0     [001] .Ns2  1479.113139: softirq_exit: vec=9 [action=RCU]
>>
>>
>> So, I'm being very doubtful now actually.
>>
>> First of all, I realize my patch only fixes things halfway. Only softirq raised from
>> hardirqs are going to be handled after ksoftirqd is parked. If it's raised outside
>> interrupts, the softirq is going to be ignored. If other smpboot kthreads, following
>> ksoftirqd parking, raise softirqs from their park() callback we should at least warn
>> that we are ignoring that.
>>
>> Also, I'm still not sure if you're running threaded IRQs. Very likely not as
>> the softirqs in your traces are executed in idle, which means from an IRQ interrupting
>> idle. You haven't passed "threadirqs" in your kernel parameters, right?
>> In any case we need to figure out why your softirqs raised at 1479.112930 and
>> 1479.112935 don't get handled.
>>
>> Finally I don't understand why you have so many timer softirqs and yet no timer traces
>> at all, I turned them on in the script I gave you. So something weird is happening with
>> the timers code. At best we are wasting lots of CPU cycles with those empty softirqs, at
>> worst we are miscalculating some expiration somewhere, possibly ignoring a timer.
>>
>> So I'll need to cook up an updated debug patch for you to trigger if you don't
>> mind.
>>
> Hi Frederic,
> is the update debug patch still to come?
> 
>> Thanks.
>>
> Heiner
> 
Hi Frederic,

before it's forgotten: If I can test more, just let me know.

Heiner
