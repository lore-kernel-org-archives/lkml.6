Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29811C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BBC21A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="CoCMzqzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BBC21A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbeHFRac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:30:32 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42977 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbeHFRac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:30:32 -0400
Received: by mail-qk0-f194.google.com with SMTP id 13-v6so6479212qkl.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h+72NQHnVkw3JzF7vSCUqCLRqDUBnExu3aTIRjzL7UQ=;
        b=CoCMzqzoYcTFmx000b8rNbHI4R45SGuXMX7WwraKp1WQingX7hWPLQsH2yLNZZNKA4
         VwfNXJqbPKUPqtsle2r4g8kRNsolpAe8qZhoKlTJh9KUJ9X11zGks/ZrNuzDt8y2Ktpz
         0o8CGXsBjD+ds/MEGkt0Q8pKvRqmr+wvvU9RglL0BdEsSpryYENJq1GOva3nzzjlK48L
         PpoZ4Sj0NQ9PFwNHzFaPHWDOgAMa/RrxYewv+FyPfCkT7MyKmYo/wlU19VXehfy0dmpR
         trRqAAHGL7mOcPuSnziZkWO/HqBk7uS5PtodZ0ce4yIbB/wYlYlm5RJVl62ItLPUO1TS
         bbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h+72NQHnVkw3JzF7vSCUqCLRqDUBnExu3aTIRjzL7UQ=;
        b=ndXcU0hl7jF7/yGZOMS+z3ozfzKAvSUjWxtTDZDNqnLjZD4uEsQDWz3QZMlda+r2Xm
         Fv7abS3AqX6ScY4CHg2kCHCVFAtfYr2dxOtaMcAS4FY7XQXTF8yfy4bVrnBwjnw70kQU
         z4g/sptGxiv8B3EOvUxVnKbW43nRLNHFkuesCPxk3gJ3Ch+boQcizhdOQAPo60lJLD5+
         TeMohHZkV4kCNWnCutVvJR92bxSNdSB6inokszGuR+1S545mRP9ZCL4BWTq9fvkIzL13
         3KYl93OCd3gy6sNE1Fv7je6aQpx3JYCy53bkVbY9Afcv0BBS/qMtjmtGlqouqtR0HU/P
         bOTA==
X-Gm-Message-State: AOUpUlHgeDyQlvtv8AtRH+7OG87zOxsbbtwvYpy7kHJ4itmfvbv8cDGX
        HCTlZMWGud5Poatrev6WZ6++oA==
X-Google-Smtp-Source: AAOMgpcZ6CXyW5rS5m1nixaTvdFXb8PkEhl8sStzhgBazxV6ZOf+DHQXSvx8jO3lKJjqgAr6GESIdQ==
X-Received: by 2002:a37:2a04:: with SMTP id q4-v6mr13014144qkh.191.1533568856885;
        Mon, 06 Aug 2018 08:20:56 -0700 (PDT)
Received: from localhost (pool-96-246-38-36.nycmny.fios.verizon.net. [96.246.38.36])
        by smtp.gmail.com with ESMTPSA id j45-v6sm10753705qta.46.2018.08.06.08.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 08:20:55 -0700 (PDT)
Date:   Mon, 6 Aug 2018 11:23:54 -0400
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
Message-ID: <20180806152354.GC9888@cmpxchg.org>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
 <20180801151958.32590-9-hannes@cmpxchg.org>
 <20180803170733.GC2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803170733.GC2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 07:07:33PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 01, 2018 at 11:19:57AM -0400, Johannes Weiner wrote:
> > +static bool psi_update_stats(struct psi_group *group)
> > +{
> > +	u64 deltas[NR_PSI_STATES - 1] = { 0, };
> > +	unsigned long missed_periods = 0;
> > +	unsigned long nonidle_total = 0;
> > +	u64 now, expires, period;
> > +	int cpu;
> > +	int s;
> > +
> > +	mutex_lock(&group->stat_lock);
> > +
> > +	/*
> > +	 * Collect the per-cpu time buckets and average them into a
> > +	 * single time sample that is normalized to wallclock time.
> > +	 *
> > +	 * For averaging, each CPU is weighted by its non-idle time in
> > +	 * the sampling period. This eliminates artifacts from uneven
> > +	 * loading, or even entirely idle CPUs.
> > +	 *
> > +	 * We don't need to synchronize against CPU hotplugging. If we
> > +	 * see a CPU that's online and has samples, we incorporate it.
> > +	 */
> > +	for_each_online_cpu(cpu) {
> 
> I'm still puzzled by this.. for 99% of the machines online == possible.
> Why not always iterate possible and leave it at that? This is hardly a
> fast path.

Hmm, you're right, that makes things much simpler. I guess I'm mostly
worried about the 1% where this significantly differs, but it looks
like we're smarter than simply doing CONFIG_NR_CPUS for the possible
map, and we can easily stomach a bit of discrepancy in this path.

I'll change that to possible and delete/update the third paragraph.

Thanks
