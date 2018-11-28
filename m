Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00ECC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB7D2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB7D2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbeK2BX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:23:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43237 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbeK2BX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:23:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASELR4R2320854
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:21:27 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASELRoH2320851;
        Wed, 28 Nov 2018 06:21:27 -0800
Date:   Wed, 28 Nov 2018 06:21:27 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tim Chen <tipbot@zytor.com>
Message-ID: <tip-b86bda0426853bfe8a3506c7d2a5b332760ae46b@git.kernel.org>
Cc:     dave.hansen@intel.com, torvalds@linux-foundation.org,
        peterz@infradead.org, keescook@chromium.org, luto@kernel.org,
        casey.schaufler@intel.com, jpoimboe@redhat.com,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        longman9394@gmail.com, david.c.stewart@intel.com,
        asit.k.mallick@intel.com, jcm@redhat.com, thomas.lendacky@amd.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com, jkosina@suse.cz,
        aarcange@redhat.com, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, hpa@zytor.com, arjan@linux.intel.com,
        tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          arjan@linux.intel.com, tglx@linutronix.de, ak@linux.intel.com,
          jkosina@suse.cz, tim.c.chen@linux.intel.com, aarcange@redhat.com,
          dwmw@amazon.co.uk, casey.schaufler@intel.com,
          gregkh@linuxfoundation.org, jpoimboe@redhat.com,
          mingo@kernel.org, longman9394@gmail.com,
          david.c.stewart@intel.com, asit.k.mallick@intel.com,
          jcm@redhat.com, thomas.lendacky@amd.com, dave.hansen@intel.com,
          torvalds@linux-foundation.org, peterz@infradead.org,
          luto@kernel.org, keescook@chromium.org
In-Reply-To: <20181125185003.783903657@linutronix.de>
References: <20181125185003.783903657@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Remove unnecessary ret variable in
 cpu_show_common()
Git-Commit-ID: b86bda0426853bfe8a3506c7d2a5b332760ae46b
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

Commit-ID:  b86bda0426853bfe8a3506c7d2a5b332760ae46b
Gitweb:     https://git.kernel.org/tip/b86bda0426853bfe8a3506c7d2a5b332760ae46b
Author:     Tim Chen <tim.c.chen@linux.intel.com>
AuthorDate: Sun, 25 Nov 2018 19:33:31 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:05 +0100

x86/speculation: Remove unnecessary ret variable in cpu_show_common()

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
Link: https://lkml.kernel.org/r/20181125185003.783903657@linutronix.de


---
 arch/x86/kernel/cpu/bugs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 839ab4103e89..b52a48966e01 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -847,8 +847,6 @@ static ssize_t l1tf_show_state(char *buf)
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
 			       char *buf, unsigned int bug)
 {
-	int ret;
-
 	if (!boot_cpu_has_bug(bug))
 		return sprintf(buf, "Not affected\n");
 
@@ -866,13 +864,12 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 
 	case X86_BUG_SPECTRE_V2:
-		ret = sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+		return sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
 			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
 			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
 			       (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ? ", STIBP" : "",
 			       boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
 			       spectre_v2_module_string());
-		return ret;
 
 	case X86_BUG_SPEC_STORE_BYPASS:
 		return sprintf(buf, "%s\n", ssb_strings[ssb_mode]);
