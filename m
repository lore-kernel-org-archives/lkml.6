Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288FDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3742081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3742081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbeK2Bdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:33:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47405 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2Bdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:33:33 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASERJMv2323059
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:27:19 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASERI582323056;
        Wed, 28 Nov 2018 06:27:18 -0800
Date:   Wed, 28 Nov 2018 06:27:18 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-15d6b7aab0793b2de8a05d8a828777dd24db424e@git.kernel.org>
Cc:     david.c.stewart@intel.com, asit.k.mallick@intel.com,
        tglx@linutronix.de, ak@linux.intel.com, jkosina@suse.cz,
        jpoimboe@redhat.com, mingo@kernel.org, luto@kernel.org,
        tim.c.chen@linux.intel.com, casey.schaufler@intel.com,
        jcm@redhat.com, aarcange@redhat.com, longman9394@gmail.com,
        dave.hansen@intel.com, arjan@linux.intel.com,
        gregkh@linuxfoundation.org, dwmw@amazon.co.uk,
        thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, peterz@infradead.org, torvalds@linux-foundation.org,
        keescook@chromium.org
Reply-To: keescook@chromium.org, peterz@infradead.org,
          torvalds@linux-foundation.org, hpa@zytor.com,
          thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
          dwmw@amazon.co.uk, gregkh@linuxfoundation.org,
          arjan@linux.intel.com, dave.hansen@intel.com,
          longman9394@gmail.com, aarcange@redhat.com, jcm@redhat.com,
          casey.schaufler@intel.com, tim.c.chen@linux.intel.com,
          luto@kernel.org, mingo@kernel.org, ak@linux.intel.com,
          jkosina@suse.cz, jpoimboe@redhat.com, tglx@linutronix.de,
          asit.k.mallick@intel.com, david.c.stewart@intel.com
In-Reply-To: <20181125185004.707122879@linutronix.de>
References: <20181125185004.707122879@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Reorder the spec_v2 code
Git-Commit-ID: 15d6b7aab0793b2de8a05d8a828777dd24db424e
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

Commit-ID:  15d6b7aab0793b2de8a05d8a828777dd24db424e
Gitweb:     https://git.kernel.org/tip/15d6b7aab0793b2de8a05d8a828777dd24db424e
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:41 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:08 +0100

x86/speculation: Reorder the spec_v2 code

Reorder the code so it is better grouped. No functional change.

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
Link: https://lkml.kernel.org/r/20181125185004.707122879@linutronix.de


---
 arch/x86/kernel/cpu/bugs.c | 168 ++++++++++++++++++++++-----------------------
 1 file changed, 84 insertions(+), 84 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2dc4ee2bedcb..c9542b9fb329 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -124,29 +124,6 @@ void __init check_bugs(void)
 #endif
 }
 
-/* The kernel command line selection */
-enum spectre_v2_mitigation_cmd {
-	SPECTRE_V2_CMD_NONE,
-	SPECTRE_V2_CMD_AUTO,
-	SPECTRE_V2_CMD_FORCE,
-	SPECTRE_V2_CMD_RETPOLINE,
-	SPECTRE_V2_CMD_RETPOLINE_GENERIC,
-	SPECTRE_V2_CMD_RETPOLINE_AMD,
-};
-
-static const char *spectre_v2_strings[] = {
-	[SPECTRE_V2_NONE]			= "Vulnerable",
-	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
-	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
-	[SPECTRE_V2_IBRS_ENHANCED]		= "Mitigation: Enhanced IBRS",
-};
-
-#undef pr_fmt
-#define pr_fmt(fmt)     "Spectre V2 : " fmt
-
-static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
-	SPECTRE_V2_NONE;
-
 void
 x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {
@@ -216,6 +193,12 @@ static void x86_amd_ssb_disable(void)
 		wrmsrl(MSR_AMD64_LS_CFG, msrval);
 }
 
+#undef pr_fmt
+#define pr_fmt(fmt)     "Spectre V2 : " fmt
+
+static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
+	SPECTRE_V2_NONE;
+
 #ifdef RETPOLINE
 static bool spectre_v2_bad_module;
 
@@ -237,18 +220,6 @@ static inline const char *spectre_v2_module_string(void)
 static inline const char *spectre_v2_module_string(void) { return ""; }
 #endif
 
-static void __init spec2_print_if_insecure(const char *reason)
-{
-	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
-		pr_info("%s selected on command line.\n", reason);
-}
-
-static void __init spec2_print_if_secure(const char *reason)
-{
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
-		pr_info("%s selected on command line.\n", reason);
-}
-
 static inline bool match_option(const char *arg, int arglen, const char *opt)
 {
 	int len = strlen(opt);
@@ -256,24 +227,53 @@ static inline bool match_option(const char *arg, int arglen, const char *opt)
 	return len == arglen && !strncmp(arg, opt, len);
 }
 
