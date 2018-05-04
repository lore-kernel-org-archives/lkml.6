Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbeEDKmf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:42:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39107 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeEDKme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:42:34 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] sched/swait: include wait.h
Date: Fri,  4 May 2018 12:42:24 +0200
Message-Id: <20180504104224.20218-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild bot reported against an intermediate RT patch that the build
fails with:

>    In file included from include/linux/completion.h:12:0,
>                     from include/linux/rcupdate_wait.h:10,
>                     from kernel/rcu/srcutiny.c:27:
>    kernel/rcu/srcutiny.c: In function 'srcu_drive_gp':
> >> include/linux/swait.h:172:7: error: implicit declaration of function '=
___wait_is_interruptible'; did you mean '__swait_event_interruptible'?
>       if (___wait_is_interruptible(state) && __int) {  \

That error vanishes a few patches later (in the RT queue) because wait.h
is then pulled in by other means. It does not seem to surface on !RT.
I think that swait should include a header file for a function/macro
(___wait_is_interruptible()) it is using.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/swait.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
+#include <linux/wait.h>
 #include <asm/current.h>
=20
 /*
