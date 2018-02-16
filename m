Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932405AbeBPJqY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:46:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59463 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932325AbeBPJqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:46:23 -0500
Date: Fri, 16 Feb 2018 01:45:59 -0800
From: tip-bot for Randy Dunlap <tipbot@zytor.com>
Message-ID: <tip-562c45d635ecd5c0648ceb4d4aff9bdc1ad91252@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rdunlap@infradead.org, torvalds@linux-foundation.org
Reply-To: peterz@infradead.org, hpa@zytor.com, mingo@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, tglx@linutronix.de
In-Reply-To: <b24b9ec8-4970-65f5-759a-911d4ba2fcf0@infradead.org>
References: <b24b9ec8-4970-65f5-759a-911d4ba2fcf0@infradead.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/headers] headers: Drop two #included headers from
 <linux/interrupt.h>
Git-Commit-ID: 562c45d635ecd5c0648ceb4d4aff9bdc1ad91252
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

Commit-ID:  562c45d635ecd5c0648ceb4d4aff9bdc1ad91252
Gitweb:     https://git.kernel.org/tip/562c45d635ecd5c0648ceb4d4aff9bdc1ad91252
Author:     Randy Dunlap <rdunlap@infradead.org>
AuthorDate: Thu, 15 Feb 2018 16:49:45 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 16 Feb 2018 08:59:16 +0100

headers: Drop two #included headers from <linux/interrupt.h>

It seems that <linux/interrupt.h> does not need <linux/linkage.h>
nor <linux/preempt.h>.  8 kernels builds are successful without
these 2 headers (allmodconfig, allyesconfig, allnoconfig, and
tinyconfig on both i386 and x86_64).

<linux/interrupt.h> is #included 3875 times in 4.16-rc1, so this
reduces #include processing of these 2 files by a total of 7750 times.

Since I only tested x86 builds, this needs to be tested on other
$ARCHes as well.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Link: http://lkml.kernel.org/r/b24b9ec8-4970-65f5-759a-911d4ba2fcf0@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/interrupt.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 69c2382..5426627 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -4,9 +4,7 @@
 #define _LINUX_INTERRUPT_H
 
 #include <linux/kernel.h>
-#include <linux/linkage.h>
 #include <linux/bitops.h>
-#include <linux/preempt.h>
 #include <linux/cpumask.h>
 #include <linux/irqreturn.h>
 #include <linux/irqnr.h>
