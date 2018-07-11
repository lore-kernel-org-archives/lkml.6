Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F81C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7233213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7233213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbeGKUCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:02:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbeGKUCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:02:24 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 650D020C0E;
        Wed, 11 Jul 2018 19:56:30 +0000 (UTC)
Date:   Wed, 11 Jul 2018 15:56:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Francis Deslauriers <francis.deslauriers@efficios.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 2/2] kprobe: fix: Add ftrace_ops_assist_func to kprobe
 blacklist
Message-ID: <20180711155628.78b0fd83@gandalf.local.home>
In-Reply-To: <CADcCL0gFTR2s7X_a8CiqHBeFyy3mR15jF48tOyZoJ3zbDA9KZA@mail.gmail.com>
References: <1500044315-9508-1-git-send-email-francis.deslauriers@efficios.com>
        <1500044315-9508-3-git-send-email-francis.deslauriers@efficios.com>
        <20170714142900.1c91949c@gandalf.local.home>
        <CADcCL0i_Rw9dRkrTUXiVK4dXOXD6QsRrBRc_pJ3XB_SyEqPR5w@mail.gmail.com>
        <20180316112517.66bdd85a@gandalf.local.home>
        <229385456.11580.1521217739037.JavaMail.zimbra@efficios.com>
        <20180316124134.30fa47d5@gandalf.local.home>
        <20180316124840.3e83bbec@gandalf.local.home>
        <1577244734.11604.1521222781948.JavaMail.zimbra@efficios.com>
        <20180317091334.55f1fc325c26deaa4d4a4d19@kernel.org>
        <20180317102211.a648f26ae0d5a53d95c63022@kernel.org>
        <20180703183048.1eeeef4a@gandalf.local.home>
        <CADcCL0gFTR2s7X_a8CiqHBeFyy3mR15jF48tOyZoJ3zbDA9KZA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 15:34:30 -0400
Francis Deslauriers <francis.deslauriers@efficios.com> wrote:

> Hi Steven,
> I tested it and it prevents the kernel crash I am witnessing.
> As for the side-effect that Masami mentioned regarding not being able to probe
> function inside the trace_kprobe.c file, I suggest we move the target
> function in
> its own separate compile unit so it can be compiled with the ftrace cflags.
> See patch below.
> 

The patch below looks fine and so does Masami's. But there's too many
patches within emails (not separated out). I have no idea what to
apply. I'm not going to apply anything that is not sent as a proper
patch (ie. any patch within a separate thread, like the patch below).

-- Steve


> Thanks
> Francis
> 
> >From d5a3645bd0046f28275d6b60207958f2751c1f47 Mon Sep 17 00:00:00 2001  
> From: Francis Deslauriers <francis.deslauriers@efficios.com>
> Date: Wed, 11 Jul 2018 12:34:22 -0400
> Subject: [PATCH] selftest/ftrace: Move kprobe selftest function to separate
>  compile unit
> 
> Move selftest function to its own compile unit so it can be compiled
> with the ftrace cflags (CC_FLAGS_FTRACE) allowing it to be probed
> during the ftrace startup tests.
> 
> Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
> ---
>  kernel/trace/Makefile                |  5 +++++
>  kernel/trace/trace_kprobe.c          | 12 +-----------
>  kernel/trace/trace_kprobe_selftest.c | 10 ++++++++++
>  kernel/trace/trace_kprobe_selftest.h |  7 +++++++
>  4 files changed, 23 insertions(+), 11 deletions(-)
>  create mode 100644 kernel/trace/trace_kprobe_selftest.c
>  create mode 100644 kernel/trace/trace_kprobe_selftest.h
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index e2538c7..e38771e 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -13,6 +13,11 @@ obj-y += trace_selftest_dynamic.o
>  endif
>  endif
> 
> +ifdef CONFIG_FTRACE_STARTUP_TEST
> +CFLAGS_trace_kprobe_selftest.o = $(CC_FLAGS_FTRACE)
> +obj-$(CONFIG_KPROBE_EVENTS) += trace_kprobe_selftest.o
> +endif
> +
>  # If unlikely tracing is enabled, do not trace these files
>  ifdef CONFIG_TRACING_BRANCHES
>  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 952dc2a..3fe966f 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -24,6 +24,7 @@
>  #include <linux/error-injection.h>
> 
>  #include "trace_probe.h"
> +#include "trace_kprobe_selftest.h"
> 
>  #define KPROBE_EVENT_SYSTEM "kprobes"
>  #define KRETPROBE_MAXACTIVE_MAX 4096
> @@ -1560,17 +1561,6 @@ fs_initcall(init_kprobe_trace);
> 
> 
>  #ifdef CONFIG_FTRACE_STARTUP_TEST
> -/*
> - * The "__used" keeps gcc from removing the function symbol
> - * from the kallsyms table. 'noinline' makes sure that there
> - * isn't an inlined version used by the test method below
> - */
> -static __used __init noinline int
> -kprobe_trace_selftest_target(int a1, int a2, int a3, int a4, int a5, int a6)
> -{
> - return a1 + a2 + a3 + a4 + a5 + a6;
> -}
> -
>  static __init struct trace_event_file *
>  find_trace_probe_file(struct trace_kprobe *tk, struct trace_array *tr)
>  {
> diff --git a/kernel/trace/trace_kprobe_selftest.c
> b/kernel/trace/trace_kprobe_selftest.c
> new file mode 100644
> index 0000000..a3d2090
> --- /dev/null
> +++ b/kernel/trace/trace_kprobe_selftest.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Function used during the kprobe self test. This function is in a seperate
> + * compile unit so it can be compile with CC_FLAGS_FTRACE to ensure that it
> + * can be probed by the selftests.
> + */
> +int kprobe_trace_selftest_target(int a1, int a2, int a3, int a4, int
> a5, int a6)
> +{
> + return a1 + a2 + a3 + a4 + a5 + a6;
> +}
> diff --git a/kernel/trace/trace_kprobe_selftest.h
> b/kernel/trace/trace_kprobe_selftest.h
> new file mode 100644
> index 0000000..9243d4e
> --- /dev/null
> +++ b/kernel/trace/trace_kprobe_selftest.h
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Function used during the kprobe self test. This function is in a seperate
> + * compile unit so it can be compile with CC_FLAGS_FTRACE to ensure that it
> + * can be probed by the selftests.
> + */
> +int kprobe_trace_selftest_target(int a1, int a2, int a3, int a4, int
> a5, int a6);

