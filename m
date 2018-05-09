Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-680809-1525886375-2-10402090438488805079
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
    1525886375; b=PRB684OZgtkJQuLQAuLYbWpdiiYyq6/jjIEQ3yxLMP4552n2/d
    oYmrtsSt0m8i74ao3G9Dt6gef1j1NF6Su14gyLCFjmzqXUBEqghNEbGxlHVhOzYw
    JdXJ10ojkicvFbUVHLWEYJlRmL128NjZ+jb/A9asmF4gAQCEA3Q7ZFRNPVb3ZB8r
    RtxCle8Egvew57I7FxkGsRwAWumMaaAFNw4RJqOEUggtruhL+3gY7DMVgITHIvAO
    YMos9mL1Cq7E0EgEnf4AKEIx/fcWShIdv+CssNfyrJvdt1CdQN9QvtWLwsRWqsWk
    FmXo9zNlagQq1T7Q9LX1V9tk0uB/GEZyolAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:date:references
    :in-reply-to:message-id:sender:list-id; s=fm2; t=1525886375; bh=
    ICZYMRaHioJrTTQRJCcjCLaoKqWpEQ3cJ1mG1fWVWKU=; b=nss4vAEldka0I0aN
    c8mO1ckV2BbKvtChXUI9CeHWOuNE639SArawBnlaxSJZzn5G0EMyLQLfV0R6sqo4
    VWZWsx5RkCSGysdIiY0xWK0Ol5ozBbiUuxgNv7Um1hLPzQj8Z7pH56CFXnz/u99v
    9KXq/AL8VYX2bOdfvB34zmrWKX9UL7gRGPgfJ+TUd2Y5KUGcbHrg+RGiXMGBiYb0
    10AfFBAADT+86zM1v/6E4a+Crfp7kzFEyRStfjlIxO8UoGsADPlNVUWiRwnchpd7
    jw2uz6DW4rDn6g2mV1ikste8zfMtT3jdPdeSrsolBml7oAjpSlZC6CMffDy4zWV3
    SiKdAg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfFuB6Xpg1AhrSz4Ho666amPkclpvgawYOzxC5diT7yy+zKB7cvca7IQFAfP5AM3ccqhea0mI43vU22D8jxOcXOFAdWP0AeETJuU2NtPDKnMjmjamjiD/
    Kwxw88FjajFWQbv1k+oXhqEnNH+wpD4wLaRMouk5lsyw8MmE89S3ikLWpwGHTi4ypqymKq05PV8fyddnI4d7gPfYLk38B1A3sHsN89zQs56xwzx0aDhgZht9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8 a=bd_wP00HRsYNP6wUEzEA:9
    a=0Yhvs-2UZUkA:10 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935088AbeEIRTT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 13:19:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:46256 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935556AbeEIRTE (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 9 May 2018 13:19:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,382,1520924400";
   d="scan'208";a="38654860"
Subject: [PATCH 13/13] x86/pkeys: Do not special case protection key 0
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        stable@vger.kernel.org, linuxram@us.ibm.com, tglx@linutronix.de,
        dave.hansen@intel.com, mpe@ellerman.id.au, mingo@kernel.org,
        akpm@linux-foundation.org, shuah@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 09 May 2018 10:13:58 -0700
References: <20180509171336.76636D88@viggo.jf.intel.com>
In-Reply-To: <20180509171336.76636D88@viggo.jf.intel.com>
Message-Id: <20180509171358.47FD785E@viggo.jf.intel.com>
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

This is a bit nicer than what Ram proposed[1] because it is simpler
and removes special-casing for pkey 0.  On the other hand, it does
allow applications to pkey_free() pkey-0, but that's just a silly
thing to do, so we are not going to protect against it.

The scenario that could happen is similar to what happens if you free
any other pkey that is in use: it might get reallocated later and used
to protect some other data.  The most likely scenario is that pkey-0
comes back from pkey_alloc(), an access-disable or write-disable bit
is set in PKRU for it, and the next stack access will SIGSEGV.  It's
not horribly different from if you mprotect()'d your stack or heap to
be unreadable or unwritable, which is generally very foolish, but also
not explicitly prevented by the kernel.

1. http://lkml.kernel.org/r/1522112702-27853-1-git-send-email-linuxram@us.ibm.com

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Fixes: 58ab9a088dda ("x86/pkeys: Check against max pkey to avoid overflows")
Cc: stable@vger.kernel.org
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
--- a/arch/x86/include/asm/mmu_context.h~x86-pkey-0-default-allocated	2018-05-09 09:20:24.362698393 -0700
+++ b/arch/x86/include/asm/mmu_context.h	2018-05-09 09:20:24.367698393 -0700
@@ -193,7 +193,7 @@ static inline int init_new_context(struc
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
-		/* pkey 0 is the default and always allocated */
+		/* pkey 0 is the default and allocated implicitly */
 		mm->context.pkey_allocation_map = 0x1;
 		/* -1 means unallocated or invalid */
 		mm->context.execute_only_pkey = -1;
diff -puN arch/x86/include/asm/pkeys.h~x86-pkey-0-default-allocated arch/x86/include/asm/pkeys.h
--- a/arch/x86/include/asm/pkeys.h~x86-pkey-0-default-allocated	2018-05-09 09:20:24.364698393 -0700
+++ b/arch/x86/include/asm/pkeys.h	2018-05-09 09:20:24.367698393 -0700
@@ -51,10 +51,10 @@ bool mm_pkey_is_allocated(struct mm_stru
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
