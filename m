Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0852EC28CF6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 03:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4949217CE
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 03:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBSMij5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4949217CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeHEFZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 01:25:31 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41429 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeHEFZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 01:25:30 -0400
Received: by mail-pl0-f68.google.com with SMTP id w19-v6so2543889ply.8;
        Sat, 04 Aug 2018 20:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SK56+5RdIQbYqRji3I7EZg8OZqP3Orae5FOZ2UzhpBc=;
        b=bBSMij5ap8N4lndRwMpETAqvpi2wgXDCoZ1ArFuMfUPfrN9oLOjS7SVz2CLvN0XaP2
         Q7gsccvU0lDmfP/caf8jDsm3p1aLNExLgfXQz9ntqLjYQRwpDWFeS5wNZC1xwbb5ZXso
         tpfKqfto9gQJOdx85u5sbcCMjtNPGQrXmob/3BGGRUQVznBdNoYsv2EAVjN8UwC+mplE
         exFLBi1TNHUdPbbZ4uYaYtRD6j8AqDTl+QpyAh1oFwHCFKM853exbx8AJW5lizy7XEzi
         FCsLnLWVLT3/ZF4dHYgxSRQrz0grDE4fEEUGTp4si5S6vHnrgY0sLYvJwh9PHp05jH+0
         RZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SK56+5RdIQbYqRji3I7EZg8OZqP3Orae5FOZ2UzhpBc=;
        b=RzfqQhJMcPEAU0366R/UhIUlwuL93GVNZnoNACpPIkjQxTVDpN05qDbzgEr6/G6DHC
         P2OD7FiHQON0hrG4LApicVX9LxHT/UCRmA8BaQXExlWoydht2XSx4f09SQ6n9rr+Vi7l
         iUcJiziyFUdKbS8hFBJ1ogZdPR5733/+vREtXij3zW1hw6ctp/hr/76l2UGeWQJ/Agts
         lDguno2quNlmJKJRTkRcOP3Vt49aZrqJ7ejD1UCyCy9Ke/X/JGUc1wHAk9WRbg9KKH0U
         eCWjEjd76miZqGEQew21cdgFrLV6AlgF7dmX6H9IIQaBOCSCidSxB/TnEzfBJtaP6GX7
         nasQ==
X-Gm-Message-State: AOUpUlGjARZ2MveBIGYL/47YZV1mG1A0G7Oap8QoCHnsVzki9izPim3i
        FHVzqsfbcX/c9fsZ3WfLpRwAYeze
X-Google-Smtp-Source: AAOMgpekiA2GseAGkUnhvdUS/cnDntTmwBrVTnCbyoVNtK34o8sMTHjdDBR/9olw4rFjNOrd5ifqAA==
X-Received: by 2002:a17:902:e088:: with SMTP id cb8-v6mr9154895plb.189.1533439350683;
        Sat, 04 Aug 2018 20:22:30 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id x87-v6sm15971922pfa.143.2018.08.04.20.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 Aug 2018 20:22:30 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 1/6] x86/KASLR: make getting random long number function public
Date:   Sun,  5 Aug 2018 11:21:14 +0800
Message-Id: <20180805032119.20485-2-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180805032119.20485-1-jlee@suse.com>
References: <20180805032119.20485-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separating the functions for getting random long number from KASLR
to x86 library, then it can be used to generate random long for
EFI root key.

Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Ryan Chen <yu.chen.surf@gmail.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 arch/x86/boot/compressed/kaslr.c | 21 -------------
 arch/x86/boot/compressed/misc.c  | 17 ++++++++++
 arch/x86/boot/compressed/misc.h  |  6 ++++
 arch/x86/lib/kaslr.c             | 61 ++---------------------------------
 arch/x86/lib/random.c            | 68 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 93 insertions(+), 80 deletions(-)
 create mode 100644 arch/x86/lib/random.c

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b87a7582853d..0f40d2178ebc 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -33,13 +33,11 @@
 #include "error.h"
 #include "../string.h"
 
-#include <generated/compile.h>
 #include <linux/module.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <linux/ctype.h>
 #include <linux/efi.h>
-#include <generated/utsrelease.h>
 #include <asm/efi.h>
 
 /* Macros used by the included decompressor code below. */
@@ -57,25 +55,6 @@ extern unsigned long get_cmd_line_ptr(void);
 /* Used by PAGE_KERN* macros: */
 pteval_t __default_kernel_pte_mask __read_mostly = ~0;
 