+/* The kernel command line selection for spectre v2 */
+enum spectre_v2_mitigation_cmd {
+	SPECTRE_V2_CMD_NONE,
+	SPECTRE_V2_CMD_AUTO,
+	SPECTRE_V2_CMD_FORCE,
+	SPECTRE_V2_CMD_RETPOLINE,
+	SPECTRE_V2_CMD_RETPOLINE_GENERIC,
+	SPECTRE_V2_CMD_RETPOLINE_AMD,
+};
+
+static const char *spectre_v2_strings[] = {
+	[SPECTRE_V2_NONE]			= "Vulnerable",
+	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
+	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
+	[SPECTRE_V2_IBRS_ENHANCED]		= "Mitigation: Enhanced IBRS",
+};
+
 static const struct {
 	const char *option;
 	enum spectre_v2_mitigation_cmd cmd;
 	bool secure;
 } mitigation_options[] = {
-	{ "off",               SPECTRE_V2_CMD_NONE,              false },
-	{ "on",                SPECTRE_V2_CMD_FORCE,             true },
-	{ "retpoline",         SPECTRE_V2_CMD_RETPOLINE,         false },
-	{ "retpoline,amd",     SPECTRE_V2_CMD_RETPOLINE_AMD,     false },
-	{ "retpoline,generic", SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
-	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
+	{ "off",		SPECTRE_V2_CMD_NONE,		  false },
+	{ "on",			SPECTRE_V2_CMD_FORCE,		  true  },
+	{ "retpoline",		SPECTRE_V2_CMD_RETPOLINE,	  false },
+	{ "retpoline,amd",	SPECTRE_V2_CMD_RETPOLINE_AMD,	  false },
+	{ "retpoline,generic",	SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
+	{ "auto",		SPECTRE_V2_CMD_AUTO,		  false },
 };
 
+static void __init spec2_print_if_insecure(const char *reason)
+{
+	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
+		pr_info("%s selected on command line.\n", reason);
+}
+
+static void __init spec2_print_if_secure(const char *reason)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
+		pr_info("%s selected on command line.\n", reason);
+}
+
 static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 {
+	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_AUTO;
 	char arg[20];
 	int ret, i;
-	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_AUTO;
 
 	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
 		return SPECTRE_V2_CMD_NONE;
@@ -317,48 +317,6 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	return cmd;
 }
 
-static bool stibp_needed(void)
-{
-	if (spectre_v2_enabled == SPECTRE_V2_NONE)
-		return false;
-
-	/* Enhanced IBRS makes using STIBP unnecessary. */
-	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
-		return false;
-
-	if (!boot_cpu_has(X86_FEATURE_STIBP))
-		return false;
-
-	return true;
-}
-
-static void update_stibp_msr(void *info)
-{
-	wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
-}
-
-void arch_smt_update(void)
-{
-	u64 mask;
-
-	if (!stibp_needed())
-		return;
-
-	mutex_lock(&spec_ctrl_mutex);
-
-	mask = x86_spec_ctrl_base & ~SPEC_CTRL_STIBP;
-	if (sched_smt_active())
-		mask |= SPEC_CTRL_STIBP;
-
-	if (mask != x86_spec_ctrl_base) {
-		pr_info("Spectre v2 cross-process SMT mitigation: %s STIBP\n",
-			mask & SPEC_CTRL_STIBP ? "Enabling" : "Disabling");
-		x86_spec_ctrl_base = mask;
-		on_each_cpu(update_stibp_msr, NULL, 1);
-	}
-	mutex_unlock(&spec_ctrl_mutex);
-}
-
 static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
@@ -462,6 +420,48 @@ specv2_set_mode:
 	arch_smt_update();
 }
 
+static bool stibp_needed(void)
+{
+	if (spectre_v2_enabled == SPECTRE_V2_NONE)
+		return false;
+
+	/* Enhanced IBRS makes using STIBP unnecessary. */
+	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
+		return false;
+
+	if (!boot_cpu_has(X86_FEATURE_STIBP))
+		return false;
+
+	return true;
+}
+
+static void update_stibp_msr(void *info)
+{
+	wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+}
+
+void arch_smt_update(void)
+{
+	u64 mask;
+
+	if (!stibp_needed())
+		return;
+
+	mutex_lock(&spec_ctrl_mutex);
+
+	mask = x86_spec_ctrl_base & ~SPEC_CTRL_STIBP;
+	if (sched_smt_active())
+		mask |= SPEC_CTRL_STIBP;
+
+	if (mask != x86_spec_ctrl_base) {
+		pr_info("Spectre v2 cross-process SMT mitigation: %s STIBP\n",
+			mask & SPEC_CTRL_STIBP ? "Enabling" : "Disabling");
+		x86_spec_ctrl_base = mask;
+		on_each_cpu(update_stibp_msr, NULL, 1);
+	}
+	mutex_unlock(&spec_ctrl_mutex);
+}
+
 #undef pr_fmt
 #define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
 
