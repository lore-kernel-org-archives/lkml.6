Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E80C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CCE21EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CCE21EFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeHIXdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbeHIXdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:33:31 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 502C821EFC;
        Thu,  9 Aug 2018 21:06:55 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fns90-0001Pf-8y; Thu, 09 Aug 2018 17:06:54 -0400
Message-Id: <20180809210333.588854137@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 09 Aug 2018 17:03:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        joel@joelfernandes.org
Subject: [for-next][PATCH 0/6] tracing: Last minute updates before pushing to linux-next
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel,

These are the last minute updates I have on top of your changes.
A couple of them I may have already posted to you. I'm trying to
get my tests to all pass without errors or new warnings. My tests
are still running, and hopefully this will have all the fixes.

-- Steve


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/core

Head SHA1: 05ceccdf48666c14eed1082439bf9d5cb50ff9ed


Colin Ian King (1):
      ftrace: Remove unused pointer ftrace_swapper_pid

Steven Rostedt (VMware) (5):
      tracing: Partial revert of "tracing: Centralize preemptirq tracepoints and unify their usage"
      tracing/irqsoff: Handle preempt_count for different configs
      tracing: More reverting of "tracing: Centralize preemptirq tracepoints and unify their usage"
      tracing: Fix synchronizing to event changes with tracepoint_synchronize_unregister()
      uprobes: Use synchronize_rcu() not synchronize_sched()

----
 include/linux/irqflags.h            |  8 ++-
 include/linux/lockdep.h             |  2 -
 init/main.c                         |  2 -
 kernel/locking/lockdep.c            | 14 +-----
 kernel/trace/ftrace.c               |  2 -
 kernel/trace/trace.h                | 15 ++++++
 kernel/trace/trace_events.c         |  8 +--
 kernel/trace/trace_events_filter.c  | 15 +++---
 kernel/trace/trace_events_hist.c    |  2 +-
 kernel/trace/trace_events_trigger.c |  6 ++-
 kernel/trace/trace_irqsoff.c        | 98 +++++++++++++------------------------
 kernel/trace/trace_preemptirq.c     | 53 +++++++++++++-------
 kernel/trace/trace_uprobe.c         |  2 +-
 13 files changed, 109 insertions(+), 118 deletions(-)
