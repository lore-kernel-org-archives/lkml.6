Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA39C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F9A2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F9A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeK2BkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:40:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36443 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeK2BkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:40:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEaXGt2324758
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:36:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEaXHv2324755;
        Wed, 28 Nov 2018 06:36:33 -0800
Date:   Wed, 28 Nov 2018 06:36:33 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-55a974021ec952ee460dc31ca08722158639de72@git.kernel.org>
Cc:     jpoimboe@redhat.com, david.c.stewart@intel.com,
        aarcange@redhat.com, peterz@infradead.org,
        tim.c.chen@linux.intel.com, dwmw@amazon.co.uk,
        casey.schaufler@intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        keescook@chromium.org, arjan@linux.intel.com,
        longman9394@gmail.com, thomas.lendacky@amd.com, tglx@linutronix.de,
        luto@kernel.org, hpa@zytor.com, jcm@redhat.com,
        asit.k.mallick@intel.com, mingo@kernel.org, dave.hansen@intel.com,
        ak@linux.intel.com, jkosina@suse.cz
Reply-To: david.c.stewart@intel.com, jpoimboe@redhat.com,
          aarcange@redhat.com, peterz@infradead.org,
          tim.c.chen@linux.intel.com, dwmw@amazon.co.uk,
          casey.schaufler@intel.com, gregkh@linuxfoundation.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          keescook@chromium.org, thomas.lendacky@amd.com,
          arjan@linux.intel.com, longman9394@gmail.com, tglx@linutronix.de,
          luto@kernel.org, hpa@zytor.com, jcm@redhat.com, mingo@kernel.org,
          dave.hansen@intel.com, asit.k.mallick@intel.com, jkosina@suse.cz,
          ak@linux.intel.com
In-Reply-To: <20181125185006.144047038@linutronix.de>
References: <20181125185006.144047038@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Provide IBPB always command line
 options
Git-Commit-ID: 55a974021ec952ee460dc31ca08722158639de72
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

Commit-ID:  55a974021ec952ee460dc31ca08722158639de72
Gitweb:     https://git.kernel.org/tip/55a974021ec952ee460dc31ca08722158639de72
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:56 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:14 +0100

x86/speculation: Provide IBPB always command line options

Provide the possibility to enable IBPB always in combination with 'prctl'
and 'seccomp'.

Add the extra command line options and rework the IBPB selection to
evaluate the command instead of the mode selected by the STIPB switch case.

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
Link: https://lkml.kernel.org/r/20181125185006.144047038@linutronix.de

---
 Documentation/admin-guide/kernel-parameters.txt | 12 +++++++++
 arch/x86/kernel/cpu/bugs.c                      | 34 +++++++++++++++++--------
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f405281bb202..05a252e5178d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4241,11 +4241,23 @@
 				  per thread.  The mitigation control state
 				  is inherited on fork.
 
+			prctl,ibpb
+				- Like "prctl" above, but only STIBP is
+				  controlled per thread. IBPB is issued
+				  always when switching between different user
+				  space processes.
+
 			seccomp
 				- Same as "prctl" above, but all seccomp
 				  threads will enable the mitigation unless
 				  they explicitly opt out.
 
