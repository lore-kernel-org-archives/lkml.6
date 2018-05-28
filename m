Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934653AbeE1V7Y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 17:59:24 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33109 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934543AbeE1V6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:58:24 -0400
X-Google-Smtp-Source: ADUXVKJF6ANuh7w+8xds2tkqA+IBrwEyScwIcoi22s7OepYw8y5duHpdMDyaQyIqitOLf611yGXHNw==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 18/20] signal: make legacy_queue() return bool
Date: Mon, 28 May 2018 23:53:53 +0200
Message-Id: <20180528215355.16119-19-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528215355.16119-1-christian@brauner.io>
References: <20180528215355.16119-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

legacy_queue() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
* patch introduced
---
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index ac5c2700901d..7e217e83a6de 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -982,7 +982,7 @@ static void complete_signal(int sig, struct task_struct *p, int group)
 	return;
 }
 
-static inline int legacy_queue(struct sigpending *signals, int sig)
+static inline bool legacy_queue(struct sigpending *signals, int sig)
 {
 	return (sig < SIGRTMIN) && sigismember(&signals->signal, sig);
 }
-- 
2.17.0
