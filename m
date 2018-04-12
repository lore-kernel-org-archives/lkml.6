Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754119AbeDLPNa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:13:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:27649 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753279AbeDLPN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:13:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,442,1517904000";
   d="scan'208";a="190981709"
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 0/6] tracing: trace event error_log and inter-event bugfixes
Date: Thu, 12 Apr 2018 10:13:15 -0500
Message-Id: <cover.1523545519.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 1.9.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Here are a few patches that should be applied on top of the
'Inter-event (e.g. latency) support v9' patchset.

The first fixes another problem I noticed when printing flags.

The rest implement the tracing/events/error_log suggested by Masami,
and update the inter-event code to use it (and remove the old hist
file error mechanism).

Thanks,

Tom

The following changes since commit 404bb11b24fb9a592023c077b878d30ad6da4322:

  tracing: Enforce passing in filter=NULL to create_filter() (2018-04-11 11:18:42 -0400)

are available in the git repository at:

  https://github.com/tzanussi/linux-trace-inter-event.git tzanussi/inter-event-update2
  https://github.com/tzanussi/linux-trace-inter-event/tree/tzanussi/inter-event-update2

Tom Zanussi (6):
  tracing: Restore proper field flag printing when displaying triggers
  tracing: Add trace event error log
  tracing: Save the last hist command's associated event name
  tracing: Use trace event error_log with hist triggers
  tracing: Add field parsing trace event errors for hist triggers
  selftests: ftrace: Fix extended error support testcase

 kernel/trace/trace.h                               |   3 +
 kernel/trace/trace_events.c                        | 172 +++++++++++++++++++
 kernel/trace/trace_events_hist.c                   | 188 +++++++++++----------
 .../inter-event/trigger-extended-error-support.tc  |   2 +-
 4 files changed, 274 insertions(+), 91 deletions(-)

-- 
1.9.3