-/* Simplified build-specific string for starting entropy. */
-static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
-		LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
-
-static unsigned long rotate_xor(unsigned long hash, const void *area,
-				size_t size)
-{
-	size_t i;
-	unsigned long *ptr = (unsigned long *)area;
-
-	for (i = 0; i < size / sizeof(hash); i++) {
-		/* Rotate by odd number of bits and XOR. */
-		hash = (hash << ((sizeof(hash) * 8) - 7)) | (hash >> 7);
-		hash ^= ptr[i];
-	}
-
-	return hash;
-}
-
 /* Attempt to create a simple but unpredictable starting entropy. */
 static unsigned long get_boot_seed(void)
 {
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 8dd1d5ccae58..eb0ab9cad4e4 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -426,3 +426,20 @@ void fortify_panic(const char *name)
 {
 	error("detected buffer overflow");
 }
+
+#if CONFIG_RANDOMIZE_BASE
+unsigned long rotate_xor(unsigned long hash, const void *area,
+			size_t size)
+{
+	size_t i;
+	unsigned long *ptr = (unsigned long *)area;
+
+	for (i = 0; i < size / sizeof(hash); i++) {
+		/* Rotate by odd number of bits and XOR. */
+		hash = (hash << ((sizeof(hash) * 8) - 7)) | (hash >> 7);
+		hash ^= ptr[i];
+	}
+
+	return hash;
+}
+#endif
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index a423bdb42686..957f327ad83c 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -70,6 +70,8 @@ int cmdline_find_option_bool(const char *option);
 
 
 #if CONFIG_RANDOMIZE_BASE
+#include <generated/compile.h>
+#include <generated/utsrelease.h>
 /* kaslr.c */
 void choose_random_location(unsigned long input,
 			    unsigned long input_size,
@@ -78,6 +80,10 @@ void choose_random_location(unsigned long input,
 			    unsigned long *virt_addr);
 /* cpuflags.c */
 bool has_cpuflag(int flag);
+/* Simplified build-specific string for starting entropy. */
+static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
+		LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
+unsigned long rotate_xor(unsigned long hash, const void *area, size_t size);
 #else
 static inline void choose_random_location(unsigned long input,
 					  unsigned long input_size,
diff --git a/arch/x86/lib/kaslr.c b/arch/x86/lib/kaslr.c
index 79778ab200e4..29ed9bfde5a5 100644
--- a/arch/x86/lib/kaslr.c
+++ b/arch/x86/lib/kaslr.c
@@ -26,67 +26,10 @@
 #define get_boot_seed() kaslr_offset()
 #endif
 
-#define I8254_PORT_CONTROL	0x43
-#define I8254_PORT_COUNTER0	0x40
-#define I8254_CMD_READBACK	0xC0
-#define I8254_SELECT_COUNTER0	0x02
-#define I8254_STATUS_NOTREADY	0x40
-static inline u16 i8254(void)
-{
-	u16 status, timer;
-
-	do {
-		outb(I8254_PORT_CONTROL,
-		     I8254_CMD_READBACK | I8254_SELECT_COUNTER0);
-		status = inb(I8254_PORT_COUNTER0);
-		timer  = inb(I8254_PORT_COUNTER0);
-		timer |= inb(I8254_PORT_COUNTER0) << 8;
-	} while (status & I8254_STATUS_NOTREADY);
-
-	return timer;
-}
+#include "random.c"
 
 unsigned long kaslr_get_random_long(const char *purpose)
 {
-#ifdef CONFIG_X86_64
-	const unsigned long mix_const = 0x5d6008cbf3848dd3UL;
-#else
-	const unsigned long mix_const = 0x3f39e593UL;
-#endif
-	unsigned long raw, random = get_boot_seed();
-	bool use_i8254 = true;
-
-	debug_putstr(purpose);
 	debug_putstr(" KASLR using");
-
-	if (has_cpuflag(X86_FEATURE_RDRAND)) {
-		debug_putstr(" RDRAND");
-		if (rdrand_long(&raw)) {
-			random ^= raw;
-			use_i8254 = false;
-		}
-	}
-
-	if (has_cpuflag(X86_FEATURE_TSC)) {
-		debug_putstr(" RDTSC");
-		raw = rdtsc();
-
-		random ^= raw;
-		use_i8254 = false;
-	}
-
-	if (use_i8254) {
-		debug_putstr(" i8254");
-		random ^= i8254();
-	}
-
-	/* Circular multiply for better bit diffusion */
-	asm(_ASM_MUL "%3"
-	    : "=a" (random), "=d" (raw)
-	    : "a" (random), "rm" (mix_const));
-	random += raw;
-
-	debug_putstr("...\n");
-
-	return random;
+	return get_random_long(purpose);
 }
diff --git a/arch/x86/lib/random.c b/arch/x86/lib/random.c
new file mode 100644
index 000000000000..f2fe6a784c98
--- /dev/null
+++ b/arch/x86/lib/random.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/io.h>
+#include <asm/archrandom.h>
+
+#define I8254_PORT_CONTROL	0x43
+#define I8254_PORT_COUNTER0	0x40
+#define I8254_CMD_READBACK	0xC0
+#define I8254_SELECT_COUNTER0	0x02
+#define I8254_STATUS_NOTREADY	0x40
+static inline u16 i8254(void)
+{
+	u16 status, timer;
+
+	do {
+		outb(I8254_PORT_CONTROL,
+		     I8254_CMD_READBACK | I8254_SELECT_COUNTER0);
+		status = inb(I8254_PORT_COUNTER0);
+		timer  = inb(I8254_PORT_COUNTER0);
+		timer |= inb(I8254_PORT_COUNTER0) << 8;
+	} while (status & I8254_STATUS_NOTREADY);
+
+	return timer;
+}
+
+static unsigned long get_random_long(const char *purpose)
+{
+#ifdef CONFIG_X86_64
+	const unsigned long mix_const = 0x5d6008cbf3848dd3UL;
+#else
+	const unsigned long mix_const = 0x3f39e593UL;
+#endif
+	unsigned long raw, random = get_boot_seed();
+	bool use_i8254 = true;
+
+	debug_putstr(purpose);
+
+	if (has_cpuflag(X86_FEATURE_RDRAND)) {
+		debug_putstr(" RDRAND");
+		if (rdrand_long(&raw)) {
+			random ^= raw;
+			use_i8254 = false;
+		}
+	}
+
+	if (has_cpuflag(X86_FEATURE_TSC)) {
+		debug_putstr(" RDTSC");
+		raw = rdtsc();
+
+		random ^= raw;
+		use_i8254 = false;
+	}
+
+	if (use_i8254) {
+		debug_putstr(" i8254");
+		random ^= i8254();
+	}
+
+	/* Circular multiply for better bit diffusion */
+	asm(_ASM_MUL "%3"
+	    : "=a" (random), "=d" (raw)
+	    : "a" (random), "rm" (mix_const));
+	random += raw;
+
+	debug_putstr("...\n");
+
+	return random;
+}
-- 
2.13.6

