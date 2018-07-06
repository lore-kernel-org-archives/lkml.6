Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F469C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD05424011
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD05424011
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932668AbeGFBGs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932123AbeGFBGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:06:39 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0640824011;
        Fri,  6 Jul 2018 01:06:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fbFCo-0007H7-1G; Thu, 05 Jul 2018 21:06:38 -0400
Message-Id: <20180706010604.225864413@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Jul 2018 21:06:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/6] [GIT PULL] tracing: Small fixes and clean ups
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

While cleaning out my INBOX, I found a few patches that were lost
in the noise. These are minor bug fixes and clean ups. Those include:

 - Avoiding a string overflow
 - Code that didn't match the comment (but should)
 - A small code optimization (use of a conditional)
 - Quieting printf warnings
 - Nuking unused code
 - Fixing function graph interrupt annotation

Please pull the latest trace-v4.18-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.18-rc3

Tag SHA1: 146913c0aedd504d9230680c8a4708098c4396a6
Head SHA1: 1fe4293f4b8de75824935f8d8e9a99c7fc6873da


Arnd Bergmann (1):
      tracing: Avoid string overflow

Changbin Du (1):
      tracing: Fix missing return symbol in function_graph output

Mathieu Malaterre (1):
      tracing: Use __printf markup to silence compiler

Steven Rostedt (VMware) (1):
      tracing: Make create_filter() code match the comments

Yisheng Xie (1):
      ftrace: Nuke clear_ftrace_function

yuan linyu (1):
      tracing: Optimize trace_buffer_iter() logic

----
 include/linux/ftrace.h               |  2 --
 kernel/trace/ftrace.c                | 13 +------------
 kernel/trace/trace.c                 |  5 +++++
 kernel/trace/trace.h                 |  4 +---
 kernel/trace/trace_events_filter.c   |  5 +++++
 kernel/trace/trace_events_hist.c     |  2 +-
 kernel/trace/trace_functions_graph.c |  5 ++++-
 7 files changed, 17 insertions(+), 19 deletions(-)
