Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40788C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31082157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31082157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392247AbeIVGOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:14:36 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44213 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391986AbeIVGKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:47 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdx-0008BM-PQ; Sat, 22 Sep 2018 01:19:29 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000t9-JV; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Arjan van de Ven" <arjan@linux.intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.758053879@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 43/63] x86/speculation: Clean up various Spectre
 related details
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ingo Molnar <mingo@kernel.org>

commit 21e433bdb95bdf3aa48226fd3d33af608437f293 upstream.

Harmonize all the Spectre messages so that a:

    dmesg | grep -i spectre

... gives us most Spectre related kernel boot messages.

Also fix a few other details:

 - clarify a comment about firmware speculation control

 - s/KPTI/PTI

 - remove various line-breaks that made the code uglier

Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -224,8 +224,7 @@ static enum spectre_v2_mitigation_cmd __
 	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
 		return SPECTRE_V2_CMD_NONE;
 	else {
-		ret = cmdline_find_option(boot_command_line, "spectre_v2", arg,
-					  sizeof(arg));
+		ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
 		if (ret < 0)
 			return SPECTRE_V2_CMD_AUTO;
 
@@ -246,8 +245,7 @@ static enum spectre_v2_mitigation_cmd __
 	     cmd == SPECTRE_V2_CMD_RETPOLINE_AMD ||
 	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC) &&
 	    !IS_ENABLED(CONFIG_RETPOLINE)) {
-		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
-		       mitigation_options[i].option);
+		pr_err("%s selected but not compiled in. Switching to AUTO select\n", mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
@@ -317,14 +315,14 @@ static void __init spectre_v2_select_mit
 			goto retpoline_auto;
 		break;
 	}
-	pr_err("kernel not compiled with retpoline; no mitigation available!");
+	pr_err("Spectre mitigation: kernel not compiled with retpoline; no mitigation available!");
 	return;
 
 retpoline_auto:
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
 	retpoline_amd:
 		if (!boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
-			pr_err("LFENCE not serializing. Switching to generic retpoline\n");
+			pr_err("Spectre mitigation: LFENCE not serializing, switching to generic retpoline\n");
 			goto retpoline_generic;
 		}
 		mode = retp_compiler() ? SPECTRE_V2_RETPOLINE_AMD :
@@ -342,7 +340,7 @@ retpoline_auto:
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
 	/*
-	 * If neither SMEP or KPTI are available, there is a risk of
+	 * If neither SMEP nor PTI are available, there is a risk of
 	 * hitting userspace addresses in the RSB after a context switch
 	 * from a shallow call stack to a deeper one. To prevent this fill
 	 * the entire RSB, even when using IBRS.
@@ -356,13 +354,13 @@ retpoline_auto:
 	if ((!boot_cpu_has(X86_FEATURE_KAISER) &&
 	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_skylake_era()) {
 		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
-		pr_info("Filling RSB on context switch\n");
+		pr_info("Spectre v2 mitigation: Filling RSB on context switch\n");
 	}
 
 	/* Initialize Indirect Branch Prediction Barrier if supported */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
-		pr_info("Enabling Indirect Branch Prediction Barrier\n");
+		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
 	}
 
 	/*
@@ -378,8 +376,7 @@ retpoline_auto:
 #undef pr_fmt
 
 #ifdef CONFIG_SYSFS
-ssize_t cpu_show_meltdown(struct device *dev,
-			  struct device_attribute *attr, char *buf)
+ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	if (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
 		return sprintf(buf, "Not affected\n");
@@ -388,16 +385,14 @@ ssize_t cpu_show_meltdown(struct device
 	return sprintf(buf, "Vulnerable\n");
 }
 
-ssize_t cpu_show_spectre_v1(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
 		return sprintf(buf, "Not affected\n");
 	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 }
 
-ssize_t cpu_show_spectre_v2(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return sprintf(buf, "Not affected\n");

