Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4713C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E58A20BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E58A20BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389695AbeGLArv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:47:51 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44473 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388683AbeGLAru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:47:50 -0400
Received: by mail-io0-f196.google.com with SMTP id q19-v6so26256757ioh.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7iprcpX3pvTEdMCbDnh2jG3MsV7K+ssdsJkEDAGGItk=;
        b=QtD3PFIfZcIJYM8Zp0t0IMDgabYXETiuzMvxt9KASMye2TnHqktkBvXgLsLTq53n7G
         u4DhZP9yu609mUS5ol88+qa/npKHNJydM7UlTVqnzAfxsoCS699eDVFnDflG7sbxmYhf
         Z5OrOVqp/nDxd8LQB++zS4frYailPCmaBu2jBdyDfPYXdFMpB+x6k/tUelodiT2J4gev
         Othe4Jp44FWUn0VYsG/6IZ9yDib96qunlE//lRFnI7/MEp9SB1Ib/oU+Mkx5omAhSEoF
         J3g5xZdB4mzxyMFLL7y5o8cR4QprpNKrza7qpn8Scs8IgDDJtcCUbaPCMr5cn89hRoqv
         uHZA==
X-Gm-Message-State: APt69E1QQkdXEe50N3tVrzuSOzET67ZQisTbz3CweW/tM/jLH2xSBUMA
        McO8fUhYPYHFJPRtHHxMsalN13O59bpNMweFY44=
X-Google-Smtp-Source: AAOMgpfH8/l4LsMxanMpTmPyZ5eaPf/Hu27YeoInfplHVE1eAaywpqE1AMzeopzU2VBJOoJFHObIS3r/UnvUCwmfMWQ=
X-Received: by 2002:a6b:8fd4:: with SMTP id r203-v6mr27134421iod.24.1531356056480;
 Wed, 11 Jul 2018 17:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <1500044315-9508-1-git-send-email-francis.deslauriers@efficios.com>
 <1500044315-9508-3-git-send-email-francis.deslauriers@efficios.com>
 <20170714142900.1c91949c@gandalf.local.home> <CADcCL0i_Rw9dRkrTUXiVK4dXOXD6QsRrBRc_pJ3XB_SyEqPR5w@mail.gmail.com>
 <20180316112517.66bdd85a@gandalf.local.home> <229385456.11580.1521217739037.JavaMail.zimbra@efficios.com>
 <20180316124134.30fa47d5@gandalf.local.home> <20180316124840.3e83bbec@gandalf.local.home>
 <1577244734.11604.1521222781948.JavaMail.zimbra@efficios.com>
 <20180317091334.55f1fc325c26deaa4d4a4d19@kernel.org> <20180317102211.a648f26ae0d5a53d95c63022@kernel.org>
 <20180703183048.1eeeef4a@gandalf.local.home> <CADcCL0gFTR2s7X_a8CiqHBeFyy3mR15jF48tOyZoJ3zbDA9KZA@mail.gmail.com>
 <20180711155628.78b0fd83@gandalf.local.home>
In-Reply-To: <20180711155628.78b0fd83@gandalf.local.home>
From:   Francis Deslauriers <francis.deslauriers@efficios.com>
Date:   Wed, 11 Jul 2018 20:40:45 -0400
Message-ID: <CADcCL0hz7GOW=+pzMcwktiMx+g7NTV3ua41zU0UHHSjHQdGKQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kprobe: fix: Add ftrace_ops_assist_func to kprobe blacklist
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 11 juill. 2018, à 15 h 56, Steven Rostedt
<rostedt@goodmis.org> a écrit :
>
> On Wed, 11 Jul 2018 15:34:30 -0400
> Francis Deslauriers <francis.deslauriers@efficios.com> wrote:
>
> > Hi Steven,
> > I tested it and it prevents the kernel crash I am witnessing.
> > As for the side-effect that Masami mentioned regarding not being able to probe
> > function inside the trace_kprobe.c file, I suggest we move the target
> > function in
> > its own separate compile unit so it can be compiled with the ftrace cflags.
> > See patch below.
> >
>
> The patch below looks fine and so does Masami's. But there's too many
> patches within emails (not separated out). I have no idea what to
> apply. I'm not going to apply anything that is not sent as a proper
> patch (ie. any patch within a separate thread, like the patch below).
>
I will put together a proper patch set with both commits.

Masami, you mentioned: "So anyway we still need to mark those functions
NOKPROBE_SYMBOL." in a reply. What functions were you talking about?
ftrace_ops_assist_func? Aren't those functions covered by your
within_notrace_func check?

