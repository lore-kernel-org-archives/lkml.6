Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-680809-1525886415-2-5784712763828615124
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525886415; b=FZHCTaVWE3Qx93rDEwmzW9xfumSbWW2x3m6DCBox95mFCRK8jc
    w9lkVU9WGV8Qwu6/jLLozJpcDSlsynfu2735b4CBRnbgNmV9xAzSr7CIVKXBpond
    npnsP8XemA47lp3O8ENEMzMBeQFy5G7DqqAHjmTgdzyjK4U2ajJ82TCyIYhVHpsI
    mkg1JyhDucQhpifa5WpLPlXv1SO4ZIQhMWzsuuR/nJqRElQGC1xZUdDHSJlzXMQ0
    9EfGOCTSliCOEjiciLa/P4Uy/aDjc0U2Q+nmRnYbEHa6iQsLxIvs8ihC7qmcWJWw
    ZLPkwxQ97u4LPgT49qhUK1grI8aun3ws1xPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:date:references
    :in-reply-to:message-id:sender:list-id; s=fm2; t=1525886415; bh=
    /XiA5eadDpm+1c83WTmG0fote4PdZrEd1hQ35DrJ/DY=; b=jFUJrXAlEZq3goXJ
    Gdfkcj6iqW4EdlG5pcVZ7pcEP+VQqBclW9ePClV9IcU33PyrEqtZUIto8umrtreJ
    Yp+H3pVvCvMJan1A/FzCdizFaQ8ufjt4CdIg+YhB7eX923LDyPCL0SPPJPsT23qk
    U4OGxhcfod7yKW3q8mEQCDdvVinbeaM6NNLQN8KeXxCOlJkeBD3lL5ufScMRh20i
    aF7rsFUfQF2GEozIGKKoNgojuslhQsgg+CknBskdWy4lH5UYoPdk5rPbtyY90Wwd
    XxEDe+hI2OGUBlp5yQ2mRJlA/YTtLHfC/KyC4i8GlOyKAuYDKYFjakNYAGm+5kKF
    wQDjQQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLZw5pWOf+sp7pyonZBPQg0NAF7i/qTr7t4t3VHUrukmo1Mum4ITCy4G2ZD4lkLLus39GM3QHaBL1wLuW/wuYt7Ffl9jLwYh1mU5YcX+mG8lL652GP/r
    KPxqZCXHeixZPZST3eYDhlj9G/5LFsQ7L0ynBAoMs2FjG284uvJ5DgYy0pFqfM0QfAV554H18HbYd7hr9bBZ46SenNP0V6jmTLpCKoFFEf1HM3W6TWo6BMZb
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8
    a=WexYMCiOe6C4khrCuiUA:9 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965881AbeEIRUB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 13:20:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:29736 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935535AbeEIRS5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 9 May 2018 13:18:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,382,1520924400";
   d="scan'208";a="39684411"
Subject: [PATCH 09/13] x86/pkeys: Override pkey when moving away from PROT_EXEC
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        shakeelb@google.com, stable@vger.kernel.org, linuxram@us.ibm.com,
        tglx@linutronix.de, dave.hansen@intel.com, mpe@ellerman.id.au,
        mingo@kernel.org, akpm@linux-foundation.org, shuah@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 09 May 2018 10:13:51 -0700
References: <20180509171336.76636D88@viggo.jf.intel.com>
In-Reply-To: <20180509171336.76636D88@viggo.jf.intel.com>
Message-Id: <20180509171351.084C5A71@viggo.jf.intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

I got a bug report that the following code (roughly) was
causing a SIGSEGV:

	mprotect(ptr, size, PROT_EXEC);
	mprotect(ptr, size, PROT_NONE);
	mprotect(ptr, size, PROT_READ);
	*ptr = 100;

The problem is hit when the mprotect(PROT_EXEC)
is implicitly assigned a protection key to the VMA, and made
that key ACCESS_DENY|WRITE_DENY.  The PROT_NONE mprotect()
failed to remove the protection key, and the PROT_NONE->
PROT_READ left the PTE usable, but the pkey still in place
and left the memory inaccessible.

