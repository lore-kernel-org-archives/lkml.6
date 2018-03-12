Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3369064-1520824247-2-10312046485793717318
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enfrro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520824246; b=sj+Li2NgPQ/CbDeDr+NYXvDCUT5O6a4m8wsg0uME9AHr7u9
    yIFtuQJYFGp+bPn/jQHvd1uAvY0NVGrJwIlRbNWil+Fm1Y6ZchD7y5OOgUn/DwMX
    w+jGB9FBD9R3Z+9YIg5dD+ulxD7+aBgq/7GW6rLBPut0DwFpT8GBHI6bNMwk90vJ
    IfdWNhD9XGY5g9EXOXLYFnKUeA1Uuxx5Fs+ynMASpDI5SVyIUo+W9Jj6ZYuzAV0O
    bXkS3mK++EoY+NeumlrjyO6WgXpDXUkyMSx/kGypo7GLhdZerVwtfa7+rbpSe62F
    MRutdksgqgtJN6iygP2iL8qOgMrCjHibeIhzo8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824246; bh=fhw6sK2CNHH71dodN+g
    DIOxH1fq/GOfQVIXnU2sZSEs=; b=WBiwvF6p7kRgPDff51RNCe9+8kGqalGR+6d
    KhOVcuRm7Fa0t4Mwh5pfbawnsd4Vxmg0gOGx/GcXa0kW2NHAUdS81aXX848U86/d
    RgiVt9geOkAT36uBczClPXufWs6SYN1hbFOZxqYhLYpwMngiQTqPblWwWHAqAEVE
    lV/AqDc98AFQ4oF5TnFzthG4IN5O4AK/ywKJfMUyDQoTqERVvkxoN3VrN0h0tjBi
    q+CelAzybH41iiYHS1tH7eIWnZSfDNgwrGEg67C+VgkTJfkYnfRaM2daKDg+DIpO
    L/HViNFOMeoSh73WshSuWWwcEfI51TEwFI+iquCYu7fgTUJ8Fxw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932969AbeCLDJF (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:09:05 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41589 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932804AbeCLDHw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:52 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "KarimAllah Ahmed" <karahmed@amazon.de>,
        "Thomas Gleixner" <tglx@linutronix.de>, peterz@infradead.org,
        "David Woodhouse" <dwmw@amazon.co.uk>, bp@alien8.de
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.728716892@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 64/76] x86/spectre: Simplify spectre_v2 command line
 parsing
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: KarimAllah Ahmed <karahmed@amazon.de>

commit 9005c6834c0ffdfe46afa76656bd9276cca864f6 upstream.

[dwmw2: Use ARRAY_SIZE]

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org
Cc: bp@alien8.de
Link: https://lkml.kernel.org/r/1517484441-1420-3-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/bugs.c | 86 ++++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 30 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -181,13 +181,13 @@ static inline const char *spectre_v2_mod
 static void __init spec2_print_if_insecure(const char *reason)
 {
 	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
-		pr_info("%s\n", reason);
+		pr_info("%s selected on command line.\n", reason);
 }
 
 static void __init spec2_print_if_secure(const char *reason)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
-		pr_info("%s\n", reason);
+		pr_info("%s selected on command line.\n", reason);
 }
 
 static inline bool retp_compiler(void)
@@ -202,42 +202,68 @@ static inline bool match_option(const ch
 	return len == arglen && !strncmp(arg, opt, len);
 }
 
+static const struct {
+	const char *option;
+	enum spectre_v2_mitigation_cmd cmd;
+	bool secure;
+} mitigation_options[] = {
+	{ "off",               SPECTRE_V2_CMD_NONE,              false },
+	{ "on",                SPECTRE_V2_CMD_FORCE,             true },
+	{ "retpoline",         SPECTRE_V2_CMD_RETPOLINE,         false },
+	{ "retpoline,amd",     SPECTRE_V2_CMD_RETPOLINE_AMD,     false },
+	{ "retpoline,generic", SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
+	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
+};
+
 static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 {
 	char arg[20];
-	int ret;
+	int ret, i;
+	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_AUTO;
+
+	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
+		return SPECTRE_V2_CMD_NONE;
+	else {
+		ret = cmdline_find_option(boot_command_line, "spectre_v2", arg,
+					  sizeof(arg));
+		if (ret < 0)
+			return SPECTRE_V2_CMD_AUTO;
 
-	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg,
-				  sizeof(arg));
-	if (ret > 0)  {
-		if (match_option(arg, ret, "off")) {
-			goto disable;
-		} else if (match_option(arg, ret, "on")) {
-			spec2_print_if_secure("force enabled on command line.");
-			return SPECTRE_V2_CMD_FORCE;
-		} else if (match_option(arg, ret, "retpoline")) {
-			spec2_print_if_insecure("retpoline selected on command line.");
-			return SPECTRE_V2_CMD_RETPOLINE;
-		} else if (match_option(arg, ret, "retpoline,amd")) {
-			if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
-				pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
-				return SPECTRE_V2_CMD_AUTO;
-			}
-			spec2_print_if_insecure("AMD retpoline selected on command line.");
-			return SPECTRE_V2_CMD_RETPOLINE_AMD;
-		} else if (match_option(arg, ret, "retpoline,generic")) {
-			spec2_print_if_insecure("generic retpoline selected on command line.");
-			return SPECTRE_V2_CMD_RETPOLINE_GENERIC;
-		} else if (match_option(arg, ret, "auto")) {
+		for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
+			if (!match_option(arg, ret, mitigation_options[i].option))
+				continue;
+			cmd = mitigation_options[i].cmd;
+			break;
+		}
+
+		if (i >= ARRAY_SIZE(mitigation_options)) {
+			pr_err("unknown option (%s). Switching to AUTO select\n",
+			       mitigation_options[i].option);
 			return SPECTRE_V2_CMD_AUTO;
 		}
 	}
 
-	if (!cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
+	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
+	     cmd == SPECTRE_V2_CMD_RETPOLINE_AMD ||
+	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC) &&
+	    !IS_ENABLED(CONFIG_RETPOLINE)) {
+		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
+		       mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
-disable:
-	spec2_print_if_insecure("disabled on command line.");
-	return SPECTRE_V2_CMD_NONE;
+	}
+
+	if (cmd == SPECTRE_V2_CMD_RETPOLINE_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
+		pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
+		return SPECTRE_V2_CMD_AUTO;
+	}
+
+	if (mitigation_options[i].secure)
+		spec2_print_if_secure(mitigation_options[i].option);
+	else
+		spec2_print_if_insecure(mitigation_options[i].option);
+
+	return cmd;
 }
 
 /* Check for Skylake-like CPUs (for RSB handling) */
