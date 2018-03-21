Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeCUCVa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751456AbeCUCVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C92F2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022052.030055576@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:20:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/46] tracing: Updates for v4.17
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 80765597bc587feae8dbc8ce97a0f32e12a6e625


Rajvi Jingar (1):
      selftests: ftrace: Add inter-event hist triggers testcases

Steven Rostedt (VMware) (10):
      ring-buffer: Add nesting for adding events within events
      tracing: Use the ring-buffer nesting to allow synthetic events to be traced
      tracing: Remove BUG_ON() from append_filter_string()
      tracing: Use trace_seq instead of open code string appending
      tracing: Remove filter allocator helper
      tracing: Only add filter list when needed
      tracing: Embed replace_filter_string() helper function
      tracing: Combine enum and arrays into single macro in filter code
      tracing: Clean up and document pred_funcs_##type creation and use
      tracing: Rewrite filter logic to be simpler and faster

Tom Zanussi (33):
      tracing: Move hist trigger Documentation to histogram.txt
      tracing: Add Documentation for log2 modifier
      ring-buffer: Add interface for setting absolute time stamps
      ring-buffer: Redefine the unimplemented RINGBUF_TYPE_TIME_STAMP
      tracing: Add timestamp_mode trace file
      tracing: Give event triggers access to ring_buffer_event
      tracing: Add ring buffer event param to hist field functions
      tracing: Break out hist trigger assignment parsing
      tracing: Add hist trigger timestamp support
      tracing: Add per-element variable support to tracing_map
      tracing: Add hist_data member to hist_field
      tracing: Add usecs modifier for hist trigger timestamps
      tracing: Add variable support to hist triggers
      tracing: Account for variables in named trigger compatibility
      tracing: Move get_hist_field_flags()
      tracing: Add simple expression support to hist triggers
      tracing: Generalize per-element hist trigger data
      tracing: Pass tracing_map_elt to hist_field accessor functions
      tracing: Add hist_field 'type' field
      tracing: Add variable reference handling to hist triggers
      tracing: Add hist trigger action hook
      tracing: Add support for 'synthetic' events
      tracing: Add support for 'field variables'
      tracing: Add 'onmatch' hist trigger action support
      tracing: Add 'onmax' hist trigger action support
      tracing: Allow whitespace to surround hist trigger filter
      tracing: Add cpu field for hist triggers
      tracing: Add hist trigger support for variable reference aliases
      tracing: Add 'last error' error facility for hist triggers
      tracing: Add inter-event hist trigger Documentation
      tracing: Make tracing_set_clock() non-static
      tracing: Add a clock attribute for hist triggers
      tracing: Add inter-event blurb to HIST_TRIGGERS config option

Vedang Patel (2):
      tracing: Add support to detect and avoid duplicates
      tracing: Remove code which merges duplicates

----
 Documentation/trace/events.txt                     | 1548 +------
 Documentation/trace/ftrace.txt                     |   24 +
 Documentation/trace/histogram.txt                  | 1995 ++++++++
 include/linux/ring_buffer.h                        |   17 +-
 include/linux/trace_events.h                       |   14 +-
 kernel/trace/Kconfig                               |    5 +-
 kernel/trace/ring_buffer.c                         |  172 +-
 kernel/trace/trace.c                               |   97 +-
 kernel/trace/trace.h                               |   33 +-
 kernel/trace/trace_events_filter.c                 | 2487 +++++-----
 kernel/trace/trace_events_hist.c                   | 4770 ++++++++++++++++++--
 kernel/trace/trace_events_trigger.c                |   53 +-
 kernel/trace/tracing_map.c                         |  232 +-
 kernel/trace/tracing_map.h                         |   18 +-
 tools/testing/selftests/ftrace/test.d/functions    |    7 +
 .../inter-event/trigger-extended-error-support.tc  |   39 +
 .../inter-event/trigger-field-variable-support.tc  |   54 +
 .../trigger-inter-event-combined-hist.tc           |   58 +
 .../inter-event/trigger-onmatch-action-hist.tc     |   50 +
 .../trigger-onmatch-onmax-action-hist.tc           |   50 +
 .../inter-event/trigger-onmax-action-hist.tc       |   48 +
 .../trigger-synthetic-event-createremove.tc        |   54 +
 22 files changed, 8348 insertions(+), 3477 deletions(-)
 create mode 100644 Documentation/trace/histogram.txt
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
