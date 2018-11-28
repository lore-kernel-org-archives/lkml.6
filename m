Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52730C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140242081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140242081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeK2Bac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:30:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57761 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2Bac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:30:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASERrvG2323159
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:27:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASERqnl2323156;
        Wed, 28 Nov 2018 06:27:52 -0800
Date:   Wed, 28 Nov 2018 06:27:52 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-8770709f411763884535662744a3786a1806afd3@git.kernel.org>
Cc:     longman9394@gmail.com, tglx@linutronix.de, hpa@zytor.com,
        luto@kernel.org, jkosina@suse.cz, mingo@kernel.org,
        ak@linux.intel.com, casey.schaufler@intel.com,
        keescook@chromium.org, peterz@infradead.org,
        gregkh@linuxfoundation.org, dave.hansen@intel.com,
        arjan@linux.intel.com, dwmw@amazon.co.uk,
        torvalds@linux-foundation.org, thomas.lendacky@amd.com,
        david.c.stewart@intel.com, jpoimboe@redhat.com, jcm@redhat.com,
        linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com,
        asit.k.mallick@intel.com, aarcange@redhat.com
Reply-To: dave.hansen@intel.com, arjan@linux.intel.com,
          torvalds@linux-foundation.org, dwmw@amazon.co.uk,
          jpoimboe@redhat.com, thomas.lendacky@amd.com,
          david.c.stewart@intel.com, jcm@redhat.com,
          linux-kernel@vger.kernel.org, aarcange@redhat.com,
          asit.k.mallick@intel.com, tim.c.chen@linux.intel.com,
          longman9394@gmail.com, tglx@linutronix.de, luto@kernel.org,
          jkosina@suse.cz, hpa@zytor.com, mingo@kernel.org,
          ak@linux.intel.com, keescook@chromium.org,
          casey.schaufler@intel.com, peterz@infradead.org,
          gregkh@linuxfoundation.org
In-Reply-To: <20181125185004.800018931@linutronix.de>
References: <20181125185004.800018931@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Mark string arrays const correctly
Git-Commit-ID: 8770709f411763884535662744a3786a1806afd3
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

Commit-ID:  8770709f411763884535662744a3786a1806afd3
Gitweb:     https://git.kernel.org/tip/8770709f411763884535662744a3786a1806afd3
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:42 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:09 +0100

x86/speculation: Mark string arrays const correctly

checkpatch.pl muttered when reshuffling the code:
 WARNING: static const char * array should probably be static const char * const

Fix up all the string arrays.

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
Link: https://lkml.kernel.org/r/20181125185004.800018931@linutronix.de

---
 arch/x86/kernel/cpu/bugs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c9542b9fb329..4fcbccb16200 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -237,7 +237,7 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_RETPOLINE_AMD,
 };
 
-static const char *spectre_v2_strings[] = {
+static const char * const spectre_v2_strings[] = {
 	[SPECTRE_V2_NONE]			= "Vulnerable",
 	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
 	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
@@ -476,7 +476,7 @@ enum ssb_mitigation_cmd {
 	SPEC_STORE_BYPASS_CMD_SECCOMP,
 };
 
-static const char *ssb_strings[] = {
+static const char * const ssb_strings[] = {
 	[SPEC_STORE_BYPASS_NONE]	= "Vulnerable",
 	[SPEC_STORE_BYPASS_DISABLE]	= "Mitigation: Speculative Store Bypass disabled",
 	[SPEC_STORE_BYPASS_PRCTL]	= "Mitigation: Speculative Store Bypass disabled via prctl",
@@ -816,7 +816,7 @@ early_param("l1tf", l1tf_cmdline);
 #define L1TF_DEFAULT_MSG "Mitigation: PTE Inversion"
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
-static const char *l1tf_vmx_states[] = {
+static const char * const l1tf_vmx_states[] = {
 	[VMENTER_L1D_FLUSH_AUTO]		= "auto",
 	[VMENTER_L1D_FLUSH_NEVER]		= "vulnerable",
 	[VMENTER_L1D_FLUSH_COND]		= "conditional cache flushes",
