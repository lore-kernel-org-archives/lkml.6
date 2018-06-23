Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A0AC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251FB24A6C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251FB24A6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934554AbeFWBVI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 21:21:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933817AbeFWBVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 21:21:06 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBF6824A68;
        Sat, 23 Jun 2018 01:21:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fWXEe-0008PY-UL; Fri, 22 Jun 2018 21:21:04 -0400
Message-Id: <20180623012035.763099123@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 22 Jun 2018 21:20:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/5] [GIT PULL] tracing: A few fixes and a clean up
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This contains a few fixes and a clean up.

 - A bad merge caused an "endif" to go in the wrong place in
     scripts/Makefile.build
 - Softirq tracing fix for tracing that corrupts lockdep and causes a false
     splat
 - Histogram documentation typo fixes
 - Fix a bad memory reference when passing in no filter to the filter code
 - Simplify code by using the swap macro instead of open coding the swap

Please pull the latest trace-v4.18-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.18-rc1

Tag SHA1: 50d890b32aae88f43b04fe477d9a00db564e78e9
Head SHA1: ed7d40bc67b8353c677b38c6cdddcdc310c0f452


Greg Thelen (1):
      tracing: Fix SKIP_STACK_VALIDATION=1 build due to bad merge with -mrecord-mcount

Gustavo A. R. Silva (1):
      tracing: Use swap macro in update_max_tr

Joel Fernandes (Google) (2):
      softirq: Reorder trace_softirqs_on to prevent lockdep splat
      tracing: Fix some errors in histogram documentation

Steven Rostedt (VMware) (1):
      tracing: Check for no filter when processing event filters

----
 Documentation/trace/histogram.txt  | 23 ++++++++++++-----------
 kernel/softirq.c                   |  6 +++++-
 kernel/trace/trace.c               |  6 +-----
 kernel/trace/trace_events_filter.c | 10 +++++++++-
 scripts/Makefile.build             |  2 +-
 5 files changed, 28 insertions(+), 19 deletions(-)
