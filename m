Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8CFC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB7420685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTZDI6gP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB7420685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbeGZCV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:21:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45811 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbeGZCV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:21:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id f1-v6so14596pgq.12;
        Wed, 25 Jul 2018 18:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ywLQPJZS0v12teFwlUPp7DbAsuqlLkl4NP6N1NUIKtI=;
        b=BTZDI6gPlmJZb4X/f/ZXKG0R6lBpB+i93gTpiJG44Vt/VTLg2KwYdSDJSlQyGPT9A7
         6IM3vAe1JisN43wFMncOnEcSWsuDgCVYM1wRHbh6b66DgPCC59ohj4c6Qv8KtrKMMoxL
         KqNMLQX7FWz1OJUdY60Z9Zp2Xmvolc1n6UmRfd0zt93MVWslbO01KzYxpmZxK6vQvswK
         lQnBL0W6JhxmGGOfHOQWKYOpA24j1e1WYbyxK9i0rKe0Ett9h3n2EAh9MRchuC61gUtH
         LoTiikcs9zg0dZ+TE3nUI7Ez1gpUKrLG/ZzxgOkTDsVI2mACmCA7WAbwNWXRwefj4GsK
         cm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ywLQPJZS0v12teFwlUPp7DbAsuqlLkl4NP6N1NUIKtI=;
        b=k3SuRyhHge9eTHLMJV3a9YNJRnn+lWsi5dA13xEBoEJQID5/IVy7dg+rAL6E4e36O/
         7LIRoZhQXjqNtmB4CSRvETYSav/De1JIQOEEedDIKGE4yaWkmNrdXIxhuvLazlkmXxf+
         kkUFxk0WI4UpKB5ZyMgD0sbWgEhp8hVdCp2fPsax8fXl4bAxYTHQK+mm8hgTwVeWQ1oK
         1gfDdV0uyk1wQeXT1vcg1BBw83YHW48WmNwQfivV77Gfo7PNXWPRf95hrbJnbGbkCvcF
         GtSs/HXdM31jScP20C0HXbca9B+Lahwc/OL+wIEOw+EeJPsxKTtYYCYcyFCQQAe7HNxr
         s54g==
X-Gm-Message-State: AOUpUlG07t7UBKUDqO63thbBnlq4kNYvf0CQDq+T1UaZOZdlUGnTY+60
        1xVvUMI3PpeU8MBMLV+QXDPalmJZgzE=
X-Google-Smtp-Source: AAOMgpdIdmXgZm4PDGG0HVHWuqqO4zvZVdAU9h/2tuUuoM5bDN80n7jyzTmvpDrzPUapFLnONbXTdg==
X-Received: by 2002:a63:214f:: with SMTP id s15-v6mr22333482pgm.267.1532567260091;
        Wed, 25 Jul 2018 18:07:40 -0700 (PDT)
Received: from 8c8590bceeee.ant.amazon.com ([54.240.193.1])
        by smtp.gmail.com with ESMTPSA id g63-v6sm22101545pfc.77.2018.07.25.18.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 18:07:39 -0700 (PDT)
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory, and
 IO v2
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, surenb@google.com,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christoph Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>,
        linux-mm <linux-mm@kvack.org>, cgroups@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <CAKTCnzmt_CnfZMMdK9_-rBrL4kUmoE70nVbnE58CJp++FP0CCQ@mail.gmail.com>
 <20180724151519.GA11598@cmpxchg.org>
From:   "Singh, Balbir" <bsingharora@gmail.com>
Message-ID: <268c2b08-6c90-de2b-d693-1270bb186713@gmail.com>
Date:   Thu, 26 Jul 2018 11:07:32 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724151519.GA11598@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/18 1:15 AM, Johannes Weiner wrote:
> Hi Balbir,
> 
> On Tue, Jul 24, 2018 at 07:14:02AM +1000, Balbir Singh wrote:
>> Does the mechanism scale? I am a little concerned about how frequently
>> this infrastructure is monitored/read/acted upon.
> 
> I expect most users to poll in the frequency ballpark of the running
> averages (10s, 1m, 5m). Our OOMD defaults to 5s polling of the 10s
> average; we collect the 1m average once per minute from our machines
> and cgroups to log the system/workload health trends in our fleet.
> 
> Suren has been experimenting with adaptive polling down to the
> millisecond range on Android.
> 

I think this is a bad way of doing things, polling only adds to overheads, there needs to be an event driven mechanism and the selection of the events need to happen in user space.

>> Why aren't existing mechanisms sufficient
> 
> Our existing stuff gives a lot of indication when something *may* be
> an issue, like the rate of page reclaim, the number of refaults, the
> average number of active processes, one task waiting on a resource.
> 
> But the real difference between an issue and a non-issue is how much
> it affects your overall goal of making forward progress or reacting to
> a request in time. And that's the only thing users really care
> about. It doesn't matter whether my system is doing 2314 or 6723 page
> refaults per minute, or scanned 8495 pages recently. I need to know
> whether I'm losing 1% or 20% of my time on overcommitted memory.
> 
> Delayacct is time-based, so it's a step in the right direction, but it
> doesn't aggregate tasks and CPUs into compound productivity states to
> tell you if only parts of your workload are seeing delays (which is
> often tolerable for the purpose of ensuring maximum HW utilization) or
> your system overall is not making forward progress. That aggregation
> isn't something you can do in userspace with polled delayacct data.

By aggregation you mean cgroup aggregation?

> 
>> -- why is the avg delay calculation in the kernel?
> 
> For one, as per above, most users will probably be using the standard
> averaging windows, and we already have this highly optimizd
> infrastructure from the load average. I don't see why we shouldn't use
> that instead of exporting an obscure number that requires most users
> to have an additional library or copy-paste the loadavg code.
> 
> I also mentioned the OOM killer as a likely in-kernel user of the
> pressure percentages to protect from memory livelocks out of the box,
> in which case we have to do this calculation in the kernel anyway.
> 
>> There is no talk about the overhead this introduces in general, may be
>> the details are in the patches. I'll read through them
> 
> I sent an email on benchmarks and overhead in one of the subthreads, I
> will include that information in the cover letter in v3.
> 
> https://lore.kernel.org/lkml/20180718215644.GB2838@cmpxchg.org/

Thanks, I'll take a look

Balbir Singh.
