Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65388C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CA22087C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPrl0hgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CA22087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeH2GGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:06:45 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36415 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbeH2GGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:06:44 -0400
Received: by mail-vk0-f67.google.com with SMTP id v62-v6so1796643vkd.3;
        Tue, 28 Aug 2018 19:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xM3v+LANheDRvzV9RwuhVSoQ0iN57Y13+PAGWzTL4BA=;
        b=IPrl0hgYMvrn63DzeK5kkPbGDkDE7rRyBvSY8L7g3kUMt5sF4yueIwETeCEfOUSHVP
         saWwwmYPbGyRfaiXV4ImNXvagnKDZFz9/PhMtr7IA9/yavMTTEOUqB+5lTrrdAq03Clw
         nP6/k9sGjC8L04nvjOM/2xThzY2B6usIkPkaSKIB1o7KhbyuVL4WfuO5mA8/s5FNVdVq
         CfziMzhXjbqELMzwESiP/1XqYTNkDMOuWRSGbnVYctBuMewCmRWtxufP6FLkBiF3naDL
         dbnIrHgN3Qmc68tQci+ORHbMGTkfLmxPgC9TRo4W98ERur7yV8iSDIO/8L9lHtxh7FyG
         Y+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xM3v+LANheDRvzV9RwuhVSoQ0iN57Y13+PAGWzTL4BA=;
        b=cHmQpr8c97uWdmoRHRmd6LyvegVYmvzdPvRMgSFoeZIO+7noORniAmT9ox72FZ+cam
         iCiQYa85BOhCzrMnsNn7z/nmnQ0txhLpsJu76NjFA0wD6dUmURVN4lD/qBENH8YT7yz3
         p5MkOH1N94OKihPEgVxNCau6mPvVu/ZOnuhqCkfSkmF2aK+mA5/zX6PJZGES+rO53e3W
         kU6sI40eZG6nBFWSgxvstn4ggJoDRAuAAcufJADjMfTmQz3E+blvcUErT7K71eSqOVIw
         yTqWBEQyUfz5mKVk73YrPLtOeQfLRFzCEjdY3fGh8du/pq69XE4EQWOCl1sHbqyrZrHU
         lLVg==
X-Gm-Message-State: APzg51DVuQxR3lzeYjE5E+k1QKBoyt/L+00py7zLQatBrmbOj16GnNS4
        qeg1dfFVqHcSPCGXTjCKc3NrmdhznuX9OdYFycA=
X-Google-Smtp-Source: ANB0VdZt/5ewgusziTl37PSb2+xIyHb1UgSHvqsgWLNewBTV1KSMMmeVKZY7bpdkQCrU3ESMyPJSo5lnSg8zzaGRfx8=
X-Received: by 2002:a1f:fc05:: with SMTP id a5-v6mr2634905vki.98.1535508735076;
 Tue, 28 Aug 2018 19:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180824133206.4218c2e5@canb.auug.org.au> <20180824172053.20fa197294f51496dcec5605@kernel.org>
 <CAK8P3a0LXxq8tgsz9YL3hT47dB6nKeBdip3gFA5w0dgRGDwCMQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0LXxq8tgsz9YL3hT47dB6nKeBdip3gFA5w0dgRGDwCMQ@mail.gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 29 Aug 2018 10:11:39 +0800
