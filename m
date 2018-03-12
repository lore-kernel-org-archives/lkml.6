Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeCLMQ7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:16:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40657 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeCLMQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:16:57 -0400
Date: Mon, 12 Mar 2018 05:16:36 -0700
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-9e49e2447c6385e45c6fddd70d6c0e917e21b669@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com, peterz@infradead.org
Reply-To: peterz@infradead.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de
In-Reply-To: <20180227160510.10829-1-bigeasy@linutronix.de>
References: <20180227160510.10829-1-bigeasy@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Remove TASK_ALL
Git-Commit-ID: 9e49e2447c6385e45c6fddd70d6c0e917e21b669
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9e49e2447c6385e45c6fddd70d6c0e917e21b669
Gitweb:     https://git.kernel.org/tip/9e49e2447c6385e45c6fddd70d6c0e917e21b669
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue, 27 Feb 2018 17:05:10 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 10:51:47 +0100

sched/core: Remove TASK_ALL

It's unused:

  $ git grep "\<TASK_ALL\>" | wc -l
  1

... and it is also dangerous, kill the bugger.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180227160510.10829-1-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b161ef8a902e..21b1168da951 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -93,7 +93,6 @@ struct task_group;
 
 /* Convenience macros for the sake of wake_up(): */
 #define TASK_NORMAL			(TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE)
-#define TASK_ALL			(TASK_NORMAL | __TASK_STOPPED | __TASK_TRACED)
 
 /* get_task_state(): */
 #define TASK_REPORT			(TASK_RUNNING | TASK_INTERRUPTIBLE | \
