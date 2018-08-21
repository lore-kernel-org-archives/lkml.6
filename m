Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D08C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151172088E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="o0nzq8ek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151172088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeHUXcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:32:54 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33858 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbeHUXcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:32:54 -0400
Received: by mail-yw1-f65.google.com with SMTP id y134-v6so4773025ywg.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 13:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b2WGfRK2+UA3n6bV2KvevrdkLr5T4x/xhZPGefawB/E=;
        b=o0nzq8ek18Q1D6sMjAvusJvF2jBYjGTSBe2M/32qfESQfgfzNcAIN+mVo2f8t3Jq3z
         DB5HNYVH4CzZYoNm1mzGCFAcZ+XCwy7HlrU5LVlKptFjZaTjh/b68PAfpclmFX+8lMpQ
         rP4qadGIbCTtYXHsXXQoasipYQFo871Hl2p2bdpaLtbmVurpejhT/B4uknKeA0jLMkva
         +a/3kb0JzErn/7iTfRGKpY6lHO8WnCu/6HWrBnZNzcR9ZwQkAlMIybI8jIHkBtxlKtXW
         qk4j9o9JS1x5LEzo/sS7ZZXgE5Y1Wz+0+Ibah3A4i6kM0w48TD3tw0kbkE57ZyPJgHVG
         9NDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b2WGfRK2+UA3n6bV2KvevrdkLr5T4x/xhZPGefawB/E=;
        b=Caj+0NUsEa9F18PCxXxNb/c3ChVSN8iske9K6EyM1RUkCwE8GwEeJrNj18h4pWr58z
         QTkOiVwIk3gdQIbEgfH3czLA3PhTOlYlYLRqLia1luXww22KyE/O95m6XNELHDBNbOXO
         AGZnvQH4pA6Dt6YTBLi6naggamYyyvbQGK0CebJDz62lMYaiBgbo+yNsCeZ7btr4Nk5y
         UvnlvMqUBX6/bSo9mRutIEi3hqitdhObXXaEISnTEXMd5HQEKvh28A6bvNpwkcq8R9Zh
         h5O1QW9zafC0KSwRTCkGkwz3n4tIIeMYp9aHUsAS2Zpgwi1SiHk5kZvUJYD08g3vJDgr
         RIXA==
X-Gm-Message-State: APzg51CvQ41oBReVF4GjeZ7Asn+AqvZ3YpLMd4LVlmY8oFwitaZJTsbV
        VvVLZi7DUzM339L0H6XWA0vvCQ==
X-Google-Smtp-Source: ANB0VdacL/0dh5CqpT7Iwa6/6V2ol+EMzd7jgg7PuzQPRkqkBevVCFCHNZfQ64C0/6VYj/QRGJM7Qg==
X-Received: by 2002:a81:590b:: with SMTP id n11-v6mr5137937ywb.352.1534882277857;
        Tue, 21 Aug 2018 13:11:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:17a0])
        by smtp.gmail.com with ESMTPSA id o74-v6sm1589985ywo.54.2018.08.21.13.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 13:11:16 -0700 (PDT)
Date:   Tue, 21 Aug 2018 16:11:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 8/9] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180821201115.GB24538@cmpxchg.org>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
 <20180801151958.32590-9-hannes@cmpxchg.org>
 <20180803172139.GE2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803172139.GE2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 07:21:39PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 01, 2018 at 11:19:57AM -0400, Johannes Weiner wrote:
> > +			time = READ_ONCE(groupc->times[s]);
> > +			/*
> > +			 * In addition to already concluded states, we
> > +			 * also incorporate currently active states on
> > +			 * the CPU, since states may last for many
> > +			 * sampling periods.
> > +			 *
> > +			 * This way we keep our delta sampling buckets
> > +			 * small (u32) and our reported pressure close
> > +			 * to what's actually happening.
> > +			 */
> > +			if (test_state(groupc->tasks, cpu, s)) {
> > +				/*
> > +				 * We can race with a state change and
> > +				 * need to make sure the state_start
> > +				 * update is ordered against the
> > +				 * updates to the live state and the
> > +				 * time buckets (groupc->times).
> > +				 *
> > +				 * 1. If we observe task state that
> > +				 * needs to be recorded, make sure we
> > +				 * see state_start from when that
> > +				 * state went into effect or we'll
> > +				 * count time from the previous state.
> > +				 *
> > +				 * 2. If the time delta has already
> > +				 * been added to the bucket, make sure
> > +				 * we don't see it in state_start or
> > +				 * we'll count it twice.
> > +				 *
> > +				 * If the time delta is out of
> > +				 * state_start but not in the time
> > +				 * bucket yet, we'll miss it entirely
> > +				 * and handle it in the next period.
> > +				 */
> > +				smp_rmb();
> > +				time += cpu_clock(cpu) - groupc->state_start;
> > +			}
> 
> As is, groupc->state_start needs a READ_ONCE() above and a WRITE_ONCE()
> below. But like stated earlier, doing an update in scheduler_tick() is
> probably easier.

I've wrapped these in READ_ONCE/WRITE_ONCE.

> > +static void psi_group_change(struct psi_group *group, int cpu, u64 now,
> > +			     unsigned int clear, unsigned int set)
> > +{
> > +	struct psi_group_cpu *groupc;
> > +	unsigned int t, m;
> > +	u32 delta;
> > +
> > +	groupc = per_cpu_ptr(group->pcpu, cpu);
> > +
> > +	/*
> > +	 * First we assess the aggregate resource states these CPU's
> > +	 * tasks have been in since the last change, and account any
> > +	 * SOME and FULL time that may have resulted in.
> > +	 *
> > +	 * Then we update the task counts according to the state
> > +	 * change requested through the @clear and @set bits.
> > +	 */
> > +
> > +	delta = now - groupc->state_start;
> > +	groupc->state_start = now;
> > +
> > +	/*
> > +	 * Update state_start before recording time in the sampling
> > +	 * buckets and changing task counts, to prevent a racing
> > +	 * aggregation from counting the delta twice or attributing it
> > +	 * to an old state.
> > +	 */
> > +	smp_wmb();
> > +
> > +	if (test_state(groupc->tasks, cpu, PSI_IO_SOME)) {
> > +		groupc->times[PSI_IO_SOME] += delta;
> > +		if (test_state(groupc->tasks, cpu, PSI_IO_FULL))
> > +			groupc->times[PSI_IO_FULL] += delta;
> > +	}
> > +	if (test_state(groupc->tasks, cpu, PSI_MEM_SOME)) {
> > +		groupc->times[PSI_MEM_SOME] += delta;
> > +		if (test_state(groupc->tasks, cpu, PSI_MEM_FULL))
> > +			groupc->times[PSI_MEM_FULL] += delta;
> > +	}
> 
> Might we worth checking the compiler does the right thing here and
> optimizes this branch fest into something sensible.

Yup, the results looked good. It recognizes that SOME and FULL have
overlapping conditions and then lays out the branches such that it
does not have to do redundant tests. It also recognizes that NONIDLE
is true when any of the other states is true and collapses that.

> > +	if (test_state(groupc->tasks, cpu, PSI_CPU_SOME))
> > +		groupc->times[PSI_CPU_SOME] += delta;
> > +	if (test_state(groupc->tasks, cpu, PSI_NONIDLE))
> > +		groupc->times[PSI_NONIDLE] += delta;
