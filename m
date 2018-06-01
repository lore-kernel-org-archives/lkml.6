Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbeFANXl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:23:41 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45951 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752464AbeFANXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:23:11 -0400
X-Google-Smtp-Source: ADUXVKIf0zpbWr2kjmXNVKDlBTkfM4O/i3n+cwRwJivyjSMr5aP3p4LNgUZly21iWIA1CI2ZyMdIHg==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 16/17] signal: make security_task_kill() return bool
Date: Fri,  1 Jun 2018 15:22:38 +0200
Message-Id: <20180601132239.4421-17-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601132239.4421-1-christian@brauner.io>
References: <20180601132239.4421-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

security_task_kill() already behaves like a boolean function. Let's
actually declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v1->v2:
* unchanged
v0->v1:
* patch added
---
 kernel/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 515fa59a0e9c..d5f9472a0935 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1922,10 +1922,10 @@ static inline bool may_ptrace_stop(void)
  * Return non-zero if there is a SIGKILL that should be waking us up.
  * Called with the siglock held.
  */
-static int sigkill_pending(struct task_struct *tsk)
+static bool sigkill_pending(struct task_struct *tsk)
 {
-	return	sigismember(&tsk->pending.signal, SIGKILL) ||
-		sigismember(&tsk->signal->shared_pending.signal, SIGKILL);
+	return sigismember(&tsk->pending.signal, SIGKILL) ||
+	       sigismember(&tsk->signal->shared_pending.signal, SIGKILL);
 }
 
 /*
-- 
2.17.0
