Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AL5OACZyGlvlPgAAmS7hNA
	; Fri, 08 Jun 2018 12:10:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D7A166089E; Fri,  8 Jun 2018 12:10:52 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nx9V8eP3"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2C73A60290;
	Fri,  8 Jun 2018 12:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C73A60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932124AbeFHMKu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:10:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38475 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753020AbeFHMKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:10:44 -0400
Received: by mail-wr0-f194.google.com with SMTP id e18-v6so4914550wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rkvjbfQsQjKzXzCOUy1KX6h5OggUX2Y49yDI9+C1Ggs=;
        b=Nx9V8eP3HUOiBHLrxP9RBWvGKlLR9+A37fQAb9baIxrodTpunR2bvSZp6csEoICECe
         X7+dxAsUqe4h3ba1O4vgIgZ2AmgHYCs7YAEfs/FW8U5OsjXkE8iFGM+66w9paiCfTYj0
         dizyeGKPn/pfLVylp+4oHcM+UGLXY0S1zeeRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rkvjbfQsQjKzXzCOUy1KX6h5OggUX2Y49yDI9+C1Ggs=;
        b=ruQy+5+XpWfsf4q60+0KnWTgP94BXRX5xcmQbvr6HOlEZ8KRH/w0XgfBgTIctAaWwh
         PFUec1a4YjBdlCNG5lAl5bIWcGK4qurjN8XxySFCyiKRIlzLLHzvhZ0or0218nAt16uZ
         YUn2GztBf6gttOfCZc9/zjkQ/psQT5PhTytULhksyABurS/yISlswcgDFtLINsgG9RoR
         oni3oUC3E53zTbhmOPjdy6I8bRrnaB1Y4cLWuhgd+ATbg1x/CjAlOzpRoFehJeMOIAAu
         jfR82wDm/vY6z64vwgkrjo632ftR5a6WYRzmjpSLOE7pTSJs2mxXTLgEa9td/JX2DyRY
         uc5Q==
X-Gm-Message-State: APt69E0CsDNm8lW68hcVoaWdDbWk6lTfZ3vprwWX5MbYH6uIg76PvLBS
        iRotuck59AZzViwN+6JSnRlN6g==
X-Google-Smtp-Source: ADUXVKLA2QUxaRUSHa2uJADfIdMDq3kGB+awXpQTMNDI9Pv82xexkk2DKkXO7ijSju1I7cjPGimydw==
X-Received: by 2002:adf:e542:: with SMTP id z2-v6mr5072182wrm.111.1528459843201;
        Fri, 08 Jun 2018 05:10:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6c67:7ea:9f4d:8968])
        by smtp.gmail.com with ESMTPSA id b204-v6sm1546003wmh.22.2018.06.08.05.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 05:10:42 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 11/11] proc/sched: remove unused sched_time_avg_ms
Date: Fri,  8 Jun 2018 14:09:54 +0200
Message-Id: <1528459794-13066-12-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/sys/kernel/sched_time_avg_ms entry is not used anywhere.
Remove it

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched/sysctl.h | 1 -
 kernel/sched/core.c          | 8 --------
 kernel/sched/sched.h         | 1 -
 kernel/sysctl.c              | 8 --------
 4 files changed, 18 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 1c1a151..913488d 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -40,7 +40,6 @@ extern unsigned int sysctl_numa_balancing_scan_size;
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
 extern __read_mostly unsigned int sysctl_sched_nr_migrate;
-extern __read_mostly unsigned int sysctl_sched_time_avg;
 
 int sched_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *length,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 213d277..9894bc7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -46,14 +46,6 @@ const_debug unsigned int sysctl_sched_features =
 const_debug unsigned int sysctl_sched_nr_migrate = 32;
 
 /*
- * period over which we average the RT time consumption, measured
- * in ms.
- *
- * default: 1s
- */
-const_debug unsigned int sysctl_sched_time_avg = MSEC_PER_SEC;
-
-/*
  * period over which we measure -rt task CPU usage in us.
  * default: 1s
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1faab06..6766a3c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1706,7 +1706,6 @@ extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 
 extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 
-extern const_debug unsigned int sysctl_sched_time_avg;
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 6a78cf7..d77a959 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -368,14 +368,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-	{
-		.procname	= "sched_time_avg_ms",
-		.data		= &sysctl_sched_time_avg,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-	},
 #ifdef CONFIG_SCHEDSTATS
 	{
 		.procname	= "sched_schedstats",
-- 
2.7.4
