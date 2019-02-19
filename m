Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C05C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981CB21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550589342;
	bh=UXTMAp77lww4+bpz0feGZIr6yC0jdEDLoANQ94Kolv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pxKLT6fSigX0BQXXvaHeG+ZE9wr2VhTiLW7/SC3BPdFzdHEc1jVOZaQOlWuaiUlpo
	 8v6wVgsn5PKYC/jYxbeglDYfUaE/KZvpi8m3CofTjlBy+LQzegnhdwNOUwG4mb79bT
	 FaX1HkHTr/HPUdwpRGRNDg+n1rMDDgWVVpVXh6Ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfBSPPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:15:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33340 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfBSPPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:15:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so22464323wrw.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 07:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qFvOZomIzscHI8SzO5TYj9sCxqNsD4z/vDs+D6ZY0HE=;
        b=PvBTocvvxmq7eIx2yqw2xBmSy5ixRtixtgAnx3znKSWtWkSRE3oF8sOA+3XKxhUXkc
         Kj2Mp6vfBvTSbvcR2H80V4FBzuLA81MAOa9t3CGouSztHSGrm2iI70Eb2Eg7p7JolHIb
         Qy4TCAGkAEHB5fmvXwz4J5ZpuNVpNziHLu8zxj9mtNJotR53M2oJzoF8rh8SPMAzNSvr
         98Qic2th1CZxzAoYq8ulOGUcbKQ1RVSB7n4FcOM+o8q9QqxPkPPbDZND9anJTJ3FeInO
         el2VeoDft9dIKv1EdJ2rL0QbU7bhw3MYX1lJf9mVwEwdxO5WvttRzr1b+ssWrRb4kf9m
         /LBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qFvOZomIzscHI8SzO5TYj9sCxqNsD4z/vDs+D6ZY0HE=;
        b=EOSDLId+3I+5R+EmFbZy1i0TbUnBGLxInP6v+/g0QUS9FLNJmw3bwwvSraDn41uIuM
         9o0+FQusM08K8N1B1+rHhVpvT84YEqVi408CfqHuFnbuvaxCbSy6r+Gs8mLfMARimRWe
         tpHbOrj63FhmRuKKgJoAOIdJr2EtOT8Pmj6WGWUEmQypCoiwXp0ch/ijXfVq9P7N9Gy4
         Ab0bY7y7GAiD+1bOiq/79jiSWszTMPHAhCti+aEi7do745V96a23Ibj4kPaBmH6WmXX/
         yj84YhgP5AaMezkZldIXNxppuhuQludAnKKUBtR1Jzp4FiYWptI0Aci44Oa3mENNl5qf
         AcPw==
X-Gm-Message-State: AHQUAuamLdKi1WR6lMzEarjoOnCUmyBBJMXphdWk30H0F4KIZtOemqwN
        s/MEwi9NI+R23LaLnDpMpAc=
X-Google-Smtp-Source: AHgI3IakFUZRh5/WBdhybJN3TE8+dgKRWWMa4OiqabCUAkqkUfZgBr3UNQ0XXicSKH+d1c8s8tZ02g==
X-Received: by 2002:adf:fc12:: with SMTP id i18mr19812687wrr.201.1550589336018;
        Tue, 19 Feb 2019 07:15:36 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t2sm1513257wmi.37.2019.02.19.07.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 07:15:35 -0800 (PST)
Date:   Tue, 19 Feb 2019 16:15:32 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        subhra.mazumdar@oracle.com,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>, kerrnel@google.com
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
Message-ID: <20190219151532.GA40581@gmail.com>
References: <20190218165620.383905466@infradead.org>
 <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <20190218204020.GV32494@hirez.programming.kicks-ass.net>
 <CAHk-=whVrNomWXRmCjnBJkosiwiGXz5pYb63aXy=nSPGjvc-1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whVrNomWXRmCjnBJkosiwiGXz5pYb63aXy=nSPGjvc-1g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Feb 18, 2019 at 12:40 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > If there were close to no VMEXITs, it beat smt=off, if there were lots
