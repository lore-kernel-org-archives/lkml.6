Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeFANZY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:25:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36950 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeFANW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:22:56 -0400
X-Google-Smtp-Source: ADUXVKLcbcbc06VTq54qqKWAGOgB2F9+hLeQab9thZPT7y4GcMj82RrgAV6eJu7pKF6erRtluC9leQ==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 07/17] signal: make sig_handler_ignored() return bool
Date: Fri,  1 Jun 2018 15:22:29 +0200
Message-Id: <20180601132239.4421-8-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601132239.4421-1-christian@brauner.io>
References: <20180601132239.4421-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sig_handler_ignored() already behaves like a boolean function. Let's
actually declare it as such too.

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
index bbd15e984a84..62e2586f961e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -65,11 +65,11 @@ static void __user *sig_handler(struct task_struct *t, int sig)
 	return t->sighand->action[sig - 1].sa.sa_handler;
 }
 
-static int sig_handler_ignored(void __user *handler, int sig)
+static inline bool sig_handler_ignored(void __user *handler, int sig)
 {
 	/* Is it explicitly or implicitly ignored? */
 	return handler == SIG_IGN ||
-		(handler == SIG_DFL && sig_kernel_ignore(sig));
+	       (handler == SIG_DFL && sig_kernel_ignore(sig));
 }
 
 static int sig_task_ignored(struct task_struct *t, int sig, bool force)
-- 
2.17.0
