Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-541790-1524851537-2-5619167917323381573
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
    1524851536; b=mOMRn7DaUwWEz8DtJgvonj/WPVnEt+l9gfK2daLChRCvI9cJ0m
    3V4NREppEalb4Efi23sasoE1K29o2akXDdMID/uq4OOZS05OZS0MY2VpWBSq56nZ
    WdOAK6s5zAty2xS1zKTv2I/9CUzr2miz6NUb+6/9DKQ9Cg0fQXdJdzJO0vs/W98s
    hhWYXI0Xe+xxtgGHK63+6W6cxWIFS8Zr/iQQq6Tq2J2UjKeJKw88vGa1rpg6tMnA
    itArORAGWnQe5tt1YdnBoL8TJonWlmuOQrTZcqlYjRZ+NdIJVUsXlCcKJAp5XQLi
    is/yb56GSazBbIKx/tIemjHJ+yluYPNNnPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:date:references
    :in-reply-to:message-id:sender:list-id; s=fm2; t=1524851536; bh=
    oNYr8wOOgjVkWIrGRs/HZtArZbJB6uYjPbvfSuRxN/I=; b=bEWO92A3+0SI4n00
    hx1NpokqY8YGjJiqD8Pugf4bZFG78GClyfS199VqSGvZ9NVoZo9WxBcmg4jgUP2B
    m2x42QpfuhlvMs+TFDUcI0TPR8PXnTtAzSXLcmgAhZDvOaZ4ImiFf8YPl0Qha88F
    xJIB1eU8Zfch/aJCxGIz/7pK5om4w8zP0Ks2N1He+DrARjbFNkZbGVotbZLC3n8p
    o3egJGN8uTlTqPNz8cUl6L9gtRnaiYsDp+YUszYednjHKfdxBiWSepn/ac7j4rfh
    65J/AsarhQbVpoWaNv3MPqxaGTrFB/emNwpiQcYAXF/cdL3+U4SREwaK9HLHLmXs
    gdAogg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfClA9LlA2g4i0u2Ju4HL4nV0sCtTsHUjc1DrhJn4dcV78KmS+y6mqfPa84/LkqruUlWK2BJIBZbD6j+WajIMIRxBSku0cH0o0/7Jou9fGyciOWlTc9sK
    r1s2Tp4+5a9DiJi7MBvaJgohVkUxSfa77YgV1GV5bht65/55k6tzb8cEaNZaOrq1zMcx4A3S8oTKyZ/0yTRRpCpjhA2FKaw2xQXlXRsrjgBIzZH9tBQqqaWJ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8 a=7fMUVvZQanGK6ToBRAIA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757542AbeD0Rts (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 13:49:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:54907 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932235AbeD0Rtr (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 13:49:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,336,1520924400";
   d="scan'208";a="36976900"
Subject: [PATCH 1/9] x86, pkeys: do not special case protection key 0
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        stable@vger.kernel.org, linuxram@us.ibm.com, tglx@linutronix.de,
        dave.hansen@intel.com, mpe@ellerman.id.au, mingo@kernel.org,
        akpm@linux-foundation.org, shuah@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 27 Apr 2018 10:45:28 -0700
References: <20180427174527.0031016C@viggo.jf.intel.com>
In-Reply-To: <20180427174527.0031016C@viggo.jf.intel.com>
Message-Id: <20180427174528.23748D52@viggo.jf.intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

mm_pkey_is_allocated() treats pkey 0 as unallocated.  That is
inconsistent with the manpages, and also inconsistent with
mm->context.pkey_allocation_map.  Stop special casing it and only
disallow values that are actually bad (< 0).

The end-user visible effect of this is that you can now use
mprotect_pkey() to set pkey=0.

This is a bit nicer than what Ram proposed because it is simpler
and removes special-casing for pkey 0.  On the other hand, it does
allow applciations to pkey_free() pkey-0, but that's just a silly
thing to do, so we are not going to protect against it.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Fixes: 58ab9a088dda ("x86/pkeys: Check against max pkey to avoid overflows")
Cc: stable@kernel.org
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>p
Cc: Shuah Khan <shuah@kernel.org>
---

 b/arch/x86/include/asm/mmu_context.h |    2 +-
 b/arch/x86/include/asm/pkeys.h       |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -puN arch/x86/include/asm/mmu_context.h~x86-pkey-0-default-allocated arch/x86/include/asm/mmu_context.h
--- a/arch/x86/include/asm/mmu_context.h~x86-pkey-0-default-allocated	2018-03-26 10:22:33.742170197 -0700
+++ b/arch/x86/include/asm/mmu_context.h	2018-03-26 10:22:33.747170197 -0700
@@ -192,7 +192,7 @@ static inline int init_new_context(struc
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
-		/* pkey 0 is the default and always allocated */
+		/* pkey 0 is the default and allocated implicitly */
 		mm->context.pkey_allocation_map = 0x1;
 		/* -1 means unallocated or invalid */
 		mm->context.execute_only_pkey = -1;
diff -puN arch/x86/include/asm/pkeys.h~x86-pkey-0-default-allocated arch/x86/include/asm/pkeys.h
--- a/arch/x86/include/asm/pkeys.h~x86-pkey-0-default-allocated	2018-03-26 10:22:33.744170197 -0700
+++ b/arch/x86/include/asm/pkeys.h	2018-03-26 10:22:33.747170197 -0700
@@ -49,10 +49,10 @@ bool mm_pkey_is_allocated(struct mm_stru
 {
 	/*
 	 * "Allocated" pkeys are those that have been returned
-	 * from pkey_alloc().  pkey 0 is special, and never
-	 * returned from pkey_alloc().
+	 * from pkey_alloc() or pkey 0 which is allocated
+	 * implicitly when the mm is created.
 	 */
-	if (pkey <= 0)
+	if (pkey < 0)
 		return false;
 	if (pkey >= arch_max_pkey())
 		return false;
_
