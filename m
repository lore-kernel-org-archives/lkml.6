Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1765C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D36620882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mafjHiga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D36620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932547AbeGIK6L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:58:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52529 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932415AbeGIK6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:58:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id w16-v6so20609344wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 03:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9xsxGqg3LvQXHsYSiF2c/zM/wRK3y4nq7pp8pqKt2Z0=;
        b=mafjHigagqSnQWijUVe5voNTPwZaXXNgiuOueC0mb4qrIs0ag2J4CaMVu/oW4MwbLk
         VpOOTiQjoxecOQ8Na92LdlDn6RG1GTpSIB8a443CDTP+6PupjsGicI1j4h5JQeuyMlzb
         824Gs4oF/psHPBKUUb6xQNd2f1d/t667GOdqWyu5OPotukR0i6NDQasecPXtsTIUTQkY
         UqjG1b2oMeMU1EPQcf1jRT/1d8VyND0+EFGKmU5yTeVbliWQo9XFTuDJk72VwsiwKRkG
         CUIOSythJguE/k+gJLFt8140zFSGXNz+nsZFbv9uqI8OXMD1BlFOnJt5//aRjmR8eHBk
         gg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9xsxGqg3LvQXHsYSiF2c/zM/wRK3y4nq7pp8pqKt2Z0=;
        b=pPfHKPFcA+iZMrFmY6hbVVcVLho+aZ2US5WDpRT3cP86i2uOVokWklPEYMecFiE5bn
         JbRSf168giZXxG4iP4ptyBKj0VLjTg5JCBWZo5JioXH/SlbSOia9WODQv5g1ACbFm8Ii
         vu4MT5m4P+weUILPZXr8Dj+PoDVzcCs6hdR6uziAx3sfkUA0T7L3xNtIO0wjkRiY1cmz
         jvoPOs/XEVS9GMw6DA84pMt9ocgsHpXBbtxhBzhVbXqr3fjidJeJvLF5V5Hwzg+O0HvM
         LJ0J0R7Vt3OEDcjcJzQ4Mtsen6Pht1T6Xw33EofKE9Z74smVWT6eH7n+RiGcQ4ihwdui
         RaSw==
X-Gm-Message-State: AOUpUlGiqQX7xWHLsmTr914wb+5mPKOtjqKokZG4c9cwDGE9O3LeeAUP
        VSaOlvxH1RUTMdQQmj6vv2poCl1a
X-Google-Smtp-Source: AAOMgpdNAGWE7cYKBzgqdz3jSVLVKPA/HOyAO5DCeoqmsC71yXI6tQfMFq1B+PBZRxnML5RCdpSgRw==
X-Received: by 2002:a1c:f415:: with SMTP id z21-v6mr138011wma.80.1531133888661;
        Mon, 09 Jul 2018 03:58:08 -0700 (PDT)
Received: from msi-8775.fritz.box (p200300EC43C483007ADD4582C6297BE1.dip0.t-ipconnect.de. [2003:ec:43c4:8300:7add:4582:c629:7be1])
        by smtp.gmail.com with ESMTPSA id e13-v6sm32708420wrd.9.2018.07.09.03.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 03:58:08 -0700 (PDT)
From:   Tobias Tefke <tobias.tefke@gmail.com>
X-Google-Original-From: Tobias Tefke <tobias.tefke@tutanota.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tobias.tefke@tutanota.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] perf/core, uprobes: use correct articles in comments
Date:   Mon,  9 Jul 2018 12:57:15 +0200
Message-Id: <20180709105715.22938-1-tobias.tefke@tutanota.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the comments in the kernel events code use articles incorrectly,
using 'a' for words beginning with a vowel sound, where 'an' should be
used.

Signed-off-by: Tobias Tefke <tobias.tefke@tutanota.com>
---
 kernel/events/core.c    | 16 ++++++++--------
 kernel/events/uprobes.c |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 323fab1e512d..95dc7278d8c7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1656,7 +1656,7 @@ perf_event_groups_next(struct perf_event *event)
 				typeof(*event), group_node))
 
 /*
- * Add a event from the lists for its context.
+ * Add an event from the lists for its context.
  * Must be called with ctx->mutex and ctx->lock held.
  */
 static void
@@ -1844,7 +1844,7 @@ static void perf_group_attach(struct perf_event *event)
 }
 
 /*
- * Remove a event from the lists for its context.
+ * Remove an event from the lists for its context.
  * Must be called with ctx->mutex and ctx->lock held.
  */
 static void
@@ -2148,7 +2148,7 @@ static void __perf_event_disable(struct perf_event *event,
 }
 
 /*
- * Disable a event.
+ * Disable an event.
  *
  * If event->ctx is a cloned context, callers must make sure that
  * every task struct that event->ctx->task could possibly point to
@@ -2677,7 +2677,7 @@ static void __perf_event_enable(struct perf_event *event,
 }
 
 /*
- * Enable a event.
+ * Enable an event.
  *
  * If event->ctx is a cloned context, callers must make sure that
  * every task struct that event->ctx->task could possibly point to
@@ -2755,7 +2755,7 @@ static int __perf_event_stop(void *info)
 	 * events will refuse to restart because of rb::aux_mmap_count==0,
 	 * see comments in perf_aux_output_begin().
 	 *
-	 * Since this is happening on a event-local CPU, no trace is lost
+	 * Since this is happening on an event-local CPU, no trace is lost
 	 * while restarting.
 	 */
 	if (sd->restart)
@@ -4827,7 +4827,7 @@ __perf_read(struct perf_event *event, char __user *buf, size_t count)
 	int ret;
 
 	/*
-	 * Return end-of-file for a read on a event that is in
+	 * Return end-of-file for a read on an event that is in
 	 * error state (i.e. because it was pinned but it couldn't be
 	 * scheduled on to the CPU at some point).
 	 */
@@ -9898,7 +9898,7 @@ static void account_event(struct perf_event *event)
 }
 
 /*
- * Allocate and initialize a event structure
+ * Allocate and initialize an event structure
  */
 static struct perf_event *
 perf_event_alloc(struct perf_event_attr *attr, int cpu,
@@ -11229,7 +11229,7 @@ const struct perf_event_attr *perf_event_attrs(struct perf_event *event)
 }
 
 /*
- * Inherit a event from parent task to child task.
+ * Inherit an event from parent task to child task.
  *
  * Returns:
  *  - valid pointer on success
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ccc579a7d32e..aed1ba569954 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -918,7 +918,7 @@ int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *
 EXPORT_SYMBOL_GPL(uprobe_register);
 
 /*
- * uprobe_apply - unregister a already registered probe.
+ * uprobe_apply - unregister an already registered probe.
  * @inode: the file in which the probe has to be removed.
  * @offset: offset from the start of the file.
  * @uc: consumer which wants to add more or remove some breakpoints
@@ -947,7 +947,7 @@ int uprobe_apply(struct inode *inode, loff_t offset,
 }
 
 /*
- * uprobe_unregister - unregister a already registered probe.
+ * uprobe_unregister - unregister an already registered probe.
  * @inode: the file in which the probe has to be removed.
  * @offset: offset from the start of the file.
  * @uc: identify which probe if multiple probes are colocated.
@@ -1403,7 +1403,7 @@ static struct return_instance *free_ret_instance(struct return_instance *ri)
 
 /*
  * Called with no locks held.
- * Called in context of a exiting or a exec-ing thread.
+ * Called in context of an exiting or an exec-ing thread.
  */
 void uprobe_free_utask(struct task_struct *t)
 {
-- 
2.18.0

