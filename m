Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526938471-2-7741063341340262467
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
    1526938470; b=LRGbANcthlH2loH0YJqaaw1i25Or1japoEi4NcSxEreI7aexR6
    2QXfnVW3a1ItUQ4snnKBn3TTzcpNHKN2E07Khq1vDjFoo1xK6BQjnpvB4xglskCt
    O+fJG3Ka50FqS91ckEJgAWBxGMSbxFHmGx4/ODPuake0BMEo/xYi1z2BnYQrE1bA
    4dpmpmzeCZAU3wNik9w/PWSivOZsuSKX4PUDwkc40k1u/oaAC3E3DQUsm80MiH1v
    C/ZMNSyFrTij5KSqzr11C6DZHMssPdIB0pvIxHcUOjXfbKJIYocgXRqy+Q3+iJz7
    Dj3CPzrrnPtTmjtswHTfn21EA9rgaGrd+DYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938470; bh=gznkxUDw6eRWRc3wzEpkxO1gNFPP7A
    VgTZFkZIuYjrU=; b=jfyNbEb5IjEn/J6CvFQgQjTzkjuVgUYifxSgXdwy9bDopX
    LS2eIe2mCwR9VOPAtQnS+ZFKYHIkc0EXWERtpjs3ZCFcdBjY8AnTLiJr6c62TmQ+
    kFaW3nyXvOX0rwPPcwWI6K7/UhUtfmkS5mhTHmN21csiOYNdbcipIjoWVoxovOkd
    xPKuuVYNwdAlHihp53CoBGoZOlxgz2UNY3iqNPIlzY8OAdOk0IUw4W8GovsGJvXj
    wLNaMD4cyX6pU8UoSk2u1u0CWUwGFuOrzx2gF0Y7a/SF0oiFf0d6mepr12FunIzs
    9l+zZs7+Jxje5hhyRk8fLkwE/7vySFAwpKPQ8DFQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=HWtliuQb x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=HWtliuQb x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfL9x7sVnW+ot0X4m/9Wv9kUIpuxbO9Ylm22qCdk0SxpUGoUUmh7zB3EcZiDmuO3MY7dc56keF4VMivJg+Frgewtlt3x5fWZ1iqap/mnWszpKdshImB1G
    OYnSYdpt+g8ZBxuVpOwaBwIlUxUOGhG1lK5fuTVbd2SVypmwBPz/rrWsejBXJsrCkFpss+6T4xtrCiIZa+P+qNCTC/QSLE/mpmVvcuHCKsTjhctumtkdyr8e
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=cm27Pg_UAAAA:8 a=ag1SF4gXAAAA:8 a=AbmRykLzv6zd4g4xyXcA:9 a=QEXdDO2ut3YA:10
    a=xmb-EsYY8bH0VWELuYED:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754411AbeEUVZ7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932492AbeEUVZy (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:25:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 086/110] x86/speculation: Make "seccomp" the default mode for Speculative Store Bypass
Date: Mon, 21 May 2018 23:12:23 +0200
Message-Id: <20180521210513.757308335@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit f21b53b20c754021935ea43364dbf53778eeba32 upstream

Unless explicitly opted out of, anything running under seccomp will have
SSB mitigations enabled. Choosing the "prctl" mode will disable this.

[ tglx: Adjusted it to the new arch_seccomp_spec_mitigate() mechanism ]

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/kernel-parameters.txt |   26 ++++++++++++-------
 arch/x86/include/asm/nospec-branch.h            |    1 
 arch/x86/kernel/cpu/bugs.c                      |   32 +++++++++++++++++-------
 3 files changed, 41 insertions(+), 18 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4021,19 +4021,27 @@
 			This parameter controls whether the Speculative Store
 			Bypass optimization is used.
 
-			on     - Unconditionally disable Speculative Store Bypass
-			off    - Unconditionally enable Speculative Store Bypass
-			auto   - Kernel detects whether the CPU model contains an
-				 implementation of Speculative Store Bypass and
-				 picks the most appropriate mitigation.
-			prctl  - Control Speculative Store Bypass per thread
-				 via prctl. Speculative Store Bypass is enabled
-				 for a process by default. The state of the control
-				 is inherited on fork.
+			on      - Unconditionally disable Speculative Store Bypass
+			off     - Unconditionally enable Speculative Store Bypass
+			auto    - Kernel detects whether the CPU model contains an
+				  implementation of Speculative Store Bypass and
+				  picks the most appropriate mitigation. If the
+				  CPU is not vulnerable, "off" is selected. If the
+				  CPU is vulnerable the default mitigation is
+				  architecture and Kconfig dependent. See below.
+			prctl   - Control Speculative Store Bypass per thread
+				  via prctl. Speculative Store Bypass is enabled
+				  for a process by default. The state of the control
+				  is inherited on fork.
+			seccomp - Same as "prctl" above, but all seccomp threads
+				  will disable SSB unless they explicitly opt out.
 
 			Not specifying this option is equivalent to
 			spec_store_bypass_disable=auto.
 