Message-ID: <CAEbi=3cnd+nZbKpCPzWgSuWP3kDcJC_rTtbGtg=w9B=cJ-f2LA@mail.gmail.com>
Subject: Re: linux-next: build warnings from the build of Linus' tree
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     mhiramat@kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> =E6=96=BC 2018=E5=B9=B48=E6=9C=8824=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:48=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Aug 24, 2018 at 10:23 AM Masami Hiramatsu <mhiramat@kernel.org> w=
rote:
> >
> > On Fri, 24 Aug 2018 13:32:06 +1000
> > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > > Hi all,
> > >
> > > After merging the origin tree, today's linux-next build (powerpc
> > > allyesconfig) produced these warnings:
> > >
> > > Maybe introduced by commit
> > >
> > >   6b7dca401cb1 ("tracing: Allow gcov profiling on only ftrace subsyst=
em")
> > >
> > > I am guessing, but that is the only new thing that affects all of
> > > kernel/trace ...
> >
> > Yes, I agree. But I just followed Documentation/dev-tools/gcov.rst
> > to enable profiling in kernel/trace. Hmm, doesn't ppc64 support
> > GCOV_PROFILE?  (But as far as I can see, ARCH_HAS_GCOV_PROFILE_ALL
> > is enabled in arch/powerpc/Kconfig)
> >
> > Anyway, I'll try to reproduce it.
>
> Thje same commit causes a link failure on ARM with a randconfig
> kernel (see https://pastebin.com/KspjpyKG for the .config):
>
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_clock.o: defined in discarded section `.text.exit'
> of kernel/trace/trace_clock.o
> `_GLOBAL__sub_D_00100_1_trace_clock_local' referenced in section
> `.fini_array.00100' of kernel/trace/trace_clock.o: defined in
> discarded section `.text.exit' of kernel/trace/trace_clock.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/ftrace.o: defined in discarded section `.text.exit' of
> kernel/trace/ftrace.o
> `_GLOBAL__sub_D_00100_1_function_trace_op' referenced in section
> `.fini_array.00100' of kernel/trace/ftrace.o: defined in discarded
> section `.text.exit' of kernel/trace/ftrace.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/ring_buffer.o: defined in discarded section `.text.exit'
> of kernel/trace/ring_buffer.o
> `_GLOBAL__sub_D_00100_1_ring_buffer_print_entry_header' referenced in
> section `.fini_array.00100' of kernel/trace/ring_buffer.o: defined in
> discarded section `.text.exit' of kernel/trace/ring_buffer.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/ring_buffer_benchmark.o: defined in discarded section
> `.text.exit' of kernel/trace/ring_buffer_benchmark.o
> `_GLOBAL__sub_D_00100_1_ring_buffer_benchmark.c' referenced in section
> `.fini_array.00100' of kernel/trace/ring_buffer_benchmark.o: defined
> in discarded section `.text.exit' of
> kernel/trace/ring_buffer_benchmark.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace.o: defined in discarded section `.text.exit' of
> kernel/trace/trace.o
> `_GLOBAL__sub_D_00100_1_ns2usecs' referenced in section
> `.fini_array.00100' of kernel/trace/trace.o: defined in discarded
> section `.text.exit' of kernel/trace/trace.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_output.o: defined in discarded section `.text.exit'
> of kernel/trace/trace_output.o
> `_GLOBAL__sub_D_00100_1_trace_event_sem' referenced in section
> `.fini_array.00100' of kernel/trace/trace_output.o: defined in
> discarded section `.text.exit' of kernel/trace/trace_output.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_seq.o: defined in discarded section `.text.exit' of
> kernel/trace/trace_seq.o
> `_GLOBAL__sub_D_00100_1_trace_print_seq' referenced in section
> `.fini_array.00100' of kernel/trace/trace_seq.o: defined in discarded
> section `.text.exit' of kernel/trace/trace_seq.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_stat.o: defined in discarded section `.text.exit'
> of kernel/trace/trace_stat.o
> `_GLOBAL__sub_D_00100_1_register_stat_tracer' referenced in section
> `.fini_array.00100' of kernel/trace/trace_stat.o: defined in discarded
> section `.text.exit' of kernel/trace/trace_stat.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_printk.o: defined in discarded section `.text.exit'
> of kernel/trace/trace_printk.o
> `_GLOBAL__sub_D_00100_1_trace_printk_control' referenced in section
> `.fini_array.00100' of kernel/trace/trace_printk.o: defined in
> discarded section `.text.exit' of kernel/trace/trace_printk.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_sched_switch.o: defined in discarded section
> `.text.exit' of kernel/trace/trace_sched_switch.o
> `_GLOBAL__sub_D_00100_1_tracing_start_cmdline_record' referenced in
> section `.fini_array.00100' of kernel/trace/trace_sched_switch.o:
> defined in discarded section `.text.exit' of
> kernel/trace/trace_sched_switch.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_functions.o: defined in discarded section
> `.text.exit' of kernel/trace/trace_functions.o
> `_GLOBAL__sub_D_00100_1_ftrace_create_function_files' referenced in
> section `.fini_array.00100' of kernel/trace/trace_functions.o: defined
> in discarded section `.text.exit' of kernel/trace/trace_functions.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_preemptirq.o: defined in discarded section
> `.text.exit' of kernel/trace/trace_preemptirq.o
> `_GLOBAL__sub_D_00100_1___tracepoint_irq_disable' referenced in
> section `.fini_array.00100' of kernel/trace/trace_preemptirq.o:
> defined in discarded section `.text.exit' of
> kernel/trace/trace_preemptirq.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_irqsoff.o: defined in discarded section
> `.text.exit' of kernel/trace/trace_irqsoff.o
> `_GLOBAL__sub_D_00100_1_start_critical_timings' referenced in section
> `.fini_array.00100' of kernel/trace/trace_irqsoff.o: defined in
> discarded section `.text.exit' of kernel/trace/trace_irqsoff.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_sched_wakeup.o: defined in discarded section
> `.text.exit' of kernel/trace/trace_sched_wakeup.o
> `_GLOBAL__sub_D_00100_1_trace_sched_wakeup.c' referenced in section
> `.fini_array.00100' of kernel/trace/trace_sched_wakeup.o: defined in
> discarded section `.text.exit' of kernel/trace/trace_sched_wakeup.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_hwlat.o: defined in discarded section `.text.exit'
> of kernel/trace/trace_hwlat.o
> `_GLOBAL__sub_D_00100_1_trace_hwlat_callback' referenced in section
> `.fini_array.00100' of kernel/trace/trace_hwlat.o: defined in
> discarded section `.text.exit' of kernel/trace/trace_hwlat.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_nop.o: defined in discarded section `.text.exit' of
> kernel/trace/trace_nop.o
> `_GLOBAL__sub_D_00100_1_nop_trace' referenced in section
> `.fini_array.00100' of kernel/trace/trace_nop.o: defined in discarded
> section `.text.exit' of kernel/trace/trace_nop.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_stack.o: defined in discarded section `.text.exit'
> of kernel/trace/trace_stack.o
> `_GLOBAL__sub_D_00100_1_stack_trace_max' referenced in section
> `.fini_array.00100' of kernel/trace/trace_stack.o: defined in
> discarded section `.text.exit' of kernel/trace/trace_stack.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_branch.o: defined in discarded section `.text.exit'
> of kernel/trace/trace_branch.o
> `_GLOBAL__sub_D_00100_1_enable_branch_tracing' referenced in section
> `.fini_array.00100' of kernel/trace/trace_branch.o: defined in
> discarded section `.text.exit' of kernel/trace/trace_branch.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_events.o: defined in discarded section `.text.exit'
> of kernel/trace/trace_events.o
> `_GLOBAL__sub_D_00100_1_event_mutex' referenced in section
> `.fini_array.00100' of kernel/trace/trace_events.o: defined in
> discarded section `.text.exit' of kernel/trace/trace_events.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_export.o: defined in discarded section `.text.exit'
> of kernel/trace/trace_export.o
> `_GLOBAL__sub_D_00100_1_ftrace_event_is_function' referenced in
> section `.fini_array.00100' of kernel/trace/trace_export.o: defined in
> discarded section `.text.exit' of kernel/trace/trace_export.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_event_perf.o: defined in discarded section
> `.text.exit' of kernel/trace/trace_event_perf.o
> `_GLOBAL__sub_D_00100_1_perf_trace_init' referenced in section
> `.fini_array.00100' of kernel/trace/trace_event_perf.o: defined in
> discarded section `.text.exit' of kernel/trace/trace_event_perf.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_events_filter.o: defined in discarded section
> `.text.exit' of kernel/trace/trace_events_filter.o
> `_GLOBAL__sub_D_00100_1_filter_parse_regex' referenced in section
> `.fini_array.00100' of kernel/trace/trace_events_filter.o: defined in
> discarded section `.text.exit' of kernel/trace/trace_events_filter.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_events_trigger.o: defined in discarded section
> `.text.exit' of kernel/trace/trace_events_trigger.o
> `_GLOBAL__sub_D_00100_1_trigger_data_free' referenced in section
> `.fini_array.00100' of kernel/trace/trace_events_trigger.o: defined in
> discarded section `.text.exit' of kernel/trace/trace_events_trigger.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/power-traces.o: defined in discarded section `.text.exit'
> of kernel/trace/power-traces.o
> `_GLOBAL__sub_D_00100_1___tracepoint_cpu_idle' referenced in section
> `.fini_array.00100' of kernel/trace/power-traces.o: defined in
> discarded section `.text.exit' of kernel/trace/power-traces.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/rpm-traces.o: defined in discarded section `.text.exit'
> of kernel/trace/rpm-traces.o
> `_GLOBAL__sub_D_00100_1___tracepoint_rpm_suspend' referenced in
> section `.fini_array.00100' of kernel/trace/rpm-traces.o: defined in
> discarded section `.text.exit' of kernel/trace/rpm-traces.o
> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> kernel/trace/trace_benchmark.o: defined in discarded section
> `.text.exit' of kernel/trace/trace_benchmark.o
> `_GLOBAL__sub_D_00100_1___tracepoint_benchmark_event' referenced in
> section `.fini_array.00100' of kernel/trace/trace_benchmark.o: defined
> in discarded section `.text.exit' of kernel/trace/trace_benchmark.o

It seems, happened in nds32 with allmodconfig.

gcc version: 8.0.1
binutil version: 2.30.51.20180307

greentime@atcsqa02:/sqa2s/greentime/v3-upstream/linux <next-4.19> $
PATH=3D/sqa2s/greentime/v3-upstream/toolchain/nds32le-linux-glibc-v3-upstre=
am2/bin:$PATH
ARCH=3Dnds32 CROSS_COMPILE=3Dnds32le-linux- nds32le-linux-ld -EL
--no-undefined -X --build-id -X -o .tmp_vmlinux1 -T
./arch/nds32/kernel/vmlinux.lds --whole-archive built-in.a
--no-whole-archive --start-group lib/lib.a arch/nds32/lib/lib.a
--end-group
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/ftrace.o: defined in discarded section `.text.exit' of
kernel/trace/ftrace.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/ring_buffer.o: defined in discarded section `.text.exit'
of kernel/trace/ring_buffer.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace.o: defined in discarded section `.text.exit' of
kernel/trace/trace.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_output.o: defined in discarded section `.text.exit'
of kernel/trace/trace_output.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_printk.o: defined in discarded section `.text.exit'
of kernel/trace/trace_printk.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_functions.o: defined in discarded section
`.text.exit' of kernel/trace/trace_functions.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_preemptirq.o: defined in discarded section
`.text.exit' of kernel/trace/trace_preemptirq.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_irqsoff.o: defined in discarded section
`.text.exit' of kernel/trace/trace_irqsoff.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_sched_wakeup.o: defined in discarded section
`.text.exit' of kernel/trace/trace_sched_wakeup.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_hwlat.o: defined in discarded section `.text.exit'
of kernel/trace/trace_hwlat.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_stack.o: defined in discarded section `.text.exit'
of kernel/trace/trace_stack.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_functions_graph.o: defined in discarded section
`.text.exit' of kernel/trace/trace_functions_graph.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/blktrace.o: defined in discarded section `.text.exit' of
kernel/trace/blktrace.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_events.o: defined in discarded section `.text.exit'
of kernel/trace/trace_events.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_export.o: defined in discarded section `.text.exit'
of kernel/trace/trace_export.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_events_filter.o: defined in discarded section
`.text.exit' of kernel/trace/trace_events_filter.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_events_trigger.o: defined in discarded section
`.text.exit' of kernel/trace/trace_events_trigger.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/power-traces.o: defined in discarded section `.text.exit'
of kernel/trace/power-traces.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_benchmark.o: defined in discarded section
`.text.exit' of kernel/trace/trace_benchmark.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_selftest_dynamic.o: defined in discarded section
`.text.exit' of kernel/trace/trace_selftest_dynamic.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_clock.o: defined in discarded section `.text.exit'
of kernel/trace/trace_clock.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_seq.o: defined in discarded section `.text.exit' of
kernel/trace/trace_seq.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_stat.o: defined in discarded section `.text.exit'
of kernel/trace/trace_stat.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_sched_switch.o: defined in discarded section
`.text.exit' of kernel/trace/trace_sched_switch.o
`.text.exit' referenced in section `.dtors.65435' of
kernel/trace/trace_nop.o: defined in discarded section `.text.exit' of
kernel/trace/trace_nop.o
