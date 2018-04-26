Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756968AbeDZRcL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755998AbeDZRcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 13:32:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915BE21745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180426173039.426131207@goodmis.org>
User-Agent: quilt/0.63-1
Date: Thu, 26 Apr 2018 13:30:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/7] [GIT PULL] tracing: Fixes for v4.17-rc1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Following tracing fixes:

 - Add workqueue forward declaration (for new work, but a nice clean up)

 - seftest fixes for the new histogram code

 - Print output fix for hwlat tracer

 - Fix missing system call events - due to change in x86 syscall naming

 - Fix kprobe address being used by perf being hashed

Please pull the latest trace-v4.17-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.17-rc1

Tag SHA1: c9521e0e3e53b547e39eff37bf58baf2ec146c9d
Head SHA1: 9a0fd675304d410f3a9586e1b333e16f4658d56c


Ahbong Chang (1):
      tracing: Add missing forward declaration

Masami Hiramatsu (2):
      selftests: ftrace: Fix trigger extended error testcase
      selftests: ftrace: Add a testcase for multiple actions on trigger

Peter Xu (1):
      tracing: Fix missing tab for hwlat_detector print format

Ravi Bangoria (1):
      tracing: Fix kernel crash while using empty filter with perf

Steven Rostedt (VMware) (1):
      tracing/x86: Update syscall trace events to handle new prefixed syscall func names

Thomas Richter (1):
      kprobes: Fix random address output of blacklist file

----
 arch/x86/include/asm/ftrace.h                      | 19 +++++++++-
 include/trace/events/workqueue.h                   |  2 +
 kernel/kprobes.c                                   |  2 +-
 kernel/trace/trace_entries.h                       |  2 +-
 kernel/trace/trace_events_filter.c                 | 14 +++----
 .../inter-event/trigger-extended-error-support.tc  |  2 +-
 .../inter-event/trigger-multi-actions-accept.tc    | 44 ++++++++++++++++++++++
 7 files changed, 73 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
