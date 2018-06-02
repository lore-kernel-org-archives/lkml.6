Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeFBKjb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:39:31 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45357 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751871AbeFBKh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:37:29 -0400
X-Google-Smtp-Source: ADUXVKKPwxqSL3QKEL7MaNT07fcr1MSZiG4JcWUQl+DH3XbgE8cXJHXXyebCdFSMEG5BXEofpEfz8A==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 16/17] signal: make sigkill_pending() return bool
Date: Sat,  2 Jun 2018 12:36:52 +0200
Message-Id: <20180602103653.18181-17-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180602103653.18181-1-christian@brauner.io>
References: <20180602103653.18181-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sigkill_pending() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v2->v3:
* [Oleg Nestorov] fix wrong function name in commit message
v1->v2:
* unchanged
v0->v1:
* patch added
---
 kernel/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 50255b6a3124..8d57a64abe52 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1918,10 +1918,10 @@ static inline bool may_ptrace_stop(void)
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
