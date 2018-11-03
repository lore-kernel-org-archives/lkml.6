Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8746C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5516B20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="SINdvEcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5516B20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbeKDDpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:45:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38815 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbeKDDpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:45:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id p4-v6so89304plo.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iXPhjBGuHMxMaRXdVtVi5S1b/4/EEj7dXXmpSpcVTv4=;
        b=SINdvEcZP/3EJG2D3sTVeYNHt1wYcMhNoPJ1OdYRxcnz8ixFmbFUFajUs47oIkXPI0
         q2i8sot0xjQbemfKAWFd8CRNN9z3H2QY8kXSWgSjcX3ggQLuAN3C/QCdzvp1BU8+qTXj
         Qg9e6h2iwF1mrvOBavYRFgXROdzu2H+lUUGOScG8uZLIuLGZn9EzCPv3BD+YvlHgZ5vi
         i4Cb0KGxAKl0XyNdhwTrUPKyIWa0Jk2cOgNm3ohYGE8ar+qyyYpwonZwrkn6tTpq97rC
         ZtrVEz7DlbplV3/ch3bJtqN7zi+jnzc2mwuwfCUW+knGb5dPDVIm0rBrSBIcwyAwt6Qi
         ueJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iXPhjBGuHMxMaRXdVtVi5S1b/4/EEj7dXXmpSpcVTv4=;
        b=NZWO2itcyqTP5UngSAkLHcf+Wu6zSvl2qSGoFzaR6zEcPYZ/wE3i7Rq6K7mdQgyMZx
         FCMIYaaE40A+6LLTyEYozzz257b2rRUCXm+FDRmGVj4kXDeiOgd557QvkjbLsR2cchim
         k3TaB78JDjphcwf0WHCuGGzU5GgywtG0dRbRPx1YmiKsSC/L7NlLCasbqBAfz2sHrUjp
         IEVcLCr7x/AeS6Oq7fr4Vbxkk4wNxVROVRGVelcDtFUBft1jYT/jtB3U99uLgks2jYz0
         SIFziYIWNng7qF6lXcoAMv4vXKySvzWefroe/9R2vjfaix/2cRLQh+rjgYQ/F4oAUMZQ
         qK8w==
X-Gm-Message-State: AGRZ1gIr7U9856nUj1R9HggFq7bk9J6+mmEiM2mr655tBwQDTa+XX9h5
        YhKAjiQlrfXaV9IAV91FUjtuFQ==
X-Google-Smtp-Source: AJdET5ceDxMzHfpqLT+lLt2TGdpa1/5DhlJHvL0+kE4FGPeO2UKk6kim+8wtLmtXH310Pd62b13Qag==
X-Received: by 2002:a17:902:7108:: with SMTP id a8-v6mr16004927pll.290.1541270029125;
        Sat, 03 Nov 2018 11:33:49 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id w2-v6sm3958669pfn.89.2018.11.03.11.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 11:33:46 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] psi: simplify cgroup_move_task
Date:   Sat,  3 Nov 2018 11:33:39 -0700
Message-Id: <20181103183339.8669-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing code triggered an invalid warning about 'rq' possibly being
used uninitialized. Instead of doing the silly warning suppression by
initializa it to NULL, refactor the code to bail out early instead.

Warning was:

kernel/sched/psi.c: In function ‘cgroup_move_task’:
kernel/sched/psi.c:639:13: warning: ‘rq’ may be used uninitialized in this function [-Wmaybe-uninitialized]

Fixes: 2ce7135adc9ad ("psi: cgroup support")
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 kernel/sched/psi.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7cdecfc010af..3d7355d7c3e3 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -633,38 +633,39 @@ void psi_cgroup_free(struct cgroup *cgroup)
  */
 void cgroup_move_task(struct task_struct *task, struct css_set *to)
 {
-	bool move_psi = !psi_disabled;
 	unsigned int task_flags = 0;
 	struct rq_flags rf;
 	struct rq *rq;
 
-	if (move_psi) {
-		rq = task_rq_lock(task, &rf);
+	if (psi_disabled) {
+		/*
+		 * Lame to do this here, but the scheduler cannot be locked
+		 * from the outside, so we move cgroups from inside sched/.
+		 */
+		rcu_assign_pointer(task->cgroups, to);
+		return;
+	}
 
-		if (task_on_rq_queued(task))
-			task_flags = TSK_RUNNING;
-		else if (task->in_iowait)
-			task_flags = TSK_IOWAIT;
+	rq = task_rq_lock(task, &rf);
 
-		if (task->flags & PF_MEMSTALL)
-			task_flags |= TSK_MEMSTALL;
+	if (task_on_rq_queued(task))
+		task_flags = TSK_RUNNING;
+	else if (task->in_iowait)
+		task_flags = TSK_IOWAIT;
 
-		if (task_flags)
-			psi_task_change(task, task_flags, 0);
-	}
+	if (task->flags & PF_MEMSTALL)
+		task_flags |= TSK_MEMSTALL;
 
-	/*
-	 * Lame to do this here, but the scheduler cannot be locked
-	 * from the outside, so we move cgroups from inside sched/.
-	 */
+	if (task_flags)
+		psi_task_change(task, task_flags, 0);
+
+	/* See comment above */
 	rcu_assign_pointer(task->cgroups, to);
 
-	if (move_psi) {
-		if (task_flags)
-			psi_task_change(task, 0, task_flags);
+	if (task_flags)
+		psi_task_change(task, 0, task_flags);
 
-		task_rq_unlock(rq, task, &rf);
-	}
+	task_rq_unlock(rq, task, &rf);
 }
 #endif /* CONFIG_CGROUPS */
 
-- 
2.11.0

