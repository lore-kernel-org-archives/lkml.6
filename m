Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbeENHw3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:52:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48777 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbeENHwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:52:24 -0400
Date: Mon, 14 May 2018 00:51:58 -0700
From: tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-a59a68fee05d46cccc4279ab6609421f7270398e@git.kernel.org>
Cc: fengguang.wu@intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, efault@gmx.de, bigeasy@linutronix.de,
        hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, efault@gmx.de, bigeasy@linutronix.de,
        fengguang.wu@intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180504104224.20218-1-bigeasy@linutronix.de>
References: <20180504104224.20218-1-bigeasy@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/wait: Include <linux/wait.h> in
 <linux/swait.h>
Git-Commit-ID: a59a68fee05d46cccc4279ab6609421f7270398e
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

Commit-ID:  a59a68fee05d46cccc4279ab6609421f7270398e
Gitweb:     https://git.kernel.org/tip/a59a68fee05d46cccc4279ab6609421f7270398e
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 4 May 2018 12:42:24 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 09:12:25 +0200

sched/wait: Include <linux/wait.h> in <linux/swait.h>

kbuild bot reported against an intermediate RT patch that the build
fails with:

>    In file included from include/linux/completion.h:12:0,
>                     from include/linux/rcupdate_wait.h:10,
>                     from kernel/rcu/srcutiny.c:27:
>    kernel/rcu/srcutiny.c: In function 'srcu_drive_gp':
> >> include/linux/swait.h:172:7: error: implicit declaration of function '___wait_is_interruptible'; did you mean '__swait_event_interruptible'?
>       if (___wait_is_interruptible(state) && __int) {  \

That error vanishes a few patches later (in the RT queue) because wait.h
is then pulled in by other means. It does not seem to surface on !RT.
I think that swait should include a header file for a function/macro
(___wait_is_interruptible()) it is using.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180504104224.20218-1-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/swait.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index c98aaf677466..84f9745365ff 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
+#include <linux/wait.h>
 #include <asm/current.h>
 
 /*
