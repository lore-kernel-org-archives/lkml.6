Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbeBYOHK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 09:07:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57997 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbeBYOHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 09:07:08 -0500
Date: Sun, 25 Feb 2018 06:06:50 -0800
From: tip-bot for Randy Dunlap <tipbot@zytor.com>
Message-ID: <tip-6ce5ae7977c89f2a09092954396a66c90e8213f2@git.kernel.org>
Cc: rdunlap@infradead.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: rdunlap@infradead.org, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <582b3892-4e4c-06b2-a368-5c2d439de7fc@infradead.org>
References: <582b3892-4e4c-06b2-a368-5c2d439de7fc@infradead.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] mutex: Drop linkage.h from mutex.h
Git-Commit-ID: 6ce5ae7977c89f2a09092954396a66c90e8213f2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6ce5ae7977c89f2a09092954396a66c90e8213f2
Gitweb:     https://git.kernel.org/tip/6ce5ae7977c89f2a09092954396a66c90e8213f2
Author:     Randy Dunlap <rdunlap@infradead.org>
AuthorDate: Sat, 24 Feb 2018 21:22:12 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 25 Feb 2018 15:00:46 +0100

mutex: Drop linkage.h from mutex.h

<linux/mutex.h> does not use nor need <linux/linkage.h>, so drop that
one header file from mutex.h.

<linux/mutex.h> is currently #included in around 1250 C source files
(oops, I didn't count other header files that #include it), making it
the 27th most-used header file.

Build tested on i386 and x86_64 * (allnoconfig, tiny.config, defconfig,
allyesconfig, and allmodconfig) and x64_64 allmodconfig + SMP=disabled.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/582b3892-4e4c-06b2-a368-5c2d439de7fc@infradead.org

---
 include/linux/mutex.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index f25c13423bd4..9b7fe56692bd 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -14,7 +14,6 @@
 #include <asm/current.h>
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
-#include <linux/linkage.h>
 #include <linux/lockdep.h>
 #include <linux/atomic.h>
 #include <asm/processor.h>