+			Default mitigations:
+			X86:	If CONFIG_SECCOMP=y "seccomp", otherwise "prctl"
+
 	spia_io_base=	[HW,MTD]
 	spia_fio_base=
 	spia_pedr=
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -233,6 +233,7 @@ enum ssb_mitigation {
 	SPEC_STORE_BYPASS_NONE,
 	SPEC_STORE_BYPASS_DISABLE,
 	SPEC_STORE_BYPASS_PRCTL,
+	SPEC_STORE_BYPASS_SECCOMP,
 };
 
 extern char __indirect_thunk_start[];
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -416,22 +416,25 @@ enum ssb_mitigation_cmd {
 	SPEC_STORE_BYPASS_CMD_AUTO,
 	SPEC_STORE_BYPASS_CMD_ON,
 	SPEC_STORE_BYPASS_CMD_PRCTL,
+	SPEC_STORE_BYPASS_CMD_SECCOMP,
 };
 
 static const char *ssb_strings[] = {
 	[SPEC_STORE_BYPASS_NONE]	= "Vulnerable",
 	[SPEC_STORE_BYPASS_DISABLE]	= "Mitigation: Speculative Store Bypass disabled",
-	[SPEC_STORE_BYPASS_PRCTL]	= "Mitigation: Speculative Store Bypass disabled via prctl"
+	[SPEC_STORE_BYPASS_PRCTL]	= "Mitigation: Speculative Store Bypass disabled via prctl",
+	[SPEC_STORE_BYPASS_SECCOMP]	= "Mitigation: Speculative Store Bypass disabled via prctl and seccomp",
 };
 
 static const struct {
 	const char *option;
 	enum ssb_mitigation_cmd cmd;
 } ssb_mitigation_options[] = {
-	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO },  /* Platform decides */
-	{ "on",		SPEC_STORE_BYPASS_CMD_ON },    /* Disable Speculative Store Bypass */
-	{ "off",	SPEC_STORE_BYPASS_CMD_NONE },  /* Don't touch Speculative Store Bypass */
-	{ "prctl",	SPEC_STORE_BYPASS_CMD_PRCTL }, /* Disable Speculative Store Bypass via prctl */
+	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO },    /* Platform decides */
+	{ "on",		SPEC_STORE_BYPASS_CMD_ON },      /* Disable Speculative Store Bypass */
+	{ "off",	SPEC_STORE_BYPASS_CMD_NONE },    /* Don't touch Speculative Store Bypass */
+	{ "prctl",	SPEC_STORE_BYPASS_CMD_PRCTL },   /* Disable Speculative Store Bypass via prctl */
+	{ "seccomp",	SPEC_STORE_BYPASS_CMD_SECCOMP }, /* Disable Speculative Store Bypass via prctl and seccomp */
 };
 
 static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
@@ -481,8 +484,15 @@ static enum ssb_mitigation_cmd __init __
 
 	switch (cmd) {
 	case SPEC_STORE_BYPASS_CMD_AUTO:
-		/* Choose prctl as the default mode */
-		mode = SPEC_STORE_BYPASS_PRCTL;
+	case SPEC_STORE_BYPASS_CMD_SECCOMP:
+		/*
+		 * Choose prctl+seccomp as the default mode if seccomp is
+		 * enabled.
+		 */
+		if (IS_ENABLED(CONFIG_SECCOMP))
+			mode = SPEC_STORE_BYPASS_SECCOMP;
+		else
+			mode = SPEC_STORE_BYPASS_PRCTL;
 		break;
 	case SPEC_STORE_BYPASS_CMD_ON:
 		mode = SPEC_STORE_BYPASS_DISABLE;
@@ -530,12 +540,14 @@ static void ssb_select_mitigation()
 }
 
 #undef pr_fmt
+#define pr_fmt(fmt)     "Speculation prctl: " fmt
 
 static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	bool update;
 
-	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL)
+	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL &&
+	    ssb_mode != SPEC_STORE_BYPASS_SECCOMP)
 		return -ENXIO;
 
 	switch (ctrl) {
@@ -583,7 +595,8 @@ int arch_prctl_spec_ctrl_set(struct task
 #ifdef CONFIG_SECCOMP
 void arch_seccomp_spec_mitigate(struct task_struct *task)
 {
-	ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
+	if (ssb_mode == SPEC_STORE_BYPASS_SECCOMP)
+		ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
 }
 #endif
 
@@ -592,6 +605,7 @@ static int ssb_prctl_get(struct task_str
 	switch (ssb_mode) {
 	case SPEC_STORE_BYPASS_DISABLE:
 		return PR_SPEC_DISABLE;
+	case SPEC_STORE_BYPASS_SECCOMP:
 	case SPEC_STORE_BYPASS_PRCTL:
 		if (task_spec_ssb_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
