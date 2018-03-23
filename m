Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeCWWOa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 18:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751668AbeCWWO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 18:14:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7517721777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180323221311.405667933@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 23 Mar 2018 18:13:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/4] [GIT PULL] tracing, kprobes: Fix kprobe symbol offset (for minus)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

The documentation for kprobe events says that symbol offets can
take both a + and - sign to get to before and after the symbol address.
But in actuality, the code does not support the minus. This fixes
that issue, and adds a few more selftests to kprobe events.

Please pull the latest trace-v4.16-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.16-rc4

Tag SHA1: d92df88947baacdf2ebfe80871fb1c6f9211aa80
Head SHA1: dfa453bc90eca0febff33c8d292a656e53702158


Masami Hiramatsu (4):
      tracing: probeevent: Fix to support minus offset from symbol
      selftests: ftrace: Add probe event argument syntax testcase
      selftests: ftrace: Add a testcase for string type with kprobe_event
      selftests: ftrace: Add a testcase for probepoint

----
 kernel/trace/trace_kprobe.c                        |  4 +-
 kernel/trace/trace_probe.c                         |  8 +-
 kernel/trace/trace_probe.h                         |  2 +-
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     | 46 ++++++++++
 .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     | 97 ++++++++++++++++++++++
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   | 43 ++++++++++
 6 files changed, 192 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
