Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6l5ALx1IGVteQQAAmS7hNA
	; Thu, 07 Jun 2018 14:58:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9E67E607E7; Thu,  7 Jun 2018 14:58:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 56C1C601C3;
	Thu,  7 Jun 2018 14:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56C1C601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753777AbeFGO6Q (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:58:16 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41169 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935522AbeFGO6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:58:11 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbz-0005Zx-Ui; Thu, 07 Jun 2018 15:10:00 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0002jQ-Jw; Thu, 07 Jun 2018 15:08:56 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, gnomes@lxorguk.ukuu.org.uk,
        arjan@linux.intel.com, karahmed@amazon.de,
        torvalds@linux-foundation.org,
        "Thomas Gleixner" <tglx@linutronix.de>, dave.hansen@intel.com,
        ak@linux.intel.com, gregkh@linux-foundation.org,
        "David Woodhouse" <dwmw@amazon.co.uk>, ashok.raj@intel.com,
        bp@alien8.de, "Borislav Petkov" <bp@suse.de>, peterz@infradead.org,
        pbonzini@redhat.com, tim.c.chen@linux.intel.com,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.720406059@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 041/410] x86/cpufeatures: Add Intel feature bits for
 Speculation Control
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit fc67dd70adb711a45d2ef34e12d1a8be75edde61 upstream.

Add three feature bits exposed by new microcode on Intel CPUs for
speculation control.

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
Link: https://lkml.kernel.org/r/1516896855-7642-3-git-send-email-dwmw@amazon.co.uk
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: This CPUID word wasn't used at all yet, so
 add it as feature word 10]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/cpufeature.h | 7 ++++++-
 arch/x86/kernel/cpu/common.c      | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -8,7 +8,7 @@
 #include <asm/required-features.h>
 #endif
 
-#define NCAPINTS	10	/* N 32-bit words worth of info */
+#define NCAPINTS	11	/* N 32-bit words worth of info */
 #define NBUGINTS	1	/* N 32-bit bug flags */
 
 /*
@@ -234,6 +234,11 @@
 #define X86_FEATURE_AVX512ER	(9*32+27) /* AVX-512 Exponential and Reciprocal */
 #define X86_FEATURE_AVX512CD	(9*32+28) /* AVX-512 Conflict Detection */
 
+/* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 10 */
+#define X86_FEATURE_SPEC_CTRL		(10*32+26) /* Speculation Control (IBRS + IBPB) */
+#define X86_FEATURE_STIBP		(10*32+27) /* Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_ARCH_CAPABILITIES	(10*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
+
 /*
  * BUG word(s)
  */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -701,6 +701,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		cpuid_count(0x00000007, 0, &eax, &ebx, &ecx, &edx);
 
 		c->x86_capability[9] = ebx;
+		c->x86_capability[10] = edx;
 	}
 
 	/* AMD-defined flags: level 0x80000001 */
