Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964867AbeE2PXy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935483AbeE2PX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:23:29 -0400
Message-Id: <20180529152304.885389740@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 29 May 2018 11:23:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/19] tracing: Updates for 4.18
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 086d713d2535b389de1893d2f3874e9cfb6dbdf3


Andi Kleen (1):
      trace: Use -mcount-record for dynamic ftrace

Lee, Chun-Yi (1):
      tracepoints: Fix the descriptions of tracepoint_probe_register{_prio}

Steven Rostedt (VMware) (16):
      tracing: Do not reference event data in post call triggers
      tracing: Add __find_event_file() to find event files without restrictions
      tracing: Have event_trace_init() called by trace_init_tracefs()
      tracing: Add brackets in ftrace event dynamic arrays
      tracing: Do not show filter file for ftrace internal events
      tracing: Add trigger file for trace_markers tracefs/ftrace/print
      tracing: Have zero size length in filter logic be full string
      tracing: Prevent further users of zero size static arrays in trace events
      tracing: Allow histogram triggers to access ftrace internal events
      tracing: Document trace_marker triggers
      ftrace/selftest: Have the reset_trigger code be a bit more careful
      ftrace/selftest: Fix reset_trigger() to handle triggers with filters
      tracing/selftest: Add selftests to test trace_marker histogram triggers
      tracing/selftest: Add test to test hist trigger between kernel event and trace_marker
      tracing/selftest: Add test to test simple snapshot trigger for trace_marker
      ring-buffer: Fix a bunch of typos in comments

Vasyl Gomonovych (1):
      ring-buffer: Fix typo in comment

----
 Documentation/trace/events.rst                     |   6 +-
 Documentation/trace/ftrace.rst                     |   5 +
 Documentation/trace/histogram.txt                  | 545 ++++++++++++++++++++-
 include/linux/ring_buffer.h                        |   2 +-
 include/linux/trace_events.h                       |   3 +-
 include/trace/trace_events.h                       |   1 +
 kernel/trace/ring_buffer.c                         |  20 +-
 kernel/trace/trace.c                               |  19 +
 kernel/trace/trace.h                               |   9 +-
 kernel/trace/trace_entries.h                       |   6 +-
 kernel/trace/trace_events.c                        |  36 +-
 kernel/trace/trace_events_filter.c                 |  23 +-
 kernel/trace/trace_events_hist.c                   |   2 +-
 kernel/trace/trace_events_trigger.c                |   6 +-
 kernel/trace/trace_export.c                        |   9 +-
 kernel/tracepoint.c                                |   3 +-
 scripts/Makefile.build                             |   6 +
 tools/testing/selftests/ftrace/test.d/functions    |  23 +-
 .../test.d/trigger/trigger-trace-marker-hist.tc    |  49 ++
 .../trigger/trigger-trace-marker-snapshot.tc       |  74 +++
 .../trigger-trace-marker-synthetic-kernel.tc       |  68 +++
 .../trigger/trigger-trace-marker-synthetic.tc      |  66 +++
 22 files changed, 927 insertions(+), 54 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
