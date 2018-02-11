Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518325057-2-12270360004481261767
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES rosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325056; b=XlIYR1XmGFnZxEWJtDV4XbyyDr73qEEhncsB8iYZ7R94LV5
    kcPLm7FX4OR7mhlUc6RZ3baM+AT+96PXf9iiHcKpZaWJcsjVi1JQeKgO/hHJesFm
    Pp10iFq6PsmJIJu985kqYQkTkziuKSs51MJaNX7k8fHLd3uMMUfObS2jVnx1YNKn
    noPyxvFD9LxJBEOI0KScXW+3uRfHVkUU/0hcTF2jiNm53XYDTAdqmEbGpY+jWmCy
    uHE1ovHiLpcw7FBiQmv+VS6QfgkYyysIIEuPIRmH3646QjakGh/UCNeMN6qPhfdG
    AaRRBKiUPQ9rsSvx6mzfDvNdDNQ29YLdPcVKCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325056; bh=q2eEf2g6jXwyy+Ohpnz
    QLW/j/X5hRo4W/axSvvXZ+hg=; b=Cp1FuusB3wj32nGg6BoqZ4GUDwmboRVpHA8
    PBCFN7zg3SsUGFwCzZtBkC8YC9QxAQlLmpoCInr1HL4MQAwJcinUbAnyn6F4J59J
    n9zi4kIl4sltxIiOjH1paaNpKIozPHQ9UeNGEJ8TK3WIBQ5UrspKlKT6wmIMtaWg
    9YwjBUXj6SZ2UY/nCYiYHix6PrNgnX7EgSKjB3YsnLCBS3xO5kMzNWAofujZHmQE
    GaEyVy6CTnHHlJSDavzDMiFCmHS/P0we6M/iav8DrMPfZ2ZcCmqdkCCyAU9HwUsG
    MQ/YwFhKbfgbHYX5YLRJkVgTszrHkGY/SETKfSrKDd3K4TQrG9g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753631AbeBKEz7 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:55:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41698 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752793AbeBKEd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Andy Lutomirski" <luto@amacapital.net>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ingo Molnar" <mingo@kernel.org>, linux-mm@kvack.org
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.680710138@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 134/136] x86/vdso: Remove pvclock fixmap machinery
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit cc1e24fdb064d3126a494716f22ad4fc39306742 upstream.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/4933029991103ae44672c82b97a20035f5c1fe4f.1449702533.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16: adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/fixmap.h  |  5 -----
 arch/x86/include/asm/pvclock.h |  5 -----
 arch/x86/kernel/kvmclock.c     |  6 ------
 arch/x86/kernel/pvclock.c      | 24 ------------------------
 arch/x86/vdso/vclock_gettime.c |  1 -
 arch/x86/vdso/vma.c            |  1 +
 6 files changed, 1 insertion(+), 41 deletions(-)

--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -19,7 +19,6 @@
 #include <asm/acpi.h>
 #include <asm/apicdef.h>
 #include <asm/page.h>
-#include <asm/pvclock.h>
 #ifdef CONFIG_X86_32
 #include <linux/threads.h>
 #include <asm/kmap_types.h>
@@ -70,10 +69,6 @@ enum fixed_addresses {
 	FIX_HOLE,
 #else
 	VSYSCALL_PAGE = (FIXADDR_TOP - VSYSCALL_ADDR) >> PAGE_SHIFT,
-#ifdef CONFIG_PARAVIRT_CLOCK
-	PVCLOCK_FIXMAP_BEGIN,
-	PVCLOCK_FIXMAP_END = PVCLOCK_FIXMAP_BEGIN+PVCLOCK_VSYSCALL_NR_PAGES-1,
-#endif
 #endif
 	FIX_DBGP_BASE,
 	FIX_EARLYCON_MEM_BASE,
--- a/arch/x86/include/asm/pvclock.h
+++ b/arch/x86/include/asm/pvclock.h
@@ -107,10 +107,5 @@ struct pvclock_vsyscall_time_info {
 } __attribute__((__aligned__(SMP_CACHE_BYTES)));
 
 #define PVTI_SIZE sizeof(struct pvclock_vsyscall_time_info)
-#define PVCLOCK_VSYSCALL_NR_PAGES (((NR_CPUS-1)/(PAGE_SIZE/PVTI_SIZE))+1)
-
-int __init pvclock_init_vsyscall(struct pvclock_vsyscall_time_info *i,
-				 int size);
-struct pvclock_vcpu_time_info *pvclock_get_vsyscall_time_info(int cpu);
 
 #endif /* _ASM_X86_PVCLOCK_H */
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -278,7 +278,6 @@ int __init kvm_setup_vsyscall_timeinfo(v
 {
 #ifdef CONFIG_X86_64
 	int cpu;
-	int ret;
 	u8 flags;
 	struct pvclock_vcpu_time_info *vcpu_time;
 	unsigned int size;
@@ -299,11 +298,6 @@ int __init kvm_setup_vsyscall_timeinfo(v
 		return 1;
 	}
 
-	if ((ret = pvclock_init_vsyscall(hv_clock, size))) {
-		preempt_enable();
-		return ret;
-	}
-
 	preempt_enable();
 
 	kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -140,27 +140,3 @@ void pvclock_read_wallclock(struct pvclo
 
 	set_normalized_timespec(ts, now.tv_sec, now.tv_nsec);
 }
-
-#ifdef CONFIG_X86_64
-/*
- * Initialize the generic pvclock vsyscall state.  This will allocate
- * a/some page(s) for the per-vcpu pvclock information, set up a
- * fixmap mapping for the page(s)
- */
-
-int __init pvclock_init_vsyscall(struct pvclock_vsyscall_time_info *i,
-				 int size)
-{
-	int idx;
-
-	WARN_ON (size != PVCLOCK_VSYSCALL_NR_PAGES*PAGE_SIZE);
-
-	for (idx = 0; idx <= (PVCLOCK_FIXMAP_END-PVCLOCK_FIXMAP_BEGIN); idx++) {
-		__set_fixmap(PVCLOCK_FIXMAP_BEGIN + idx,
-			     __pa(i) + (idx*PAGE_SIZE),
-			     PAGE_KERNEL_VVAR);
-	}
-
-	return 0;
-}
-#endif
--- a/arch/x86/vdso/vclock_gettime.c
+++ b/arch/x86/vdso/vclock_gettime.c
@@ -45,7 +45,6 @@ extern u8 pvclock_page
 
 #include <linux/kernel.h>
 #include <asm/vsyscall.h>
-#include <asm/fixmap.h>
 #include <asm/pvclock.h>
 
 notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
--- a/arch/x86/vdso/vma.c
+++ b/arch/x86/vdso/vma.c
@@ -11,6 +11,7 @@
 #include <linux/random.h>
 #include <linux/elf.h>
 #include <asm/vsyscall.h>
+#include <asm/pvclock.h>
 #include <asm/vgtod.h>
 #include <asm/proto.h>
 #include <asm/vdso.h>
