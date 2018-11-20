Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAC6C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3575C213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3575C213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbeKTSn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:43:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45177 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeKTSn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:43:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAK8F4Rq2908776
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Nov 2018 00:15:04 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAK8F3OH2908773;
        Tue, 20 Nov 2018 00:15:03 -0800
Date:   Tue, 20 Nov 2018 00:15:03 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-dae0a10593007d049ea71601357ac41d4f247ee9@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, brgerst@gmail.com, hpa@zytor.com,
        tglx@linutronix.de, dave.hansen@linux.intel.com,
        luto@amacapital.net, yu-cheng.yu@intel.com, luto@kernel.org,
        riel@surriel.com, torvalds@linux-foundation.org,
        dvlasenk@redhat.com, bp@alien8.de, peterz@infradead.org,
        mingo@kernel.org
Reply-To: bp@alien8.de, peterz@infradead.org, mingo@kernel.org,
          yu-cheng.yu@intel.com, riel@surriel.com, luto@kernel.org,
          luto@amacapital.net, torvalds@linux-foundation.org,
          dvlasenk@redhat.com, tglx@linutronix.de,
          dave.hansen@linux.intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, brgerst@gmail.com
In-Reply-To: <fe93332eded3d702f0b0b4cf83928d6830739ba3.1542667307.git.luto@kernel.org>
References: <fe93332eded3d702f0b0b4cf83928d6830739ba3.1542667307.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/cpufeatures, x86/fault: Mark SMAP as disabled when
 configured out
Git-Commit-ID: dae0a10593007d049ea71601357ac41d4f247ee9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  dae0a10593007d049ea71601357ac41d4f247ee9
Gitweb:     https://git.kernel.org/tip/dae0a10593007d049ea71601357ac41d4f247ee9
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Mon, 19 Nov 2018 14:45:27 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Nov 2018 08:44:28 +0100

x86/cpufeatures, x86/fault: Mark SMAP as disabled when configured out

Add X86_FEATURE_SMAP to the disabled features mask as appropriate
and use cpu_feature_enabled() in the fault code.  This lets us get
rid of a redundant IS_ENABLED(CONFIG_X86_SMAP).

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/fe93332eded3d702f0b0b4cf83928d6830739ba3.1542667307.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/disabled-features.h | 8 +++++++-
 arch/x86/mm/fault.c                      | 5 +----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 33833d1909af..a5ea841cc6d2 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -16,6 +16,12 @@
 # define DISABLE_MPX	(1<<(X86_FEATURE_MPX & 31))
 #endif
 
+#ifdef CONFIG_X86_SMAP
+# define DISABLE_SMAP	0
+#else
+# define DISABLE_SMAP	(1<<(X86_FEATURE_SMAP & 31))
+#endif
+
 #ifdef CONFIG_X86_INTEL_UMIP
 # define DISABLE_UMIP	0
 #else
@@ -68,7 +74,7 @@
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
 #define DISABLED_MASK8	0
-#define DISABLED_MASK9	(DISABLE_MPX)
+#define DISABLED_MASK9	(DISABLE_MPX|DISABLE_SMAP)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	0
 #define DISABLED_MASK12	0
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 8624cb7d8d65..39e39cd42097 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1150,10 +1150,7 @@ static int fault_in_kernel_space(unsigned long address)
 
 static inline bool smap_violation(int error_code, struct pt_regs *regs)
 {
-	if (!IS_ENABLED(CONFIG_X86_SMAP))
-		return false;
-
-	if (!static_cpu_has(X86_FEATURE_SMAP))
+	if (!cpu_feature_enabled(X86_FEATURE_SMAP))
 		return false;
 
 	if (error_code & X86_PF_USER)
