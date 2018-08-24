Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BC6C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C2921523
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYVYvuEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C2921523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeHXPWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:22:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbeHXPWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:22:18 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A79120880;
        Fri, 24 Aug 2018 11:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535111279;
        bh=+bpiNW5ZK6tqU+ofTUHm1Lv9gmY9NeMuvaNoHf3mqpM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bYVYvuEQOzTaCeZeZCBnM0XU4lJH3hksoT9JxsHaVGB0uHNGDhsMcmUbKTZ/RasXR
         yhzZX0Vi2W+1lbhPEIccPki0GavMVhqioKW7Sq8h5EVWOOPpzHf2X4xf3Upbnh4oTL
         w2CLAaxKvyyJborF8laWjKauAUELsJknuCOE7zLQ=
Date:   Fri, 24 Aug 2018 20:47:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warnings from the build of Linus' tree
Message-Id: <20180824204756.e787765461975cd1e27502dc@kernel.org>
In-Reply-To: <20180824172053.20fa197294f51496dcec5605@kernel.org>
References: <20180824133206.4218c2e5@canb.auug.org.au>
        <20180824172053.20fa197294f51496dcec5605@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 17:20:53 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Fri, 24 Aug 2018 13:32:06 +1000
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi all,
> > 
> > After merging the origin tree, today's linux-next build (powerpc
> > allyesconfig) produced these warnings:
> > 
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_selftest_dynamic.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_kprobe_selftest.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_clock.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/ftrace.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/ring_buffer.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/ring_buffer_benchmark.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_output.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_seq.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_stat.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_printk.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/tracing_map.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_sched_switch.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_functions.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_preemptirq.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_irqsoff.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_sched_wakeup.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_hwlat.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_nop.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_stack.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_functions_graph.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/blktrace.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_events.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_export.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_syscalls.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_event_perf.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_events_filter.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_events_trigger.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_events_hist.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/bpf_trace.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_kprobe.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/power-traces.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/rpm-traces.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_kdb.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_probe.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_uprobe.o' being placed in section `.data..LPBX1'
> > ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_benchmark.o' being placed in section `.data..LPBX1'
> > 
> > Maybe introduced by commit
> > 
> >   6b7dca401cb1 ("tracing: Allow gcov profiling on only ftrace subsystem")
> > 
> > I am guessing, but that is the only new thing that affects all of
> > kernel/trace ...
> 
> Yes, I agree. But I just followed Documentation/dev-tools/gcov.rst
> to enable profiling in kernel/trace. Hmm, doesn't ppc64 support
> GCOV_PROFILE?  (But as far as I can see, ARCH_HAS_GCOV_PROFILE_ALL
> is enabled in arch/powerpc/Kconfig)
> 
> Anyway, I'll try to reproduce it.

gcc-7.3.0 cross build ld shows below warnings.

  MODPOST vmlinux.o
/opt/gcc-7.3.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
  KSYM    .tmp_kallsyms1.o
/opt/gcc-7.3.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
  KSYM    .tmp_kallsyms2.o
/opt/gcc-7.3.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
  KSYM    .tmp_kallsyms3.o
  LD      vmlinux
/opt/gcc-7.3.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.

But it seems another warning, and I couldn't see your warnings. Could you tell me your gcc version?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
