Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5969C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F462086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F462086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeK2Bch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:32:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52103 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbeK2Bcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:32:36 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASET4EP2323224
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:29:04 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASET3bi2323221;
        Wed, 28 Nov 2018 06:29:03 -0800
Date:   Wed, 28 Nov 2018 06:29:03 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-495d470e9828500e0155027f230449ac5e29c025@git.kernel.org>
Cc:     dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, longman9394@gmail.com, jpoimboe@redhat.com,
        peterz@infradead.org, keescook@chromium.org,
        david.c.stewart@intel.com, hpa@zytor.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        thomas.lendacky@amd.com, arjan@linux.intel.com, dwmw@amazon.co.uk,
        ak@linux.intel.com, jkosina@suse.cz, mingo@kernel.org,
        jcm@redhat.com, tglx@linutronix.de, aarcange@redhat.com,
        asit.k.mallick@intel.com, tim.c.chen@linux.intel.com,
        casey.schaufler@intel.com
Reply-To: ak@linux.intel.com, jkosina@suse.cz, jcm@redhat.com,
          mingo@kernel.org, aarcange@redhat.com, tglx@linutronix.de,
          tim.c.chen@linux.intel.com, asit.k.mallick@intel.com,
          casey.schaufler@intel.com, linux-kernel@vger.kernel.org,
          dave.hansen@intel.com, longman9394@gmail.com,
          jpoimboe@redhat.com, luto@kernel.org, keescook@chromium.org,
          peterz@infradead.org, david.c.stewart@intel.com, hpa@zytor.com,
          gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
          thomas.lendacky@amd.com, arjan@linux.intel.com, dwmw@amazon.co.uk
In-Reply-To: <20181125185004.986890749@linutronix.de>
References: <20181125185004.986890749@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Unify conditional spectre v2 print
 functions
Git-Commit-ID: 495d470e9828500e0155027f230449ac5e29c025
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

Commit-ID:  495d470e9828500e0155027f230449ac5e29c025
Gitweb:     https://git.kernel.org/tip/495d470e9828500e0155027f230449ac5e29c025
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:44 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:09 +0100

x86/speculation: Unify conditional spectre v2 print functions

There is no point in having two functions and a conditional at the call
site.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Casey Schaufler <casey.schaufler@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Waiman Long <longman9394@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Stewart <david.c.stewart@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181125185004.986890749@linutronix.de


---
 arch/x86/kernel/cpu/bugs.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9279cbabe16e..4f5a6319dca6 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -257,15 +257,9 @@ static const struct {
 	{ "auto",		SPECTRE_V2_CMD_AUTO,		  false },
 };
 
-static void __init spec2_print_if_insecure(const char *reason)
+static void __init spec_v2_print_cond(const char *reason, bool secure)
 {
-	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
-		pr_info("%s selected on command line.\n", reason);
-}
-
-static void __init spec2_print_if_secure(const char *reason)
-{
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
+	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) != secure)
 		pr_info("%s selected on command line.\n", reason);
 }
 
@@ -309,11 +303,8 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (mitigation_options[i].secure)
-		spec2_print_if_secure(mitigation_options[i].option);
-	else
-		spec2_print_if_insecure(mitigation_options[i].option);
-
+	spec_v2_print_cond(mitigation_options[i].option,
+			   mitigation_options[i].secure);
 	return cmd;
 }
 
