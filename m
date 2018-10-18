Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD89ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628132148E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXCfB4Um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628132148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbeJSCIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730527AbeJSCIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:08:49 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B902145D;
        Thu, 18 Oct 2018 18:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539886001;
        bh=4QjTu785IKyz92oRLB1jq63SfS4erv9UBWdVH88lVh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXCfB4Umq+ZibCU5ty0SzdIbua82B8wTjNSYeNGhlTZj+x/ms4H3VB4lk2kyEsKNo
         LsZTXYtZjupTYzJb2XZoQTp2oeOM3Fs5xucy6ekEU3uB2brOlVpLNhkbniMpqEN/WU
         CKH8k41P05JygGo1S7mmtsL4As37Srihos4SdxRs=
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
Subject: [PATCH 4.4 34/48] x86/fpu: Finish excising eagerfpu
Date:   Thu, 18 Oct 2018 19:55:09 +0200
Message-Id: <20181018175429.764997534@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/kernel-parameters.txt |    5 -----
 arch/x86/include/asm/cpufeatures.h  |    1 -
 arch/x86/include/asm/fpu/types.h    |   23 -----------------------
 3 files changed, 29 deletions(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -961,11 +961,6 @@ bytes respectively. Such letter suffixes
 			See Documentation/x86/intel_mpx.txt for more
 			information about the feature.
 
-	eagerfpu=	[X86]
-			on	enable eager fpu restore
-			off	disable eager fpu restore
-			auto	selects the default scheme, which automatically
-				enables eagerfpu restore for xsaveopt.
 
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


