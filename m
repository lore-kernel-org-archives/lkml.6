Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934847AbeBPLB4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:01:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54401 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeBPLBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:01:54 -0500
Date: Fri, 16 Feb 2018 02:50:27 -0800
From: tip-bot for Matthew Whitehead <tipbot@zytor.com>
Message-ID: <tip-25d76ac888216c369dea91768764728b83769799@git.kernel.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, dvlasenk@redhat.com,
        brgerst@gmail.com, mingo@kernel.org, tglx@linutronix.de,
        tedheadster@gmail.com, torvalds@linux-foundation.org,
        jpoimboe@redhat.com, peterz@infradead.org, bp@alien8.de,
        arjan@linux.intel.com, luto@kernel.org
Reply-To: luto@kernel.org, arjan@linux.intel.com, peterz@infradead.org,
        jpoimboe@redhat.com, bp@alien8.de, torvalds@linux-foundation.org,
        brgerst@gmail.com, mingo@kernel.org, tglx@linutronix.de,
        tedheadster@gmail.com, linux-kernel@vger.kernel.org,
        dvlasenk@redhat.com, hpa@zytor.com
In-Reply-To: <1518713696-11360-3-git-send-email-tedheadster@gmail.com>
References: <1518713696-11360-3-git-send-email-tedheadster@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/Kconfig: Explicitly enumerate i686-class CPUs
 in Kconfig
Git-Commit-ID: 25d76ac888216c369dea91768764728b83769799
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

Commit-ID:  25d76ac888216c369dea91768764728b83769799
Gitweb:     https://git.kernel.org/tip/25d76ac888216c369dea91768764728b83769799
Author:     Matthew Whitehead <tedheadster@gmail.com>
AuthorDate: Thu, 15 Feb 2018 11:54:56 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 16 Feb 2018 10:36:39 +0100

x86/Kconfig: Explicitly enumerate i686-class CPUs in Kconfig

The X86_P6_NOP config class leaves out many i686-class CPUs. Instead,
explicitly enumerate all these CPUs.

Using a configuration with M686 currently sets X86_MINIMUM_CPU_FAMILY=5
instead of the correct value of 6.

Booting on an i586 it will fail to generate the "This kernel
requires an i686 CPU, but only detected an i586 CPU" message and
intentional halt as expected. It will instead just silently hang
when it hits i686-specific instructions.

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
Link: http://lkml.kernel.org/r/1518713696-11360-3-git-send-email-tedheadster@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig.cpu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index ec64aa7..8b8d229 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -385,7 +385,7 @@ config X86_CMOV
 config X86_MINIMUM_CPU_FAMILY
 	int
 	default "64" if X86_64
-	default "6" if X86_32 && X86_P6_NOP
+	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCRUSOE || MCORE2 || MK7 || MK8)
 	default "5" if X86_32 && X86_CMPXCHG64
 	default "4"
 
