Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6515C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7211820652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xyDbFzcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7211820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbeJKXMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:12:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730276AbeJKXMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:12:10 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40AA2213A2;
        Thu, 11 Oct 2018 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272665;
        bh=TmSnEPLiQn0s85CbO985nyAkupwDXyIYL5+dP3gd1Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xyDbFzcff0SXinmsuQNp1SLX162Qq1ZjMdtHWhSzOM9C6MGJumkTOAb5FAfpClvXz
         a5rKrS9T0s/XVB77msX62QCcUcWhx+b873LG8SHVXQ+J2YWWRXLmwfcMdG91fAcIY8
         N/k06AiHP4RQ57G3JytOH7qMo4sZCShuweDh0Z0Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
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
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: [PATCH 4.9 35/35] x86/fpu: Finish excising eagerfpu
Date:   Thu, 11 Oct 2018 17:35:37 +0200
Message-Id: <20181011152521.577412393@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152520.174949126@linuxfoundation.org>
References: <20181011152520.174949126@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit e63650840e8b053aa09ad934877e87e9941ed135 upstream.

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
Cc: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/kernel-parameters.txt      |    6 ------
 arch/x86/include/asm/cpufeatures.h       |    1 -
 arch/x86/include/asm/fpu/types.h         |   23 -----------------------
 arch/x86/mm/pkeys.c                      |    3 +--
 tools/arch/x86/include/asm/cpufeatures.h |    1 -
 5 files changed, 1 insertion(+), 33 deletions(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1084,12 +1084,6 @@ bytes respectively. Such letter suffixes
 	nopku		[X86] Disable Memory Protection Keys CPU feature found
 			in some Intel CPUs.
 
-	eagerfpu=	[X86]
-			on	enable eager fpu restore
-			off	disable eager fpu restore
-			auto	selects the default scheme, which automatically
-				enables eagerfpu restore for xsaveopt.
-
 	module.async_probe [KNL]
 			Enable asynchronous probe on this module.
 
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -104,7 +104,6 @@
 #define X86_FEATURE_EXTD_APICID	( 3*32+26) /* has extended APICID (8 bits) */
 #define X86_FEATURE_AMD_DCM     ( 3*32+27) /* multi-node processor */
 #define X86_FEATURE_APERFMPERF	( 3*32+28) /* APERFMPERF */
-/* free, was #define X86_FEATURE_EAGER_FPU	( 3*32+29) * "eagerfpu" Non lazy FPU restore */
 #define X86_FEATURE_NONSTOP_TSC_S3 ( 3*32+30) /* TSC doesn't stop in S3 state */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -329,29 +329,6 @@ struct fpu {
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
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -142,8 +142,7 @@ u32 init_pkru_value = PKRU_AD_KEY( 1) |
  * Called from the FPU code when creating a fresh set of FPU
  * registers.  This is called from a very specific context where
  * we know the FPU regstiers are safe for use and we can use PKRU
- * directly.  The fact that PKRU is only available when we are
- * using eagerfpu mode makes this possible.
+ * directly.
  */
 void copy_init_pkru_to_fpregs(void)
 {
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -104,7 +104,6 @@
 #define X86_FEATURE_EXTD_APICID	( 3*32+26) /* has extended APICID (8 bits) */
 #define X86_FEATURE_AMD_DCM     ( 3*32+27) /* multi-node processor */
 #define X86_FEATURE_APERFMPERF	( 3*32+28) /* APERFMPERF */
-#define X86_FEATURE_EAGER_FPU	( 3*32+29) /* "eagerfpu" Non lazy FPU restore */
 #define X86_FEATURE_NONSTOP_TSC_S3 ( 3*32+30) /* TSC doesn't stop in S3 state */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */


