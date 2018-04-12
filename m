Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeDLByo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 21:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751777AbeDLBym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 21:54:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DD02178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180412015359.244491749@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 11 Apr 2018 21:53:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/5] [GIT PULL] tracing: A few last minute clean up and fixes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

A few clean ups and bug fixes

 - Replace open coded "ARRAY_SIZE()" with macro

 - Updates to uprobes

 - Bug fix for perf event filter on error path

Please pull the latest ktest-v4.17-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
ktest-v4.17-2

Tag SHA1: f4a56400c3b9f949cf5740153aab48a8240f88db
Head SHA1: 0b3dec05dbbce023f4f25aba975b5d253c313ebb


Howard McLauchlan (1):
      tracing/uprobe: Add support for overlayfs

Jérémy Lefaure (1):
      tracing: Use ARRAY_SIZE() macro instead of open coding it

Ravi Bangoria (2):
      trace_uprobe: Use %lx to display offset
      trace_uprobe: Simplify probes_seq_show()

Steven Rostedt (VMware) (1):
      tracing: Enforce passing in filter=NULL to create_filter()

----
 kernel/trace/trace_events_filter.c | 26 +++++++++++---------------
 kernel/trace/trace_uprobe.c        | 23 ++++-------------------
 2 files changed, 15 insertions(+), 34 deletions(-)
