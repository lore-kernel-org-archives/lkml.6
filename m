Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE6AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B797420832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B797420832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeK2BZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:25:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41307 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeK2BZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:25:08 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEMbHL2320935
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:22:37 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEMa1K2320929;
        Wed, 28 Nov 2018 06:22:36 -0800
Date:   Wed, 28 Nov 2018 06:22:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tim Chen <tipbot@zytor.com>
Message-ID: <tip-34bce7c9690b1d897686aac89604ba7adc365556@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, aarcange@redhat.com, hpa@zytor.com,
        asit.k.mallick@intel.com, tglx@linutronix.de,
        casey.schaufler@intel.com, dwmw@amazon.co.uk,
        longman9394@gmail.com, jcm@redhat.com, arjan@linux.intel.com,
        jkosina@suse.cz, gregkh@linuxfoundation.org,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        jpoimboe@redhat.com, luto@kernel.org, peterz@infradead.org,
        ak@linux.intel.com, david.c.stewart@intel.com,
        torvalds@linux-foundation.org, keescook@chromium.org
Reply-To: tim.c.chen@linux.intel.com, jpoimboe@redhat.com,
          dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
          ak@linux.intel.com, david.c.stewart@intel.com,
          torvalds@linux-foundation.org, keescook@chromium.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          aarcange@redhat.com, thomas.lendacky@amd.com, hpa@zytor.com,
          asit.k.mallick@intel.com, tglx@linutronix.de,
          casey.schaufler@intel.com, dwmw@amazon.co.uk,
          longman9394@gmail.com, arjan@linux.intel.com, jcm@redhat.com,
          gregkh@linuxfoundation.org, jkosina@suse.cz
In-Reply-To: <20181125185003.966801480@linutronix.de>
References: <20181125185003.966801480@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Disable STIBP when enhanced IBRS is
 in use
Git-Commit-ID: 34bce7c9690b1d897686aac89604ba7adc365556
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

Commit-ID:  34bce7c9690b1d897686aac89604ba7adc365556
Gitweb:     https://git.kernel.org/tip/34bce7c9690b1d897686aac89604ba7adc365556
Author:     Tim Chen <tim.c.chen@linux.intel.com>
AuthorDate: Sun, 25 Nov 2018 19:33:33 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:05 +0100

x86/speculation: Disable STIBP when enhanced IBRS is in use

If enhanced IBRS is active, STIBP is redundant for mitigating Spectre v2
user space exploits from hyperthread sibling.

Disable STIBP when enhanced IBRS is used.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
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
Link: https://lkml.kernel.org/r/20181125185003.966801480@linutronix.de


---
 arch/x86/kernel/cpu/bugs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a1502bce9eb8..924cd06dd43b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -321,6 +321,10 @@ static bool stibp_needed(void)
 	if (spectre_v2_enabled == SPECTRE_V2_NONE)
 		return false;
 
+	/* Enhanced IBRS makes using STIBP unnecessary. */
+	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
+		return false;
+
 	if (!boot_cpu_has(X86_FEATURE_STIBP))
 		return false;
 
@@ -846,6 +850,9 @@ static ssize_t l1tf_show_state(char *buf)
 
 static char *stibp_state(void)
 {
+	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
+		return "";
+
 	if (x86_spec_ctrl_base & SPEC_CTRL_STIBP)
 		return ", STIBP";
 	else
