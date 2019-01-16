Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5095EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2004F20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wc/OT1Rq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391787AbfAPJn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:43:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33794 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391771AbfAPJnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:43:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so6164457wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 01:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U3BNDRrIiDC9gX+eckawILhRIOf/eDTHG1vkELYvYtE=;
        b=Wc/OT1Rq9Z3sW5vUlpQ/umlnkUWXtuD2H+KzVh4GKumNG4/BFGDcD87QvGq8gl4Oa8
         WztWfx0ma2sUnte08FjSNBLrHXOnS5uhZuzRzKKlL89Hr4orhwMsPH7s5uGiv9VOFQZ+
         Ib+51fAQKrbrxRoH7EGlyAmpSfMO/LrwT9H0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U3BNDRrIiDC9gX+eckawILhRIOf/eDTHG1vkELYvYtE=;
        b=bCUt5wM9lyd4FYTu8zCM6NOKS5HIr0PMSQ5kKplvh59DLcev42chw4zAF59ohqKUAw
         xS9cjyK04kTMXVl3MDomLlZwX7HmOI56yDDyz1Ofwq/xGSDHnfYcQBddSSNIhI4AsUkv
         vxGegqg6VJ1l9/mWBQLowZqE2Xf9uU62Jw6/72leJbPfQKhSj+3WXjVSadknbCHR1Xry
         eD5V/jnjHY+fh7g3XmQ7mp6B3A/m417KoxxVSuIoZNM2D67yp4uKaK07rc2ZgwQ39CjM
         ZK6Ow2PzEGVHt84iDFZRfJVQwnztfRor0+fBgqrWsJmX0j790tqQilYv+HQ89USV+zeX
         sfcw==
X-Gm-Message-State: AJcUukdzy14neBJz4JHZGTJQadonRlUWygP03dHcVjwQhez1QV7bwgee
        n7oDgV6kGk/m00L+fF0ZR1VELA==
X-Google-Smtp-Source: ALg8bN4+n6TEe4LOtppx5BF99X7TGv4UvVEb9b2K9sd0X0GbCKesAbH+n4by64kV6lO1ZuQ3QdE6Jg==
X-Received: by 2002:adf:8b4d:: with SMTP id v13mr6490941wra.282.1547631802479;
        Wed, 16 Jan 2019 01:43:22 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:596d:a8c4:e914:fdde])
        by smtp.gmail.com with ESMTPSA id k19sm115996304wre.5.2019.01.16.01.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 01:43:21 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, pjt@google.com,
        bsegall@google.com, thara.gopinath@linaro.org,
        pkondeti@codeaurora.org, quentin.perret@arm.com,
        srinivas.pandruvada@linux.intel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v8 1/3] sched/fair: move rq_of helper function
Date:   Wed, 16 Jan 2019 10:43:09 +0100
Message-Id: <1547631791-16018-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547631791-16018-1-git-send-email-vincent.guittot@linaro.org>
References: <1547631791-16018-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move rq_of() helper function so it can be used in pelt.c

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  | 13 -------------
 kernel/sched/sched.h | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ca46964..63b9151 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -248,13 +248,6 @@ const struct sched_class fair_sched_class;
  */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-
-/* cpu runqueue to which this cfs_rq is attached */
-static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
-{
-	return cfs_rq->rq;
-}
-
 static inline struct task_struct *task_of(struct sched_entity *se)
 {
 	SCHED_WARN_ON(!entity_is_task(se));
@@ -411,12 +404,6 @@ static inline struct task_struct *task_of(struct sched_entity *se)
 	return container_of(se, struct task_struct, se);
 }
 
-static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
-{
-	return container_of(cfs_rq, struct rq, cfs);
-}
-
-
 #define for_each_sched_entity(se) \
 		for (; se; se = NULL)
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0ba0892..fd1bad2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -951,6 +951,22 @@ struct rq {
 #endif
 };
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+
+/* cpu runqueue to which this cfs_rq is attached */
+static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->rq;
+}
+
+#else	/* !CONFIG_FAIR_GROUP_SCHED */
+
+static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
+{
+	return container_of(cfs_rq, struct rq, cfs);
+}
+#endif
+
 static inline int cpu_of(struct rq *rq)
 {
 #ifdef CONFIG_SMP
-- 
2.7.4

