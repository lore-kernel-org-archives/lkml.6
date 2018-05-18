Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3687130-1526635074-2-6393908760248694639
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526635074; b=FfE15vHeZ70MOyycB3EISikpg+BeEKU8o8imjVS+6GYfcHQEtS
    zG66B1DAvYGZe0QLbFFVFk6AZBoR/mXkyG7AIUandvWfIHbED4NqZFytACU+GBR/
    b4JEKM490nY8DzjuKKUX1Z8i+XdaMpa6aRI8n5FMAum6dlO7nRojjVZKOn2La2ts
    wsyc9UGBxoVCxereW9OZDdRpx0yufAuCM/UaPZYaS9e7jxQe5IH+Lccdz57LwwzS
    xYQQE6xoTCkvxisNsLA1Avv+QjJHnyRojoAuYmKOpOxY6GJjLh1f7b7MDAKUIlqh
    zogtitHsz55psZMF1gdFN8J8yM7n9WaurKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526635074; bh=
    Q5X3Qpi5Xw7YFBhAbTU0t/VIhy3q+hhHCEwQirIYb1Q=; b=CHMEJusPLRVem1zv
    N2WQ9rOe442LJk0eULwQIYvxMwFMlrYS6wBUGtCnEhuKjLfN9j8fjj0KLX8ej5ZA
    pdXfSqh6XcRjOD+QRWAAvF3lrSGNiPupAya7M0Kh2lm7owUdo/7OmR7d49nePmDx
    YU02rPD5nWrEea5xePQhtKfyISxmMbqe9BpgKFEOBpc+mKJKE+I9OdnSwyjtk8k+
    0CUH66x0iHMeRZExAZHMRbzh/llErx6vSHB7338/qb8CtWmOJdBNUz2qMDMTxauE
    94zyun9uuzrZCNjcK2SScweh0n4Jc/xNYfkLb8P+cuPh4RHXS+P2zgO0YaIs2tgT
    4TgBCQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ40817F/ukOCKhyvY2E5iuJLfN7VYWIxsrzxGIekzIsoG5WQH/Tav6l48tWiDYAVVid8h5dMjHPz4rbGkFXiBRumcNUxVyScZ+JVtt6QDRLqNOZ83Gh
    U1IDzZMZcu3V6IGaVS+AHN3BRpzYN+rSNhwEj1K1l8I79ixeF0e5WarOgc79UVr13imf0HUCLT6A1QCc6CPevT2WgRrfYHZYxJaJkhKGL9eaBuoQgPgucg42
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=VwQbUJbxAAAA:8 a=7S8H7V3pDoY91oZkGvcA:9
    a=NdAtdrkLVvyUPsUoGJp4:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbeERJRv (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 05:17:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:45467 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753165AbeERJRm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 May 2018 05:17:42 -0400
From: Jiri Slaby <jslaby@suse.cz>
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH v6 15/28] x86/asm/purgatory: start using annotations
Date: Fri, 18 May 2018 11:17:08 +0200
Message-Id: <20180518091721.7604-16-jslaby@suse.cz>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180518091721.7604-1-jslaby@suse.cz>
References: <20180518091721.7604-1-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

purgatory used no annotations at all. So include linux/linkage.h and
annotate everything:
* code by SYM_CODE_*
* data by SYM_DATA_*

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/purgatory/entry64.S      | 21 ++++++++++++---------
 arch/x86/purgatory/setup-x86_64.S | 14 ++++++++------
 arch/x86/purgatory/stack.S        |  7 ++++---
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/x86/purgatory/entry64.S b/arch/x86/purgatory/entry64.S
index d1a4291d3568..c51e3c999e38 100644
--- a/arch/x86/purgatory/entry64.S
+++ b/arch/x86/purgatory/entry64.S
@@ -10,13 +10,13 @@
  * Version 2.  See the file COPYING for more details.
  */
 
+#include <linux/linkage.h>
+
 	.text
 	.balign 16
 	.code64
-	.globl entry64, entry64_regs
-
 
