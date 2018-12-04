Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43F7C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B192087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1sN05bc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B192087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeLDLFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbeLDLE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:04:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D28D2214E0;
        Tue,  4 Dec 2018 11:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921495;
        bh=0XYWsjQz9vb1AcC9e83xM9RJilVnVnvrU2zuHajHUrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n1sN05bcDPC7LQqJT6pP/kArJVvkC/dpvcRr6wn3h5yIV3yRc7OWw3Nk86IoMjxDm
         0/EiOC1W6BHJbxDdSGcY8mKMf15Ef/Gx32ZGmutJMyOqnyab2Hrt0zcXnuHPV8lD6N
         LCXqvLhTSqOz0zf4O3/vfgd9dY3qTKdJeRSN/zc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.14 092/146] x86/speculation: Reorder the spec_v2 code
Date:   Tue,  4 Dec 2018 11:49:38 +0100
Message-Id: <20181204103730.532895585@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner tglx@linutronix.de

commit 15d6b7aab0793b2de8a05d8a828777dd24db424e upstream

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |  168 ++++++++++++++++++++++-----------------------
 1 file changed, 84 insertions(+), 84 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -123,29 +123,6 @@ void __init check_bugs(void)
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
@@ -215,6 +192,12 @@ static void x86_amd_ssb_disable(void)
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
 
@@ -236,18 +219,6 @@ static inline const char *spectre_v2_mod
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
@@ -255,24 +226,53 @@ static inline bool match_option(const ch
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
@@ -315,48 +315,6 @@ static enum spectre_v2_mitigation_cmd __
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
@@ -459,6 +417,48 @@ specv2_set_mode:
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
 


