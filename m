Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE61ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7A72075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="jVXcicgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7A72075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbeGRXOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:14:00 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34466 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbeGRXOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:14:00 -0400
Received: by mail-yw0-f195.google.com with SMTP id j68-v6so2349788ywg.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mdcasbT5nuYq6T0zUYdhs6kUC62eS5unO9iAl6OFIhg=;
        b=jVXcicgSqZHNrhICIqsWLnHN4/6/aFMac/r4iWo5HSuaRFGbFNvUHNLOU4Os+p/OSj
         15tedgLd5o4vIEn490auASvCe1n6fLh8zndQz1R3c8NmVkXzLYW0zgralbYxLx3uBuA5
         /OemkmXuvCOje1koOHZmEsFOrmoQQvHEo153dj5nulnfsCrecnhsJf69CGWbZSJVbfXP
         +fLXGoyrPnl9eAWjU5Phl/M6bdyMAvG1Irkj8tPOIH+QiytLcXUw3SzW4pi6APL9p7ks
         S9SdBH4ZNBJc/TOBxBLSSW6z5ZHQ4zdNrrNNDkylfyDscem/vJhbHq5qsovl0F4m9TRJ
         5i0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mdcasbT5nuYq6T0zUYdhs6kUC62eS5unO9iAl6OFIhg=;
        b=N3TWk0uzHirde8KqQNX+u2XNxv5v0W2WwgqGkNVTEm4VPIQBaR7kVpozho4mOmHM/S
         HoyLDXvMYtIfXAKAD6FmNMcyWcUpNULJjPMGiprrYIJdr62Q/1xaeaEZtDHY9koDNVoF
         /c9W3XNnVCZWvFUGfB/deazXnc5gHU0efSP1DFxb9j5wtF82KmeOKLPMBfkZEGYlYT/I
         7XRyA3O2W0stKHp1yN3MCbti3YSlZ1TuvdMHp96jni14at7TkPfSqEKPoA4iFXTRQaJ/
         UT7Q4cTC7vFCKkqY7G6EYUhDBHa3nrIrU7xDpRU3SqHh3/3aRDnnZvQoy7j/c10dKSqd
         ywgg==
X-Gm-Message-State: AOUpUlF84kDo6x5uBozceAb+41g6spW+ZWlsUY5FZvFPU80zZMij4ktw
        gcNl7Dwy52BORu9Lm+qe77PEww==
X-Google-Smtp-Source: AAOMgpeJP34uVXc9vSvoMo/vX9VFywck4+7N5vvlgx1ELp2vCagY1gU1kjzmPAGWGZftKNPB05isVA==
X-Received: by 2002:a81:203:: with SMTP id 3-v6mr3930058ywc.457.1531953238219;
        Wed, 18 Jul 2018 15:33:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:7eca])
        by smtp.gmail.com with ESMTPSA id c2-v6sm1975210ywf.94.2018.07.18.15.33.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 15:33:57 -0700 (PDT)
Date:   Wed, 18 Jul 2018 18:36:44 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180718223644.GH2838@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180718120318.GC2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718120318.GC2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 02:03:18PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> > +	/* Time in which tasks wait for the CPU */
> > +	state = PSI_NONE;
> > +	if (tasks[NR_RUNNING] > 1)
> > +		state = PSI_SOME;
> > +	time_state(&groupc->res[PSI_CPU], state, now);
> > +
> > +	/* Time in which tasks wait for memory */
> > +	state = PSI_NONE;
> > +	if (tasks[NR_MEMSTALL]) {
> > +		if (!tasks[NR_RUNNING] ||
> > +		    (cpu_curr(cpu)->flags & PF_MEMSTALL))
> 
> I'm confused, why do we care if the current tasks is MEMSTALL or not?

We want to know whether we're losing CPU potential because of a lack
of memory. That can happen when the task waits for refaults and the
CPU goes idle, but it can also happen when the CPU is performing
reclaim.

If the task waits for refaults and something else is runnable, we're
not losing CPU potential. But if the task performs reclaim and uses
the CPU, nothing else can do productive work on that CPU.
