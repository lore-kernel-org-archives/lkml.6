Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526937640-2-16218778167457627152
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937639; b=ERQHD69U6ZLekCtMk7isslXQHlaDiQuirPiOwzIgdrdqyzc50/
    EtIUamscADs7vDjjjHuC2G7/DaCsu6hWI4loECY3+FOgRaf8HawTshuuAoPS7hh/
    y/4sjK1gi57NcjRHuMg55qlv/eL6I0+OjMrPvU6NnOXzj6kUNV3KKcjmzA+hPaKI
    zvDexvP09vXwAHt3loF5V+VzCvOMhwtjtiJzv2sMAUYOb23oHYTPiUSYf5XyRiYQ
    mgajv1YpbvHlzPIOTmDTDH3XOwJYL6uh4vm/7jqjksg7Jciw5Q+D9QqfjQiC4eUC
    V8woYtbaRqzn2QL3Txhm8K5r+VnZ8XaWWF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937639; bh=KSlD/uNyjqAzzo8oY2qRSOqikWu9wH
    EESWtda07GWk4=; b=HdM2cMQ40GRAvYAtVU0Onwa6pCVPNhDsUuWs8yprq/PYQS
    1IkiCDMxM56zwu5CyAtMBp1LIVSFA/XpzXc4rS0KNSBps2rQXtt6JFPur+tP40oR
    MA8Bq3BO2T1e9mvwtid4HcfMhgVRVGXFsgLq7c1PeXuUaM9Lu1tGmLf23ACJMWaP
    QD+TFvhDEHZcNTvC1BZy3099/uZ/ouswVg1GfJtMHRTWeMwrLeJWqlIqpD9ELFTb
    x8vqQN6xMXtwxA3mX+8VVctF/351SNUjJQeD0NZkswjM20ZQXi2GiIscf+PQ6sme
    rtWnmvRKMNHf2q5BQXWRpoLwSwAsupE0hUXGlhCA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=V5dlTzJI x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=V5dlTzJI x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEaqohUZxe/eZnE2zYpMG4O1FuZEQKHbJFtg75OJUoGWx8CBS7VsRm31/flIXP5X+ZRqDIx4VbDb+K8myvYAv8lGBfw5N4Do7Czk3X41P2246ZkPKDyr
    AvLF20IqJvRJORzuEK8U7HSYkyG6UReOYGwR2ZACny6ku+1Zu78v1elXAMp3ss+eXO37NtHTwePtn2BKasEwtH07ZF3JSr80LY7srqDglIe7RuJwFlF8IfCz
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=ag1SF4gXAAAA:8 a=egPMTCwtXMhYOTT4dCAA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753925AbeEUVUe (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753923AbeEUVUc (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:20:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.14 63/95] x86/speculation: Add prctl for Speculative Store Bypass mitigation
Date: Mon, 21 May 2018 23:11:53 +0200
Message-Id: <20180521210459.354504475@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit a73ec77ee17ec556fe7f165d00314cb7c047b1ac upstream

Add prctl based control for Speculative Store Bypass mitigation and make it
the default mitigation for Intel and AMD.

Andi Kleen provided the following rationale (slightly redacted):

 There are multiple levels of impact of Speculative Store Bypass:

 1) JITed sandbox.
    It cannot invoke system calls, but can do PRIME+PROBE and may have call
    interfaces to other code

 2) Native code process.
    No protection inside the process at this level.

 3) Kernel.

 4) Between processes.

 The prctl tries to protect against case (1) doing attacks.

 If the untrusted code can do random system calls then control is already
 lost in a much worse way. So there needs to be system call protection in
 some way (using a JIT not allowing them or seccomp). Or rather if the
 process can subvert its environment somehow to do the prctl it can already
 execute arbitrary code, which is much worse than SSB.

 To put it differently, the point of the prctl is to not allow JITed code
 to read data it shouldn't read from its JITed sandbox. If it already has
 escaped its sandbox then it can already read everything it wants in its
 address space, and do much worse.

 The ability to control Speculative Store Bypass allows to enable the
 protection selectively without affecting overall system performance.

Based on an initial patch from Tim Chen. Completely rewritten.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/kernel-parameters.txt |    6 +
 arch/x86/include/asm/nospec-branch.h            |    1 
 arch/x86/kernel/cpu/bugs.c                      |   83 +++++++++++++++++++++---
 3 files changed, 79 insertions(+), 11 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3958,7 +3958,11 @@
 			off    - Unconditionally enable Speculative Store Bypass
 			auto   - Kernel detects whether the CPU model contains an
 				 implementation of Speculative Store Bypass and
