Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1CDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F0320818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F0320818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407643AbeKWIac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:30:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60021 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731179AbeKWIac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:30:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMLmGpW3947421
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 13:48:16 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMLmGmX3947417;
        Thu, 22 Nov 2018 13:48:16 -0800
Date:   Thu, 22 Nov 2018 13:48:16 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Babu Moger <tipbot@zytor.com>
Message-ID: <tip-1ad4fa41d99f606098fd7b90c1f5deb2b3dfae5d@git.kernel.org>
Cc:     mingo@kernel.org, bp@suse.de, qianyue.zj@alibaba-inc.com,
        mingo@redhat.com, brijesh.singh@amd.com, Babu.Moger@amd.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tony.luck@intel.com, reinette.chatre@intel.com,
        arnd@arndb.de, tglx@linutronix.de, babu.moger@amd.com,
        dima@arista.com, rian@alum.mit.edu, dwmw2@infradead.org,
        akpm@linux-foundation.org, sherry.hurwitz@amd.com,
        jpoimboe@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        suravee.suthikulpanit@amd.com, vkuznets@redhat.com,
        gregkh@linuxfoundation.org, jannh@google.com, rafael@kernel.org,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, jroedel@suse.de,
        fenghua.yu@intel.com, xiaochen.shen@intel.com, puwen@hygon.cn,
        linux-doc@vger.kernel.org, mchehab+samsung@kernel.org,
        luto@kernel.org, pombredanne@nexb.com, davem@davemloft.net,
        kstewart@linuxfoundation.org, Thomas.Lendacky@amd.com
Reply-To: gregkh@linuxfoundation.org, vkuznets@redhat.com,
          jannh@google.com, rafael@kernel.org,
          kirill.shutemov@linux.intel.com, fenghua.yu@intel.com,
          xiaochen.shen@intel.com, jroedel@suse.de, corbet@lwn.net,
          puwen@hygon.cn, linux-doc@vger.kernel.org,
          mchehab+samsung@kernel.org, kstewart@linuxfoundation.org,
          davem@davemloft.net, luto@kernel.org, pombredanne@nexb.com,
          Thomas.Lendacky@amd.com, qianyue.zj@alibaba-inc.com,
          mingo@kernel.org, bp@suse.de, Babu.Moger@amd.com,
          mingo@redhat.com, brijesh.singh@amd.com,
          chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, tony.luck@intel.com, reinette.chatre@intel.com,
          arnd@arndb.de, tglx@linutronix.de, dima@arista.com,
          babu.moger@amd.com, akpm@linux-foundation.org,
          sherry.hurwitz@amd.com, rian@alum.mit.edu, dwmw2@infradead.org,
          pbonzini@redhat.com, suravee.suthikulpanit@amd.com,
          peterz@infradead.org, jpoimboe@redhat.com
In-Reply-To: <20181121202811.4492-6-babu.moger@amd.com>
References: <20181121202811.4492-6-babu.moger@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Initialize the vendor-specific
 resource functions
Git-Commit-ID: 1ad4fa41d99f606098fd7b90c1f5deb2b3dfae5d
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

Commit-ID:  1ad4fa41d99f606098fd7b90c1f5deb2b3dfae5d
Gitweb:     https://git.kernel.org/tip/1ad4fa41d99f606098fd7b90c1f5deb2b3dfae5d
Author:     Babu Moger <Babu.Moger@amd.com>
AuthorDate: Wed, 21 Nov 2018 20:28:33 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 22 Nov 2018 20:16:19 +0100

x86/resctrl: Initialize the vendor-specific resource functions

Initialize the resource functions that are different between the
vendors. Some features are initialized differently between the vendors.
Add _intel suffix to Intel-specific functions.

For example, the MBA feature varies significantly between Intel and AMD.
Separate the initialization of these resource functions. That way we can
easily add AMD's functions later.

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
Link: https://lkml.kernel.org/r/20181121202811.4492-6-babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 34 ++++++++++++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 ++--
 arch/x86/kernel/cpu/resctrl/internal.h    |  8 ++++++--
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index cf6491eeadc6..3bd245b057c4 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -57,7 +57,8 @@ int max_name_width, max_data_width;
 bool rdt_alloc_capable;
 
 static void
-mba_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r);
+mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
+		struct rdt_resource *r);
 static void
 cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r);
 
@@ -171,10 +172,7 @@ struct rdt_resource rdt_resources_all[] = {
 		.rid			= RDT_RESOURCE_MBA,
 		.name			= "MB",
 		.domains		= domain_init(RDT_RESOURCE_MBA),
-		.msr_base		= MSR_IA32_MBA_THRTL_BASE,
-		.msr_update		= mba_wrmsr,
 		.cache_level		= 3,
-		.parse_ctrlval		= parse_bw,
 		.format_str		= "%d=%*u",
 		.fflags			= RFTYPE_RES_MB,
 	},
@@ -357,7 +355,8 @@ u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
 }
 
 static void
-mba_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
+mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
+		struct rdt_resource *r)
 {
 	unsigned int i;
 
@@ -874,6 +873,25 @@ static __init bool get_rdt_resources(void)
 	return (rdt_mon_capable || rdt_alloc_capable);
 }
 
+static __init void rdt_init_res_defs_intel(void)
+{
+	struct rdt_resource *r;
+
+	for_each_rdt_resource(r) {
+		if (r->rid == RDT_RESOURCE_MBA) {
+			r->msr_base = MSR_IA32_MBA_THRTL_BASE;
+			r->msr_update = mba_wrmsr_intel;
+			r->parse_ctrlval = parse_bw_intel;
+		}
+	}
+}
+
+static __init void rdt_init_res_defs(void)
+{
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		rdt_init_res_defs_intel();
+}
+
 static enum cpuhp_state rdt_online;
 
 static int __init resctrl_late_init(void)
@@ -881,6 +899,12 @@ static int __init resctrl_late_init(void)
 	struct rdt_resource *r;
 	int state, ret;
 
+	/*
+	 * Initialize functions(or definitions) that are different
+	 * between vendors here.
+	 */
+	rdt_init_res_defs();
+
 	check_quirks();
 
 	if (!get_rdt_resources())
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 407d2179bfcb..a8ae87e756e9 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -64,8 +64,8 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 	return true;
 }
 
-int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
-	     struct rdt_domain *d)
+int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
+		   struct rdt_domain *d)
 {
 	unsigned long bw_val;
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index fb26d347ae6c..9a643f444723 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -444,8 +444,8 @@ struct rdt_resource {
 
 int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 	      struct rdt_domain *d);
-int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
-	     struct rdt_domain *d);
+int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
+		   struct rdt_domain *d);
 
 extern struct mutex rdtgroup_mutex;
 
@@ -468,6 +468,10 @@ enum {
 	RDT_NUM_RESOURCES,
 };
 
+#define for_each_rdt_resource(r)					      \
+	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
+	     r++)
+
 #define for_each_capable_rdt_resource(r)				      \
 	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
 	     r++)							      \
