Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lpmyGgWFGlsZeAAAmS7hNA
	; Fri, 08 Jun 2018 13:30:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5FFBC607DC; Fri,  8 Jun 2018 13:30:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JNYt4GTM"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 83DC4606FA;
	Fri,  8 Jun 2018 13:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83DC4606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeFHNau (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:30:50 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39356 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeFHNat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:30:49 -0400
Received: by mail-wr0-f196.google.com with SMTP id w7-v6so13419201wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 06:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nbEdmb4ehTddIbwt1ENyfrA1yCcxbUgm5HBUrqTX6ns=;
        b=JNYt4GTMliwhKicBk/1o1dO5dGeOeFHzMYgGr47booBGQDqFL5nwGtztfwxc/NsOZE
         o3vKsyRIoyniUcd4k2AI3CShB9bglTK7VD1TS6236yx22IvKLiJOJiMDc2T9ScDM9VOY
         uLNUsqzLyUd2san8x6huT3h4I+a/6Xrzx9giXCc24XlXrwEnpsSgAkSnlUf0DDZIBdak
         dEue8ZTYWjwpsd00pP6t6UuF/BEn03+OExu+Y4qtUFoN35AoL4Xv/RF2xJY0qnlcEsZX
         inpn3mWsyivZz2d8LHW0q4UUgIou5Fa1DLv9+8qAMUzTYjkgm9VQKWzL/RFn9oO7IGHh
         JdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nbEdmb4ehTddIbwt1ENyfrA1yCcxbUgm5HBUrqTX6ns=;
        b=FO7WCcTQ76iIM8K6d+Z04zY/Py+Ia55kz29Hkjz64Zw3mUretyAToWa+KmiyTR9gAu
         xIcWG3nv0lqHqW3zlVmQm4Z7UTa4IusXuG7ckET2rPZYsJVvcUrAm0b2f8ZUW7qmIFeh
         AVN2JKE0ORp2DpFPdI8RgNMNKYqdUm4th21yukUK3YLKAHACloPKmTeq4icqMYP0sN5H
         ZtkcfrSHZsKZ/n6fz6u/y7gXBj83SX2WuZuvQ/W8WyMmKpF0QJ8eJHvPp19+PAWCU13f
         xFnoHXlIaA8OXcYFIpnmFAwrRPmL6vYJxpsYM3Bqkcp1FSzr8pnLB/d6s08IhaJzu74A
         0P8w==
X-Gm-Message-State: APt69E0fAOv/8syBi9NfhLrDgEerm3T369kffiv4HIoZ0yczTzkqZPtq
        91PhLFcRs66wZ4qK4lvoAT3Jdg==
X-Google-Smtp-Source: ADUXVKKOZm7QZSafe9v+T0d27iAXHJyMLtiSk/sgY9Rkv/sZYbU36hgUsa69z6hBExBQ2m/hexBUCg==
X-Received: by 2002:adf:c104:: with SMTP id r4-v6mr5365373wre.203.1528464647563;
        Fri, 08 Jun 2018 06:30:47 -0700 (PDT)
Received: from dvyukov-z840.muc.corp.google.com ([100.105.28.230])
        by smtp.gmail.com with ESMTPSA id u15-v6sm2313517wma.37.2018.06.08.06.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 06:30:46 -0700 (PDT)
Received: by dvyukov-z840.muc.corp.google.com (Postfix, from userid 129372)
        id 749E2E0860; Fri,  8 Jun 2018 15:30:45 +0200 (CEST)
From: Dmitry Vyukov <dvyukov@google.com>
To: akpm@linux-foundation.org, penguin-kernel@I-love.SAKURA.ne.jp,
        paulmck@linux.vnet.ibm.com
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
Subject: [PATCH] kernel/hung_task.c: allow to set period separately from timeout
Date: Fri,  8 Jun 2018 15:30:43 +0200
Message-Id: <20180608133043.203744-1-dvyukov@google.com>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently task hung checking period is equal to timeout,
as the result hung is detected anywhere between timeout and 2*timeout.
This is fine for most interactive environments, but this hurts automated
testing setups (syzbot). In an automated setup we need to strictly order
CPU lockup < RCU stall < workqueue lockup < task hung < silent loss,
so that RCU stall is not detected as task hung and task hung is not
detected as silent machine loss. The large variance in task hung
detection timeout requires setting silent machine loss timeout to
a very large value (e.g. if task hung is 3 mins, then silent loss
need to be set to ~7 mins). The additional 3 minutes significantly
reduce testing efficiency because usually we crash kernel within
a minute, and this can add hours to bug localization process as it
needs to do dozens of tests.

Allow setting checking period separately from timeout.
This allows to set timeout to, say, 3 minutes, but period to 10 secs.

The period is controlled via a new hung_task_period_secs sysctl,
similar to the existing hung_task_timeout_secs sysctl.
The default value of 0 results in the current behavior.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com
---
 include/linux/sched.h        |  1 +
 include/linux/sched/sysctl.h |  1 +
 kernel/fork.c                |  1 +
 kernel/hung_task.c           | 15 ++++++++++++++-
 kernel/sysctl.c              |  8 ++++++++
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 14e4f9c12337..520032e87c9e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -848,6 +848,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_DETECT_HUNG_TASK
 	unsigned long			last_switch_count;
+	unsigned long			last_switch_time;
 #endif
 	/* Filesystem information: */
 	struct fs_struct		*fs;
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 1c1a1512ec55..1db0fc4cb134 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -10,6 +10,7 @@ struct ctl_table;
 extern int	     sysctl_hung_task_check_count;
 extern unsigned int  sysctl_hung_task_panic;
 extern unsigned long sysctl_hung_task_timeout_secs;
+extern unsigned long sysctl_hung_task_period_secs;
 extern int sysctl_hung_task_warnings;
 extern int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
 					 void __user *buffer,
diff --git a/kernel/fork.c b/kernel/fork.c
index c6d1c1ce9ed7..f393ed8ae15b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1262,6 +1262,7 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 	tsk->nvcsw = tsk->nivcsw = 0;
 #ifdef CONFIG_DETECT_HUNG_TASK
 	tsk->last_switch_count = tsk->nvcsw + tsk->nivcsw;
+	tsk->last_switch_time = 0;
 #endif
 
 	tsk->mm = NULL;
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 32b479468e4d..55a7e84c3315 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -40,6 +40,11 @@ int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
  */
 unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_TASK_TIMEOUT;
 
+/*
+ * Zero (default value) means use sysctl_hung_task_timeout_secs:
+ */
+unsigned long __read_mostly sysctl_hung_task_period_secs;
+
 int __read_mostly sysctl_hung_task_warnings = 10;
 
 static int __read_mostly did_panic;
@@ -98,8 +103,11 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 
 	if (switch_count != t->last_switch_count) {
 		t->last_switch_count = switch_count;
+		t->last_switch_time = jiffies;
 		return;
 	}
+	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
+		return;
 
 	trace_sched_process_hang(t);
 
@@ -245,8 +253,13 @@ static int watchdog(void *dummy)
 
 	for ( ; ; ) {
 		unsigned long timeout = sysctl_hung_task_timeout_secs;
-		long t = hung_timeout_jiffies(hung_last_checked, timeout);
+		unsigned long period = sysctl_hung_task_period_secs;
+		long t;
 
+		if (period == 0)
+			period = timeout;
+		period = min_t(unsigned long, period, timeout);
+		t = hung_timeout_jiffies(hung_last_checked, period);
 		if (t <= 0) {
 			if (!atomic_xchg(&reset_hung_task, 0))
 				check_hung_uninterruptible_tasks(timeout);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 6a78cf70761d..029cfed5189c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1098,6 +1098,14 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dohung_task_timeout_secs,
 		.extra2		= &hung_task_timeout_max,
 	},
+	{
+		.procname	= "hung_task_period_secs",
+		.data		= &sysctl_hung_task_period_secs,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= proc_dohung_task_timeout_secs,
+		.extra2		= &hung_task_timeout_max,
+	},
 	{
 		.procname	= "hung_task_warnings",
 		.data		= &sysctl_hung_task_warnings,
-- 
2.18.0.rc1.242.g61856ae69a-goog
