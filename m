Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079BFC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11EE240E4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIlZQZP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11EE240E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753955AbeGEL2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:28:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39103 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753634AbeGEL2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:28:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so10213822wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 04:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=w4hfcn6UnlueFU5cq3wXrpG+V7ZEGcflMA6MZP6o6+Y=;
        b=lIlZQZP7kUWWg34eCY1QQO0tV6m/uGFf9qJdtj9wBmongvTLcliOgeTcT03vMxH/AL
         zOXtisWsMEU6OnkeIJ5eDuEltZY0rT2LmPGHHEXP4B30r46vSbewBhE7aLXvgQna6iUl
         KasotSGuuDpj6FCibyjep7A+lvLekLMw3JuP2wQDMGvAgKuH9B03httjIzSgc7hiFyJx
         H+yq7evHUKKauYMpKhXdyB8zesgrxPWgwZbSJNH0QpqrNINW1cFCW6maQe+/YesXAc1F
         XGSLHdtS1o7v6F7K41p5AHtKm3E2FPot9eCKR/BwtJzck3G7beh8nzfOFaEucv+Lm1eL
         34og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w4hfcn6UnlueFU5cq3wXrpG+V7ZEGcflMA6MZP6o6+Y=;
        b=GCJliP/fIXIbKQbcEjHTSV2IT5M1k3H2Qnuq8vbD088le58uvYuhJyQi/gUOTmbb6A
         yuSM7d4+w7vAFuOMLKWDq1rWEvqWM0wfngZrj7rjpBstE0FdI699r+1sDUqSdWYNPYl2
         tbmRCS+4DSYDh3T1hUMTEsUcW8FCW0hLyE+4gCKVYufqmdwumYjxveDGSvhMWvcwdb93
         XRNresRQ6MNXp+p1Ue8a7L/4mXVCNgzNsTa4/8paxXOLH8tn8V19j7EmAoYMDJqjBQ5j
         MZP6qnHpyLl2crgdTgua6SfVqO57K99ml/RVHQRjGcCyzOs7xE0NGFur2YExLUbpi5i6
         rXdQ==
X-Gm-Message-State: APt69E2MCphqkw/F+bjBg64/4+gQlGGAy0HuucOmHwtVH0Pc3+R9hXe/
        V7QpDg+jXKf4PJyjSoPWUVE=
X-Google-Smtp-Source: AAOMgpcORNwqNCcoLe5vo3FmBPvjeiH1eF++nKJV++yZBQ7yu4JvoqwCVQhgLqkCPL3MGTJyWcUGOQ==
X-Received: by 2002:adf:80c4:: with SMTP id 62-v6mr4075665wrl.95.1530790125216;
        Thu, 05 Jul 2018 04:28:45 -0700 (PDT)
Received: from msi-8775.fritz.box (p200300EC43C67700FAC17288B9833083.dip0.t-ipconnect.de. [2003:ec:43c6:7700:fac1:7288:b983:3083])
        by smtp.gmail.com with ESMTPSA id a12-v6sm6703253wrs.26.2018.07.05.04.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 04:28:44 -0700 (PDT)
From:   Tobias Tefke <tobias.tefke@gmail.com>
X-Google-Original-From: Tobias Tefke <tobias.tefke@tutanota.com>
To:     tobias.tefke@tutanota.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: events: use correct articles in comments
Date:   Thu,  5 Jul 2018 13:27:56 +0200
Message-Id: <20180705112756.1663-1-tobias.tefke@tutanota.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These words are pronounced (and start) with a vowel sound.
Therefore the article we use has to be 'an' instead of 'a'.

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

