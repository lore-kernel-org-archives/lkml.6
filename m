Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B36C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B361321722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6fD9eON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B361321722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbeKLPHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:07:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45973 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbeKLPHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:07:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id k15-v6so7779927wre.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 21:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lJJ28nN/A4YvJSOzFsmL0Ogitve3CQMz5eP+fQVHVFM=;
        b=k6fD9eONhGzx5MN7jWptYP/wIFpLqElL0oVXQYJRhenfVAr9NEsIks8I/mI6m+FiNJ
         m+zMVm8ddDsrP/GIJDS8XSP6bfsWxRpa87eP5W5EHRyvkDqjboJVDtxtQfeWpyFiy6hi
         Nd8818OhJYrCp5gVvhQpBes3ppdJ0UfhKsR2XNJOzCKDyoghwRDzeR+zxkjYX0Zp/gRQ
         +4raYSH1PjMEa7HZ9eKYJLlwBpv0bnonU1PCNH/5x8m3WlXBPE1CG+NZTtTzdVur5Wlf
         6aaH2AIEyWwAcqDvWO3NRtrOAw11dWVeOdd0Nakd+6YhQLayRuNcZill53lDVrulxEnd
         Plhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lJJ28nN/A4YvJSOzFsmL0Ogitve3CQMz5eP+fQVHVFM=;
        b=CUeo/mJgbRJ9C1xK3EQFpYyrcdy5cXMZasJ84AITQ6UtrQBdWMoNiX+uZNd1JIeE1Y
         NLS1iC4LnjcuKVfWQ/wasJVVxo/v5Hga0b/pSUDsQdWcO/YeosufeYqTmWwazcd2LKNj
         JBrNXH0HyOcdnaI6zGmob9a92dgxaOIMLj4Eytt82V3GGcpnZ5rUtTrBX1rwyAcQS4sl
         lvQU77NAYALi9NNu+nM2oztgxScNMGbawju8pQr9OwaNkTx7i/qLEayBPO701g0FRWOJ
         ARr1h/5FrM3LFmMf0zK+Rg/mM1CqsjrY1aFQKx87nqcbZTnoIMym2743ZpecPbCJ6Wi6
         fBhQ==
X-Gm-Message-State: AGRZ1gJ08laOwi7pXEYuAle5ZwXlTvBglgRPYLA/3h2VpfYcqYVHP4rP
        yBe5fIIwBu35JdyEAJ7JmAM=
X-Google-Smtp-Source: AJdET5clCOe04gxHgbn/UawCxG9Q1JNecBshFbgsqU5veZ1jh1JRgO3IC4Wobl2oXFHelhPcm4NOuQ==
X-Received: by 2002:a5d:5445:: with SMTP id w5-v6mr15837431wrv.4.1541999740284;
        Sun, 11 Nov 2018 21:15:40 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a126-v6sm6185123wmh.4.2018.11.11.21.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 21:15:39 -0800 (PST)
Date:   Mon, 12 Nov 2018 06:15:37 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/12] locking/lockdep: Add a new class of terminal
 locks
Message-ID: <20181112051537.GB123204@gmail.com>
References: <1541709268-3766-1-git-send-email-longman@redhat.com>
 <20181109080412.GC86700@gmail.com>
 <1fcaa330-a4be-0f8a-7974-7b17f0ce01ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fcaa330-a4be-0f8a-7974-7b17f0ce01ad@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> > Could you please measure a locking intense workload instead, such as:
> >
> >    $ perf stat --null --sync --repeat 10 perf bench sched messaging
> >
> > and profile which locks used there could be marked terminal, and measure 
> > the before/after performance impact?
> 
> I will run the test. It will probably be done after the LPC next week.

Thanks!

> >> Below were selected output lines from the lockdep_stats files of the
> >> patched and unpatched kernels after bootup and running parallel kernel
> >> builds.
> >>
> >>   Item                     Unpatched kernel  Patched kernel  % Change
> >>   ----                     ----------------  --------------  --------
> >>   direct dependencies           9732             8994          -7.6%
> >>   dependency chains            18776            17033          -9.3%
> >>   dependency chain hlocks      76044            68419         -10.0%
> >>   stack-trace entries         110403           104341          -5.5%
> > That's pretty impressive!
> >
> >> There were some reductions in the size of the lockdep tables. They were
> >> not significant, but it is still a good start to rein in the number of
> >> entries in those tables to make it harder to overflow them.
> > Agreed.
> >
> > BTW., if you are interested in more radical approaches to optimize 
> > lockdep, we could also add a static checker via objtool driven call graph 
> > analysis, and mark those locks terminal that we can prove are terminal.
> >
> > This would require the unified call graph of the kernel image and of all 
> > modules to be examined in a final pass, but that's within the principal 
> > scope of objtool. (This 'final pass' could also be done during bootup, at 
> > least in initial versions.)
> >
> > Note that beyond marking it 'terminal' such a static analysis pass would 
> > also allow the detection of obvious locking bugs at the build (or boot) 
> > stage already - plus it would allow the disabling of lockdep for 
> > self-contained locks that don't interact with anything else.
> >
> > I.e. the static analysis pass would 'augment' lockdep and leave only 
> > those locks active for runtime lockdep tracking whose dependencies it 
> > cannot prove to be correct yet.
> 
> It is a pretty interesting idea to use objtool to scan for locks. The
> list of locks that I marked as terminal in this patch was found by
> looking at /proc/lockdep for those that only have backward dependencies,
> but no forward dependency. I focused on those with a large number of BDs
> and check the code to see if they could marked as terminal. This is a
> rather labor intensive process and is subject to error.

Yeah.

> [...] It would be nice if it can be done by an automated tool. So I am 
> going to look into that, but it won't be part of this initial patchset, 
> though.

Of course!

> I sent this patchset out to see if anyone has any objection to it. It
> seems you don't have any objection to that. So I am going to move ahead
> to do more testing and performance analysis.

The one worry I have is that this interim solution removes the benefit of 
a proper static analysis method.

But if you promise to make a serious effort on the static analysis 
tooling as well (which should have awesome performance results and 
automate the manual markup), then I have no fundamental objections to the 
interim approach either.

If static analysis works as well as I expect it to then in principle we 
might even be able to have lockdep enabled in production kernels: it 
would only add overhead to locks that are overly complex - which would 
create incentives to improve those dependencies.

Thanks,

	Ingo
