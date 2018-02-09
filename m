Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeBIOwe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:52:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751097AbeBIOwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:52:33 -0500
From: Waiman Long <longman@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH] kthread: Export kthread_data()
Date: Fri,  9 Feb 2018 09:52:21 -0500
Message-Id: <1518187941-29275-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple kernel threads are created to cooperatively work on
a common task, we may need a convenient way to access data that are
specific to each kthread.

The kthread_data() function fits this need.  However, it was not
visible to kthreads started in a kernel module. To solve this problem,
the kthread_data() function is now exported allowing kthreads from
kernel modules to use it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/kthread.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index cd50e99..a71d461 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -156,6 +156,7 @@ void *kthread_data(struct task_struct *task)
 {
 	return to_kthread(task)->data;
 }
+EXPORT_SYMBOL(kthread_data);
 
 /**
  * kthread_probe_data - speculative version of kthread_data()
-- 
1.8.3.1
