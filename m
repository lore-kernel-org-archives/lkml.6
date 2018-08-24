Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC35C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9146E21564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dZRrUb6k";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JgxTVKeN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9146E21564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeHXQIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:08:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38774 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeHXQIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:08:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 04145604A6; Fri, 24 Aug 2018 12:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535114048;
        bh=i8w5tYU9RPCb6iP0STYPlfVTcqD+JnBeItCqiYgRPdU=;
        h=From:To:Cc:Subject:Date:From;
        b=dZRrUb6kwBPzS7e1TEj8PjpxA2RTMTXD68Tb6jvhN4PpRqiXsqCiuG5kynWAPNcpp
         0vGrTFvqDTyaCPJBoi3rqQ5ij48R7/mrYv/i7y5FngZI6rzP1ZgvFcproo3Lw5TL9t
         n7G36vRgLMXO7apxnsV26UBAZo4CDc+hAyKfCZ7E=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A05F6022B;
        Fri, 24 Aug 2018 12:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535114047;
        bh=i8w5tYU9RPCb6iP0STYPlfVTcqD+JnBeItCqiYgRPdU=;
        h=From:To:Cc:Subject:Date:From;
        b=JgxTVKeNqrI14CC5aWvwz36EK5zvCLWQVSQibvGW1hiGKEyS/23JXUhS35a/wxiTw
         PedrjiWmQsSaoyx3GRHdAoC4lKS69lmz395ePpLdYW3zV7eBhphcWT8DdKYOX27bsw
         Tzp6Ffun7zhqBJNDoi38Cs+fFaygNTb4ZOrrwFQ0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A05F6022B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH] kernel: notifier: Remove notifier header file wherever not used
Date:   Fri, 24 Aug 2018 18:03:53 +0530
Message-Id: <1535114033-4605-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When notifier converted to state-machine in hotplug, we missed to
remove header file from some of the files.
So, Remove it with this.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
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
index 4cc679d..6f1ae3a 100644
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
index 924e37f..fd6f8ed 100644
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
index c72577e..a66595b 100644
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
index 6551d3b..84ae9bf 100644
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
index e75865d..05e983f 100644
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
index ce2b9e5..8da34a8 100644
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
index 325fc50..82114e1 100644
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
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

