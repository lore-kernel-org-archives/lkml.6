Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185486-2-14689486804493126739
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518185485; b=gnofrr4kTY/K7ulSAWQaO79K7GaQA6SJ9/7HeTnC+gPovm8
    KwYsw+hGEw2zWQ4V1FDT7GscuelANArx9g1V1S6unW8Ji/Oa+k6Ukf3PXAA3EhFr
    24e7WU3aQqBctM/KHGEaouHfYnll3hgaf9Zqm6fvZsFMw3YzvEvRLgni8hjcv+Ak
    UxZwjIqvWWCClIAeyyIWGWripoLbULnkyKpu8hCDDKEReY/CwZRiS+TtJlDCKJN4
    wWx4FirD3UxhylNAYtUrKyZglw0KTFvSY89wF74JtIPrDgjvGeKy1zY+noBhrqfI
    xE1uSElhA66a5I8C7OmyacE6oxA+40xh1EXDSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185485; bh=Hy94bHAKompsLc6TftPiimYR+g
    a6LV6hfKrm533JSJ0=; b=aYFSZwi43oG/VlbJEm3ZO52w4YnYPvG1v8jvLur51j
    JizGhtGVeLjyrbc/D3y+Xtgr8UWIyXQrGo6Or+GcRRhYGrwk5txwFy06pG7pWyy0
    AVGUia8UDwZi/NN4zjWIyE2F4kDXtn7vfeg/tklW9dRgQNRBT+Gns6ElBuzRyYRd
    8IraiA5EDNHd3OfH0ure3nVqAflBRmuYq/zJ4eDxH5TxzxAV+Q/ZAcWJZvv4USuC
    VqBIsnbLJEEn+ujck5vqmW1VRnGWfqtTRCld6BJVHDo46wxYSl12hsZfQaJH5RjC
    7jfwYn8Xh4zOwdG0OjNaoEQZ1jMtVtuY1JKVYwYfZYyA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbeBINmH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:42:07 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbeBINmF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:42:05 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, gnomes@lxorguk.ukuu.org.uk,
        ak@linux.intel.com, ashok.raj@intel.com, dave.hansen@intel.com,
        karahmed@amazon.de, arjan@linux.intel.com,
        torvalds@linux-foundation.org, peterz@infradead.org, bp@alien8.de,
        pbonzini@redhat.com, tim.c.chen@linux.intel.com,
        gregkh@linux-foundation.org
Subject: [PATCH 4.9 39/92] x86/cpufeatures: Add CPUID_7_EDX CPUID leaf
Date: Fri,  9 Feb 2018 14:39:08 +0100
Message-Id: <20180209133933.972959667@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

(cherry picked from commit 95ca0ee8636059ea2800dfbac9ecac6212d6b38f)

This is a pure feature bits leaf. There are two AVX512 feature bits in it
already which were handled as scattered bits, and three more from this leaf
are going to be added for speculation control features.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: ak@linux.intel.com
Cc: ashok.raj@intel.com
Cc: dave.hansen@intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1516896855-7642-2-git-send-email-dwmw@amazon.co.uk
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeature.h        |    7 +++++--
 arch/x86/include/asm/cpufeatures.h       |   10 ++++++----
 arch/x86/include/asm/disabled-features.h |    3 ++-
 arch/x86/include/asm/required-features.h |    3 ++-
 arch/x86/kernel/cpu/common.c             |    1 +
 arch/x86/kernel/cpu/scattered.c          |    2 --
 6 files changed, 16 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -28,6 +28,7 @@ enum cpuid_leafs
 	CPUID_8000_000A_EDX,
 	CPUID_7_ECX,
 	CPUID_8000_0007_EBX,
+	CPUID_7_EDX,
 };
 
 #ifdef CONFIG_X86_FEATURE_NAMES
@@ -78,8 +79,9 @@ extern const char * const x86_bug_flags[
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 15, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 16, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 17, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 18, feature_bit) ||	\
 	   REQUIRED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 18))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 19))
 
 #define DISABLED_MASK_BIT_SET(feature_bit)				\
 	 ( CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  0, feature_bit) ||	\
@@ -100,8 +102,9 @@ extern const char * const x86_bug_flags[
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 15, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 16, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 17, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 18, feature_bit) ||	\
 	   DISABLED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 18))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 19))
 
 #define cpu_has(c, bit)							\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -12,7 +12,7 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS	18	/* N 32-bit words worth of info */
+#define NCAPINTS	19	/* N 32-bit words worth of info */
 #define NBUGINTS	1	/* N 32-bit bug flags */
 
 /*
@@ -197,9 +197,7 @@
 #define X86_FEATURE_RETPOLINE	( 7*32+12) /* Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_AMD ( 7*32+13) /* AMD Retpoline mitigation for Spectre variant 2 */
 
-#define X86_FEATURE_AVX512_4VNNIW (7*32+16) /* AVX-512 Neural Network Instructions */
-#define X86_FEATURE_AVX512_4FMAPS (7*32+17) /* AVX-512 Multiply Accumulation Single precision */
-#define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* Fill RSB on context switches */
+#define X86_FEATURE_RSB_CTXSW	( 7*32+19) /* Fill RSB on context switches */
 
 /* Because the ALTERNATIVE scheme is for members of the X86_FEATURE club... */
 #define X86_FEATURE_KAISER	( 7*32+31) /* CONFIG_PAGE_TABLE_ISOLATION w/o nokaiser */
@@ -295,6 +293,10 @@
 #define X86_FEATURE_SUCCOR	(17*32+1) /* Uncorrectable error containment and recovery */
 #define X86_FEATURE_SMCA	(17*32+3) /* Scalable MCA */
 
+/* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
+#define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
+#define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+
 /*
  * BUG word(s)
  */
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -59,6 +59,7 @@
 #define DISABLED_MASK15	0
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE)
 #define DISABLED_MASK17	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 18)
+#define DISABLED_MASK18	0
+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -100,6 +100,7 @@
 #define REQUIRED_MASK15	0
 #define REQUIRED_MASK16	0
 #define REQUIRED_MASK17	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 18)
+#define REQUIRED_MASK18	0
+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -737,6 +737,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		cpuid_count(0x00000007, 0, &eax, &ebx, &ecx, &edx);
 		c->x86_capability[CPUID_7_0_EBX] = ebx;
 		c->x86_capability[CPUID_7_ECX] = ecx;
+		c->x86_capability[CPUID_7_EDX] = edx;
 	}
 
 	/* Extended state features: level 0x0000000d */
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -31,8 +31,6 @@ void init_scattered_cpuid_features(struc
 	const struct cpuid_bit *cb;
 
 	static const struct cpuid_bit cpuid_bits[] = {
-		{ X86_FEATURE_AVX512_4VNNIW,	CR_EDX, 2, 0x00000007, 0 },
-		{ X86_FEATURE_AVX512_4FMAPS,	CR_EDX, 3, 0x00000007, 0 },
 		{ X86_FEATURE_APERFMPERF,	CR_ECX, 0, 0x00000006, 0 },
 		{ X86_FEATURE_EPB,		CR_ECX, 3, 0x00000006, 0 },
 		{ X86_FEATURE_HW_PSTATE,	CR_EDX, 7, 0x80000007, 0 },
