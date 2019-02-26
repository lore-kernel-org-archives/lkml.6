Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E17C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFD821874
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HHE1Crps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfBZViy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:38:54 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36042 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbfBZViy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 16:38:54 -0500
Received: by mail-qk1-f195.google.com with SMTP id c2so7882545qkb.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 13:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pm3Z19EgiB4tZ2QGWf/agC8qxf26nmME/9Tbpufp1nk=;
        b=HHE1CrpsEffY5nwBKcWP8cZYUtSyj+D2mQ+d1Fq/yAezaZ1do97tN3znKKXF7tKPg8
         YJFWjUrKCud7NUU4GmhohT3yoTla6IiXGTdDw9XxqWoRd3jbgJvlhcHnUHvsn7FgIYeJ
         V/I64QXOyKbFIROs/w2vugB647+Bs2A4i1h6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pm3Z19EgiB4tZ2QGWf/agC8qxf26nmME/9Tbpufp1nk=;
        b=Ui610rAuPlDrhLAtF6+d2mB+Ku16KtuDjtKQ1fTFaxMeA6pjos55Fcjq1g6KJhBr2h
         qn1bhWYbJCYM9rf8AMFtaj6HbbKpObiNgFzKQiQ0nQHSFMHzIjQKSuOJd/1miTrXFkqk
         4pFY5rnXfGCHvg5oEEm2cFGBLvLAGCvx9kMFUGheazgvg2ufPhaRNeyOUq8Lf85TJpLQ
         SytihVd7AB4AhtfSh74ufFnVxY5rC+Z3cL91jVXkLgXOFIqRpFXcFPEi+jHux7yTPL76
         7eyEMA4tU0otmeCD4Mku5oUfaKh84/ii7GSqWmT9TW+b1mL5Bun3dhhXOdu7pNbB9n28
         W4MA==
X-Gm-Message-State: AHQUAuYYKefucmen/+Bkq3cWPSS0NWVIGolMkyCfCLF9yRZK6PZh2emH
        eqFo+c/+iD3DUMRuqIcahhdPCg==
X-Google-Smtp-Source: AHgI3IazL1MWsf6RjAfHG6Ql6+AqGQ/we9wEIV162mcYXzeiUXqbx6r14ANEhhuXuBmTrNbO2W8iRg==
X-Received: by 2002:a37:340c:: with SMTP id b12mr18735302qka.144.1551217132342;
        Tue, 26 Feb 2019 13:38:52 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id s72sm7830245qka.10.2019.02.26.13.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 13:38:51 -0800 (PST)
Date:   Tue, 26 Feb 2019 16:38:50 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/4] tracing/probes: uaccess: Add support user-space
 access
Message-ID: <20190226213850.GA219025@google.com>
References: <155110348217.21156.3874419272673328527.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155110348217.21156.3874419272673328527.stgit@devbox>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 11:04:42PM +0900, Masami Hiramatsu wrote:
> Hi,
> 
> Here is an RFC series of probe-event to support user-space access
> methods, which we discussed in previous thread.
> 
> https://lkml.kernel.org/r/20190220171019.5e81a4946b56982f324f7c45@kernel.org
> 
> So in this thread, it is clear that current probe_kernel_read()
> and strncpy_from_unsafe() are not enough to access user-space
> variables from kprobe events on some arch. On such arch, user
> address space and kernel address space can overlap so we have
> to change the memory segment to user-mode before copying.
> But probe_kernel_read() is designed to access primarily kernel
> memory, it may fail to get, or get unexpected value on such
> arch. So we need to expand kprobe fetcharg to support new options
> for such case.
> 
> For user-space access extension, this series adds 2 features,
> "ustring" type and user-space dereference syntax. "ustring" is
> used for recording a null-terminated string in user-space from
> kprobe events.
> 
> "ustring" type is easy, it is able to use instead of "string"
> type, so if you want to record a user-space string via
> "__user char *", you can use ustring type instead of string.
> For example,
> 
> echo 'p do_sys_open path=+0($arg2):ustring' >> kprobe_events
> 
> will record the path string from user-space.
> 
> The user-space dereference syntax is also simple. Thi just
> adds 'u' prefix before an offset value.
> 
>    +|-u<OFFSET>(<FETCHARG>)
> 
> e.g. +u8(%ax), +u0(+0(%si))
> 
> This is more generic. If you want to refer the variable in user-
> space from its address or access a field in data structure in
> user-space, you need to use this.
> 
> For example, if you probe do_sched_setscheduler(pid, policy,
> param) and record param->sched_priority, you can add new
> probe as below;
>     
>    p do_sched_setscheduler priority=+u0($arg3)
> 
> Actually, with this feature, "ustring" type is not absolutely
> necessary, because these are same meanings.
> 
>   +0($arg2):ustring == +u0($arg2):string
> 
> Perhups, we may be better removing "ustring" and just introducing
> this user-space dereference syntax...
> 
> Note that kprobe event provides these methods, but it doesn't
> change it from kernel to user automatically because we do not
> know whether the given address is in userspace or kernel on
> some arch.
> Moreover, from perf-probe, at this moment it is not able to
> switch. Since __user is not for compiler but checker, we have
> no clue which data structure is in user-space, in debuginfo.
> 
> BTW, according to Linus's comment, I implemented probe_user_read()
> and strncpy_from_unsafe_user() APIs. And since those use
> "access_ok()" inside it, if CONFIG_DEBUG_ATOMIC_SLEEP=y on x86,
> it will get a warn message at once. It should be solved before
> merging this series.

I was wondering why access_ok() can sleep. In the arm64 and x86
implementation, I don't see access_ok() itself causing a user pointer
dereference access that can cause a page fault. It seems to just be checking
the validity of the ranges.

Any idea why the access_ok() code has these comments?
"Context: User context only. This function may sleep if pagefaults are
enabled."

My _guess_ is this is because whatever calls access_ok() may also call
something else that *does* fault next, if that's the case then that
WARN_ON_IN_IRQ() in access_ok() is fine, but at least I guess the comments
should be more clear that it is not access_ok() itself that sleeps.

thanks for any help on understanding this,

 - Joel


> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (4):
>       uaccess: Make sure kernel_uaccess_faults_ok is updated before pagefault
>       uaccess: Add non-pagefault user-space read functions
>       tracing/probe: Add ustring type for user-space string
>       tracing/probe: Support user-space dereference
> 
> 
>  Documentation/trace/kprobetrace.rst  |   13 ++-
>  Documentation/trace/uprobetracer.rst |    9 +-
>  fs/namespace.c                       |    2 
>  include/linux/uaccess.h              |   13 +++
>  kernel/trace/trace.c                 |    7 +-
>  kernel/trace/trace_kprobe.c          |   65 ++++++++++++++++
>  kernel/trace/trace_probe.c           |   39 ++++++++--
>  kernel/trace/trace_probe.h           |    3 +
>  kernel/trace/trace_probe_tmpl.h      |   36 +++++++--
>  kernel/trace/trace_uprobe.c          |   19 +++++
>  mm/maccess.c                         |  138 ++++++++++++++++++++++++++++++----
>  11 files changed, 302 insertions(+), 42 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
