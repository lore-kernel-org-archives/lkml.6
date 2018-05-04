Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeEDPyL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbeEDPyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:54:10 -0400
Message-Id: <20180504155241.113624273@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 04 May 2018 11:52:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] [GIT PULL] tracing: Minor fixes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Some of the files in the tracing directory show file mode 0444
when they are writable by root. To fix the confusion, they should
be 0644. Note, either case root can still write to them.

Note, Zhengyuan asked why I never applied that patch (the first one
is from 2014!). I simply forgot about it. /me lowers head in shame.

Please pull the latest trace-v4.17-rc1-3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.17-rc1-3

Tag SHA1: b23eed18b73241c8aa5829cc6f570610ce65c93b
Head SHA1: 0c5a9acc8b4e878e761f735e144d4a7e4477d4e6


Chen LinX (1):
      ftrace: Have set_graph_* files have normal file modes

Zhengyuan Liu (1):
      tracing: Fix the file mode of stack tracer

----
 kernel/trace/ftrace.c      | 4 ++--
 kernel/trace/trace_stack.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