+			seccomp,ibpb
+				- Like "seccomp" above, but only STIBP is
+				  controlled per thread. IBPB is issued
+				  always when switching between different
+				  user space processes.
+
 			auto    - Kernel selects the mitigation depending on
 				  the available CPU features and vulnerability.
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c9e304960534..500278f5308e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -256,7 +256,9 @@ enum spectre_v2_user_cmd {
 	SPECTRE_V2_USER_CMD_AUTO,
 	SPECTRE_V2_USER_CMD_FORCE,
 	SPECTRE_V2_USER_CMD_PRCTL,
+	SPECTRE_V2_USER_CMD_PRCTL_IBPB,
 	SPECTRE_V2_USER_CMD_SECCOMP,
+	SPECTRE_V2_USER_CMD_SECCOMP_IBPB,
 };
 
 static const char * const spectre_v2_user_strings[] = {
@@ -271,11 +273,13 @@ static const struct {
 	enum spectre_v2_user_cmd	cmd;
 	bool				secure;
 } v2_user_options[] __initdata = {
-	{ "auto",	SPECTRE_V2_USER_CMD_AUTO,	false },
-	{ "off",	SPECTRE_V2_USER_CMD_NONE,	false },
-	{ "on",		SPECTRE_V2_USER_CMD_FORCE,	true  },
-	{ "prctl",	SPECTRE_V2_USER_CMD_PRCTL,	false },
-	{ "seccomp",	SPECTRE_V2_USER_CMD_SECCOMP,	false },
+	{ "auto",		SPECTRE_V2_USER_CMD_AUTO,		false },
+	{ "off",		SPECTRE_V2_USER_CMD_NONE,		false },
+	{ "on",			SPECTRE_V2_USER_CMD_FORCE,		true  },
+	{ "prctl",		SPECTRE_V2_USER_CMD_PRCTL,		false },
+	{ "prctl,ibpb",		SPECTRE_V2_USER_CMD_PRCTL_IBPB,		false },
+	{ "seccomp",		SPECTRE_V2_USER_CMD_SECCOMP,		false },
+	{ "seccomp,ibpb",	SPECTRE_V2_USER_CMD_SECCOMP_IBPB,	false },
 };
 
 static void __init spec_v2_user_print_cond(const char *reason, bool secure)
@@ -321,6 +325,7 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 {
 	enum spectre_v2_user_mitigation mode = SPECTRE_V2_USER_NONE;
 	bool smt_possible = IS_ENABLED(CONFIG_SMP);
+	enum spectre_v2_user_cmd cmd;
 
 	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
 		return;
@@ -329,17 +334,20 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 	    cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
 		smt_possible = false;
 
-	switch (spectre_v2_parse_user_cmdline(v2_cmd)) {
+	cmd = spectre_v2_parse_user_cmdline(v2_cmd);
+	switch (cmd) {
 	case SPECTRE_V2_USER_CMD_NONE:
 		goto set_mode;
 	case SPECTRE_V2_USER_CMD_FORCE:
 		mode = SPECTRE_V2_USER_STRICT;
 		break;
 	case SPECTRE_V2_USER_CMD_PRCTL:
+	case SPECTRE_V2_USER_CMD_PRCTL_IBPB:
 		mode = SPECTRE_V2_USER_PRCTL;
 		break;
 	case SPECTRE_V2_USER_CMD_AUTO:
 	case SPECTRE_V2_USER_CMD_SECCOMP:
+	case SPECTRE_V2_USER_CMD_SECCOMP_IBPB:
 		if (IS_ENABLED(CONFIG_SECCOMP))
 			mode = SPECTRE_V2_USER_SECCOMP;
 		else
@@ -351,12 +359,15 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
 
-		switch (mode) {
-		case SPECTRE_V2_USER_STRICT:
+		switch (cmd) {
+		case SPECTRE_V2_USER_CMD_FORCE:
+		case SPECTRE_V2_USER_CMD_PRCTL_IBPB:
+		case SPECTRE_V2_USER_CMD_SECCOMP_IBPB:
 			static_branch_enable(&switch_mm_always_ibpb);
 			break;
-		case SPECTRE_V2_USER_PRCTL:
-		case SPECTRE_V2_USER_SECCOMP:
+		case SPECTRE_V2_USER_CMD_PRCTL:
+		case SPECTRE_V2_USER_CMD_AUTO:
+		case SPECTRE_V2_USER_CMD_SECCOMP:
 			static_branch_enable(&switch_mm_cond_ibpb);
 			break;
 		default:
@@ -364,7 +375,8 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 		}
 
 		pr_info("mitigation: Enabling %s Indirect Branch Prediction Barrier\n",
-			mode == SPECTRE_V2_USER_STRICT ? "always-on" : "conditional");
+			static_key_enabled(&switch_mm_always_ibpb) ?
+			"always-on" : "conditional");
 	}
 
 	/* If enhanced IBRS is enabled no STIPB required */
