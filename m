Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeFBKhm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:37:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55339 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeFBKhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:37:17 -0400
X-Google-Smtp-Source: ADUXVKLdosXxxCwdtq/cp0Rh++FcO65q1etGG74FdTzwWF6Yer9IViihg/rvdvs5wsr+xXUD8WxsZg==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 08/17] signal: make sig_task_ignored() return bool
Date: Sat,  2 Jun 2018 12:36:44 +0200
Message-Id: <20180602103653.18181-9-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180602103653.18181-1-christian@brauner.io>
References: <20180602103653.18181-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sig_task_ignored() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v2->v3:
* unchanged
v1->v2:
* unchanged
v0->v1:
* patch added
---
 kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 13061f388042..ff2ea82e376b 100644
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
