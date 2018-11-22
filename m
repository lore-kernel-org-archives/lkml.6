Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CFAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A70320818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A70320818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407639AbeKWI37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:29:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48687 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392384AbeKWI37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:29:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMLlfBX3947149
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 13:47:41 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMLlfho3947145;
        Thu, 22 Nov 2018 13:47:41 -0800
Date:   Thu, 22 Nov 2018 13:47:41 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Babu Moger <tipbot@zytor.com>
Message-ID: <tip-aa50453a448ad645ea05788505680aa403934aa8@git.kernel.org>
Cc:     pbonzini@redhat.com, chang.seok.bae@intel.com, hpa@zytor.com,
        jpoimboe@redhat.com, jannh@google.com, tony.luck@intel.com,
        babu.moger@amd.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        tglx@linutronix.de, reinette.chatre@intel.com,
        xiaochen.shen@intel.com, davem@davemloft.net, peterz@infradead.org,
        bp@suse.de, kstewart@linuxfoundation.org, sherry.hurwitz@amd.com,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        mingo@redhat.com, mchehab+samsung@kernel.org, corbet@lwn.net,
        dima@arista.com, pombredanne@nexb.com, Babu.Moger@amd.com,
        mingo@kernel.org, brijesh.singh@amd.com, fenghua.yu@intel.com,
        dwmw2@infradead.org, suravee.suthikulpanit@amd.com,
        luto@kernel.org, jroedel@suse.de, Thomas.Lendacky@amd.com,
        vkuznets@redhat.com, puwen@hygon.cn, gregkh@linuxfoundation.org,
        kirill.shutemov@linux.intel.com, qianyue.zj@alibaba-inc.com,
        rian@alum.mit.edu, rafael@kernel.org
Reply-To: pbonzini@redhat.com, jannh@google.com, jpoimboe@redhat.com,
          hpa@zytor.com, chang.seok.bae@intel.com,
          linux-kernel@vger.kernel.org, babu.moger@amd.com,
          tony.luck@intel.com, xiaochen.shen@intel.com,
          reinette.chatre@intel.com, arnd@arndb.de, tglx@linutronix.de,
          bp@suse.de, peterz@infradead.org, davem@davemloft.net,
          kstewart@linuxfoundation.org, corbet@lwn.net,
          mchehab+samsung@kernel.org, akpm@linux-foundation.org,
          mingo@redhat.com, linux-doc@vger.kernel.org,
          sherry.hurwitz@amd.com, pombredanne@nexb.com, dima@arista.com,
          Babu.Moger@amd.com, dwmw2@infradead.org, fenghua.yu@intel.com,
          mingo@kernel.org, brijesh.singh@amd.com, Thomas.Lendacky@amd.com,
          vkuznets@redhat.com, suravee.suthikulpanit@amd.com,
          jroedel@suse.de, luto@kernel.org, puwen@hygon.cn,
          rian@alum.mit.edu, qianyue.zj@alibaba-inc.com,
          gregkh@linuxfoundation.org, kirill.shutemov@linux.intel.com,
          rafael@kernel.org
In-Reply-To: <20181121202811.4492-5-babu.moger@amd.com>
References: <20181121202811.4492-5-babu.moger@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Move all the macros to
 resctrl/internal.h
Git-Commit-ID: aa50453a448ad645ea05788505680aa403934aa8
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

Commit-ID:  aa50453a448ad645ea05788505680aa403934aa8
Gitweb:     https://git.kernel.org/tip/aa50453a448ad645ea05788505680aa403934aa8
Author:     Babu Moger <Babu.Moger@amd.com>
AuthorDate: Wed, 21 Nov 2018 20:28:31 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 22 Nov 2018 20:16:19 +0100

x86/resctrl: Move all the macros to resctrl/internal.h

Move all the macros to resctrl/internal.h and rename the registers with
MSR_ prefix for consistency.

 [bp: align MSR definitions vertically ]

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
Link: https://lkml.kernel.org/r/20181121202811.4492-5-babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 22 ++++++++++------------
 arch/x86/kernel/cpu/resctrl/internal.h | 19 ++++++++++++-------
 arch/x86/kernel/cpu/resctrl/monitor.c  |  3 ---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 ++--
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 40380731c588..cf6491eeadc6 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -33,9 +33,6 @@
 #include <asm/resctrl_sched.h>
 #include "internal.h"
 
-#define MBA_IS_LINEAR	0x4
-#define MBA_MAX_MBPS	U32_MAX
-
 /* Mutex to protect rdtgroup access. */
 DEFINE_MUTEX(rdtgroup_mutex);
 
