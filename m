Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E54C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91D92146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfBTSkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfBTSiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:38:05 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B718B2146E;
        Wed, 20 Feb 2019 18:38:03 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1gwWks-0006Zh-RJ; Wed, 20 Feb 2019 13:38:02 -0500
Message-Id: <20190220183737.034634614@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 20 Feb 2019 13:37:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/29] tracing: Updates for 5.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 5308e9705d9a017f0e732610ac0a7cab52fb01f7


Changbin Du (6):
      function_graph: Support displaying relative timestamp
      tracing: Show more info for funcgraph wakeup tracers
      tracing: Put a margin between flags and duration for wakeup tracers
      tracing/doc: Add latency tracer funcgraph example
      tracing: Show stacktrace for wakeup tracers
      tracing: Change the function format to display function names by perf

Elena Reshetova (1):
      uprobes: convert uprobe.ref to refcount_t

Mathieu Malaterre (2):
      tracing: Annotate implicit fall through in parse_probe_arg()
      tracing: Annotate implicit fall through in predicate_parse()

Miroslav Benes (1):
      ring-buffer: Remove unused function ring_buffer_page_len()

Steven Rostedt (VMware) (3):
      tracing: Add comment to predicate_parse() about "&&" or "||"
      ftrace: Allow enabling of filters via index of available_filter_functions
      tracing: Comment why cond_snapshot is checked outside of max_lock protection

Tom Zanussi (15):
      tracing: Refactor hist trigger action code
      tracing: Make hist trigger Documentation better reflect actions/handlers
      tracing: Split up onmatch action data
      tracing: Generalize hist trigger onmax and save action
      tracing: Add conditional snapshot
      tracing: Add hist trigger snapshot() action
      tracing: Add hist trigger snapshot() action Documentation
      tracing: Add hist trigger onchange() handler
      tracing: Add hist trigger onchange() handler Documentation
      tracing: Add alternative synthetic event trace action syntax
      tracing: Add SPDX license GPL-2.0 license identifier to inter-event testcases
      tracing: Add hist trigger snapshot() action test case
      tracing: Add hist trigger onchange() handler test case
      tracing: Add alternative synthetic event trace action test case
      tracing: Add hist trigger action 'expected fail' test case

zhangyi (F) (1):
      tracing: No need to free iter->trace in fail path of tracing_open_pipe()

----
 Documentation/trace/ftrace.rst                     |   89 ++
 Documentation/trace/histogram.rst                  |  316 +++++-
 include/linux/ring_buffer.h                        |    2 -
 kernel/events/uprobes.c                            |    8 +-
 kernel/trace/ftrace.c                              |   30 +
 kernel/trace/ring_buffer.c                         |   14 -
 kernel/trace/trace.c                               |  217 +++-
 kernel/trace/trace.h                               |   66 +-
 kernel/trace/trace_entries.h                       |   41 +-
 kernel/trace/trace_events_filter.c                 |    7 +
 kernel/trace/trace_events_hist.c                   | 1048 ++++++++++++++------
 kernel/trace/trace_functions_graph.c               |   30 +-
 kernel/trace/trace_irqsoff.c                       |    2 +-
 kernel/trace/trace_probe.c                         |    1 +
 kernel/trace/trace_sched_wakeup.c                  |   11 +-
 .../inter-event/trigger-action-hist-xfail.tc       |   30 +
 .../inter-event/trigger-extended-error-support.tc  |    1 +
 .../inter-event/trigger-field-variable-support.tc  |    1 +
 .../trigger-inter-event-combined-hist.tc           |    1 +
 .../inter-event/trigger-multi-actions-accept.tc    |    1 +
 .../inter-event/trigger-onchange-action-hist.tc    |   28 +
 .../inter-event/trigger-onmatch-action-hist.tc     |    1 +
 .../trigger-onmatch-onmax-action-hist.tc           |    1 +
 .../inter-event/trigger-onmax-action-hist.tc       |    1 +
 .../inter-event/trigger-snapshot-action-hist.tc    |   43 +
 .../trigger-synthetic-event-createremove.tc        |    1 +
 .../inter-event/trigger-trace-action-hist.tc       |   42 +
 27 files changed, 1659 insertions(+), 374 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
