Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeDJQlV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:41:21 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:58850 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeDJQlU (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 10 Apr 2018 12:41:20 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org
Cc: longman@redhat.com, dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/2] locking/rtmutex: Delete save_state member of struct rt_mutex
Date: Tue, 10 Apr 2018 09:27:49 -0700
Message-Id: <20180410162750.8290-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This field (debug) is unused. Furthermore it looks like a result
of rtmutex from -rt into upstream, where it serves to determine
if the wakeup is for a task blocked on a "sleeping spinlock",
iow if this is a regular rt_mutex_lock() or rt_spin_lock().

Of course, upstream we only have regular rt_mutexes, thus we
can safely assume nothing will be done with this field anyway.
There is also the fact that this is under debug.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/rtmutex.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 1b92a28dd672..572606acd700 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -32,7 +32,6 @@ struct rt_mutex {
 	struct rb_root_cached   waiters;
 	struct task_struct	*owner;
 #ifdef CONFIG_DEBUG_RT_MUTEXES
-	int			save_state;
 	const char		*name, *file;
 	int			line;
 	void			*magic;
-- 
2.13.6
