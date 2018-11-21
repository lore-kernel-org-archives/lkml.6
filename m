Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07DFC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF50B2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF50B2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389224AbeKVGx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:53:58 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45187 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731042AbeKVGx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:53:58 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPYwo-0000FO-HU; Wed, 21 Nov 2018 21:18:06 +0100
Message-Id: <20181121201722.440938272@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 21:14:32 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [patch 02/24] x86/speculation: Clean up spectre_v2_parse_cmdline()
References: <20181121201430.559770965@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation-Clean-up-spectre-v2-parse-cmdline-.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

Remove the unnecessary 'else' statement in spectre_v2_parse_cmdline()
to save an indentation level.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/bugs.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -276,22 +276,21 @@ static enum spectre_v2_mitigation_cmd __
 
 	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
 		return SPECTRE_V2_CMD_NONE;
-	else {
-		ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
-		if (ret < 0)
-			return SPECTRE_V2_CMD_AUTO;
 
-		for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
-			if (!match_option(arg, ret, mitigation_options[i].option))
-				continue;
-			cmd = mitigation_options[i].cmd;
-			break;
-		}
+	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
+	if (ret < 0)
+		return SPECTRE_V2_CMD_AUTO;
 
-		if (i >= ARRAY_SIZE(mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
-			return SPECTRE_V2_CMD_AUTO;
-		}
+	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
+		if (!match_option(arg, ret, mitigation_options[i].option))
+			continue;
+		cmd = mitigation_options[i].cmd;
+		break;
+	}
+
+	if (i >= ARRAY_SIZE(mitigation_options)) {
+		pr_err("unknown option (%s). Switching to AUTO select\n", arg);
+		return SPECTRE_V2_CMD_AUTO;
 	}
 
 	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||


