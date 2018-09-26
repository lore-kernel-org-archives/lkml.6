Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB306C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905242089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905242089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeIZSpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:45:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58275 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeIZSpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:45:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8QCVxA23830639
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 05:31:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8QCVx9B3830636;
        Wed, 26 Sep 2018 05:31:59 -0700
Date:   Wed, 26 Sep 2018 05:31:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Kosina <tipbot@zytor.com>
Message-ID: <tip-bb4b3b7762735cdaba5a40fd94c9303d9ffa147a@git.kernel.org>
Cc:     dwmw@amazon.co.uk, hpa@zytor.com, ak@linux.intel.com,
        aarcange@redhat.com, mingo@kernel.org, tglx@linutronix.de,
        jkosina@suse.cz, peterz@infradead.org, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        casey.schaufler@intel.com
Reply-To: tim.c.chen@linux.intel.com, peterz@infradead.org,
          jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
          casey.schaufler@intel.com, dwmw@amazon.co.uk,
          aarcange@redhat.com, ak@linux.intel.com, hpa@zytor.com,
          mingo@kernel.org, jkosina@suse.cz, tglx@linutronix.de
In-Reply-To: <nycvar.YFH.7.76.1809251438580.15880@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1809251438580.15880@cbobk.fhfr.pm>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Propagate information about RSB
 filling mitigation to sysfs
Git-Commit-ID: bb4b3b7762735cdaba5a40fd94c9303d9ffa147a
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

Commit-ID:  bb4b3b7762735cdaba5a40fd94c9303d9ffa147a
Gitweb:     https://git.kernel.org/tip/bb4b3b7762735cdaba5a40fd94c9303d9ffa147a
Author:     Jiri Kosina <jkosina@suse.cz>
AuthorDate: Tue, 25 Sep 2018 14:39:28 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Sep 2018 14:26:52 +0200

x86/speculation: Propagate information about RSB filling mitigation to sysfs

If spectrev2 mitigation has been enabled, RSB is filled on context switch
in order to protect from various classes of spectrev2 attacks.

If this mitigation is enabled, say so in sysfs for spectrev2.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc:  "WoodhouseDavid" <dwmw@amazon.co.uk>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc:  "SchauflerCasey" <casey.schaufler@intel.com>
Link: https://lkml.kernel.org/r/nycvar.YFH.7.76.1809251438580.15880@cbobk.fhfr.pm

---
 arch/x86/kernel/cpu/bugs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 53eb14a65610..fe32103fcdc7 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -874,10 +874,11 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 
 	case X86_BUG_SPECTRE_V2:
-		ret = sprintf(buf, "%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+		ret = sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
 			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
 			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
 			       (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ? ", STIBP" : "",
+			       boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
 			       spectre_v2_module_string());
 		return ret;
 
