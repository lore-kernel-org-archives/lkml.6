Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519835543-2-13186477722304702618
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835542; b=Jtxn1ZY+3yKoum6T3DXs0+AIi8uf7pbqyaZ7N1j+Gst4kCn
    4XbwkMIfv8H9iiikKk6t6BaqYlYcfUbXXPpekIJdrOrqYNjzFtiMKJnB2KfyHF6P
    5jdGwn620zhJk+LbnQODd35KzTiQ3iNGnEMCgA3Lb46FOCpgUpcMJ1CY9XUbWy9R
    Akp5LieHXFOK/5Ke7s8Sm/gIeiYc2/C6E8yauaGsSkJhBemMq1GodO+CDQ8X/3ds
    gn56yyawL2pbHnsbkFQq0j+/JJgiONZh2wqOQn5hPB3Yt5+SAJj/k8rSvvfMQVLW
    ye+nLqtATNpK5Mx2sPbj76UoIhNUqDZkscEYn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835542; bh=y43Y+Br2nos8zKNy8NP
    cNYfOwJUseCJnAMBf2ZN8WP8=; b=fbceNByYMDIsnyMI6BjQNuDcF/2q73txkTK
    /CnUqS4XKiMoMbuvD460R7SGBCsw3c5K4lZDzyMHuyO4C3WNMwk6vDWY10xwt7h7
    STx51psPDP6yNzcTfzQaqsyqHumVlUcegu/4w0LQbjMouFyWmFWDzU8a3PNpj9ul
    w1aXG03itS49rMQn1zjONghZxEfikna7v3KIav1tfBu+zC2hq+B+H70DfUmOz9be
    3KEHjqXrJ5yUAq05CLL3cwvuyrSuQHfT6YIHpelMoF38k50wG//0OcrJ/v+VnRwo
    l1vilNC0fbFBP0HFr2FZKtmtuNoyNRvFNjEKiqkHoW7Cz1z3NLA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753301AbeB1QOa (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:14:30 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35114 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753118AbeB1QO3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:14:29 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Borislav Petkov" <bp@alien8.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.291303251@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 222/254] x86/mce: Make machine check speculation
 protected
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 6f41c34d69eb005e7848716bbcafc979b35037d5 upstream.

The machine check idtentry uses an indirect branch directly from the low
level code. This evades the speculation protection.

Replace it by a direct call into C code and issue the indirect call there
so the compiler can apply the proper speculation protection.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by:Borislav Petkov <bp@alien8.de>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Niced-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/alpine.DEB.2.20.1801181626290.1847@nanos
[bwh: Backported to 3.16
 - #include <asm/traps.h> in mce.c
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -91,6 +91,7 @@ dotraplinkage void do_simd_coprocessor_e
 #ifdef CONFIG_X86_32
 dotraplinkage void do_iret_error(struct pt_regs *, long);
 #endif
+dotraplinkage void do_mce(struct pt_regs *, long);
 
 static inline int get_si_code(unsigned long condition)
 {
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -46,6 +46,7 @@
 #include <asm/tlbflush.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
+#include <asm/traps.h>
 
 #include "mce-internal.h"
 
@@ -1693,6 +1694,11 @@ static void unexpected_machine_check(str
 void (*machine_check_vector)(struct pt_regs *, long error_code) =
 						unexpected_machine_check;
 
+dotraplinkage void do_mce(struct pt_regs *regs, long error_code)
+{
+	machine_check_vector(regs, error_code);
+}
+
 /*
  * Called for each booted CPU to set up machine checks.
  * Must be called with preempt off:
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1320,7 +1320,7 @@ trace_idtentry page_fault do_page_fault
 idtentry async_page_fault do_async_page_fault has_error_code=1
 #endif
 #ifdef CONFIG_X86_MCE
-idtentry machine_check has_error_code=0 paranoid=1 do_sym=*machine_check_vector(%rip)
+idtentry machine_check		do_mce			has_error_code=0	paranoid=1
 #endif
 
 	/*
