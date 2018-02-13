Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964827AbeBMNHO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:07:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49069 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964797AbeBMNHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:07:13 -0500
Date: Tue, 13 Feb 2018 05:06:49 -0800
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-87360f969eb214fb22b7e03acb2475a809e040c5@git.kernel.org>
Cc: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        torvalds@linux-foundation.org, luto@kernel.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, luto@kernel.org,
        dan.j.williams@intel.com
In-Reply-To: <151797010204.1289.1510000292250184993.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151797010204.1289.1510000292250184993.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Fix up array_index_nospec_mask() asm
 constraint
Git-Commit-ID: 87360f969eb214fb22b7e03acb2475a809e040c5
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

Commit-ID:  87360f969eb214fb22b7e03acb2475a809e040c5
Gitweb:     https://git.kernel.org/tip/87360f969eb214fb22b7e03acb2475a809e040c5
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Tue, 6 Feb 2018 18:22:40 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 14:01:25 +0100

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
