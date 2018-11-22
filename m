Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5E9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFDB20818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFDB20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407707AbeKWIcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:32:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37065 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbeKWIcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:32:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMLoWR33947855
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 13:50:32 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMLoWuW3947850;
        Thu, 22 Nov 2018 13:50:32 -0800
Date:   Thu, 22 Nov 2018 13:50:32 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sherry Hurwitz <tipbot@zytor.com>
Message-ID: <tip-9f72f855a6cdbb5313787145a69b474cd9f55f28@git.kernel.org>
Cc:     linux-doc@vger.kernel.org, fenghua.yu@intel.com, jroedel@suse.de,
        puwen@hygon.cn, corbet@lwn.net, akpm@linux-foundation.org,
        pombredanne@nexb.com, davem@davemloft.net, xiaochen.shen@intel.com,
        tglx@linutronix.de, suravee.suthikulpanit@amd.com, hpa@zytor.com,
        luto@kernel.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, rian@alum.mit.edu,
        sherry.hurwitz@amd.com, mchehab+samsung@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
        babu.moger@amd.com, qianyue.zj@alibaba-inc.com, jannh@google.com,
        reinette.chatre@intel.com, Thomas.Lendacky@amd.com,
        jpoimboe@redhat.com, dima@arista.com, chang.seok.bae@intel.com,
        dwmw2@infradead.org, tony.luck@intel.com, vkuznets@redhat.com,
        mingo@kernel.org, brijesh.singh@amd.com, rafael@kernel.org,
        bp@suse.de, pbonzini@redhat.com, kirill.shutemov@linux.intel.com,
        mingo@redhat.com
Reply-To: brijesh.singh@amd.com, rafael@kernel.org, vkuznets@redhat.com,
          mingo@kernel.org, kirill.shutemov@linux.intel.com,
          mingo@redhat.com, bp@suse.de, pbonzini@redhat.com,
          jannh@google.com, reinette.chatre@intel.com,
          qianyue.zj@alibaba-inc.com, babu.moger@amd.com, arnd@arndb.de,
          dwmw2@infradead.org, tony.luck@intel.com,
          Thomas.Lendacky@amd.com, chang.seok.bae@intel.com,
          dima@arista.com, jpoimboe@redhat.com, gregkh@linuxfoundation.org,
          luto@kernel.org, kstewart@linuxfoundation.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          rian@alum.mit.edu, mchehab+samsung@kernel.org,
          sherry.hurwitz@amd.com, davem@davemloft.net,
          pombredanne@nexb.com, fenghua.yu@intel.com,
          linux-doc@vger.kernel.org, jroedel@suse.de, corbet@lwn.net,
          puwen@hygon.cn, akpm@linux-foundation.org,
          suravee.suthikulpanit@amd.com, hpa@zytor.com, tglx@linutronix.de,
          xiaochen.shen@intel.com
In-Reply-To: <20181121202811.4492-10-babu.moger@amd.com>
References: <20181121202811.4492-10-babu.moger@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Add AMD's X86_FEATURE_MBA to the
 scattered CPUID features
Git-Commit-ID: 9f72f855a6cdbb5313787145a69b474cd9f55f28
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

Commit-ID:  9f72f855a6cdbb5313787145a69b474cd9f55f28
Gitweb:     https://git.kernel.org/tip/9f72f855a6cdbb5313787145a69b474cd9f55f28
Author:     Sherry Hurwitz <sherry.hurwitz@amd.com>
AuthorDate: Wed, 21 Nov 2018 20:28:41 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 22 Nov 2018 20:16:19 +0100

x86/resctrl: Add AMD's X86_FEATURE_MBA to the scattered CPUID features

The feature bit X86_FEATURE_MBA is detected via CPUID leaf 0x80000008
EBX Bit 06. This bit indicates the support of AMD's MBA feature.

This feature is supported by both Intel and AMD. But they are detected
in different CPUID leaves.

 [ bp: s/cpuid/CPUID/g ]

Signed-off-by: Sherry Hurwitz <sherry.hurwitz@amd.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: David Miller <davem@davemloft.net>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: <qianyue.zj@alibaba-inc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Rian Hunter <rian@alum.mit.edu>
Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: <xiaochen.shen@intel.com>
Link: https://lkml.kernel.org/r/20181121202811.4492-10-babu.moger@amd.com
---
 arch/x86/kernel/cpu/scattered.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 772c219b6889..a4d74d616222 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -17,7 +17,11 @@ struct cpuid_bit {
 	u32 sub_leaf;
 };
 
-/* Please keep the leaf sorted by cpuid_bit.level for faster search. */
+/*
+ * Please keep the leaf sorted by cpuid_bit.level for faster search.
+ * X86_FEATURE_MBA is supported by both Intel and AMD. But the CPUID
+ * levels are different and there is a separate entry for each.
+ */
 static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_APERFMPERF,       CPUID_ECX,  0, 0x00000006, 0 },
 	{ X86_FEATURE_EPB,		CPUID_ECX,  3, 0x00000006, 0 },
@@ -29,6 +33,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_HW_PSTATE,	CPUID_EDX,  7, 0x80000007, 0 },
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
+	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SME,		CPUID_EAX,  0, 0x8000001f, 0 },
 	{ X86_FEATURE_SEV,		CPUID_EAX,  1, 0x8000001f, 0 },
 	{ 0, 0, 0, 0, 0 }
