Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7343DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A4520818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A4520818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407632AbeKWI3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:29:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47869 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404865AbeKWI3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:29:22 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMLl7e23947114
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 13:47:07 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMLl71P3947110;
        Thu, 22 Nov 2018 13:47:07 -0800
Date:   Thu, 22 Nov 2018 13:47:07 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Babu Moger <tipbot@zytor.com>
Message-ID: <tip-0f00717ecce4b366b3f530153e982cb2eeadafd1@git.kernel.org>
Cc:     x86@kernel.org, mingo@redhat.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, bp@suse.de,
        davem@davemloft.net, linux-doc@vger.kernel.org,
        kstewart@linuxfoundation.org, dwmw2@infradead.org, hpa@zytor.com,
        babu.moger@amd.com, Thomas.Lendacky@amd.com,
        gregkh@linuxfoundation.org, jpoimboe@redhat.com,
        reinette.chatre@intel.com, brijesh.singh@amd.com,
        tglx@linutronix.de, qianyue.zj@alibaba-inc.com,
        kirill.shutemov@linux.intel.com, tony.luck@intel.com,
        dima@arista.com, rafael@kernel.org, chang.seok.bae@intel.com,
        xiaochen.shen@intel.com, puwen@hygon.cn, pbonzini@redhat.com,
        sherry.hurwitz@amd.com, fenghua.yu@intel.com, rian@alum.mit.edu,
        jroedel@suse.de, akpm@linux-foundation.org, peterz@infradead.org,
        jannh@google.com, Babu.Moger@amd.com, corbet@lwn.net,
        luto@kernel.org, vkuznets@redhat.com,
        suravee.suthikulpanit@amd.com, pombredanne@nexb.com,
        mchehab+samsung@kernel.org
Reply-To: tony.luck@intel.com, kirill.shutemov@linux.intel.com,
          puwen@hygon.cn, xiaochen.shen@intel.com,
          chang.seok.bae@intel.com, dima@arista.com, rafael@kernel.org,
          pbonzini@redhat.com, sherry.hurwitz@amd.com,
          fenghua.yu@intel.com, jroedel@suse.de, rian@alum.mit.edu,
          akpm@linux-foundation.org, jannh@google.com,
          peterz@infradead.org, mchehab+samsung@kernel.org,
          pombredanne@nexb.com, suravee.suthikulpanit@amd.com,
          vkuznets@redhat.com, luto@kernel.org, corbet@lwn.net,
          Babu.Moger@amd.com, x86@kernel.org, mingo@redhat.com,
          arnd@arndb.de, linux-kernel@vger.kernel.org, bp@suse.de,
          mingo@kernel.org, linux-doc@vger.kernel.org, dwmw2@infradead.org,
          kstewart@linuxfoundation.org, davem@davemloft.net,
          Thomas.Lendacky@amd.com, gregkh@linuxfoundation.org,
          babu.moger@amd.com, hpa@zytor.com, tglx@linutronix.de,
          brijesh.singh@amd.com, reinette.chatre@intel.com,
          jpoimboe@redhat.com, qianyue.zj@alibaba-inc.com
In-Reply-To: <20181121202811.4492-4-babu.moger@amd.com>
References: <20181121202811.4492-4-babu.moger@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Re-arrange the RDT init code
Git-Commit-ID: 0f00717ecce4b366b3f530153e982cb2eeadafd1
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

Commit-ID:  0f00717ecce4b366b3f530153e982cb2eeadafd1
Gitweb:     https://git.kernel.org/tip/0f00717ecce4b366b3f530153e982cb2eeadafd1
Author:     Babu Moger <Babu.Moger@amd.com>
AuthorDate: Wed, 21 Nov 2018 20:28:29 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 22 Nov 2018 20:16:19 +0100

x86/resctrl: Re-arrange the RDT init code

Separate the call sequence for rdt_quirks and MBA feature. This is in
preparation to handle vendor differences in these call sequences. Rename
the functions to make the flow a bit more meaningful.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
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
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181121202811.4492-4-babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 0cf890ae0de2..40380731c588 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -259,7 +259,7 @@ static inline bool rdt_get_mb_table(struct rdt_resource *r)
 	return false;
 }
 
-static bool rdt_get_mem_config(struct rdt_resource *r)
+static bool __get_mem_config(struct rdt_resource *r)
 {
 	union cpuid_0x10_3_eax eax;
 	union cpuid_0x10_x_edx edx;
@@ -794,6 +794,14 @@ static bool __init rdt_cpu_has(int flag)
 	return ret;
 }
 
+static __init bool get_mem_config(void)
+{
+	if (rdt_cpu_has(X86_FEATURE_MBA))
+		return __get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]);
+
+	return false;
+}
+
 static __init bool get_rdt_alloc_resources(void)
 {
 	bool ret = false;
@@ -818,10 +826,9 @@ static __init bool get_rdt_alloc_resources(void)
 		ret = true;
 	}
 
-	if (rdt_cpu_has(X86_FEATURE_MBA)) {
-		if (rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]))
-			ret = true;
-	}
+	if (get_mem_config())
+		ret = true;
+
 	return ret;
 }
 
@@ -840,7 +847,7 @@ static __init bool get_rdt_mon_resources(void)
 	return !rdt_get_mon_l3_config(&rdt_resources_all[RDT_RESOURCE_L3]);
 }
 
-static __init void rdt_quirks(void)
+static __init void __check_quirks_intel(void)
 {
 	switch (boot_cpu_data.x86_model) {
 	case INTEL_FAM6_HASWELL_X:
@@ -855,9 +862,14 @@ static __init void rdt_quirks(void)
 	}
 }
 
+static __init void check_quirks(void)
+{
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		__check_quirks_intel();
+}
+
 static __init bool get_rdt_resources(void)
 {
-	rdt_quirks();
 	rdt_alloc_capable = get_rdt_alloc_resources();
 	rdt_mon_capable = get_rdt_mon_resources();
 
@@ -871,6 +883,8 @@ static int __init resctrl_late_init(void)
 	struct rdt_resource *r;
 	int state, ret;
 
+	check_quirks();
+
 	if (!get_rdt_resources())
 		return -ENODEV;
 
