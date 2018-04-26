Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbeDZFeg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:34:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47479 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbeDZFed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:34:33 -0400
Date: Wed, 25 Apr 2018 22:34:22 -0700
From: tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-e3072805c61167b85a30ceeef606620704db31f7@git.kernel.org>
Cc: mingo@kernel.org, rientjes@google.com, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        douly.fnst@cn.fujitsu.com
Reply-To: douly.fnst@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org
In-Reply-To: <20180425020553.17210-1-douly.fnst@cn.fujitsu.com>
References: <20180425020553.17210-1-douly.fnst@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/vector: Remove the macro VECTOR_OFFSET_START
Git-Commit-ID: e3072805c61167b85a30ceeef606620704db31f7
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

Commit-ID:  e3072805c61167b85a30ceeef606620704db31f7
Gitweb:     https://git.kernel.org/tip/e3072805c61167b85a30ceeef606620704db31f7
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Wed, 25 Apr 2018 10:05:53 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 26 Apr 2018 07:31:17 +0200

x86/vector: Remove the macro VECTOR_OFFSET_START

Now, Linux uses matrix allocator for vector assignment, the original
assignment code which used VECTOR_OFFSET_START has been removed.

So remove the stale macro as well.

Fixes: commit 69cde0004a4b ("x86/vector: Use matrix allocator for vector assignment")
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David Rientjes <rientjes@google.com>
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180425020553.17210-1-douly.fnst@cn.fujitsu.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/irq_vectors.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 404c5fdff859..57003074bd7a 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -34,11 +34,6 @@
  * (0x80 is the syscall vector, 0x30-0x3f are for ISA)
  */
 #define FIRST_EXTERNAL_VECTOR		0x20
-/*
- * We start allocating at 0x21 to spread out vectors evenly between
- * priority levels. (0x80 is the syscall vector)
- */
-#define VECTOR_OFFSET_START		1
 
 /*
  * Reserve the lowest usable vector (and hence lowest priority)  0x20 for
