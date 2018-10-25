Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB7BECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07CE2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07CE2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJYOSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:18:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50951 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeJYOSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:18:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9P5kXmU3842822
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 24 Oct 2018 22:46:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9P5kXUY3842819;
        Wed, 24 Oct 2018 22:46:33 -0700
Date:   Wed, 24 Oct 2018 22:46:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Fenghua Yu <tipbot@zytor.com>
Message-ID: <tip-ace6485a03266cc3c198ce8e927a1ce0ce139699@git.kernel.org>
Cc:     tglx@linutronix.de, dvlasenk@redhat.com, fenghua.yu@intel.com,
        ashok.raj@intel.com, peterz@infradead.org, bp@alien8.de,
        ravi.v.shankar@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, brgerst@gmail.com,
        torvalds@linux-foundation.org, hpa@zytor.com, luto@amacapital.net
Reply-To: ravi.v.shankar@intel.com, bp@alien8.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          torvalds@linux-foundation.org, brgerst@gmail.com,
          luto@amacapital.net, tglx@linutronix.de, fenghua.yu@intel.com,
          dvlasenk@redhat.com, ashok.raj@intel.com, peterz@infradead.org
In-Reply-To: <1540418237-125817-3-git-send-email-fenghua.yu@intel.com>
References: <1540418237-125817-3-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/cpufeatures: Enumerate MOVDIR64B instruction
Git-Commit-ID: ace6485a03266cc3c198ce8e927a1ce0ce139699
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

Commit-ID:  ace6485a03266cc3c198ce8e927a1ce0ce139699
Gitweb:     https://git.kernel.org/tip/ace6485a03266cc3c198ce8e927a1ce0ce139699
Author:     Fenghua Yu <fenghua.yu@intel.com>
AuthorDate: Wed, 24 Oct 2018 14:57:17 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Oct 2018 07:42:48 +0200

x86/cpufeatures: Enumerate MOVDIR64B instruction

MOVDIR64B moves 64-bytes as direct-store with 64-bytes write atomicity.
Direct store is implemented by using write combining (WC) for writing
data directly into memory without caching the data.

In low latency offload (e.g. Non-Volatile Memory, etc), MOVDIR64B writes
work descriptors (and data in some cases) to device-hosted work-queues
atomically without cache pollution.

Availability of the MOVDIR64B instruction is indicated by the
presence of the CPUID feature flag MOVDIR64B (CPUID.0x07.0x0:ECX[bit 28]).

Please check the latest Intel Architecture Instruction Set Extensions
and Future Features Programming Reference for more details on the CPUID
feature MOVDIR64B flag.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1540418237-125817-3-git-send-email-fenghua.yu@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 90934ee7b79a..28c4a502b419 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -332,6 +332,7 @@
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 #define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
+#define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
