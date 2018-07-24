Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E78FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1A020856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="2T9HVUty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1A020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbeGXQT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:19:27 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35125 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388320AbeGXQT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:19:26 -0400
Received: by mail-yw0-f195.google.com with SMTP id t18-v6so1655369ywg.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 08:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=25p+jS6o/YSjFhg21X4cZUNJeO7pDLhB002v7M4Ttrg=;
        b=2T9HVUty2FPpzSaRvkyytY7qYsf6KygIQql8HGohvCxCdtXaFvflzT198tHPS3a4O8
         UEygwfbFzrxLFPXRTZlk6MLEctMw4TbRwo1BkClVbcWPtEriD9S5ADY0s2OESKbqZjNE
         dsbKY1akpq5xJTWblND4TpUXcQq+OzL4PTwB/q7P2+1lbeBS+2UwdYuKOWj6gxzgrQ9i
         cSJKIHCQOVfYpxJdbAc486hY4oiRdNwR/gXJOrRbX5AKFrp3Lo+WnDl7EzDBUSQgDodm
         U/gLQSGEHdNL0quDAva9w1O/YWNqoeqejPsS0+Ct7tO4PZs4b1z4y9Zw6WgK/WtLds2R
         lsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=25p+jS6o/YSjFhg21X4cZUNJeO7pDLhB002v7M4Ttrg=;
        b=T/rp0ikQgc4ghDd0CeLYZZOEC0MvHWxkzSzsolrOIeZmO0FvB19r/ENrIESo4rm2XT
         qfq9yH3DqT2R5IVndmz0FMmLZSWMe3/qRiszMWR2d88nzhjvUPWxE7dFFLMe7pCYT3t3
         OWG+al2IIcBfczlbN+XlsVY9PoHvrMVR1jwVcwVk27YldOUYYDYeVrKyGiD6s9BmNCJW
         P9PvgjkYP0wBzjHkWpdpW7BqwFCSSy8aO2RfSGf1uvdcfejjd+GbluoFExqrvh1GWKWz
         WXXoirDKonI0vT5PtZeV8JMkn4l70sGlr6WqaPmp3cgL+v685fiBVu9wuLTzaPLYLgyE
         7POA==
X-Gm-Message-State: AOUpUlG0jy2nKfq2ndvQyir3FwBc6y6HBVQhdHAfG7iMo6/fr1U5mMdq
        kNLaHj5OEGKJbMSdblzl5ATsYA==
X-Google-Smtp-Source: AAOMgpcx5ll8tCKjtt/sWMvrfW+ZUmWWJyCt4iRh8cMu7hT8wVYWN939InOYStC4J7Ihw21b8qUPTg==
X-Received: by 2002:a0d:f443:: with SMTP id d64-v6mr8768520ywf.461.1532445149826;
        Tue, 24 Jul 2018 08:12:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:c07])
        by smtp.gmail.com with ESMTPSA id q184-v6sm5967445ywd.78.2018.07.24.08.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 08:12:28 -0700 (PDT)
Date:   Tue, 24 Jul 2018 11:15:19 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Balbir Singh <bsingharora@gmail.com>
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
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory,
 and IO v2
Message-ID: <20180724151519.GA11598@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <CAKTCnzmt_CnfZMMdK9_-rBrL4kUmoE70nVbnE58CJp++FP0CCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKTCnzmt_CnfZMMdK9_-rBrL4kUmoE70nVbnE58CJp++FP0CCQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balbir,

On Tue, Jul 24, 2018 at 07:14:02AM +1000, Balbir Singh wrote:
> Does the mechanism scale? I am a little concerned about how frequently
> this infrastructure is monitored/read/acted upon.

I expect most users to poll in the frequency ballpark of the running
averages (10s, 1m, 5m). Our OOMD defaults to 5s polling of the 10s
average; we collect the 1m average once per minute from our machines
and cgroups to log the system/workload health trends in our fleet.

Suren has been experimenting with adaptive polling down to the
millisecond range on Android.

> Why aren't existing mechanisms sufficient

Our existing stuff gives a lot of indication when something *may* be
an issue, like the rate of page reclaim, the number of refaults, the
average number of active processes, one task waiting on a resource.

But the real difference between an issue and a non-issue is how much
it affects your overall goal of making forward progress or reacting to
a request in time. And that's the only thing users really care
about. It doesn't matter whether my system is doing 2314 or 6723 page
refaults per minute, or scanned 8495 pages recently. I need to know
whether I'm losing 1% or 20% of my time on overcommitted memory.

Delayacct is time-based, so it's a step in the right direction, but it
doesn't aggregate tasks and CPUs into compound productivity states to
tell you if only parts of your workload are seeing delays (which is
often tolerable for the purpose of ensuring maximum HW utilization) or
your system overall is not making forward progress. That aggregation
isn't something you can do in userspace with polled delayacct data.

> -- why is the avg delay calculation in the kernel?

For one, as per above, most users will probably be using the standard
averaging windows, and we already have this highly optimizd
infrastructure from the load average. I don't see why we shouldn't use
that instead of exporting an obscure number that requires most users
to have an additional library or copy-paste the loadavg code.

I also mentioned the OOM killer as a likely in-kernel user of the
pressure percentages to protect from memory livelocks out of the box,
in which case we have to do this calculation in the kernel anyway.

> There is no talk about the overhead this introduces in general, may be
> the details are in the patches. I'll read through them

I sent an email on benchmarks and overhead in one of the subthreads, I
will include that information in the cover letter in v3.

https://lore.kernel.org/lkml/20180718215644.GB2838@cmpxchg.org/

Thanks!