@@ -72,7 +69,7 @@ struct rdt_resource rdt_resources_all[] = {
 		.rid			= RDT_RESOURCE_L3,
 		.name			= "L3",
 		.domains		= domain_init(RDT_RESOURCE_L3),
-		.msr_base		= IA32_L3_CBM_BASE,
+		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 		.cache_level		= 3,
 		.cache = {
@@ -89,7 +86,7 @@ struct rdt_resource rdt_resources_all[] = {
 		.rid			= RDT_RESOURCE_L3DATA,
 		.name			= "L3DATA",
 		.domains		= domain_init(RDT_RESOURCE_L3DATA),
-		.msr_base		= IA32_L3_CBM_BASE,
+		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 		.cache_level		= 3,
 		.cache = {
@@ -106,7 +103,7 @@ struct rdt_resource rdt_resources_all[] = {
 		.rid			= RDT_RESOURCE_L3CODE,
 		.name			= "L3CODE",
 		.domains		= domain_init(RDT_RESOURCE_L3CODE),
-		.msr_base		= IA32_L3_CBM_BASE,
+		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 		.cache_level		= 3,
 		.cache = {
@@ -123,7 +120,7 @@ struct rdt_resource rdt_resources_all[] = {
 		.rid			= RDT_RESOURCE_L2,
 		.name			= "L2",
 		.domains		= domain_init(RDT_RESOURCE_L2),
-		.msr_base		= IA32_L2_CBM_BASE,
+		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 		.cache_level		= 2,
 		.cache = {
@@ -140,7 +137,7 @@ struct rdt_resource rdt_resources_all[] = {
 		.rid			= RDT_RESOURCE_L2DATA,
 		.name			= "L2DATA",
 		.domains		= domain_init(RDT_RESOURCE_L2DATA),
-		.msr_base		= IA32_L2_CBM_BASE,
+		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 		.cache_level		= 2,
 		.cache = {
@@ -157,7 +154,7 @@ struct rdt_resource rdt_resources_all[] = {
 		.rid			= RDT_RESOURCE_L2CODE,
 		.name			= "L2CODE",
 		.domains		= domain_init(RDT_RESOURCE_L2CODE),
-		.msr_base		= IA32_L2_CBM_BASE,
+		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 		.cache_level		= 2,
 		.cache = {
@@ -174,7 +171,7 @@ struct rdt_resource rdt_resources_all[] = {
 		.rid			= RDT_RESOURCE_MBA,
 		.name			= "MB",
 		.domains		= domain_init(RDT_RESOURCE_MBA),
-		.msr_base		= IA32_MBA_THRTL_BASE,
+		.msr_base		= MSR_IA32_MBA_THRTL_BASE,
 		.msr_update		= mba_wrmsr,
 		.cache_level		= 3,
 		.parse_ctrlval		= parse_bw,
@@ -211,9 +208,10 @@ static inline void cache_alloc_hsw_probe(void)
 	struct rdt_resource *r  = &rdt_resources_all[RDT_RESOURCE_L3];
 	u32 l, h, max_cbm = BIT_MASK(20) - 1;
 
-	if (wrmsr_safe(IA32_L3_CBM_BASE, max_cbm, 0))
+	if (wrmsr_safe(MSR_IA32_L3_CBM_BASE, max_cbm, 0))
 		return;
-	rdmsr(IA32_L3_CBM_BASE, l, h);
+
+	rdmsr(MSR_IA32_L3_CBM_BASE, l, h);
 
 	/* If all the bits were set in MSR, return success */
 	if (l != max_cbm)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index eeaee05522b5..fb26d347ae6c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -6,15 +6,18 @@
 #include <linux/kernfs.h>
 #include <linux/jump_label.h>
 
-#define IA32_L3_QOS_CFG		0xc81
-#define IA32_L2_QOS_CFG		0xc82
-#define IA32_L3_CBM_BASE	0xc90
-#define IA32_L2_CBM_BASE	0xd10
-#define IA32_MBA_THRTL_BASE	0xd50
+#define MSR_IA32_L3_QOS_CFG		0xc81
+#define MSR_IA32_L2_QOS_CFG		0xc82
+#define MSR_IA32_L3_CBM_BASE		0xc90
+#define MSR_IA32_L2_CBM_BASE		0xd10
+#define MSR_IA32_MBA_THRTL_BASE		0xd50
 
-#define L3_QOS_CDP_ENABLE	0x01ULL
+#define MSR_IA32_QM_CTR			0x0c8e
+#define MSR_IA32_QM_EVTSEL		0x0c8d
 
-#define L2_QOS_CDP_ENABLE	0x01ULL
+#define L3_QOS_CDP_ENABLE		0x01ULL
+
+#define L2_QOS_CDP_ENABLE		0x01ULL
 
 /*
  * Event IDs are used to program IA32_QM_EVTSEL before reading event
@@ -29,6 +32,8 @@
 #define MBM_CNTR_WIDTH			24
 #define MBM_OVERFLOW_INTERVAL		1000
 #define MAX_MBA_BW			100u
+#define MBA_IS_LINEAR			0x4
+#define MBA_MAX_MBPS			U32_MAX
 
 #define RMID_VAL_ERROR			BIT_ULL(63)
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ebf408db8191..f33f11f69078 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -28,9 +28,6 @@
 #include <asm/cpu_device_id.h>
 #include "internal.h"
 
-#define MSR_IA32_QM_CTR		0x0c8e
-#define MSR_IA32_QM_EVTSEL		0x0c8d
-
 struct rmid_entry {
 	u32				rmid;
 	int				busy;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2bf1f3227afa..cf159095b612 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1722,14 +1722,14 @@ static void l3_qos_cfg_update(void *arg)
 {
 	bool *enable = arg;
 
-	wrmsrl(IA32_L3_QOS_CFG, *enable ? L3_QOS_CDP_ENABLE : 0ULL);
+	wrmsrl(MSR_IA32_L3_QOS_CFG, *enable ? L3_QOS_CDP_ENABLE : 0ULL);
 }
 
 static void l2_qos_cfg_update(void *arg)
 {
 	bool *enable = arg;
 
-	wrmsrl(IA32_L2_QOS_CFG, *enable ? L2_QOS_CDP_ENABLE : 0ULL);
+	wrmsrl(MSR_IA32_L2_QOS_CFG, *enable ? L2_QOS_CDP_ENABLE : 0ULL);
 }
 
 static inline bool is_mba_linear(void)
