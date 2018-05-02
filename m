Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751202AbeEBUAo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 16:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750939AbeEBUAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 16:00:42 -0400
Message-Id: <20180502200003.592877274@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 02 May 2018 16:00:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/7] [GIT PULL] tracing: Some more fixes for 4.17
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Various fixes in tracing:

 - Tracepoints should not give warning on OOM failures

 - Use special field for function pointer in trace event

 - Fix igrab issues in uprobes

 - Fixes to the new histogram triggers

Please pull the latest trace-v4.17-rc1-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.17-rc1-2

Tag SHA1: a21207bca13342cd75fdb77962f4bc0ab96d9371
Head SHA1: d66a270be3310d7aa132fec0cea77d3d32a0ff75


Mathieu Desnoyers (1):
      tracepoint: Do not warn on ENOMEM

Rishabh Bhatnagar (1):
      tracing: initcall: Ordered comparison of function pointers

Song Liu (2):
      tracing: Fix bad use of igrab in trace_uprobe.c
      tracing: Remove igrab() iput() call from uprobes.c

Tom Zanussi (3):
      tracing: Restore proper field flag printing when displaying triggers
      tracing: Add field parsing hist error for hist triggers
      tracing: Add field modifier parsing hist error for hist triggers

----
 include/trace/events/initcall.h  | 14 +++++++++++---
 kernel/events/uprobes.c          |  7 +++----
 kernel/trace/trace_events_hist.c | 12 ++++++++++++
 kernel/trace/trace_uprobe.c      | 35 ++++++++++++++---------------------
 kernel/tracepoint.c              |  4 ++--
 5 files changed, 42 insertions(+), 30 deletions(-)
