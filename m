Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAE4C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F76F21758
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMrG2N7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F76F21758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753733AbeGEN64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:58:56 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33337 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753400AbeGEN6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:58:55 -0400
Received: by mail-oi0-f65.google.com with SMTP id c6-v6so17068891oiy.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=QG+/mUjG/ju5VMFMzX5a3Ln9O8hG/pjvwB+JFciqhwY=;
        b=KMrG2N7yexZN21XC/nk5IehWG9Go0Lzr5Ln0wtnIAeHiSXM3nqUQK8fgRydsctyKkR
         rgl8w/Ea3vFyafLMzJNNHeL7mDMINAHjqbW7OnI8272LuYVZfySFBMl3wc2D/tK544FB
         X4QTP2YGFySFl+CnjR9WZGq9zoaUPTrs0cM+izSfhegXoHl5mGjUozQdrWfmznV3qrHY
         lJ79j/3oeiT/8gpRZxYe1W7oE3/CDl4ZH4cxmwvguiTcBgddNqidNr3TR31H+HQjIhy6
         7NpdRhAVQq16HJ5A87BrajqF3QyqEFatBi87AWA98WLQ4dsxhJTrAtcn5L1ggHt/mc9Y
         f58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=QG+/mUjG/ju5VMFMzX5a3Ln9O8hG/pjvwB+JFciqhwY=;
        b=eSueYnEMk39d4IFwEnRk93wERuo9V/cfx7hY2MzHbeDuF+8/0Z5z80c7nkYKjFEjdK
         u3FEr1935D8+OpIAaclA1f4//HPmVXgL26nG9WIn2NtPBUg1e9prxAVN+Geej1P0Y1sd
         sFj+pILMkos4rPGT3WS+c/KeurlFbnVQLqNqfVDmbLhRb0GUWsPX7BTBTSlf0kG2on8L
         2VcRnRAxPnrUZziFpO9OX/B7lp5J/PDxQo6/DtfMhZLBMxOjllPkp93jmmBi4pM9Nde4
         AZu2UmohnHI9TkbqlHNs4bv6ekpyJWXenk1dYra8CK1q+zi9NGLho0C3kp+fyucxPMNt
         NztQ==
X-Gm-Message-State: APt69E0CTpvW+xMUUlczoPfLAwJg1X9xWWBRm6r+bvBNmtGQNi3lNmyM
        QI2j4xMI50Yy8NjbmIOqG5RY3Q==
X-Google-Smtp-Source: AAOMgpfsdpGuFdRYTvaK+/ce5LKZMIXr0ZwFL9GRvQHsFRhY6fzTkjpnCE3JEgBuIbcmzOtyjSWc/w==
X-Received: by 2002:aca:4c7:: with SMTP id 190-v6mr6990943oie.107.1530799134694;
        Thu, 05 Jul 2018 06:58:54 -0700 (PDT)
Received: from xunleideMacBook-Pro.local ([205.204.117.1])
        by smtp.gmail.com with ESMTPSA id b63-v6sm3673410oia.4.2018.07.05.06.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:58:54 -0700 (PDT)
Subject: Re: [PATCH] sched/cputime: Ensure correct utime and stime proportion
To:     Peter Zijlstra <peterz@infradead.org>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
References: <20180622071542.61569-1-xlpang@linux.alibaba.com>
 <b9363fa9-826f-611f-3ab3-27e50c03422a@linux.alibaba.com>
 <20180626154908.GE2458@hirez.programming.kicks-ass.net>
 <e1b69cf9-a3a7-ea67-7c0e-d67ac81f29f1@linux.alibaba.com>
 <20180705104632.GE2494@hirez.programming.kicks-ass.net>
 <bd275aff-61dd-557f-5b91-da4ce82f9501@linux.alibaba.com>
 <20180705134214.GF2494@hirez.programming.kicks-ass.net>
From:   xunlei <xunlei.pang@gmail.com>
Message-ID: <da032f2b-61e0-bd12-f0ec-0ef21b87d3d7@gmail.com>
Date:   Thu, 5 Jul 2018 21:58:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705134214.GF2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/18 9:42 PM, Peter Zijlstra wrote:
> On Thu, Jul 05, 2018 at 09:21:15PM +0800, Xunlei Pang wrote:
>> On 7/5/18 6:46 PM, Peter Zijlstra wrote:
>>> On Wed, Jun 27, 2018 at 08:22:42PM +0800, Xunlei Pang wrote:
>>>> tick-based whole utime is utime_0, tick-based whole stime
>>>> is stime_0, scheduler time is rtime_0. 
>>>
>>>> For a long time, the process runs mainly in userspace with
>>>> run-sleep patterns, and because two different clocks, it
>>>> is possible to have the following condition:
>>>>   rtime_0 < utime_0 (as with little stime_0)
>>>
>>> I don't follow... what?
>>>
>>> Why are you, and why do you think it makes sense to, compare rtime_0
>>> against utime_0 ?
>>>
>>> The [us]time_0 are, per your earlier definition, ticks. They're not an
>>> actual measure of time. Do not compare the two, that makes no bloody
>>> sense.
>>>
>>
>> [us]time_0 is task_struct:utime{stime}, I cited directly from
>> cputime_adjust(), both in nanoseconds. I assumed "rtime_0 < utime_0"
>> here to simple the following proof to help explain the problem we met.
> 
> In the !VIRT_CPU_ACCOUNTING case they (task_struct::[us]time) are not
> actual durations. Yes, the happen to be accounted in multiples of
> TICK_NSEC and thereby happen to carry a [ns] unit, but they are not
> durations, they are samples.
> 
> (we just happen to store them in a [ns] unit because for
> VIRT_CPU_ACCOUNTING they are in fact durations)
> 
> If 'rtime < utime' is not a valid assumption to build a problem on for
> !VIRT_CPU_ACCOUNTING.
> 

It is rtime < utime + stime, that is the imprecise tick-based run time
may be larger than precise sum_exec_runtime scheduler-based run time, it
can happen with some frequent run-sleep patterns.

Because stime is usually very small, so it is possible to have rtime <
utime.

> 
> So please try again, so far you're not making any sense.
> 

I also had a reproducer to verify this patch, can attach it tomorrow.