Thank you,
Francis

> -- Steve
>
>
> > Thanks
> > Francis
> >
> > >From d5a3645bd0046f28275d6b60207958f2751c1f47 Mon Sep 17 00:00:00 2001
> > From: Francis Deslauriers <francis.deslauriers@efficios.com>
> > Date: Wed, 11 Jul 2018 12:34:22 -0400
> > Subject: [PATCH] selftest/ftrace: Move kprobe selftest function to separate
> >  compile unit
> >
> > Move selftest function to its own compile unit so it can be compiled
> > with the ftrace cflags (CC_FLAGS_FTRACE) allowing it to be probed
> > during the ftrace startup tests.
> >
> > Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
> > ---
> >  kernel/trace/Makefile                |  5 +++++
> >  kernel/trace/trace_kprobe.c          | 12 +-----------
> >  kernel/trace/trace_kprobe_selftest.c | 10 ++++++++++
> >  kernel/trace/trace_kprobe_selftest.h |  7 +++++++
> >  4 files changed, 23 insertions(+), 11 deletions(-)
> >  create mode 100644 kernel/trace/trace_kprobe_selftest.c
> >  create mode 100644 kernel/trace/trace_kprobe_selftest.h
> >
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index e2538c7..e38771e 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -13,6 +13,11 @@ obj-y += trace_selftest_dynamic.o
> >  endif
> >  endif
> >
> > +ifdef CONFIG_FTRACE_STARTUP_TEST
> > +CFLAGS_trace_kprobe_selftest.o = $(CC_FLAGS_FTRACE)
> > +obj-$(CONFIG_KPROBE_EVENTS) += trace_kprobe_selftest.o
> > +endif
> > +
> >  # If unlikely tracing is enabled, do not trace these files
> >  ifdef CONFIG_TRACING_BRANCHES
> >  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 952dc2a..3fe966f 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/error-injection.h>
> >
> >  #include "trace_probe.h"
> > +#include "trace_kprobe_selftest.h"
> >
> >  #define KPROBE_EVENT_SYSTEM "kprobes"
> >  #define KRETPROBE_MAXACTIVE_MAX 4096
> > @@ -1560,17 +1561,6 @@ fs_initcall(init_kprobe_trace);
> >
> >
> >  #ifdef CONFIG_FTRACE_STARTUP_TEST
> > -/*
> > - * The "__used" keeps gcc from removing the function symbol
> > - * from the kallsyms table. 'noinline' makes sure that there
> > - * isn't an inlined version used by the test method below
> > - */
> > -static __used __init noinline int
> > -kprobe_trace_selftest_target(int a1, int a2, int a3, int a4, int a5, int a6)
> > -{
> > - return a1 + a2 + a3 + a4 + a5 + a6;
> > -}
> > -
> >  static __init struct trace_event_file *
> >  find_trace_probe_file(struct trace_kprobe *tk, struct trace_array *tr)
> >  {
> > diff --git a/kernel/trace/trace_kprobe_selftest.c
> > b/kernel/trace/trace_kprobe_selftest.c
> > new file mode 100644
> > index 0000000..a3d2090
> > --- /dev/null
> > +++ b/kernel/trace/trace_kprobe_selftest.c
> > @@ -0,0 +1,10 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Function used during the kprobe self test. This function is in a seperate
> > + * compile unit so it can be compile with CC_FLAGS_FTRACE to ensure that it
> > + * can be probed by the selftests.
> > + */
> > +int kprobe_trace_selftest_target(int a1, int a2, int a3, int a4, int
> > a5, int a6)
> > +{
> > + return a1 + a2 + a3 + a4 + a5 + a6;
> > +}
> > diff --git a/kernel/trace/trace_kprobe_selftest.h
> > b/kernel/trace/trace_kprobe_selftest.h
> > new file mode 100644
> > index 0000000..9243d4e
> > --- /dev/null
> > +++ b/kernel/trace/trace_kprobe_selftest.h
> > @@ -0,0 +1,7 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Function used during the kprobe self test. This function is in a seperate
> > + * compile unit so it can be compile with CC_FLAGS_FTRACE to ensure that it
> > + * can be probed by the selftests.
> > + */
> > +int kprobe_trace_selftest_target(int a1, int a2, int a3, int a4, int
> > a5, int a6);
>


--
Francis Deslauriers
Software developer
EfficiOS inc.
