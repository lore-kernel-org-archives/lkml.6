Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeB0QFY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:05:24 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46575 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbeB0QFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:05:22 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] sched: Remove TASK_ALL
Date: Tue, 27 Feb 2018 17:05:10 +0100
Message-Id: <20180227160510.10829-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

It's unused:

$ git grep "\<TASK_ALL\>" | wc -l
1

And dangerous, kill the bugger.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b161ef8a902e..21b1168da951 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -93,7 +93,6 @@ struct task_group;
=20
 /* Convenience macros for the sake of wake_up(): */
 #define TASK_NORMAL			(TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE)
-#define TASK_ALL			(TASK_NORMAL | __TASK_STOPPED | __TASK_TRACED)
=20
 /* get_task_state(): */
 #define TASK_REPORT			(TASK_RUNNING | TASK_INTERRUPTIBLE | \
--=20
2.16.2
