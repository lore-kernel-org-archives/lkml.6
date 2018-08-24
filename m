Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2CAC43615
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C184F21581
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTxdKwBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C184F21581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeHXLya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbeHXLya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:54:30 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9538F208E3;
        Fri, 24 Aug 2018 08:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535098856;
        bh=1mFop6dtuRUSyheS75lrH268pLjyQreF2cGZcAP9cRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XTxdKwBiv9fTvQxwEggsrbxBYl5TzohG4CtYsy8UAhj+a+Cn1hwGT4/1KqzPrhrvf
         qwEBg5Tp/xiFUUwD6F9i3Ufyl5NBsC8Q5ynO9FbVy6TjFd6co1Rsa465tmfCyRZMsC
         s9ZPdU24YOiG0fR7B39Ry5GE/I+/C12arDbiFjJo=
Date:   Fri, 24 Aug 2018 17:20:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warnings from the build of Linus' tree
Message-Id: <20180824172053.20fa197294f51496dcec5605@kernel.org>
In-Reply-To: <20180824133206.4218c2e5@canb.auug.org.au>
References: <20180824133206.4218c2e5@canb.auug.org.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 13:32:06 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the origin tree, today's linux-next build (powerpc
> allyesconfig) produced these warnings:
> 
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_selftest_dynamic.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_kprobe_selftest.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_clock.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/ftrace.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/ring_buffer.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/ring_buffer_benchmark.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_output.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_seq.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_stat.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_printk.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/tracing_map.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_sched_switch.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_functions.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_preemptirq.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_irqsoff.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_sched_wakeup.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_hwlat.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_nop.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_stack.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_functions_graph.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/blktrace.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_events.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_export.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_syscalls.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_event_perf.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_events_filter.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_events_trigger.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_events_hist.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/bpf_trace.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_kprobe.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/power-traces.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/rpm-traces.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_kdb.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_probe.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_uprobe.o' being placed in section `.data..LPBX1'
> ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_benchmark.o' being placed in section `.data..LPBX1'
> 
> Maybe introduced by commit
> 
>   6b7dca401cb1 ("tracing: Allow gcov profiling on only ftrace subsystem")
> 
> I am guessing, but that is the only new thing that affects all of
> kernel/trace ...

Yes, I agree. But I just followed Documentation/dev-tools/gcov.rst
to enable profiling in kernel/trace. Hmm, doesn't ppc64 support
GCOV_PROFILE?  (But as far as I can see, ARCH_HAS_GCOV_PROFILE_ALL
is enabled in arch/powerpc/Kconfig)

Anyway, I'll try to reproduce it.

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
