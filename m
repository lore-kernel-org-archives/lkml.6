Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeFANZW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:25:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38967 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbeFANW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:22:58 -0400
X-Google-Smtp-Source: ADUXVKLGo7bdB04WECTuVMMsi8KD8R/CMnm3sa1cyoCjgZfJwZkdiZt8Kw0noJmwZ0AjRetJwx9rMA==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 08/17] signal: make sig_task_ignored() return bool
Date: Fri,  1 Jun 2018 15:22:30 +0200
Message-Id: <20180601132239.4421-9-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601132239.4421-1-christian@brauner.io>
References: <20180601132239.4421-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sig_task_ignored() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v1->v2:
* unchanged
v0->v1:
* patch added
---
 kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 62e2586f961e..208e99b57e6f 100644
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
