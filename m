Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E13C6778A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629AD208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629AD208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeGKAyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 20:54:25 -0400
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:38372 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732278AbeGKAyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 20:54:24 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id w6B0pKZ1014505; Wed, 11 Jul 2018 09:51:21 +0900
X-Iguazu-Qid: 34tKBBYqqdQC3lc2N6
X-Iguazu-QSIG: v=1; s=0; t=1531270280; q=34tKBBYqqdQC3lc2N6; m=6GECy/tLec19e/r/4rT9sugbhMRJXakuq0RfmjYyJVs=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1510) id w6B0pFOt002376;
        Wed, 11 Jul 2018 09:51:16 +0900
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by imx2.toshiba.co.jp  with ESMTP id w6B0pFf9018200;
        Wed, 11 Jul 2018 09:51:15 +0900 (JST)
Content-Transfer-Encoding: 7bit
From:   Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
To:     stable@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Rik van Riel <riel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Razvan Ghitulete <rga@amazon.de>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>, Hugh Dickins <hughd@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4.4.y 3/3] x86/fpu: Finish excising 'eagerfpu'
Date:   Wed, 11 Jul 2018 09:48:40 +0900
X-TSB-HOP: ON
Message-Id: <1531270120-19068-4-git-send-email-daniel.sangorrin@toshiba.co.jp>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1531270120-19068-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
References: <1531270120-19068-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

commit e63650840e8b053aa09ad934877e87e9941ed135 upstream

Now that eagerfpu= is gone, remove it from the docs and some
comments.  Also sync the changes to tools/.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/cf430dd4481d41280e93ac6cf0def1007a67fc8e.1476740397.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>

Conflicts:
	Documentation/kernel-parameters.txt
	arch/x86/include/asm/cpufeatures.h
	arch/x86/mm/pkeys.c
	tools/arch/x86/include/asm/cpufeatures.h
---
 Documentation/kernel-parameters.txt |  6 ------
 arch/x86/include/asm/cpufeature.h   |  1 -
 arch/x86/include/asm/fpu/types.h    | 23 -----------------------
 3 files changed, 30 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 4df6bd7..792945c 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -961,12 +961,6 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			See Documentation/x86/intel_mpx.txt for more
 			information about the feature.
 
-	eagerfpu=	[X86]
-			on	enable eager fpu restore
-			off	disable eager fpu restore
-			auto	selects the default scheme, which automatically
-				enables eagerfpu restore for xsaveopt.
-
 	module.async_probe [KNL]
 			Enable asynchronous probe on this module.
 
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 232621c..ac4aa86 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -104,7 +104,6 @@
 #define X86_FEATURE_EXTD_APICID	( 3*32+26) /* has extended APICID (8 bits) */
 #define X86_FEATURE_AMD_DCM     ( 3*32+27) /* multi-node processor */
 #define X86_FEATURE_APERFMPERF	( 3*32+28) /* APERFMPERF */
-/* free, was #define X86_FEATURE_EAGER_FPU	( 3*32+29) * "eagerfpu" Non lazy FPU restore */
 #define X86_FEATURE_NONSTOP_TSC_S3 ( 3*32+30) /* TSC doesn't stop in S3 state */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index dcb85a9..0d81c7d 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -310,29 +310,6 @@ struct fpu {
 	 * the registers in the FPU are more recent than this state
 	 * copy. If the task context-switches away then they get
 	 * saved here and represent the FPU state.
-	 *
-	 * After context switches there may be a (short) time period
-	 * during which the in-FPU hardware registers are unchanged
-	 * and still perfectly match this state, if the tasks
-	 * scheduled afterwards are not using the FPU.
-	 *
-	 * This is the 'lazy restore' window of optimization, which
-	 * we track though 'fpu_fpregs_owner_ctx' and 'fpu->last_cpu'.
-	 *
-	 * We detect whether a subsequent task uses the FPU via setting
-	 * CR0::TS to 1, which causes any FPU use to raise a #NM fault.
-	 *
-	 * During this window, if the task gets scheduled again, we
-	 * might be able to skip having to do a restore from this
-	 * memory buffer to the hardware registers - at the cost of
-	 * incurring the overhead of #NM fault traps.
-	 *
-	 * Note that on modern CPUs that support the XSAVEOPT (or other
-	 * optimized XSAVE instructions), we don't use #NM traps anymore,
-	 * as the hardware can track whether FPU registers need saving
-	 * or not. On such CPUs we activate the non-lazy ('eagerfpu')
-	 * logic, which unconditionally saves/restores all FPU state
-	 * across context switches. (if FPU state exists.)
 	 */
 	union fpregs_state		state;
 	/*
-- 
2.1.4


