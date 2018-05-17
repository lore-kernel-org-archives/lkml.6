Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeEQRVK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:21:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751293AbeEQRVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:21:09 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak81 V3a] fixup! audit: collect audit task parameters
Date: Thu, 17 May 2018 13:20:09 -0400
Message-Id: <03014913acdc9dc6fbbee0e16c937170fea86b06.1526577485.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable fork.c compilation with audit disabled.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
Hi Paul, this one got caught by the 0-day kbuildbot.  Can you squash it
down if you haven't merged it yet?
---
 kernel/fork.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 92ab849..ff82928 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1713,7 +1713,9 @@ static __latent_entropy struct task_struct *copy_process(
 	p->start_time = ktime_get_ns();
 	p->real_start_time = ktime_get_boot_ns();
 	p->io_context = NULL;
+#ifdef CONFIG_AUDITSYSCALL
 	p->audit = NULL;
+#endif /* CONFIG_AUDITSYSCALL */
 	cgroup_fork(p);
 #ifdef CONFIG_NUMA
 	p->mempolicy = mpol_dup(p->mempolicy);
-- 
1.8.3.1
