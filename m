Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbeBIUEC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 15:04:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbeBIUEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 15:04:00 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256DE21789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180209200304.703130163@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 09 Feb 2018 15:03:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH 0/6] [GIT PULL] tracing: Some fixes to filter parsing
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Al Viro discovered some breakage with the parsing of the set_ftrace_filter
as well as the removing of function probes.

This fixes the code with Al's suggestions. I also added a few selftests
to test the broken cases such that they wont happen again.

Please pull the latest trace-v4.16-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.16-rc1

Tag SHA1: 38464a5598493ad973eab28f67e40068212a8922
Head SHA1: 878cb3fb06c67e8f1a452346e0bc6bb85f29b0a0


Steven Rostedt (VMware) (6):
      ftrace: Remove incorrect setting of glob search field
      tracing: Fix parsing of globs with a wildcard at the beginning
      selftests/ftrace: Have reset_ftrace_filter handle modules
      selftests/ftrace: Have reset_ftrace_filter handle multiple instances
      selftests/ftrace: Add some missing glob checks
      selftests/ftrace: Add more tests for removing of function probes

----
 kernel/trace/ftrace.c                              |  1 -
 kernel/trace/trace_events_filter.c                 |  9 +++---
 .../ftrace/test.d/ftrace/func-filter-glob.tc       |  6 ++++
 .../ftrace/test.d/ftrace/func_set_ftrace_file.tc   | 37 ++++++++++++++++++++++
 tools/testing/selftests/ftrace/test.d/functions    | 10 ++++--
 5 files changed, 54 insertions(+), 9 deletions(-)
