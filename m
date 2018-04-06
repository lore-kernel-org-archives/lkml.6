Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752822AbeDFNBQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752586AbeDFNBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:01:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A9F21720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406130035.400292196@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 09:00:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/18] tracing: Last minute updates before pushing to Linus
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 8ec8405f081e1e0f800b20f683451c37e81e26c1


Chris Wilson (3):
      tracing: Default to using trace_global_clock if sched_clock is unstable
      tracing: Mention trace_clock=global when warning about unstable clocks
      tracing: Fixup logic inversion on setting trace_global_clock defaults

Dan Carpenter (2):
      tracing: Fix a potential NULL dereference
      tracing: Uninitialized variable in create_tracing_map_fields()

Salvatore Mesoraca (1):
      ftrace: Drop a VLA in module_exists()

Steven Rostedt (VMware) (8):
      init: Fix initcall0 name as it is "pure" not "early"
      vsprintf: Do not preprocess non-dereferenced pointers for bprintf (%px and %pK)
      lockdep: Add print_irqtrace_events() to __warn
      ring-buffer: Check if memory is available before allocation
      ring-buffer: Add set/clear_current_oom_origin() during allocations
      tracing: Hide global trace clock from lockdep
      tracing: Add rcu dereference annotation for filter->prog
      tracing: Add rcu dereference annotation for test func that touches filter->prog

Tom Zanussi (4):
      tracing: Fix display of hist trigger expressions containing timestamps
      tracing: Don't add flag strings when displaying variable references
      tracing: Add action comparisons when testing matching hist triggers
      tracing: Make sure variable string fields are NULL-terminated

----
 init/main.c                        |  2 +-
 kernel/panic.c                     |  2 +
 kernel/trace/ftrace.c              |  7 ++--
 kernel/trace/ring_buffer.c         | 54 +++++++++++++++++++++-----
 kernel/trace/trace.c               | 19 ++++++++++
 kernel/trace/trace_clock.c         |  4 +-
 kernel/trace/trace_events_filter.c | 10 ++++-
 kernel/trace/trace_events_hist.c   | 78 +++++++++++++++++++++++++++++---------
 lib/vsprintf.c                     |  4 ++
 9 files changed, 143 insertions(+), 37 deletions(-)
