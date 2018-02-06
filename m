Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753873AbeBFWrG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 17:47:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753428AbeBFWpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 17:45:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805CE2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180206224338.446477232@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 06 Feb 2018 17:43:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [RFC][PATCH 0/6] tracing: Fix bogus parsing of probes and set_ftrace_filter
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Al Viro pointed out a couple of bugs with the parsing of the
removing of function probes and the parsing of set_ftrace_filter
strings.

This patch series implements his suggested fixes and adds selftests
that would have caught the bugs in the first place.


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
