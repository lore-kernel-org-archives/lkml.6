Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hVYABYhYHlvOBAAAmS7hNA
	; Mon, 11 Jun 2018 11:10:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 04A4760792; Mon, 11 Jun 2018 11:10:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JmvYjzqI"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 26BA2601C3;
	Mon, 11 Jun 2018 11:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26BA2601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932830AbeFKLKM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 07:10:12 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43882 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeFKLKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:10:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id d2-v6so19921694wrm.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 04:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OhSv5JlWHtifRR0vEviXN32+SxTHbHorsj4yQXBVlY0=;
        b=JmvYjzqI4YmsouDDwUD4zfdmLFM/TGmVRtVcx8KplMaewSDtEn4WfxLi5pJmiV/9oz
         zZIuZmpI+L1p0MbYJVy1x4rE0rZaorZkFrXG/ozxe2kBMJ8lddRNPv3PHazsxhhEAzIA
         5sfqxUW91uHYegR5tbIJoGcZR/CaEbYDP2RC4z2+WKTgzQ0fmHF2u8KdpfG1of6/d7YJ
         O0dVt63VH5V7s5YbBW+vrFm/bDh43DlgfL0YU2hJCsA+jq0PUILs+wBUui6vLz8tTgRH
         mhhZK0Yr25ijhOoZn2A/jnBGYYsgS4azCReVEh+U/atzRFhY3pH0dfUdBkMi4oPl9/Lz
         9eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OhSv5JlWHtifRR0vEviXN32+SxTHbHorsj4yQXBVlY0=;
        b=W8AFJFXWO2cyNEGwjnx6v2He4UGw03EE2nxYiWAoeRsZbgo4Cx8LUY/WJ3KKBHnj4P
         8r3kPt3bqJdsbLaDzJWwaLsZhlaLNLP2GjvU6L7LglyQWFtaZp7RHelPBPZutkspLssC
         XosPUBZeaUm0MJ1mQghjMZ2YYT5XZpHmd0ip9QxErDIhyyq66lN0fM6IL/hU9xoFIbsK
         Q68Z4P1mmwbPt22H7hZ7D23Cv1aYfwnB1xOnTDB3RwLvn0QE9wkiKfkjwzwjrvM9vtj3
         iLNsTbGmuz0SD3kV5wiIHyLWd5C3PsnOlrK407BqpIllb0iMq7LwSXV6m9V9YguCI6Qm
         aH0w==
X-Gm-Message-State: APt69E3RZgWJDAPnryayA4HlGkL7xP9HlT3nlkdK1DUiu2k8qZ8mLo0y
        LgIFrrNTO3S9yS7SoYpinxiTWQ==
X-Google-Smtp-Source: ADUXVKIdIymzL137vwlLeRhdDnQIQ+XPx24to7IOUPuGvDe6BcNw+nliw8hE1rMERm2rxtzem9pUoA==
X-Received: by 2002:a5d:4611:: with SMTP id t17-v6mr6513212wrq.74.1528715408928;
        Mon, 11 Jun 2018 04:10:08 -0700 (PDT)
Received: from dvyukov-z840.muc.corp.google.com ([100.105.28.230])
        by smtp.gmail.com with ESMTPSA id s10-v6sm12514382wmb.12.2018.06.11.04.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 04:10:07 -0700 (PDT)
Received: by dvyukov-z840.muc.corp.google.com (Postfix, from userid 129372)
        id 4EBDAE08BF; Mon, 11 Jun 2018 13:10:06 +0200 (CEST)
From: Dmitry Vyukov <dvyukov@google.com>
To: akpm@linux-foundation.org, penguin-kernel@I-love.SAKURA.ne.jp,
        paulmck@linux.vnet.ibm.com
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
Subject: [PATCH v2] kernel/hung_task.c: allow to set checking interval separately from timeout
Date: Mon, 11 Jun 2018 13:10:04 +0200
Message-Id: <20180611111004.203513-1-dvyukov@google.com>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently task hung checking interval is equal to timeout,
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

