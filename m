Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbeFANX5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:23:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35796 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752448AbeFANXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:23:09 -0400
X-Google-Smtp-Source: ADUXVKLtuAeEkt4u38krDVwZKQCyt+8B8DzIbCTQzP1VzN4WWtzHTGMg9xAZJAVgFwodcDC84d0ACg==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 15/17] signal: make legacy_queue() return bool
Date: Fri,  1 Jun 2018 15:22:37 +0200
Message-Id: <20180601132239.4421-16-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601132239.4421-1-christian@brauner.io>
References: <20180601132239.4421-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

legacy_queue() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v1->v2:
* unchanged
v0->v1:
* patch added
---
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 8ee3e4a57117..515fa59a0e9c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -976,7 +976,7 @@ static void complete_signal(int sig, struct task_struct *p, int group)
 	return;
 }
 
-static inline int legacy_queue(struct sigpending *signals, int sig)
+static inline bool legacy_queue(struct sigpending *signals, int sig)
 {
 	return (sig < SIGRTMIN) && sigismember(&signals->signal, sig);
 }
-- 
2.17.0
