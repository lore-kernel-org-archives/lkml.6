Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932469AbeBLBqb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 20:46:31 -0500
Received: from [198.137.202.136] ([198.137.202.136]:49711 "EHLO mail.zytor.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S932363AbeBLBqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 20:46:30 -0500
Date: Sun, 11 Feb 2018 04:18:46 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-7cc4eb1bdd8b082f3d889daccd9412aa10e56165@git.kernel.org>
Cc: luto@amacapital.net, kirill.shutemov@linux.intel.com,
        peterz@infradead.org, gorcunov@openvz.org, bp@suse.de,
        willy@infradead.org, tglx@linutronix.de, torvalds@linux-foundation.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: gorcunov@openvz.org, kirill.shutemov@linux.intel.com,
        peterz@infradead.org, luto@amacapital.net,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, willy@infradead.org,
        bp@suse.de
In-Reply-To: <20180209142228.21231-2-kirill.shutemov@linux.intel.com>
References: <20180209142228.21231-2-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot/compressed/64: Rename pagetable.c to
 kaslr_64.c
Git-Commit-ID: 7cc4eb1bdd8b082f3d889daccd9412aa10e56165
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

Commit-ID:  7cc4eb1bdd8b082f3d889daccd9412aa10e56165
Gitweb:     https://git.kernel.org/tip/7cc4eb1bdd8b082f3d889daccd9412aa10e56165
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Fri, 9 Feb 2018 17:22:25 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 11 Feb 2018 12:36:18 +0100

x86/boot/compressed/64: Rename pagetable.c to kaslr_64.c

The name of the file -- pagetable.c -- is misleading: it only contains
helpers used for KASLR in 64-bit mode.

Let's rename the file to reflect its content.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@suse.de>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180209142228.21231-2-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/Makefile                    | 2 +-
 arch/x86/boot/compressed/{pagetable.c => kaslr_64.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f25e153..1f734cd 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -78,7 +78,7 @@ vmlinux-objs-y := $(obj)/vmlinux.lds $(obj)/head_$(BITS).o $(obj)/misc.o \
 vmlinux-objs-$(CONFIG_EARLY_PRINTK) += $(obj)/early_serial_console.o
 vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr.o
 ifdef CONFIG_X86_64
-	vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/pagetable.o
+	vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr_64.o
 	vmlinux-objs-y += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
 endif
diff --git a/arch/x86/boot/compressed/pagetable.c b/arch/x86/boot/compressed/kaslr_64.c
similarity index 100%
rename from arch/x86/boot/compressed/pagetable.c
rename to arch/x86/boot/compressed/kaslr_64.c
