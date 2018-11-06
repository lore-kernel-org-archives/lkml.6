Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AD2C46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27B6206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27B6206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbeKGGRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:17:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37041 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeKGGQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:16:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6KnTBN951442
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 12:49:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6KnT6s951439;
        Tue, 6 Nov 2018 12:49:29 -0800
Date:   Tue, 6 Nov 2018 12:49:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhenzhong Duan <tipbot@zytor.com>
Message-ID: <tip-aa0bb5a223720948bdd54d4c7bd48b147502e214@git.kernel.org>
Cc:     mingo@kernel.org, dwmw@amazon.co.uk, bp@suse.de,
        peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, zhenzhong.duan@oracle.com,
        konrad.wilk@oracle.com, srinivas.eeda@oracle.com
Reply-To: bp@suse.de, mingo@kernel.org, dwmw@amazon.co.uk,
          peterz@infradead.org, srinivas.eeda@oracle.com,
          linux-kernel@vger.kernel.org, zhenzhong.duan@oracle.com,
          tglx@linutronix.de, hpa@zytor.com, konrad.wilk@oracle.com
In-Reply-To: <f06f0a89-5587-45db-8ed2-0a9d6638d5c0@default>
References: <f06f0a89-5587-45db-8ed2-0a9d6638d5c0@default>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/retpoline: Remove minimal retpoline support
Git-Commit-ID: aa0bb5a223720948bdd54d4c7bd48b147502e214
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

Commit-ID:  aa0bb5a223720948bdd54d4c7bd48b147502e214
Gitweb:     https://git.kernel.org/tip/aa0bb5a223720948bdd54d4c7bd48b147502e214
Author:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
AuthorDate: Fri, 2 Nov 2018 01:45:41 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 6 Nov 2018 21:46:20 +0100

x86/retpoline: Remove minimal retpoline support

Now that CONFIG_RETPOLINE hard depends on compiler support, there is no
reason to keep the minimal retpoline support around which only provided
basic protection in the assembly files.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Borislav Petkov <bp@suse.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: <srinivas.eeda@oracle.com>
Link: https://lkml.kernel.org/r/f06f0a89-5587-45db-8ed2-0a9d6638d5c0@default

---
 arch/x86/include/asm/nospec-branch.h |  2 --
 arch/x86/kernel/cpu/bugs.c           | 13 ++-----------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 8b09cbb2d52c..c202a64edd95 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -221,8 +221,6 @@
 /* The Spectre V2 mitigation variants */
 enum spectre_v2_mitigation {
 	SPECTRE_V2_NONE,
-	SPECTRE_V2_RETPOLINE_MINIMAL,
-	SPECTRE_V2_RETPOLINE_MINIMAL_AMD,
 	SPECTRE_V2_RETPOLINE_GENERIC,
 	SPECTRE_V2_RETPOLINE_AMD,
 	SPECTRE_V2_IBRS_ENHANCED,
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d0108fb6e4dd..7f6d8159398e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -135,8 +135,6 @@ enum spectre_v2_mitigation_cmd {
 
 static const char *spectre_v2_strings[] = {
 	[SPECTRE_V2_NONE]			= "Vulnerable",
-	[SPECTRE_V2_RETPOLINE_MINIMAL]		= "Vulnerable: Minimal generic ASM retpoline",
-	[SPECTRE_V2_RETPOLINE_MINIMAL_AMD]	= "Vulnerable: Minimal AMD ASM retpoline",
 	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
 	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
 	[SPECTRE_V2_IBRS_ENHANCED]		= "Mitigation: Enhanced IBRS",
@@ -250,11 +248,6 @@ static void __init spec2_print_if_secure(const char *reason)
 		pr_info("%s selected on command line.\n", reason);
 }
 
-static inline bool retp_compiler(void)
-{
-	return __is_defined(CONFIG_RETPOLINE);
-}
-
 static inline bool match_option(const char *arg, int arglen, const char *opt)
 {
 	int len = strlen(opt);
@@ -417,14 +410,12 @@ retpoline_auto:
 			pr_err("Spectre mitigation: LFENCE not serializing, switching to generic retpoline\n");
 			goto retpoline_generic;
 		}
-		mode = retp_compiler() ? SPECTRE_V2_RETPOLINE_AMD :
-					 SPECTRE_V2_RETPOLINE_MINIMAL_AMD;
+		mode = SPECTRE_V2_RETPOLINE_AMD;
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE_AMD);
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 	} else {
 	retpoline_generic:
-		mode = retp_compiler() ? SPECTRE_V2_RETPOLINE_GENERIC :
-					 SPECTRE_V2_RETPOLINE_MINIMAL;
+		mode = SPECTRE_V2_RETPOLINE_GENERIC;
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 	}
 
