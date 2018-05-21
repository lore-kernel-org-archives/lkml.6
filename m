Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526938319-2-14657968272888680879
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
    1526938318; b=dHXkKC17kVdKZSj9Z/3qNzG6lJaH/5K+9jQO6BMd/l3Qm1srCt
    8orEVRhJwAAiEku8jGM3fFLU7oQsiM1z488YiG+mrS7oGckG5pT95I1EAcefJJn7
    Ov8CaTQWAzd0CS3zdTqOjv7RAhCjRf/Sk7lwDzx4ilg55snte+7TnEwIQt4qn3wg
    QMIWo81Kpq055+MwpQHu1hrIXF2fyKgy4M/5LF75CYwA37fwO+R67GNIDV/Ca+Ns
    OD/vem4N6mIvl1+FopaZ8xPfEgrrvPw2s7L4ARQweH1BeHCApXRi5l6YVmc+5HmK
    v7cRkTfijegG4iTJGbUEonw7vJ3/AyTV5YLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938318; bh=JyWZNWOCcK0diqjhpr6JjO0sR4RxL+
    oFRzrDgR5de5k=; b=iMvepmapc+84VsSgZGB0i+pg8RzLRlsV95Pf+YvEQ5AxOz
    KoVdenGc4mloq2/lAITWAJDn6TFIaYFSqEcwyTO71UA/XgkpCvsg6reQ3igAVmJH
    JaorrrI8nxALEfnfDp4d/hLTl+/iu/ImMSmw3D6IW/8ZHBJ/UyOrOPjlxeWnPTl7
    qZQMca5Zc5/LICTh4mhGI1O/F3WPIadwyGGpT0+S7gpvNj4I6WKlgS7fKjWKMcnW
    wmudDSMY/MWWFcBsU+jwFqOzxNTHq6De1tSbmF1w7lq/E8MCg78LBKAKioY8JMMq
    kbyV5sDhE8+WU+j8ttl1OYUOS5uiO21CLDgqWIKg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=JtzprrKF x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=JtzprrKF x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFKwGvla5h4ImjS2TmNi3pQut6rzaKIpBvP4p7GObzPVahxZt3r3xsOnqPtIcbyg1UrUXA0biiTQorfy+lQz+kT/+b+LNpzOow53KUU/3CrAFaDfeK09
    GcBfTPTrnsUNh71gf7JcRtVqT0EwIeCisYMje/xAL0UhssNOTuNZX+JYELP+fTJ65ZrENU02Rnmv1j8UjBxEYBpRcALLYP4E/PLePy/cLmV3lzCv+3d3EO8g
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=5anS3MJBsEuBzAT7vSgA:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932392AbeEUV0d (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932569AbeEUV0c (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:26:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 069/110] x86/bugs: Provide boot parameters for the spec_store_bypass_disable mitigation
Date: Mon, 21 May 2018 23:12:06 +0200
Message-Id: <20180521210512.300155287@linuxfoundation.org>
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

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 24f7fc83b9204d20f878c57cb77d261ae825e033 upstream

Contemporary high performance processors use a common industry-wide
optimization known as "Speculative Store Bypass" in which loads from
addresses to which a recent store has occurred may (speculatively) see an
older value. Intel refers to this feature as "Memory Disambiguation" which
is part of their "Smart Memory Access" capability.

Memory Disambiguation can expose a cache side-channel attack against such
speculatively read values. An attacker can create exploit code that allows
them to read memory outside of a sandbox environment (for example,
malicious JavaScript in a web page), or to perform more complex attacks
against code running within the same privilege level, e.g. via the stack.

As a first step to mitigate against such attacks, provide two boot command
line control knobs:

 nospec_store_bypass_disable
 spec_store_bypass_disable=[off,auto,on]

By default affected x86 processors will power on with Speculative
Store Bypass enabled. Hence the provided kernel parameters are written
from the point of view of whether to enable a mitigation or not.
The parameters are as follows:

 - auto - Kernel detects whether your CPU model contains an implementation
	  of Speculative Store Bypass and picks the most appropriate
	  mitigation.

 - on   - disable Speculative Store Bypass
 - off  - enable Speculative Store Bypass

[ tglx: Reordered the checks so that the whole evaluation is not done
  	when the CPU does not support RDS ]

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/kernel-parameters.txt |   33 +++++++
 arch/x86/include/asm/cpufeatures.h              |    1 
 arch/x86/include/asm/nospec-branch.h            |    6 +
 arch/x86/kernel/cpu/bugs.c                      |  103 ++++++++++++++++++++++++
 4 files changed, 143 insertions(+)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2647,6 +2647,9 @@
 			allow data leaks with this option, which is equivalent
 			to spectre_v2=off.
 
+	nospec_store_bypass_disable
+			[HW] Disable all mitigations for the Speculative Store Bypass vulnerability
+
 	noxsave		[BUGS=X86] Disables x86 extended register state save
 			and restore using xsave. The kernel will fallback to
 			enabling legacy floating-point and sse state.
@@ -3997,6 +4000,36 @@
 			Not specifying this option is equivalent to
 			spectre_v2=auto.
 
+	spec_store_bypass_disable=
+			[HW] Control Speculative Store Bypass (SSB) Disable mitigation
+			(Speculative Store Bypass vulnerability)
+
+			Certain CPUs are vulnerable to an exploit against a
+			a common industry wide performance optimization known
+			as "Speculative Store Bypass" in which recent stores
+			to the same memory location may not be observed by
+			later loads during speculative execution. The idea
+			is that such stores are unlikely and that they can
+			be detected prior to instruction retirement at the
+			end of a particular speculation execution window.
+
+			In vulnerable processors, the speculatively forwarded
+			store can be used in a cache side channel attack, for
+			example to read memory to which the attacker does not
+			directly have access (e.g. inside sandboxed code).
+
+			This parameter controls whether the Speculative Store
+			Bypass optimization is used.
+
+			on     - Unconditionally disable Speculative Store Bypass
+			off    - Unconditionally enable Speculative Store Bypass
+			auto   - Kernel detects whether the CPU model contains an
+				 implementation of Speculative Store Bypass and
+				 picks the most appropriate mitigation
+
+			Not specifying this option is equivalent to
+			spec_store_bypass_disable=auto.
+
 	spia_io_base=	[HW,MTD]
 	spia_fio_base=
 	spia_pedr=
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -214,6 +214,7 @@
 
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
+#define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -238,6 +238,12 @@ extern u64 x86_spec_ctrl_get_default(voi
 extern void x86_spec_ctrl_set_guest(u64);
 extern void x86_spec_ctrl_restore_host(u64);
 
+/* The Speculative Store Bypass disable variants */
+enum ssb_mitigation {
+	SPEC_STORE_BYPASS_NONE,
+	SPEC_STORE_BYPASS_DISABLE,
+};
+
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -27,6 +27,7 @@
 #include <asm/intel-family.h>
 
 static void __init spectre_v2_select_mitigation(void);
+static void __init ssb_select_mitigation(void);
 
 /*
  * Our boot-time value of the SPEC_CTRL MSR. We read it once so that any
@@ -53,6 +54,12 @@ void __init check_bugs(void)
 	/* Select the proper spectre mitigation before patching alternatives */
 	spectre_v2_select_mitigation();
 
+	/*
+	 * Select proper mitigation for any exposure to the Speculative Store
+	 * Bypass vulnerability.
+	 */
+	ssb_select_mitigation();
+
 #ifdef CONFIG_X86_32
 	/*
 	 * Check whether we are able to run this kernel safely on SMP.
@@ -358,6 +365,99 @@ retpoline_auto:
 }
 
 #undef pr_fmt
+#define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
+
+static enum ssb_mitigation ssb_mode = SPEC_STORE_BYPASS_NONE;
+
+/* The kernel command line selection */
+enum ssb_mitigation_cmd {
+	SPEC_STORE_BYPASS_CMD_NONE,
+	SPEC_STORE_BYPASS_CMD_AUTO,
+	SPEC_STORE_BYPASS_CMD_ON,
+};
+
+static const char *ssb_strings[] = {
+	[SPEC_STORE_BYPASS_NONE]	= "Vulnerable",
+	[SPEC_STORE_BYPASS_DISABLE]	= "Mitigation: Speculative Store Bypass disabled"
+};
+
+static const struct {
+	const char *option;
+	enum ssb_mitigation_cmd cmd;
+} ssb_mitigation_options[] = {
+	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO }, /* Platform decides */
+	{ "on",		SPEC_STORE_BYPASS_CMD_ON },   /* Disable Speculative Store Bypass */
+	{ "off",	SPEC_STORE_BYPASS_CMD_NONE }, /* Don't touch Speculative Store Bypass */
+};
+
+static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
+{
+	enum ssb_mitigation_cmd cmd = SPEC_STORE_BYPASS_CMD_AUTO;
+	char arg[20];
+	int ret, i;
+
+	if (cmdline_find_option_bool(boot_command_line, "nospec_store_bypass_disable")) {
+		return SPEC_STORE_BYPASS_CMD_NONE;
+	} else {
+		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
+					  arg, sizeof(arg));
+		if (ret < 0)
+			return SPEC_STORE_BYPASS_CMD_AUTO;
+
+		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
+			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
+				continue;
+
+			cmd = ssb_mitigation_options[i].cmd;
+			break;
+		}
+
+		if (i >= ARRAY_SIZE(ssb_mitigation_options)) {
+			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
+			return SPEC_STORE_BYPASS_CMD_AUTO;
+		}
+	}
+
+	return cmd;
+}
+
+static enum ssb_mitigation_cmd __init __ssb_select_mitigation(void)
+{
+	enum ssb_mitigation mode = SPEC_STORE_BYPASS_NONE;
+	enum ssb_mitigation_cmd cmd;
+
+	if (!boot_cpu_has(X86_FEATURE_RDS))
+		return mode;
+
+	cmd = ssb_parse_cmdline();
+	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS) &&
+	    (cmd == SPEC_STORE_BYPASS_CMD_NONE ||
+	     cmd == SPEC_STORE_BYPASS_CMD_AUTO))
+		return mode;
+
+	switch (cmd) {
+	case SPEC_STORE_BYPASS_CMD_AUTO:
+	case SPEC_STORE_BYPASS_CMD_ON:
+		mode = SPEC_STORE_BYPASS_DISABLE;
+		break;
+	case SPEC_STORE_BYPASS_CMD_NONE:
+		break;
+	}
+
+	if (mode != SPEC_STORE_BYPASS_NONE)
+		setup_force_cpu_cap(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE);
+	return mode;
+}
+
+static void ssb_select_mitigation()
+{
+	ssb_mode = __ssb_select_mitigation();
+
+	if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
+		pr_info("%s\n", ssb_strings[ssb_mode]);
+}
+
+#undef pr_fmt
 
 #ifdef CONFIG_SYSFS
 
@@ -383,6 +483,9 @@ ssize_t cpu_show_common(struct device *d
 			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
 			       spectre_v2_module_string());
 
+	case X86_BUG_SPEC_STORE_BYPASS:
+		return sprintf(buf, "%s\n", ssb_strings[ssb_mode]);
+
 	default:
 		break;
 	}
