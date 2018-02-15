Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032271AbeBOA15 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:27:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40179 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032127AbeBOA1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:27:55 -0500
Date: Wed, 14 Feb 2018 16:27:34 -0800
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-be3233fbfcb8f5acb6e3bcd0895c3ef9e100d470@git.kernel.org>
Cc: hpa@zytor.com, peterz@infradead.org, torvalds@linux-foundation.org,
        dan.j.williams@intel.com, tglx@linutronix.de, mingo@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, hpa@zytor.com, torvalds@linux-foundation.org,
        mingo@kernel.org, dan.j.williams@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luto@kernel.org
In-Reply-To: <151797010204.1289.1510000292250184993.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151797010204.1289.1510000292250184993.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Fix up array_index_nospec_mask() asm
 constraint
Git-Commit-ID: be3233fbfcb8f5acb6e3bcd0895c3ef9e100d470
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

Commit-ID:  be3233fbfcb8f5acb6e3bcd0895c3ef9e100d470
Gitweb:     https://git.kernel.org/tip/be3233fbfcb8f5acb6e3bcd0895c3ef9e100d470
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Tue, 6 Feb 2018 18:22:40 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 15 Feb 2018 01:15:50 +0100

x86/speculation: Fix up array_index_nospec_mask() asm constraint

Allow the compiler to handle @size as an immediate value or memory
directly rather than allocating a register.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/151797010204.1289.1510000292250184993.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/barrier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 30d4061..e1259f0 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -40,7 +40,7 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 
 	asm ("cmp %1,%2; sbb %0,%0;"
 			:"=r" (mask)
-			:"r"(size),"r" (index)
+			:"g"(size),"r" (index)
 			:"cc");
 	return mask;
 }
