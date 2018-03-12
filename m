Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520826398-2-856266848773258212
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
    t=1520826397; b=hrFvfl6XE1NnAKKimR4aUPjMh+dmPtr5Z8THiSD4j+YAx+3
    SMSvBBgcLiry+eeDr7jnA0fAukfj595VucHu8kchtqfKHl/OMA3S1I1SfYW3xNpU
    +tCo+FTOrx3givOn06PpZg7FJXChBLLXP5AvPk2TptPvpT8RlTAQ+VD5A0ENDtdP
    40BfFF7uy6aAQRIrGdk+Iz8WbAZLS1ndRnnvEF7iGk8YucEtyiAWFH8I/S/StvYz
    b0o9iIIB6cZZhL6afGilTqz6bk6CDjmVnslcae7dtDyi0YW5IxPHI84IG2fZ/MYb
    67fAuwPc1lPWtJcfl0hYiLyAMsds89l04HMD8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826397; bh=HK8gxFOCWgu4AWYQynn
    /MfouzbpaRD2L5fXDFaY2NZY=; b=onnh7K3RgD/Ir7W6xTR+UlKMxOAUZ4niq5c
    Ha4sroTHzqT+sp8nYyai1r2TorBa2hnsciLylGxYiSi+tVakA0fO9F5jytSeFBPQ
    fThRS5t1ux4eoynr5PHOPich/HeAnJVERiu9lgrObYfulbiNMSYrQhbbD9/PMiv7
    UDFLvKbUGm62GhioN3++fGymr4x2Nhl4gs3LZXPl8bHVFuOxl74r+cyDedGjp+2i
    qGEXem/a0JmInc4jp2MauqIM2Xa4+zYw74+R09CmXr6Z0JyBgkKbHsLKXzJJfQZn
    vr/7IxGtAsE7rLPK/RijFG27MOP5L+D6gIFuYxkV3DCCsmL3/Vw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S932709AbeCLDoe (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:44:34 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41146 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932649AbeCLDHm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:42 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Borislav Petkov" <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Ingo Molnar" <mingo@kernel.org>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.536601340@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 045/104] x86/cpu: Merge bugs.c and bugs_64.c
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2:
 - Add #ifdef around functions that are not used on x86_64
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -16,9 +16,7 @@ obj-y			:= intel_cacheinfo.o scattered.o
 obj-y			+= proc.o capflags.o powerflags.o common.o
 obj-y			+= vmware.o hypervisor.o sched.o mshyperv.o
 obj-y			+= rdrand.o
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
 
 static int __init no_halt(char *s)
 {
@@ -156,6 +160,7 @@ static void __init check_config(void)
 #endif
 }
 
+#endif /* CONFIG_X86_32 */
 
 void __init check_bugs(void)
 {
@@ -168,10 +173,13 @@ void __init check_bugs(void)
 #endif
 
 	identify_boot_cpu();
-#ifndef CONFIG_SMP
-	printk(KERN_INFO "CPU: ");
-	print_cpu_info(&boot_cpu_data);
-#endif
+
+	if (!IS_ENABLED(CONFIG_SMP)) {
+		pr_info("CPU: ");
+		print_cpu_info(&boot_cpu_data);
+	}
+
+#ifdef CONFIG_X86_32
 	check_config();
 	check_fpu();
 	check_hlt();
@@ -179,4 +187,18 @@ void __init check_bugs(void)
 	init_utsname()->machine[1] =
 		'0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
 	alternative_instructions();
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
