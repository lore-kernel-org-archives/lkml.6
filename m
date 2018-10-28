Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D2DECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A302147A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A302147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJ1QPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 12:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbeJ1QPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 12:15:22 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F5A120843;
        Sun, 28 Oct 2018 07:31:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gGfXp-00080n-BE; Sun, 28 Oct 2018 03:31:33 -0400
Message-Id: <20181028072948.693267247@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 28 Oct 2018 03:29:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 00/18] tracing: For this merge window
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been hammering this for some time, and Like this in this merge
window.

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: a2acce536921bd793bae13fa344fcea157638e72


Masami Hiramatsu (15):
      tracing: probeevent: Cleanup print argument functions
      tracing: probeevent: Cleanup argument field definition
      tracing: probeevent: Remove NOKPROBE_SYMBOL from print functions
      tracing: probeevent: Introduce new argument fetching code
      tracing: probeevent: Unify fetch type tables
      tracing: probeevent: Return consumed bytes of dynamic area
      tracing: probeevent: Append traceprobe_ for exported function
      tracing: probeevent: Unify fetch_insn processing common part
      tracing: probeevent: Add symbol type
      tracing: probeevent: Add array type support
      x86: ptrace: Add function argument access API
      tracing: probeevent: Add $argN for accessing function args
      tracing/uprobes: Fix to return -EFAULT if copy_from_user failed
      tracing/kprobes: Check the probe on unloaded module correctly
      tracing/kprobes: Allow kprobe-events to record module symbol

Nikolay Borisov (1):
      tracing: Export trace_dump_stack to modules

Steven Rostedt (VMware) (2):
      tracing: probeevent: Fix uninitialized used of offset in parse args
      tracing: Have stack tracer trace full stack

----
 Documentation/trace/kprobetrace.rst |  23 +-
 arch/Kconfig                        |   7 +
 arch/x86/Kconfig                    |   1 +
 arch/x86/include/asm/ptrace.h       |  38 ++
 kernel/trace/trace.c                |  10 +-
 kernel/trace/trace_kprobe.c         | 403 +++++++++------------
 kernel/trace/trace_probe.c          | 672 ++++++++++++++++++------------------
 kernel/trace/trace_probe.h          | 286 +++++----------
 kernel/trace/trace_probe_tmpl.h     | 216 ++++++++++++
 kernel/trace/trace_stack.c          |   2 +-
 kernel/trace/trace_uprobe.c         | 176 ++++------
 11 files changed, 930 insertions(+), 904 deletions(-)
 create mode 100644 kernel/trace/trace_probe_tmpl.h
