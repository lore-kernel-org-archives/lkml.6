Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50508C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BC521479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mh/j4RT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BC521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbeGLN4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbeGLN4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:56:09 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CD8C20BF2;
        Thu, 12 Jul 2018 13:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531403190;
        bh=kEe6jHs5sxO2p0c+3tqFRzpCI1EQ4uRg3UbbWkpBbcs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mh/j4RT1Jo8HdSX0/xhYJjNQC465O5uBEcIQLueMc3FUjXfycaP9SnuyFoGCaHWf1
         bKcFRpG7Gf170QFYts8AW8UV8SMdDm8FemVR6DyGSuy2EFSjlbTIj/bxGnk2kDfGiW
         OBq9ROJ7gIIzMVQgBeisCVNcrOD7bTJaa9+ALIUs=
Date:   Thu, 12 Jul 2018 22:46:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Francis Deslauriers <francis.deslauriers@efficios.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 2/2] kprobe: fix: Add ftrace_ops_assist_func to kprobe
 blacklist
Message-Id: <20180712224627.25a0abe0e2337216b5c54b24@kernel.org>
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
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Ah, good catch.

> 
> Thanks
> Francis
> 
> From d5a3645bd0046f28275d6b60207958f2751c1f47 Mon Sep 17 00:00:00 2001
> From: Francis Deslauriers <francis.deslauriers@efficios.com>
> Date: Wed, 11 Jul 2018 12:34:22 -0400
> Subject: [PATCH] selftest/ftrace: Move kprobe selftest function to separate
>  compile unit
> 
> Move selftest function to its own compile unit so it can be compiled
> with the ftrace cflags (CC_FLAGS_FTRACE) allowing it to be probed
> during the ftrace startup tests.

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

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
> -- 
> 2.7.4
> 
> 
> Le mar. 3 juill. 2018, à 18 h 31, Steven Rostedt <rostedt@goodmis.org> a écrit :
> >
> > Mathieu and Francis,
> >
> > Looking back, this thread never got further. Would Masami's patch work
> > for you?
> >
> > -- Steve
> >
> >
> > On Sat, 17 Mar 2018 10:22:11 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > > On Sat, 17 Mar 2018 09:13:34 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > > On Fri, 16 Mar 2018 13:53:01 -0400 (EDT)
> > > > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > > >
> > > > > ----- On Mar 16, 2018, at 12:48 PM, rostedt rostedt@goodmis.org wrote:
> > > > >
> > > > > > On Fri, 16 Mar 2018 12:41:34 -0400
> > > > > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > > >
> > > > > >> Yes, kprobes are dangerous. I'm not saying it shouldn't be fixed, I'm
> > > > > >> saying that I don't have time to fix it now, but would be happy to
> > > > > >> accept patches if someone else does so.
> > > > > >
> > > > > > And looking at what I replied before for the original patch. It would
> > > > > > probably be a good idea to blacklist directories. Like we do with
> > > > > > function tracing. We probably should black list both kernel/tracing and
> > > > > > kernel/events from being probed.
> > > > > >
> > > > > > Did this come up at plumbers? You were there too, I don't remember
> > > > > > discussing it there.
> > > > >
> > > > > I don't remember this coming up last Plumbers nor KS neither, given
> > > > > that we were focused on other topics.
> > > > >
> > > > > Would the general approach you envision be based on emitting all code
> > > > > generated by compilation of all objects under kernel/tracing and
> > > > > kernel/events into a specific "nokprobes" text section of the kernel ?
> > > > > Perhaps we could create a specific linker scripts for those directories,
> > > > > or do you have in mind a neater way to do this ?
> > > >
> > > > .kprobes.text section still exists. As I pointed in previous mail, I don't
> > > > think we have to put all those code into that section. But if you want,
> > > > it is acceptable to have a kconfig which push most of those ftrace related
> > > > code into .kprobes.text section.
> > >
> > > Or, we can check it by ftrace_location_range() as below patch.
> > >
> > > Note that as a side-effect, we can not trace functions in trace_kprobe.c
> > > anymore, and this means it is hard to me to make a testcase of kprobe events.
> > > It was the easiest (and maintainable) way to make test cases... sigh.
> > >
> > > -----
> > > tracing: kprobes: Prohibit probing on notrace function
> > >
> > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > >
> > > Prohibit kprobe-events probing on notrace function.
> > > Since probing on the notrace function can cause recursive
> > > event call. In most case those are just skipped, but
> > > in some case it falls into infinit recursive call.
> > >
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > ---
> > >  kernel/trace/trace_kprobe.c |   23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > > index 5ce9b8cf7be3..7404b012e51a 100644
> > > --- a/kernel/trace/trace_kprobe.c
> > > +++ b/kernel/trace/trace_kprobe.c
> > > @@ -487,6 +487,23 @@ disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
> > >       return ret;
> > >  }
> > >
> > > +#ifdef CONFIG_KPROBES_ON_FTRACE
> > > +static bool within_notrace_func(struct trace_kprobe *tk)
> > > +{
> > > +     unsigned long offset, size, addr;
> > > +
> > > +     addr = kallsyms_lookup_name(trace_kprobe_symbol(tk));
> > > +     addr += trace_kprobe_offset(tk);
> > > +
> > > +     if (!kallsyms_lookup_size_offset(addr, &size, &offset))
> > > +             return true;    /* Out of range. */
> > > +
> > > +     return !ftrace_location_range(addr - offset, addr - offset + size);
> > > +}
> > > +#else
> > > +#define within_notrace_func(tk)      (false)
> > > +#endif
> > > +
> > >  /* Internal register function - just handle k*probes and flags */
> > >  static int __register_trace_kprobe(struct trace_kprobe *tk)
> > >  {
> > > @@ -495,6 +512,12 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
> > >       if (trace_probe_is_registered(&tk->tp))
> > >               return -EINVAL;
> > >
> > > +     if (within_notrace_func(tk)) {
> > > +             pr_warn("Could not probe notrace function %s\n",
> > > +                     trace_kprobe_symbol(tk));
> > > +             return -EINVAL;
> > > +     }
> > > +
> > >       for (i = 0; i < tk->tp.nr_args; i++)
> > >               traceprobe_update_arg(&tk->tp.args[i]);
> > >
> > >
> >
> 
> 
> -- 
> Francis Deslauriers
> Software developer
> EfficiOS inc.


-- 
Masami Hiramatsu <mhiramat@kernel.org>