-entry64:
+SYM_CODE_START(entry64)
 	/* Setup a gdt that should be preserved */
 	lgdt gdt(%rip)
 
@@ -56,10 +56,11 @@ new_cs_exit:
 
 	/* Jump to the new code... */
 	jmpq	*rip(%rip)
+SYM_CODE_END(entry64)
 
 	.section ".rodata"
 	.balign 4
-entry64_regs:
+SYM_DATA_START(entry64_regs)
 rax:	.quad 0x0
 rcx:	.quad 0x0
 rdx:	.quad 0x0
@@ -77,12 +78,12 @@ r13:	.quad 0x0
 r14:	.quad 0x0
 r15:	.quad 0x0
 rip:	.quad 0x0
-	.size entry64_regs, . - entry64_regs
+SYM_DATA_END(entry64_regs)
 
 	/* GDT */
 	.section ".rodata"
 	.balign 16
-gdt:
+SYM_DATA_START_LOCAL(gdt)
 	/* 0x00 unusable segment
 	 * 0x08 unused
 	 * so use them as gdt ptr
@@ -96,6 +97,8 @@ gdt:
 
 	/* 0x18 4GB flat data segment */
 	.word 0xFFFF, 0x0000, 0x9200, 0x00CF
-gdt_end:
-stack:	.quad   0, 0
-stack_init:
+SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
+
+SYM_DATA_START_LOCAL(stack)
+	.quad   0, 0
+SYM_DATA_END_LABEL(stack, SYM_L_LOCAL, stack_init)
diff --git a/arch/x86/purgatory/setup-x86_64.S b/arch/x86/purgatory/setup-x86_64.S
index dfae9b9e60b5..f0de104d3f3a 100644
--- a/arch/x86/purgatory/setup-x86_64.S
+++ b/arch/x86/purgatory/setup-x86_64.S
@@ -9,14 +9,14 @@
  * This source code is licensed under the GNU General Public License,
  * Version 2.  See the file COPYING for more details.
  */
+#include <linux/linkage.h>
 #include <asm/purgatory.h>
 
 	.text
-	.globl purgatory_start
 	.balign 16
-purgatory_start:
 	.code64
 
+SYM_CODE_START(purgatory_start)
 	/* Load a gdt so I know what the segment registers are */
 	lgdt	gdt(%rip)
 
@@ -34,10 +34,12 @@ purgatory_start:
 	/* Call the C code */
 	call purgatory
 	jmp	entry64
+SYM_CODE_END(purgatory_start)
 
 	.section ".rodata"
 	.balign 16
-gdt:	/* 0x00 unusable segment
+SYM_DATA_START_LOCAL(gdt)
+	/* 0x00 unusable segment
 	 * 0x08 unused
 	 * so use them as the gdt ptr
 	 */
@@ -50,10 +52,10 @@ gdt:	/* 0x00 unusable segment
 
 	/* 0x18 4GB flat data segment */
 	.word	0xFFFF, 0x0000, 0x9200, 0x00CF
-gdt_end:
+SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
 	.bss
 	.balign 4096
-lstack:
+SYM_DATA_START_LOCAL(lstack)
 	.skip 4096
-lstack_end:
+SYM_DATA_END_LABEL(lstack, SYM_L_LOCAL, lstack_end)
diff --git a/arch/x86/purgatory/stack.S b/arch/x86/purgatory/stack.S
index 50a4147f91fb..987e6510a960 100644
--- a/arch/x86/purgatory/stack.S
+++ b/arch/x86/purgatory/stack.S
@@ -7,13 +7,14 @@
  * Version 2.  See the file COPYING for more details.
  */
 
+#include <linux/linkage.h>
+
 	/* A stack for the loaded kernel.
 	 * Separate and in the data section so it can be prepopulated.
 	 */
 	.data
 	.balign 4096
-	.globl stack, stack_end
 
-stack:
+SYM_DATA_START(stack)
 	.skip 4096
-stack_end:
+SYM_DATA_END_LABEL(stack, SYM_L_GLOBAL, stack_end)
-- 
2.16.3
