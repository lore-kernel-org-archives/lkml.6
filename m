Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeFBKhy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:37:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54877 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbeFBKhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:37:20 -0400
X-Google-Smtp-Source: ADUXVKIhUTgHjxSoo9fj10NVDmpVfU36w4n8ebT9Be3HL8NbJ+2O5STdAgL3+qgy39RN163WvjzKyg==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 10/17] signal: make has_pending_signals() return bool
Date: Sat,  2 Jun 2018 12:36:46 +0200
Message-Id: <20180602103653.18181-11-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180602103653.18181-1-christian@brauner.io>
References: <20180602103653.18181-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

has_pending_signals() already behaves like a boolean function. Let's
actually declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v2->v3:
* [Oleg Nestorov] remove other non-functional changes
v1->v2:
* unchanged
v0->v1:
* patch added
---
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index fed938c2e273..c2af9a7f73b3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -110,7 +110,7 @@ static bool sig_ignored(struct task_struct *t, int sig, bool force)
  * Re-calculate pending state from the set of locally pending
  * signals, globally pending signals, and blocked signals.
  */
-static inline int has_pending_signals(sigset_t *signal, sigset_t *blocked)
+static inline bool has_pending_signals(sigset_t *signal, sigset_t *blocked)
 {
 	unsigned long ready;
 	long i;
-- 
2.17.0
