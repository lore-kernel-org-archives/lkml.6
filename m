Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9D3ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0C721471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hpatF2We"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0C721471
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbeIRV0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:26:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36352 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbeIRV0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:26:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id e1-v6so2684892wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 08:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mIa6Yf8EkdXGAgTYi62JjYg8eTugXzn7NDHtxwfIEJE=;
        b=hpatF2WeoMBRAGf8wg6kgOpJRz4JTMPlXqZv9cHAFqY7r0/f2iWhDh+ruY5mH8nipc
         6qQ3dfAT9FmyBHv10l/Z31NnahKwa+i/fHLcgsL3rcsQky7VUYISb1aWVBZeWKzfk51J
         7FN3WzQfAVBd1z+9qSl/tpzIJokXNkFdL0GWZcuw4Og4cVqQCdMZtgFY6MNbgOPouAmp
         mLI3yNYyqvLliOy6ccLMPRwK2/eKEX2yfSesT0Q1l17+W2huYGkBCvLaHMBYIV5H196Q
         KEKlImBxcUweb8aS+V2wGuD2Z2LrxGpiGntNR4IOc8FMI0HZH2nYcg1hvzspBgeZ5q4D
         Dknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mIa6Yf8EkdXGAgTYi62JjYg8eTugXzn7NDHtxwfIEJE=;
        b=M4b2ILh1Jo/4Z/SuFdrfdX4KNlLN/PGN+qRCS/uCWjRNySSGiqX5XV94zi8gtKJETm
         +D8MzurDhuytWuZ/iaFd9kRognwzn93Jai2rTAIa/5f5heWJkqj0m4gW/a2B1P++WCXW
         R+xtZQXDzZR9db6Ck2PSLrA2R0zVSSHzdcV4Fu2Zk/z/Nh1V0FJFBh5sb5bUECo0Wbwp
         72GKn61Sis0ttHJmzGBEM+CFHiwv1FT75/Gy2ifOk3SGoTno+2LB3r12jIkuaUcFfnif
         Vs4avAnerRDlXHMTDbcWD76pOGkY53uAFCV9yM3TAOLmxLdmNznK34Gde8QdC4bOzfwp
         DT4A==
X-Gm-Message-State: APzg51DBZfmJwT+HxU+e2HQgdcJnvZT8KrI5PkTzLo+TiK/avkZI6P5J
        flIscY3toyvuoNxy6rG9S95sX+M9frZSXtKR7XxFbQ==
X-Google-Smtp-Source: ANB0VdZzVMooQoSW6cPyVvJNzTfRLo3iPgzG/LB5Rq0FkDeAUuvacG0LQ1U+fskMa5r+JC2WLgOJwW4AEKsZ+63X4Ss=
X-Received: by 2002:adf:f24e:: with SMTP id b14-v6mr22185100wrp.184.1537286015426;
 Tue, 18 Sep 2018 08:53:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:c710:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 08:53:35
 -0700 (PDT)
In-Reply-To: <CAD8Lp47F5N8xN41KFHybVVTpV_TEewERD-eJov6iiqBJUyVR9g@mail.gmail.com>
References: <20180828172258.3185-1-hannes@cmpxchg.org> <20180905214303.GA30178@cmpxchg.org>
 <20180907110407.GQ24106@hirez.programming.kicks-ass.net> <20180907150955.GC11088@cmpxchg.org>
 <CAJuCfpG1=pXOg=1GwC33Uy0BcXNq-BsR6dO0JJq4Jnm5TyNENQ@mail.gmail.com> <CAD8Lp47F5N8xN41KFHybVVTpV_TEewERD-eJov6iiqBJUyVR9g@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 18 Sep 2018 08:53:35 -0700
Message-ID: <CAJuCfpEmFC94HYkfDSruhrBzvnEWqFO87RXkb7MDb6yV40wPPg@mail.gmail.com>
Subject: Re: [PATCH 0/9] psi: pressure stall information for CPU, memory, and
 IO v4
To:     Daniel Drake <drake@endlessm.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm <linux-mm@kvack.org>,
        cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Sun, Sep 16, 2018 at 10:22 PM, Daniel Drake <drake@endlessm.com> wrote:
> Hi Suren
>
> On Fri, Sep 7, 2018 at 11:58 PM, Suren Baghdasaryan <surenb@google.com> wrote:
>> Thanks for the new patchset! Backported to 4.9 and retested on ARMv8 8
>> code system running Android. Signals behave as expected reacting to
>> memory pressure, no jumps in "total" counters that would indicate an
>> overflow/underflow issues. Nicely done!
>
> Can you share your Linux v4.9 psi backport somewhere?
>

Absolutely. Let me figure out what's the best way to do share that and
make sure they apply cleanly on official 4.9 (I was using vendor's
tree for testing). Will need a day or so to get this done.
In case you need them sooner, there were several "prerequisite"
patches that I had to backport to make PSI backporting
easier/possible. Following is the list as shown by "git log
--oneline":

PSI patches:

ef94c067f360 psi: cgroup support
60081a7aeb0b psi: pressure stall information for CPU, memory, and IO
acd2a16497e9 sched: introduce this_rq_lock_irq()
f30268c29309 sched: sched.h: make rq locking and clock functions
available in stats.h
a2fd1c94b743 sched: loadavg: make calc_load_n() public
32a74dec4967 sched: loadavg: consolidate LOAD_INT, LOAD_FRAC, CALC_LOAD
8e3991dd1a73 delayacct: track delays from thrashing cache pages
4ae940e7e6ff mm: workingset: tell cache transitions from workingset thrashing
e9ccd63399e0 mm: workingset: don't drop refault information prematurely

Prerequisites:

b5a58c778c54 workqueue: make workqueue available early during boot
ae5f39ee13b5 sched/core: Add wrappers for lockdep_(un)pin_lock()
7276f98a72c1 sched/headers, delayacct: Move the 'struct
task_delay_info' definition from <linux/sched.h> to
<linux/delayacct.h>
287318d13688 mm: add PageWaiters indicating tasks are waiting for a page bit
edfa64560aaa sched/headers: Remove <linux/sched.h> from <linux/sched/loadavg.h>
f6b6ba853959 sched/headers: Move loadavg related definitions from
<linux/sched.h> to <linux/sched/loadavg.h>
395b0a9f7aae sched/headers: Prepare for new header dependencies before
moving code to <linux/sched/loadavg.h>

PSI patches needed some adjustments but nothing really major.

> Thanks
> Daniel

Thanks,
Suren.
