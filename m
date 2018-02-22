Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeBVGwx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 01:52:53 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40997 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752462AbeBVGww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 01:52:52 -0500
X-Google-Smtp-Source: AH8x2262Dz0HYUIqhkYI3FQI/XnMMcDj1YUb0qU1y3j9sdpfF1HMM7YKZxGXRmg+btGharlllKCPaA==
From: zhouzhouyi@gmail.com
To: paulmck@linux.vnet.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] srcu: remove never used variable
Date: Thu, 22 Feb 2018 06:52:37 +0000
Message-Id: <1519282357-17983-1-git-send-email-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

In function srcu_gp_end, the variable idxnext is never used after assign,
remove it and its assign statement.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 kernel/rcu/srcutree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d5cea81..1241715 100644
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
2.1.4
