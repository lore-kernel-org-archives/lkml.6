Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28000C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C220B21528
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C220B21528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbeIZW1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbeIZW1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:27:17 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB0F21528;
        Wed, 26 Sep 2018 16:13:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1g5CRU-0003nX-6j; Wed, 26 Sep 2018 12:13:36 -0400
Message-Id: <20180926161226.098070917@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 26 Sep 2018 12:12:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/5] tracing: Updates for 5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 5a5e3d3ceae2121590d67258a4e658d938b4a46d


Ravi Bangoria (4):
      uprobes: Support SDT markers having reference count (semaphore)
      uprobes/sdt: Prevent multiple reference counter for same uprobe
      trace_uprobe/sdt: Prevent multiple reference counter for same uprobe
      perf probe: Support SDT markers having reference counter (semaphore)

Steven Rostedt (VMware) (1):
      tracing/kprobe: Remove unneeded extra strchr() from create_trace_kprobe()

----
 include/linux/uprobes.h       |   5 +
 kernel/events/uprobes.c       | 278 ++++++++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.c          |   2 +-
 kernel/trace/trace_kprobe.c   |   9 +-
 kernel/trace/trace_uprobe.c   |  75 +++++++++++-
 tools/perf/util/probe-event.c |  39 +++++-
 tools/perf/util/probe-event.h |   1 +
 tools/perf/util/probe-file.c  |  34 +++++-
 tools/perf/util/probe-file.h  |   1 +
 tools/perf/util/symbol-elf.c  |  46 +++++--
 tools/perf/util/symbol.h      |   7 ++
 11 files changed, 459 insertions(+), 38 deletions(-)
