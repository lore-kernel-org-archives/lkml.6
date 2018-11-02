Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051D2C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D212081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D212081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeKBTHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 15:07:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33571 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeKBTHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 15:07:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id u1-v6so1378038wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 03:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PhdBs+J4HJMqv0vum3BMBaTZunlx7/5w3ok3MGY0bQ8=;
        b=jif76KxpM4I1A/LSq3x5V6P9HLO96HBebIjwp2GvhhODHWZ9tqXS9FkbnpPtR/6fHZ
         +VChtraY3Jy+RwdJ6VJPb2Vw/yw3Jux2uCVkxhbViSWyzVeMqlwD6dsVwbQHj/IFNORe
         /uRpxt/LpPjNq6L9qi1SYi2pIH9OeIULyWPHOu9fxmeTbI6kJYIFY9skBVZ58MJNn24v
         99h3diI7tFwSoFtdHaWS6TMxKAW5HTu3Wno+yWgVruMQdLd7IYv3ENrqbcavw+EojL0Z
         M81Cdgt/w7dydxVYoRbnAhUVjHolN1pBeq+zkxDDKSyuteUK6NudqoHj56aDKYWkaeNy
         9l3g==
X-Gm-Message-State: AGRZ1gKIJd3PiFcukRRqPMvpgdxKGDG4Z/62RjLKmDKPj6FbksdS5uF7
        +iTTVegU6OpA1+1txLNlDvpmNw==
X-Google-Smtp-Source: AJdET5ckaqsf9kapFTlRns+oZxkJeRkOlKbdshZXMChvuVOHpUvfBfMytmUtwJy9lSkRFm+eHAQRCg==
X-Received: by 2002:a5d:5146:: with SMTP id u6-v6mr9612689wrt.299.1541152838727;
        Fri, 02 Nov 2018 03:00:38 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([87.18.205.191])
        by smtp.gmail.com with ESMTPSA id t134-v6sm5404719wmd.18.2018.11.02.03.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 03:00:37 -0700 (PDT)
Subject: Re: INFO: rcu detected stall in do_idle
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>
References: <20181018104713.GC21611@localhost.localdomain>
 <20181018130811.61337932@luca64>
 <20181019113942.GH3121@hirez.programming.kicks-ass.net>
 <20181019225005.61707c64@nowhere>
 <20181024120335.GE29272@localhost.localdomain>
 <20181030104554.GB8177@hirez.programming.kicks-ass.net>
 <20181030120804.2f30c2da@sweethome>
 <2942706f-db18-6d38-02f7-ef21205173ca@redhat.com>
 <20181031164009.GM18091@localhost.localdomain>
 <027899c5-c5ca-b214-2a87-abe17579724a@redhat.com>
 <20181101055512.GO18091@localhost.localdomain>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <1bf857dc-d6ac-e505-82bd-dd28449d3a60@redhat.com>
Date:   Fri, 2 Nov 2018 11:00:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181101055512.GO18091@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/18 6:55 AM, Juri Lelli wrote:
>> I meant, I am not against the/a fix, i just think that... it is more complicated
>> that it seems.
>>
>> For example: Let's assume that we have a non-rt bad thread A in CPU 0 generating
>> IPIs because of static key update, and a good dl thread B in the CPU 1.
>>
>> In this case, the thread B could run less than what was reserved for it, but it
>> was not causing the interrupts. It is not fair to put a penalty in the thread B.
>>
>> The same is valid for a dl thread running in the same CPU that is receiving a
>> lot of network packets to another application, and other legit cases.
>>
>> In the end, if we want to avoid non-rt threads starving, we need to prioritize
>> them some time, but in this case, we return to the DL server for non-rt threads.
>>
>> Thoughts?
> And I see your point. :-)
> 
> I'd also add (maybe you mentioned this as well) that it seems the same
> could happen with RT throttling safety measure, as we are using
> clock_task there as well to account runtime and throttle stuff.

Yes! The same problem can happen with rt scheduler as well! I saw this problem
first with the rt throttling mechanism when I was trying to make it work in the
microseconds granularity (it is only enforced in the schedule tick, so it is in
an ms granularity in practice). After using hr timers to do the enforcement in
the microseconds granularity, I was trying to let just fewer us for the non-rt.
But as the IRQ runtime was higher than these fewer us, the rt_rq was never
throttled. It is the same/similar behavior we see here.

As we think in the rt throttling as "avoiding rt workload to consume more than
rt_runtime/rt_period", and considering that IRQs are a level of task with a
fixed priority higher than all the real-time related schedulers, i.e., deadline
and rt, we can safely argue that we can consider the IRQ time into the pool of
rt workload and account it in the rt_runtime. The easiest way to do it is to use
the rq_clock() in the measurement. I agree.

The point is that the CBS has a dual goal: it avoids a task running for more
than its runtime (a throttling behavior), but it also is used as a guarantee of
runtime for the case in which the task behaves, and the system is not
overloaded. Considering we can have more load than we can schedule in a
multiprocessor - but that is another story.

The the obvious reasoning here is: Ok boy, but the system IS overloaded in this
case, we have a RCU stall! And that is true if you look at the processor
starving RCU. But if the system has mode than one CPU, it could have CPU time
available in another CPU. So, we could just move the dl task from one CPU to
another.

Btw, that is another point. We have the AC with the sum of the utilization of
all CPUs. But we do no enforcement for per-cpu utilization. If one set a single
thread with runtime=deadline=period  (in a system with more than one CPU), and
run in a busy-loop, we will eventually have an RCU stall as well (I just did on
my box, I got a soft lockup). I know this is a different problem. But, maybe,
there is a general solution for both issues:

For instance, if the sum of the execution time of all "task" with priority
higher than the OTHER class (rt, dl, stop_machine, IRQs, NMIs, Hypervisor?) in a
CPU is higher than rt_runtime in the rt_period, we need to avoid what is
"avoidable" by trying to move rt and dl threads away from that CPU. Another
possibility is to bump the priority of the OTHER class (and we are back to the
DL server).

- Dude, would not be easy just changing the CBS?

Yeah, but by changing the CBS, we may end up breaking the algorithms/properties
that rely on CBS... like GRUB, user-space/kernel-space synchronization...

> OTOH, when something like you describe happens, guarantees are probably
> already out of the window and we should just do our best to at least
> keep the system "working"? (maybe only to warn the user that something
> bad has happened)

Btw, don't get me wrong, I am not against changing CBS: I am just trying to
raise other viewpoints to avoid touching in the base of the DL scheduler, and
avoid punishing a thread that behaves well.

Anyway, notifying that dl+rt+IRQ time is higher than the rt_runtime is another
good thing to do as well. We will be notified anyway, either by RCU or
softlockup... but they are side effects warning. By notifying that we have an
overload of rt or higher workload we will be pointing to the cause.

Thoughts?

-- Daniel
