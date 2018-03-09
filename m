Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbeCIJQx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:16:53 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37155 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbeCIJQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:16:51 -0500
Date: Fri, 9 Mar 2018 01:16:28 -0800
From: tip-bot for Colin Ian King <tipbot@zytor.com>
Message-ID: <tip-f779ca740f25c8a6a72d951334f9efc3158a318b@git.kernel.org>
Cc: torvalds@linux-foundation.org, ard.biesheuvel@linaro.org,
        colin.king@canonical.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, peterz@infradead.org, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
        ard.biesheuvel@linaro.org, torvalds@linux-foundation.org,
        colin.king@canonical.com
In-Reply-To: <20180308080020.22828-13-ard.biesheuvel@linaro.org>
References: <20180308080020.22828-13-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: Make const array 'apple' static
Git-Commit-ID: f779ca740f25c8a6a72d951334f9efc3158a318b
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

Commit-ID:  f779ca740f25c8a6a72d951334f9efc3158a318b
Gitweb:     https://git.kernel.org/tip/f779ca740f25c8a6a72d951334f9efc3158a318b
Author:     Colin Ian King <colin.king@canonical.com>
AuthorDate: Thu, 8 Mar 2018 08:00:20 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 09:30:35 +0100

efi: Make const array 'apple' static

Don't populate the const read-only array 'buf' on the stack but instead
make it static. Makes the object code smaller by 64 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
   9264	      1	     16	   9281	   2441	arch/x86/boot/compressed/eboot.o

After:
   text	   data	    bss	    dec	    hex	filename
   9200	      1	     16	   9217	   2401	arch/x86/boot/compressed/eboot.o

(GCC version 7.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180308080020.22828-13-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/eboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 886a9115af62..f2251c1c9853 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -423,7 +423,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 
 static void setup_quirks(struct boot_params *boot_params)
 {
-	efi_char16_t const apple[] = { 'A', 'p', 'p', 'l', 'e', 0 };
+	static efi_char16_t const apple[] = { 'A', 'p', 'p', 'l', 'e', 0 };
 	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
 		efi_table_attr(efi_system_table, fw_vendor, sys_table);
 
