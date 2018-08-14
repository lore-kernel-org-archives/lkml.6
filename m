Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D595DC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9764621738
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9764621738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391335AbeHNUgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:36:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32974 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390567AbeHNUgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:36:35 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3CA54C74;
        Tue, 14 Aug 2018 17:48:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 43/43] x86/speculation/l1tf: Fix up CPU feature flags
Date:   Tue, 14 Aug 2018 19:18:19 +0200
Message-Id: <20180814171519.886415475@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171517.014285600@linuxfoundation.org>
References: <20180814171517.014285600@linuxfoundation.org>
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

From: Guenter Roeck <linux@roeck-us.net>

In linux-4.4.y, the definition of X86_FEATURE_RETPOLINE and
X86_FEATURE_RETPOLINE_AMD is different from the upstream
definition. Result is an overlap with the newly introduced
X86_FEATURE_L1TF_PTEINV. Update RETPOLINE definitions to match
upstream definitions to improve alignment with upstream code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -193,12 +193,12 @@
 #define X86_FEATURE_HW_PSTATE	( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK ( 7*32+ 9) /* AMD ProcFeedbackInterface */
 
+#define X86_FEATURE_RETPOLINE	( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
+#define X86_FEATURE_RETPOLINE_AMD ( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
+
 #define X86_FEATURE_INTEL_PT	( 7*32+15) /* Intel Processor Trace */
 #define X86_FEATURE_RSB_CTXSW	( 7*32+19) /* "" Fill RSB on context switches */
 
-#define X86_FEATURE_RETPOLINE	( 7*32+29) /* "" Generic Retpoline mitigation for Spectre variant 2 */
-#define X86_FEATURE_RETPOLINE_AMD ( 7*32+30) /* "" AMD Retpoline mitigation for Spectre variant 2 */
-
 #define X86_FEATURE_MSR_SPEC_CTRL ( 7*32+16) /* "" MSR SPEC_CTRL is implemented */
 #define X86_FEATURE_SSBD	( 7*32+17) /* Speculative Store Bypass Disable */
 