To fix this, we ensure that we always "override" the pkee
at mprotect() if the VMA does not have execute-only
permissions, but the VMA has the execute-only pkey.

We had a check for PROT_READ/WRITE, but it did not work
for PROT_NONE.  This entirely removes the PROT_* checks,
which ensures that PROT_NONE now works.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Fixes: 62b5f7d013f ("mm/core, x86/mm/pkeys: Add execute-only protection keys support")
Reported-by: Shakeel Butt <shakeelb@google.com>
Cc: stable@vger.kernel.org
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
---

 b/arch/x86/include/asm/pkeys.h |   12 +++++++++++-
 b/arch/x86/mm/pkeys.c          |   21 +++++++++++----------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff -puN arch/x86/include/asm/pkeys.h~pkeys-abandon-exec-only-pkey-more-aggressively arch/x86/include/asm/pkeys.h
--- a/arch/x86/include/asm/pkeys.h~pkeys-abandon-exec-only-pkey-more-aggressively	2018-05-09 09:20:22.295698398 -0700
+++ b/arch/x86/include/asm/pkeys.h	2018-05-09 09:20:22.300698398 -0700
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_PKEYS_H
 #define _ASM_X86_PKEYS_H
 
+#define ARCH_DEFAULT_PKEY	0
+
 #define arch_max_pkey() (boot_cpu_has(X86_FEATURE_OSPKE) ? 16 : 1)
 
 extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
@@ -15,7 +17,7 @@ extern int __execute_only_pkey(struct mm
 static inline int execute_only_pkey(struct mm_struct *mm)
 {
 	if (!boot_cpu_has(X86_FEATURE_OSPKE))
-		return 0;
+		return ARCH_DEFAULT_PKEY;
 
 	return __execute_only_pkey(mm);
 }
@@ -56,6 +58,14 @@ bool mm_pkey_is_allocated(struct mm_stru
 		return false;
 	if (pkey >= arch_max_pkey())
 		return false;
+	/*
+	 * The exec-only pkey is set in the allocation map, but
+	 * is not available to any of the user interfaces like
+	 * mprotect_pkey().
+	 */
+	if (pkey == mm->context.execute_only_pkey)
+		return false;
+
 	return mm_pkey_allocation_map(mm) & (1U << pkey);
 }
 
diff -puN arch/x86/mm/pkeys.c~pkeys-abandon-exec-only-pkey-more-aggressively arch/x86/mm/pkeys.c
--- a/arch/x86/mm/pkeys.c~pkeys-abandon-exec-only-pkey-more-aggressively	2018-05-09 09:20:22.297698398 -0700
+++ b/arch/x86/mm/pkeys.c	2018-05-09 09:20:22.301698398 -0700
@@ -94,26 +94,27 @@ int __arch_override_mprotect_pkey(struct
 	 */
 	if (pkey != -1)
 		return pkey;
-	/*
-	 * Look for a protection-key-drive execute-only mapping
-	 * which is now being given permissions that are not
-	 * execute-only.  Move it back to the default pkey.
-	 */
-	if (vma_is_pkey_exec_only(vma) &&
-	    (prot & (PROT_READ|PROT_WRITE))) {
-		return 0;
-	}
+
 	/*
 	 * The mapping is execute-only.  Go try to get the
 	 * execute-only protection key.  If we fail to do that,
 	 * fall through as if we do not have execute-only
-	 * support.
+	 * support in this mm.
 	 */
 	if (prot == PROT_EXEC) {
 		pkey = execute_only_pkey(vma->vm_mm);
 		if (pkey > 0)
 			return pkey;
+	} else if (vma_is_pkey_exec_only(vma)) {
+		/*
+		 * Protections are *not* PROT_EXEC, but the mapping
+		 * is using the exec-only pkey.  This mapping was
+		 * PROT_EXEC and will no longer be.  Move back to
+		 * the default pkey.
+		 */
+		return ARCH_DEFAULT_PKEY;
 	}
+
 	/*
 	 * This is a vanilla, non-pkey mprotect (or we failed to
 	 * setup execute-only), inherit the pkey from the VMA we
_
