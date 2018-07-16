Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3689DECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE8E2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE8E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389538AbeGPILM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:11:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48454 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388824AbeGPILK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:11:10 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 08BF7CA5;
        Mon, 16 Jul 2018 07:45:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave@sr71.net>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 34/43] x86/cpufeature: Update cpufeaure macros
Date:   Mon, 16 Jul 2018 09:36:39 +0200
Message-Id: <20180716073515.633295427@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073511.796555857@linuxfoundation.org>
References: <20180716073511.796555857@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

commit 6e17cb9c2d5efd8fcc3934e983733302b9912ff8 upstream

We had a new CPUID "NCAPINT" word added, but the REQUIRED_MASK and
DISABLED_MASK macros did not get updated.  Update them.

None of the features was needed in these masks, so there was no
harm, but we should keep them updated anyway.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave@sr71.net>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20160629200107.8D3C9A31@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/cpufeature.h        |    6 ++++--
 arch/x86/include/asm/disabled-features.h |    1 +
 arch/x86/include/asm/required-features.h |    1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -66,7 +66,8 @@ extern const char * const x86_bug_flags[
 	   (((bit)>>5)==13 && (1UL<<((bit)&31) & REQUIRED_MASK13)) ||	\
 	   (((bit)>>5)==14 && (1UL<<((bit)&31) & REQUIRED_MASK14)) ||	\
 	   (((bit)>>5)==15 && (1UL<<((bit)&31) & REQUIRED_MASK15)) ||	\
-	   (((bit)>>5)==16 && (1UL<<((bit)&31) & REQUIRED_MASK16)) )
+	   (((bit)>>5)==16 && (1UL<<((bit)&31) & REQUIRED_MASK16)) ||	\
+	   (((bit)>>5)==17 && (1UL<<((bit)&31) & REQUIRED_MASK17)))
 
 #define DISABLED_MASK_BIT_SET(bit)					\
 	 ( (((bit)>>5)==0  && (1UL<<((bit)&31) & DISABLED_MASK0 )) ||	\
@@ -85,7 +86,8 @@ extern const char * const x86_bug_flags[
 	   (((bit)>>5)==13 && (1UL<<((bit)&31) & DISABLED_MASK13)) ||	\
 	   (((bit)>>5)==14 && (1UL<<((bit)&31) & DISABLED_MASK14)) ||	\
 	   (((bit)>>5)==15 && (1UL<<((bit)&31) & DISABLED_MASK15)) ||	\
-	   (((bit)>>5)==16 && (1UL<<((bit)&31) & DISABLED_MASK16)) )
+	   (((bit)>>5)==16 && (1UL<<((bit)&31) & DISABLED_MASK16)) ||	\
+	   (((bit)>>5)==17 && (1UL<<((bit)&31) & DISABLED_MASK17)))
 
 #define cpu_has(c, bit)							\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -58,5 +58,6 @@
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE)
+#define DISABLED_MASK17	0
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -99,5 +99,6 @@
 #define REQUIRED_MASK14	0
 #define REQUIRED_MASK15	0
 #define REQUIRED_MASK16	0
+#define REQUIRED_MASK17	0
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */


