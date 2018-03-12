Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520824786-2-4752562035313775595
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520824785; b=tEFY24vqdZXxBUkdnW5SOwGTA/ETV8T9OUrsayXwPC7Ydur
    UcAWOZqPgt9wNP57UWPhMr4jJOPaNuwckHQsXg4meE+CVDTKSpsYeP3bgLOu1YWo
    J+OUlQY2rBYnBfIPZBpzSam4wLKRy7VrOotvn/gzik6cugP1/BP8cLB3DU2Bc0FF
    n7dnOWTWl80izgync9cgmEii/JwJKUwyTY9q3/Arw40dZ8JHmBdUdzu0aoiMHt/N
    664RSCUedALRVET7G3oFgbi0YvRlHGbQ4LaJuuaTns9g00DCF1mh3bf/YhsgCIHK
    Fn9MV1pgctXeZ2jDoY0lfajHs4V+APt9QCSlwYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824785; bh=MYTTnk+oYQ+/7lhRWth
    IpKueslPKaj67crV3NmfJV1g=; b=niW/Y9LnGH3W73cThqmmhYecAGldan68DCk
    uZcNwePlP2MoZdeVoBorwNZU9F8rIs3meYdLA9p/TewTaHmdQKL/84oGNHrl4yxu
    SAh4ZvPBv75UVLfAcGhYYFK/wIp/3QF97df96M81q/6ix13pwHQIWy1xcws6zHXW
    HKtiTnDNU2sLRnCaq0WwTzYL2m5gtWWxjkPGqqrlGhyZHKdZrtjZhOc+uZ3iJR+5
    bKpA8WIqalKUk3Abbqw1cMNVv5E/xVuJbbZaRMQIhIrNj29GFDLembiN3KfkialE
    uIpNG71v+gAn3s7Ik7KiSuuZkqCO6W9YB48Oo4t+UcTeatgkaDw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932848AbeCLDQS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:16:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41501 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932778AbeCLDHv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:51 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Andy Lutomirski" <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, "Borislav Petkov" <bp@suse.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Denys Vlasenko" <dvlasenk@redhat.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.541220011@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 09/76] x86/cpu: Merge bugs.c and bugs_64.c
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 62a67e123e058a67db58bc6a14354dd037bafd0a upstream.

Should be easier when following boot paths. It probably is a left over
from the x86 unification eons ago.

No functionality change.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20161024173844.23038-3-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16:
 - Add #ifdef around check_fpu(), which is not used on x86_64
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -16,9 +16,7 @@ obj-y			:= intel_cacheinfo.o scattered.o
 obj-y			+= proc.o capflags.o powerflags.o common.o
 obj-y			+= rdrand.o
 obj-y			+= match.o
-
-obj-$(CONFIG_X86_32)	+= bugs.o
-obj-$(CONFIG_X86_64)	+= bugs_64.o
+obj-y			+= bugs.o
 
 obj-$(CONFIG_CPU_SUP_INTEL)		+= intel.o
 obj-$(CONFIG_CPU_SUP_AMD)		+= amd.o
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -16,6 +16,10 @@
 #include <asm/msr.h>
 #include <asm/paravirt.h>
 #include <asm/alternative.h>
+#include <asm/pgtable.h>
+#include <asm/cacheflush.h>
+
+#ifdef CONFIG_X86_32
 
 static double __initdata x = 4195835.0;
 static double __initdata y = 3145727.0;
@@ -63,6 +67,8 @@ static void __init check_fpu(void)
 	}
 }
 
+#endif /* CONFIG_X86_32 */
+
 void __init check_bugs(void)
 {
 #ifdef CONFIG_X86_32
@@ -74,11 +80,13 @@ void __init check_bugs(void)
 #endif
 
 	identify_boot_cpu();
-#ifndef CONFIG_SMP
-	pr_info("CPU: ");
-	print_cpu_info(&boot_cpu_data);
-#endif
 
+	if (!IS_ENABLED(CONFIG_SMP)) {
+		pr_info("CPU: ");
+		print_cpu_info(&boot_cpu_data);
+	}
+
+#ifdef CONFIG_X86_32
 	/*
 	 * Check whether we are able to run this kernel safely on SMP.
 	 *
@@ -99,4 +107,18 @@ void __init check_bugs(void)
 	 */
 	if (cpu_has_fpu)
 		check_fpu();
+#else /* CONFIG_X86_64 */
+	alternative_instructions();
+
+	/*
+	 * Make sure the first 2MB area is not mapped by huge pages
+	 * There are typically fixed size MTRRs in there and overlapping
+	 * MTRRs into large pages causes slow downs.
+	 *
+	 * Right now we don't do that with gbpages because there seems
+	 * very little benefit for that case.
+	 */
+	if (!direct_gbpages)
+		set_memory_4k((unsigned long)__va(0), 1);
+#endif
 }
--- a/arch/x86/kernel/cpu/bugs_64.c
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *  Copyright (C) 1994  Linus Torvalds
- *  Copyright (C) 2000  SuSE
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <asm/alternative.h>
-#include <asm/bugs.h>
-#include <asm/processor.h>
-#include <asm/mtrr.h>
-#include <asm/cacheflush.h>
-
-void __init check_bugs(void)
-{
-	identify_boot_cpu();
-#if !defined(CONFIG_SMP)
-	printk(KERN_INFO "CPU: ");
-	print_cpu_info(&boot_cpu_data);
-#endif
-	alternative_instructions();
-
-	/*
-	 * Make sure the first 2MB area is not mapped by huge pages
-	 * There are typically fixed size MTRRs in there and overlapping
-	 * MTRRs into large pages causes slow downs.
-	 *
-	 * Right now we don't do that with gbpages because there seems
-	 * very little benefit for that case.
-	 */
-	if (!direct_gbpages)
-		set_memory_4k((unsigned long)__va(0), 1);
-}
