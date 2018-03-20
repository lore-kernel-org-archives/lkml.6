Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbeCTJYP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:24:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41652 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeCTJYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:24:12 -0400
X-Google-Smtp-Source: AG47ELue7wnuzDzzt/C3cPLa06jF4lomWQH9254XObBXhF2wG9odJVnRDeU0mbxskVE1wserL/kpVQ==
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH] workqueue: fix the comments of nr_idle
Date: Tue, 20 Mar 2018 17:24:05 +0800
Message-Id: <20180320092406.13078-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the worker rebinding behavior was refactored, there is
no idle worker off the idle_list now. The comment is outdated
and can be just removed.

It also groups nr_workers and nr_idle together.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bb9a519cbf50..19785a092026 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -153,10 +153,9 @@ struct worker_pool {
 	unsigned long		watchdog_ts;	/* L: watchdog timestamp */
 
 	struct list_head	worklist;	/* L: list of pending works */
-	int			nr_workers;	/* L: total number of workers */
 
-	/* nr_idle includes the ones off idle_list for rebinding */
-	int			nr_idle;	/* L: currently idle ones */
+	int			nr_workers;	/* L: total number of workers */
+	int			nr_idle;	/* L: currently idle workers */
 
 	struct list_head	idle_list;	/* X: list of idle workers */
 	struct timer_list	idle_timer;	/* L: worker idle timeout */
-- 
2.14.3 (Apple Git-98)