> > of VMEXITs it was far far worse. Supposedly hosting people try their
> > very bestest to have no VMEXITs so it mostly works for them (with the
> > obvious exception of single VCPU guests).
> >
> > It's just that people have been bugging me for this crap; and I figure
> > I'd post it now that it's not exploding anymore and let others have at.
> 
> The patches didn't look disgusting to me, but I admittedly just
> scanned through them quickly.
> 
> Are there downsides (maintenance and/or performance) when core
> scheduling _isn't_ enabled? I guess if it's not a maintenance or
> performance nightmare when off, it's ok to just give people the
> option.

So this bit is the main straight-line performance impact when the 
CONFIG_SCHED_CORE Kconfig feature is present (which I expect distros to 
enable broadly):

  +static inline bool sched_core_enabled(struct rq *rq)
  +{
  +       return static_branch_unlikely(&__sched_core_enabled) && rq->core_enabled;
  +}

   static inline raw_spinlock_t *rq_lockp(struct rq *rq)
   {
  +       if (sched_core_enabled(rq))
  +               return &rq->core->__lock
  +
          return &rq->__lock;


This should at least in principe keep the runtime overhead down to more 
NOPs and a bit bigger instruction cache footprint - modulo compiler 
shenanigans.

Here's the code generation impact on x86-64 defconfig:

   text	   data	    bss	    dec	    hex	filename
    228	     48	      0	    276	    114	sched.core.n/cpufreq.o (ex sched.core.n/built-in.a)
    228	     48	      0	    276	    114	sched.core.y/cpufreq.o (ex sched.core.y/built-in.a)

   4438	     96	      0	   4534	   11b6	sched.core.n/completion.o (ex sched.core.n/built-in.a)
   4438	     96	      0	   4534	   11b6	sched.core.y/completion.o (ex sched.core.y/built-in.a)

   2167	   2428	      0	   4595	   11f3	sched.core.n/cpuacct.o (ex sched.core.n/built-in.a)
   2167	   2428	      0	   4595	   11f3	sched.core.y/cpuacct.o (ex sched.core.y/built-in.a)

  61099	  22114	    488	  83701	  146f5	sched.core.n/core.o (ex sched.core.n/built-in.a)
  70541	  25370	    508	  96419	  178a3	sched.core.y/core.o (ex sched.core.y/built-in.a)

   3262	   6272	      0	   9534	   253e	sched.core.n/wait_bit.o (ex sched.core.n/built-in.a)
   3262	   6272	      0	   9534	   253e	sched.core.y/wait_bit.o (ex sched.core.y/built-in.a)

  12235	    341	     96	  12672	   3180	sched.core.n/rt.o (ex sched.core.n/built-in.a)
  13073	    917	     96	  14086	   3706	sched.core.y/rt.o (ex sched.core.y/built-in.a)

  10293	    477	   1928	  12698	   319a	sched.core.n/topology.o (ex sched.core.n/built-in.a)
  10363	    509	   1928	  12800	   3200	sched.core.y/topology.o (ex sched.core.y/built-in.a)

    886	     24	      0	    910	    38e	sched.core.n/cpupri.o (ex sched.core.n/built-in.a)
    886	     24	      0	    910	    38e	sched.core.y/cpupri.o (ex sched.core.y/built-in.a)

   1061	     64	      0	   1125	    465	sched.core.n/stop_task.o (ex sched.core.n/built-in.a)
   1077	    128	      0	   1205	    4b5	sched.core.y/stop_task.o (ex sched.core.y/built-in.a)

  18443	    365	     24	  18832	   4990	sched.core.n/deadline.o (ex sched.core.n/built-in.a)
  20019	   2189	     24	  22232	   56d8	sched.core.y/deadline.o (ex sched.core.y/built-in.a)

   1123	      8	     64	   1195	    4ab	sched.core.n/loadavg.o (ex sched.core.n/built-in.a)
   1123	      8	     64	   1195	    4ab	sched.core.y/loadavg.o (ex sched.core.y/built-in.a)

   1323	      8	      0	   1331	    533	sched.core.n/stats.o (ex sched.core.n/built-in.a)
   1323	      8	      0	   1331	    533	sched.core.y/stats.o (ex sched.core.y/built-in.a)

   1282	    164	     32	   1478	    5c6	sched.core.n/isolation.o (ex sched.core.n/built-in.a)
   1282	    164	     32	   1478	    5c6	sched.core.y/isolation.o (ex sched.core.y/built-in.a)

   1564	     36	      0	   1600	    640	sched.core.n/cpudeadline.o (ex sched.core.n/built-in.a)
   1564	     36	      0	   1600	    640	sched.core.y/cpudeadline.o (ex sched.core.y/built-in.a)

   1640	     56	      0	   1696	    6a0	sched.core.n/swait.o (ex sched.core.n/built-in.a)
   1640	     56	      0	   1696	    6a0	sched.core.y/swait.o (ex sched.core.y/built-in.a)

   1859	    244	     32	   2135	    857	sched.core.n/clock.o (ex sched.core.n/built-in.a)
   1859	    244	     32	   2135	    857	sched.core.y/clock.o (ex sched.core.y/built-in.a)

   2339	      8	      0	   2347	    92b	sched.core.n/cputime.o (ex sched.core.n/built-in.a)
   2339	      8	      0	   2347	    92b	sched.core.y/cputime.o (ex sched.core.y/built-in.a)

   3014	     32	      0	   3046	    be6	sched.core.n/membarrier.o (ex sched.core.n/built-in.a)
   3014	     32	      0	   3046	    be6	sched.core.y/membarrier.o (ex sched.core.y/built-in.a)

  50027	    964	     96	  51087	   c78f	sched.core.n/fair.o (ex sched.core.n/built-in.a)
  51537	   2484	     96	  54117	   d365	sched.core.y/fair.o (ex sched.core.y/built-in.a)

   3192	    220	      0	   3412	    d54	sched.core.n/idle.o (ex sched.core.n/built-in.a)
   3276	    252	      0	   3528	    dc8	sched.core.y/idle.o (ex sched.core.y/built-in.a)

   3633	      0	      0	   3633	    e31	sched.core.n/pelt.o (ex sched.core.n/built-in.a)
   3633	      0	      0	   3633	    e31	sched.core.y/pelt.o (ex sched.core.y/built-in.a)

   3794	    160	      0	   3954	    f72	sched.core.n/wait.o (ex sched.core.n/built-in.a)
   3794	    160	      0	   3954	    f72	sched.core.y/wait.o (ex sched.core.y/built-in.a)

I'd say this one is representative:

   text	   data	    bss	    dec	    hex	filename
  12235	    341	     96	  12672	   3180	sched.core.n/rt.o (ex sched.core.n/built-in.a)
  13073	    917	     96	  14086	   3706	sched.core.y/rt.o (ex sched.core.y/built-in.a)

which ~6% bloat is primarily due to the higher rq-lock inlining overhead, 
I believe.

This is roughly what you'd expect from a change wrapping all 350+ inlined 
instantiations of rq->lock uses. I.e. it might make sense to uninline it.

In terms of long term maintenance overhead, ignoring the overhead of the 
core-scheduling feature itself, the rq-lock wrappery is the biggest 
ugliness, the rest is mostly isolated.

So if this actually *works* and improves the performance of some real 
VMEXIT-poor SMT workloads and allows the enabling of HyperThreading with 
untrusted VMs without inviting thousands of guest roots then I'm 
cautiously in support of it.

> That all assumes that it works at all for the people who are clamoring 
> for this feature, but I guess they can run some loads on it eventually. 
> It's a holiday in the US right now ("Presidents' Day"), but maybe we 
> can get some numebrs this week?

Such numbers would be *very* helpful indeed.

Thanks,

	Ingo