-				 picks the most appropriate mitigation
+				 picks the most appropriate mitigation.
+			prctl  - Control Speculative Store Bypass per thread
+				 via prctl. Speculative Store Bypass is enabled
+				 for a process by default. The state of the control
+				 is inherited on fork.
 
 			Not specifying this option is equivalent to
 			spec_store_bypass_disable=auto.
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -232,6 +232,7 @@ extern u64 x86_spec_ctrl_get_default(voi
 enum ssb_mitigation {
 	SPEC_STORE_BYPASS_NONE,
 	SPEC_STORE_BYPASS_DISABLE,
+	SPEC_STORE_BYPASS_PRCTL,
 };
 
 extern char __indirect_thunk_start[];
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -12,6 +12,8 @@
 #include <linux/utsname.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/nospec.h>
+#include <linux/prctl.h>
 
 #include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
@@ -412,20 +414,23 @@ enum ssb_mitigation_cmd {
 	SPEC_STORE_BYPASS_CMD_NONE,
 	SPEC_STORE_BYPASS_CMD_AUTO,
 	SPEC_STORE_BYPASS_CMD_ON,
+	SPEC_STORE_BYPASS_CMD_PRCTL,
 };
 
 static const char *ssb_strings[] = {
 	[SPEC_STORE_BYPASS_NONE]	= "Vulnerable",
-	[SPEC_STORE_BYPASS_DISABLE]	= "Mitigation: Speculative Store Bypass disabled"
+	[SPEC_STORE_BYPASS_DISABLE]	= "Mitigation: Speculative Store Bypass disabled",
+	[SPEC_STORE_BYPASS_PRCTL]	= "Mitigation: Speculative Store Bypass disabled via prctl"
 };
 
 static const struct {
 	const char *option;
 	enum ssb_mitigation_cmd cmd;
 } ssb_mitigation_options[] = {
-	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO }, /* Platform decides */
-	{ "on",		SPEC_STORE_BYPASS_CMD_ON },   /* Disable Speculative Store Bypass */
-	{ "off",	SPEC_STORE_BYPASS_CMD_NONE }, /* Don't touch Speculative Store Bypass */
+	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO },  /* Platform decides */
+	{ "on",		SPEC_STORE_BYPASS_CMD_ON },    /* Disable Speculative Store Bypass */
+	{ "off",	SPEC_STORE_BYPASS_CMD_NONE },  /* Don't touch Speculative Store Bypass */
+	{ "prctl",	SPEC_STORE_BYPASS_CMD_PRCTL }, /* Disable Speculative Store Bypass via prctl */
 };
 
 static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
@@ -475,14 +480,15 @@ static enum ssb_mitigation_cmd __init __
 
 	switch (cmd) {
 	case SPEC_STORE_BYPASS_CMD_AUTO:
-		/*
-		 * AMD platforms by default don't need SSB mitigation.
-		 */
-		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
-			break;
+		/* Choose prctl as the default mode */
+		mode = SPEC_STORE_BYPASS_PRCTL;
+		break;
 	case SPEC_STORE_BYPASS_CMD_ON:
 		mode = SPEC_STORE_BYPASS_DISABLE;
 		break;
+	case SPEC_STORE_BYPASS_CMD_PRCTL:
+		mode = SPEC_STORE_BYPASS_PRCTL;
+		break;
 	case SPEC_STORE_BYPASS_CMD_NONE:
 		break;
 	}
@@ -493,7 +499,7 @@ static enum ssb_mitigation_cmd __init __
 	 *  - X86_FEATURE_RDS - CPU is able to turn off speculative store bypass
 	 *  - X86_FEATURE_SPEC_STORE_BYPASS_DISABLE - engage the mitigation
 	 */
-	if (mode != SPEC_STORE_BYPASS_NONE) {
+	if (mode == SPEC_STORE_BYPASS_DISABLE) {
 		setup_force_cpu_cap(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE);
 		/*
 		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD uses
@@ -524,6 +530,63 @@ static void ssb_select_mitigation()
 
 #undef pr_fmt
 
+static int ssb_prctl_set(unsigned long ctrl)
+{
+	bool rds = !!test_tsk_thread_flag(current, TIF_RDS);
+
+	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL)
+		return -ENXIO;
+
+	if (ctrl == PR_SPEC_ENABLE)
+		clear_tsk_thread_flag(current, TIF_RDS);
+	else
+		set_tsk_thread_flag(current, TIF_RDS);
+
+	if (rds != !!test_tsk_thread_flag(current, TIF_RDS))
+		speculative_store_bypass_update();
+
+	return 0;
+}
+
+static int ssb_prctl_get(void)
+{
+	switch (ssb_mode) {
+	case SPEC_STORE_BYPASS_DISABLE:
+		return PR_SPEC_DISABLE;
+	case SPEC_STORE_BYPASS_PRCTL:
+		if (test_tsk_thread_flag(current, TIF_RDS))
+			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
+		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
+	default:
+		if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
+			return PR_SPEC_ENABLE;
+		return PR_SPEC_NOT_AFFECTED;
+	}
+}
+
+int arch_prctl_spec_ctrl_set(unsigned long which, unsigned long ctrl)
+{
+	if (ctrl != PR_SPEC_ENABLE && ctrl != PR_SPEC_DISABLE)
+		return -ERANGE;
+
+	switch (which) {
+	case PR_SPEC_STORE_BYPASS:
+		return ssb_prctl_set(ctrl);
+	default:
+		return -ENODEV;
+	}
+}
+
+int arch_prctl_spec_ctrl_get(unsigned long which)
+{
+	switch (which) {
+	case PR_SPEC_STORE_BYPASS:
+		return ssb_prctl_get();
+	default:
+		return -ENODEV;
+	}
+}
+
 void x86_spec_ctrl_setup_ap(void)
 {
 	if (boot_cpu_has(X86_FEATURE_IBRS))
