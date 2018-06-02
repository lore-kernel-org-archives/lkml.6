Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751721AbeFBKju (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:39:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38679 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeFBKh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:37:28 -0400
X-Google-Smtp-Source: ADUXVKI37hSr7z0+1rESk8BwTYoM6oCNo+dPnzCty5VAe9KQYyLWuanakCqe/a+TBiqb7JKPhme42g==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 15/17] signal: make legacy_queue() return bool
Date: Sat,  2 Jun 2018 12:36:51 +0200
Message-Id: <20180602103653.18181-16-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180602103653.18181-1-christian@brauner.io>
References: <20180602103653.18181-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

legacy_queue() already behaves like a boolean function. Let's actually
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
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 3a12d3b25584..50255b6a3124 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -972,7 +972,7 @@ static void complete_signal(int sig, struct task_struct *p, int group)
 	return;
 }
 
-static inline int legacy_queue(struct sigpending *signals, int sig)
+static inline bool legacy_queue(struct sigpending *signals, int sig)
 {
 	return (sig < SIGRTMIN) && sigismember(&signals->signal, sig);
 }
-- 
2.17.0
