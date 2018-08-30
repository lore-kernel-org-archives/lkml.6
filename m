Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D75C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515952054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515952054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeH3PDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:03:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38407 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbeH3PDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:03:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7UB1Xd21728197
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Aug 2018 04:01:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7UB1XgQ1728191;
        Thu, 30 Aug 2018 04:01:33 -0700
Date:   Thu, 30 Aug 2018 04:01:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mukesh Ojha <tipbot@zytor.com>
Message-ID: <tip-13ba17bee18e321b073b49a88dcab10881f757da@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mojha@codeaurora.org, tglx@linutronix.de
Reply-To: mojha@codeaurora.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <1535114033-4605-1-git-send-email-mojha@codeaurora.org>
References: <1535114033-4605-1-git-send-email-mojha@codeaurora.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] notifier: Remove notifier header file wherever
 not used
Git-Commit-ID: 13ba17bee18e321b073b49a88dcab10881f757da
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  13ba17bee18e321b073b49a88dcab10881f757da
Gitweb:     https://git.kernel.org/tip/13ba17bee18e321b073b49a88dcab10881f757da
Author:     Mukesh Ojha <mojha@codeaurora.org>
AuthorDate: Fri, 24 Aug 2018 18:03:53 +0530
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 30 Aug 2018 12:56:40 +0200

notifier: Remove notifier header file wherever not used

The conversion of the hotplug notifiers to a state machine left the
notifier.h includes around in some places. Remove them.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1535114033-4605-1-git-send-email-mojha@codeaurora.org

---
 fs/buffer.c            | 1 -
 kernel/printk/printk.c | 1 -
 lib/percpu_counter.c   | 1 -
 mm/page-writeback.c    | 1 -
 mm/page_alloc.c        | 1 -
 mm/slub.c              | 1 -
 net/core/dev.c         | 1 -
 7 files changed, 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 4cc679d5bf58..6f1ae3ac9789 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -39,7 +39,6 @@
 #include <linux/buffer_head.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/bio.h>
-#include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/bitops.h>
 #include <linux/mpage.h>
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 924e37fb1620..fd6f8ed28e01 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -38,7 +38,6 @@
 #include <linux/kmsg_dump.h>
 #include <linux/syslog.h>
 #include <linux/cpu.h>
-#include <linux/notifier.h>
 #include <linux/rculist.h>
 #include <linux/poll.h>
 #include <linux/irq_work.h>
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index c72577e472f2..a66595ba5543 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/percpu_counter.h>
-#include <linux/notifier.h>
 #include <linux/mutex.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 6551d3b0dc30..84ae9bf5858a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -27,7 +27,6 @@
 #include <linux/mpage.h>
 #include <linux/rmap.h>
 #include <linux/percpu.h>
-#include <linux/notifier.h>
 #include <linux/smp.h>
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e75865d58ba7..05e983f42316 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -32,7 +32,6 @@
 #include <linux/slab.h>
 #include <linux/ratelimit.h>
 #include <linux/oom.h>
-#include <linux/notifier.h>
 #include <linux/topology.h>
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
diff --git a/mm/slub.c b/mm/slub.c
index ce2b9e5cea77..8da34a8af53d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -19,7 +19,6 @@
 #include <linux/slab.h>
 #include "slab.h"
 #include <linux/proc_fs.h>
-#include <linux/notifier.h>
 #include <linux/seq_file.h>
 #include <linux/kasan.h>
 #include <linux/cpu.h>
diff --git a/net/core/dev.c b/net/core/dev.c
index 325fc5088370..82114e1111e6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -93,7 +93,6 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
-#include <linux/notifier.h>
 #include <linux/skbuff.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
