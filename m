Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B686C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72A9218A7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72A9218A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeHQPsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbeHQPsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:48:11 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36738218F1;
        Fri, 17 Aug 2018 12:44:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fqe7X-0004rA-Qv; Fri, 17 Aug 2018 08:44:51 -0400
Message-Id: <20180817124418.038744612@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 17 Aug 2018 08:44:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/8] tracing: Some last minute updates for 4.19
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: bb730b5833b5bddf5cb226865e5f4496770d00b0


Steven Rostedt (VMware) (4):
      blktrace: Add SPDX License format header
      tracing: Add SPDX License format to bpf_trace.c
      tracing: Add SPDX License format tags to tracing files
      tracing: Fix SPDX format headers to use C++ style comments

Vasily Gorbik (4):
      tracing: Handle CC_FLAGS_FTRACE more accurately
      tracing: Avoid calling cc-option -mrecord-mcount for every Makefile
      tracing: Add -mcount-nop option support
      s390/ftrace: Add -mfentry and -mnop-mcount support

----
 Makefile                                | 24 ++++++++++++++++++++----
 arch/s390/Kconfig                       |  2 ++
 arch/s390/Makefile                      | 16 +++++++++-------
 arch/s390/include/asm/ftrace.h          |  6 +++---
 arch/s390/kernel/ftrace.c               |  2 +-
 arch/s390/kernel/mcount.S               |  2 +-
 kernel/trace/Kconfig                    |  5 +++++
 kernel/trace/blktrace.c                 | 14 +-------------
 kernel/trace/bpf_trace.c                |  5 +----
 kernel/trace/ftrace.c                   |  3 +++
 kernel/trace/ring_buffer.c              |  1 +
 kernel/trace/ring_buffer_benchmark.c    |  1 +
 kernel/trace/trace.c                    |  1 +
 kernel/trace/trace.h                    |  2 +-
 kernel/trace/trace_benchmark.h          |  2 +-
 kernel/trace/trace_clock.c              |  1 +
 kernel/trace/trace_entries.h            |  2 +-
 kernel/trace/trace_event_perf.c         |  1 +
 kernel/trace/trace_events.c             |  1 +
 kernel/trace/trace_events_filter.c      | 15 +--------------
 kernel/trace/trace_events_filter_test.h |  2 +-
 kernel/trace/trace_events_hist.c        | 11 +----------
 kernel/trace/trace_events_trigger.c     | 15 +--------------
 kernel/trace/trace_hwlat.c              |  4 +---
 kernel/trace/trace_irqsoff.c            |  1 +
 kernel/trace/trace_kprobe.c             | 13 +------------
 kernel/trace/trace_kprobe_selftest.h    |  2 +-
 kernel/trace/trace_output.c             |  1 +
 kernel/trace/trace_output.h             |  2 +-
 kernel/trace/trace_printk.c             |  1 +
 kernel/trace/trace_probe.c              | 14 +-------------
 kernel/trace/trace_probe.h              | 14 +-------------
 kernel/trace/trace_seq.c                |  1 +
 kernel/trace/trace_stat.h               |  2 +-
 kernel/trace/trace_uprobe.c             | 14 +-------------
 kernel/trace/tracing_map.c              | 11 +----------
 kernel/trace/tracing_map.h              |  2 +-
 scripts/Makefile.build                  |  9 +++------
 38 files changed, 76 insertions(+), 149 deletions(-)
