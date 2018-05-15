Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbeEOAev (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 20:34:51 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:33287 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752257AbeEOAev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 20:34:51 -0400
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From: Byungchul Park <byungchul.park@lge.com>
To: jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: [PATCH] rcu: Report a quiescent state of TASKS_RCU on a tick from user
Date: Tue, 15 May 2018 09:33:46 +0900
Message-Id: <1526344426-31836-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

You removed the reporing while simplifying the commit 508880df6 :)
Fold this patch onto the commit or add, whatever you want.

Thanks,
Byungchul

----->8-----
>From 18a2d8da3baf79d0edd5ccf94abe6f989da5b1c1 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul.park@lge.com>
Date: Tue, 15 May 2018 09:21:43 +0900
Subject: [PATCH] rcu: Report a quiescent state of TASKS_RCU on a tick from
 user

The reporting was removed while simplifying the commit 508880df6 (rcu:
Improve rcu_note_voluntary_context_switch() reporting). Add it back.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/tiny.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index befc932..3345596 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -120,8 +120,10 @@ void rcu_bh_qs(void)
  */
 void rcu_check_callbacks(int user)
 {
-	if (user)
+	if (user) {
 		rcu_sched_qs();
+		rcu_tasks_qs();
+	}
 	if (user || !in_softirq())
 		rcu_bh_qs();
 }
-- 
1.9.1
