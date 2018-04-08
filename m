Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeDHUMG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751458AbeDHUMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:12:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F8A217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201000.540816094@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:10:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/4] tracing: Addition of initcall tracing
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The last patch keeps initcall_debug working even without
CONFIG_TRACEPOINTS enabled. Nobody appears to be against this
patch set.


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: b0dc52f15e7fe2b973ecfe4f3706f1b35ce3943a


Abderrahmane Benbachir (1):
      init, tracing: instrument security and console initcall trace events

Steven Rostedt (VMware) (3):
      init, tracing: Add initcall trace events
      init, tracing: Have printk come through the trace events for initcall_debug
      init: Have initcall_debug still work without CONFIG_TRACEPOINTS

----
 include/trace/events/initcall.h | 66 +++++++++++++++++++++++++++++++++
 init/main.c                     | 82 +++++++++++++++++++++++++++++++++--------
 kernel/printk/printk.c          |  7 +++-
 security/security.c             |  8 +++-
 4 files changed, 145 insertions(+), 18 deletions(-)
 create mode 100644 include/trace/events/initcall.h
