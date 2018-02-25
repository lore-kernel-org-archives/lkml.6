Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751669AbeBYOGl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 09:06:41 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41003 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBYOGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 09:06:39 -0500
Date: Sun, 25 Feb 2018 06:05:55 -0800
From: tip-bot for Randy Dunlap <tipbot@zytor.com>
Message-ID: <tip-e69c61dd050e410d78363e5fe6e56a9f719abdf5@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <02745e91-c117-74b5-d043-dceb3d4bb4e0@infradead.org>
References: <02745e91-c117-74b5-d043-dceb3d4bb4e0@infradead.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Drop 5 #included header files from irq.h
Git-Commit-ID: e69c61dd050e410d78363e5fe6e56a9f719abdf5
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

Commit-ID:  e69c61dd050e410d78363e5fe6e56a9f719abdf5
Gitweb:     https://git.kernel.org/tip/e69c61dd050e410d78363e5fe6e56a9f719abdf5
Author:     Randy Dunlap <rdunlap@infradead.org>
AuthorDate: Sat, 24 Feb 2018 21:22:18 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 25 Feb 2018 14:57:23 +0100

genirq: Drop 5 #included header files from irq.h

<linux/irq.h> does not use nor need several of its #included files,
so drop those header files from irq.h.

<linux/irq.h> is currently #included in around 1135 C source files
(oops, I didn't count other header files that #include it), making it
the 29th most-used header file.

Build tested on i386 and x86_64 * (allnoconfig, tiny.config, defconfig,
allyesconfig, and allmodconfig) and x64_64 allmodconfig + SMP=disabled.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/02745e91-c117-74b5-d043-dceb3d4bb4e0@infradead.org

---
 include/linux/irq.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index a0231e96a578..979eed1b2654 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -10,18 +10,13 @@
  * Thanks. --rmk
  */
 
-#include <linux/smp.h>
-#include <linux/linkage.h>
 #include <linux/cache.h>
 #include <linux/spinlock.h>
 #include <linux/cpumask.h>
-#include <linux/gfp.h>
 #include <linux/irqhandler.h>
 #include <linux/irqreturn.h>
 #include <linux/irqnr.h>
-#include <linux/errno.h>
 #include <linux/topology.h>
-#include <linux/wait.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 
