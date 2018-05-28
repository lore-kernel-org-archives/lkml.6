Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934634AbeE1V6i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 17:58:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52546 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934548AbeE1V6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:58:25 -0400
X-Google-Smtp-Source: ADUXVKK4z9juApiILpspXqyVcUwxftPb2ymw1+JyHbDbRSwPBsnYm/FhvsfgKzX+kAsKC5PhU94Pww==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 19/20] signal: make security_task_kill() return bool
Date: Mon, 28 May 2018 23:53:54 +0200
Message-Id: <20180528215355.16119-20-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528215355.16119-1-christian@brauner.io>
References: <20180528215355.16119-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

security_task_kill() already behaves like a boolean function. Let's
actually declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
* patch introduced
---
 kernel/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 7e217e83a6de..a4787c90faab 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1928,10 +1928,10 @@ static inline bool may_ptrace_stop(void)
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
