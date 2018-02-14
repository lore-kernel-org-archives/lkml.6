Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934923AbeBNJF7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 04:05:59 -0500
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:45254 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934695AbeBNJF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 04:05:58 -0500
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From: Byungchul Park <byungchul.park@lge.com>
To: jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: [PATCH] srcu: Remove dead code in srcu_gp_end()
Date: Wed, 14 Feb 2018 18:05:24 +0900
Message-Id: <1518599124-29153-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Of course, compilers will optimize out a dead code. Anyway, remove
any dead code for better readibility.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/srcutree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 44bc0fa..829453b 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -531,7 +531,6 @@ static void srcu_gp_end(struct srcu_struct *sp)
 	unsigned long flags;
 	unsigned long gpseq;
 	int idx;
-	int idxnext;
 	unsigned long mask;
 	struct srcu_data *sdp;
 	struct srcu_node *snp;
@@ -555,7 +554,6 @@ static void srcu_gp_end(struct srcu_struct *sp)
 
 	/* Initiate callback invocation as needed. */
 	idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
-	idxnext = (idx + 1) % ARRAY_SIZE(snp->srcu_have_cbs);
 	rcu_for_each_node_breadth_first(sp, snp) {
 		spin_lock_irq_rcu_node(snp);
 		cbs = false;
-- 
1.9.1
