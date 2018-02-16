Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934781AbeBPLA3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:00:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47049 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeBPLA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:00:28 -0500
Date: Fri, 16 Feb 2018 02:49:55 -0800
From: tip-bot for Matthew Whitehead <tipbot@zytor.com>
Message-ID: <tip-69b8d3fcabdc81d9efd82b4a506c8279cbaba692@git.kernel.org>
Cc: torvalds@linux-foundation.org, peterz@infradead.org,
        tedheadster@gmail.com, mingo@kernel.org, hpa@zytor.com,
        jpoimboe@redhat.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de,
        dvlasenk@redhat.com, brgerst@gmail.com, linux-kernel@vger.kernel.org,
        arjan@linux.intel.com
Reply-To: hpa@zytor.com, tedheadster@gmail.com, mingo@kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org, brgerst@gmail.com,
        dvlasenk@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        arjan@linux.intel.com, luto@kernel.org, bp@alien8.de,
        jpoimboe@redhat.com
In-Reply-To: <1518713696-11360-2-git-send-email-tedheadster@gmail.com>
References: <1518713696-11360-2-git-send-email-tedheadster@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/Kconfig: Exclude i586-class CPUs lacking PAE
 support from the HIGHMEM64G Kconfig group
Git-Commit-ID: 69b8d3fcabdc81d9efd82b4a506c8279cbaba692
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

Commit-ID:  69b8d3fcabdc81d9efd82b4a506c8279cbaba692
Gitweb:     https://git.kernel.org/tip/69b8d3fcabdc81d9efd82b4a506c8279cbaba692
Author:     Matthew Whitehead <tedheadster@gmail.com>
AuthorDate: Thu, 15 Feb 2018 11:54:55 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 16 Feb 2018 10:36:39 +0100

x86/Kconfig: Exclude i586-class CPUs lacking PAE support from the HIGHMEM64G Kconfig group

i586-class machines also lack support for Physical Address Extension (PAE),
so add them to the exclusion list.

Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1518713696-11360-2-git-send-email-tedheadster@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a528c14..c1236b1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1404,7 +1404,7 @@ config HIGHMEM4G
 
 config HIGHMEM64G
 	bool "64GB"
-	depends on !M486
+	depends on !M486 && !M586 && !M586TSC && !M586MMX && !MGEODE_LX && !MGEODEGX1 && !MCYRIXIII && !MELAN && !MWINCHIPC6 && !WINCHIP3D && !MK6
 	select X86_PAE
 	---help---
 	  Select this if you have a 32-bit processor and more than 4
