Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeBIOWl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:22:41 -0500
Received: from mga07.intel.com ([134.134.136.100]:34688 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752563AbeBIOWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:22:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,483,1511856000";
   d="scan'208";a="28740916"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv9 1/4] x86/boot/compressed/64: Rename pagetable.c to kaslr_64.c
Date: Fri,  9 Feb 2018 17:22:25 +0300
Message-Id: <20180209142228.21231-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180209142228.21231-1-kirill.shutemov@linux.intel.com>
References: <20180209142228.21231-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the file -- pagetable.c -- is misleading: it only contains
helpers used for KASLR in 64-bit mode.

Let's rename the file to reflect its content.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/Makefile                    | 2 +-
 arch/x86/boot/compressed/{pagetable.c => kaslr_64.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/x86/boot/compressed/{pagetable.c => kaslr_64.c} (100%)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f25e1530e064..1f734cd98fd3 100644
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
-- 
2.15.1
