Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934554AbeE1V6Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 17:58:25 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37588 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934495AbeE1V6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:58:16 -0400
X-Google-Smtp-Source: ADUXVKI6o60vvauepdLoamUxOgwllGjNPUrViR84qSb3QkSInE6Qe5X9DnHsns9zoEzR/oagXCPATw==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 11/20] signal: make sig_task_ignored() return bool
Date: Mon, 28 May 2018 23:53:46 +0200
Message-Id: <20180528215355.16119-12-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528215355.16119-1-christian@brauner.io>
References: <20180528215355.16119-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sig_task_ignored() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
* patch introduced
---
 kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 78a9b32785df..c3981081ec25 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -72,7 +72,7 @@ static inline bool sig_handler_ignored(void __user *handler, int sig)
 	       (handler == SIG_DFL && sig_kernel_ignore(sig));
 }
 
-static int sig_task_ignored(struct task_struct *t, int sig, bool force)
+static bool sig_task_ignored(struct task_struct *t, int sig, bool force)
 {
 	void __user *handler;
 
@@ -80,7 +80,7 @@ static int sig_task_ignored(struct task_struct *t, int sig, bool force)
 
 	if (unlikely(t->signal->flags & SIGNAL_UNKILLABLE) &&
 	    handler == SIG_DFL && !(force && sig_kernel_only(sig)))
-		return 1;
+		return true;
 
 	return sig_handler_ignored(handler, sig);
 }
-- 
2.17.0