Allow setting checking interval separately from timeout.
This allows to set timeout to, say, 3 minutes,
but checking interval to 10 secs.

The interval is controlled via a new hung_task_check_interval_secs
sysctl, similar to the existing hung_task_timeout_secs sysctl.
The default value of 0 results in the current behavior:
checking interval is equal to timeout.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com

---

Changes since v1:
 - add entry to Documentation/sysctl/kernel.txt
 - rename hung_task_period_secs sysctl to hung_task_check_interval_secs
---
 Documentation/sysctl/kernel.txt | 15 ++++++++++++++-
 include/linux/sched.h           |  1 +
 include/linux/sched/sysctl.h    |  1 +
 kernel/fork.c                   |  1 +
 kernel/hung_task.c              | 15 ++++++++++++++-
 kernel/sysctl.c                 |  8 ++++++++
 6 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index eded671d55eb..71f1b8716ba9 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -38,6 +38,7 @@ show up in /proc/sys/kernel:
 - hung_task_panic
 - hung_task_check_count
 - hung_task_timeout_secs
+- hung_task_check_interval_secs
 - hung_task_warnings
 - kexec_load_disabled
 - kptr_restrict
@@ -354,7 +355,7 @@ This file shows up if CONFIG_DETECT_HUNG_TASK is enabled.
 
 hung_task_timeout_secs:
 
-Check interval. When a task in D state did not get scheduled
+When a task in D state did not get scheduled
 for more than this value report a warning.
 This file shows up if CONFIG_DETECT_HUNG_TASK is enabled.
 
@@ -363,6 +364,18 @@ Possible values to set are in range {0..LONG_MAX/HZ}.
 
 ==============================================================
 
+hung_task_check_interval_secs:
+
+Hung task check interval. If hung task checking is enabled
+(see hung_task_timeout_secs), the check is done every
+hung_task_check_interval_secs seconds.
+This file shows up if CONFIG_DETECT_HUNG_TASK is enabled.
+
+0 (default): means use hung_task_timeout_secs as checking interval.
+Possible values to set are in range {0..LONG_MAX/HZ}.
+
+==============================================================
+
 hung_task_warnings:
 
 The maximum number of warnings to report. During a check interval
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3aa4fcb74e76..0db55fbe47a4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -849,6 +849,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_DETECT_HUNG_TASK
 	unsigned long			last_switch_count;
+	unsigned long			last_switch_time;
 #endif
 	/* Filesystem information: */
 	struct fs_struct		*fs;
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 1c1a1512ec55..8ada9a538bc1 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -10,6 +10,7 @@ struct ctl_table;
 extern int	     sysctl_hung_task_check_count;
 extern unsigned int  sysctl_hung_task_panic;
 extern unsigned long sysctl_hung_task_timeout_secs;
+extern unsigned long sysctl_hung_task_check_interval_secs;
 extern int sysctl_hung_task_warnings;
 extern int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
 					 void __user *buffer,
diff --git a/kernel/fork.c b/kernel/fork.c
index 08c6e5e217a0..3c095595b940 100644
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
index 32b479468e4d..b9132d1269ef 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -40,6 +40,11 @@ int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
  */
 unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_TASK_TIMEOUT;
 
+/*
+ * Zero (default value) means use sysctl_hung_task_timeout_secs:
+ */
+unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
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
+		unsigned long interval = sysctl_hung_task_check_interval_secs;
+		long t;
 
+		if (interval == 0)
+			interval = timeout;
+		interval = min_t(unsigned long, interval, timeout);
+		t = hung_timeout_jiffies(hung_last_checked, interval);
 		if (t <= 0) {
 			if (!atomic_xchg(&reset_hung_task, 0))
 				check_hung_uninterruptible_tasks(timeout);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 6a78cf70761d..ef873976a227 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1098,6 +1098,14 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dohung_task_timeout_secs,
 		.extra2		= &hung_task_timeout_max,
 	},
+	{
+		.procname	= "hung_task_check_interval_secs",
+		.data		= &sysctl_hung_task_check_interval_secs,
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
