Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E97CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E411C20818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E411C20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407672AbeKWIbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:31:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47731 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731179AbeKWIbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:31:07 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMLmoAw3947532
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 13:48:50 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMLmoR63947528;
        Thu, 22 Nov 2018 13:48:50 -0800
Date:   Thu, 22 Nov 2018 13:48:50 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Babu Moger <tipbot@zytor.com>
Message-ID: <tip-a36c5ff560fb32d17c020fa3e7f4c70f753d8834@git.kernel.org>
Cc:     Thomas.Lendacky@amd.com, rafael@kernel.org, hpa@zytor.com,
        corbet@lwn.net, dima@arista.com, qianyue.zj@alibaba-inc.com,
        kstewart@linuxfoundation.org, bp@suse.de, mingo@kernel.org,
        sherry.hurwitz@amd.com, tony.luck@intel.com, rian@alum.mit.edu,
        dwmw2@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, puwen@hygon.cn,
        reinette.chatre@intel.com, linux-doc@vger.kernel.org,
        jpoimboe@redhat.com, davem@davemloft.net, arnd@arndb.de,
        vkuznets@redhat.com, xiaochen.shen@intel.com, pombredanne@nexb.com,
        babu.moger@amd.com, mchehab+samsung@kernel.org,
        pbonzini@redhat.com, akpm@linux-foundation.org,
        chang.seok.bae@intel.com, brijesh.singh@amd.com, jannh@google.com,
        Babu.Moger@amd.com, tglx@linutronix.de, mingo@redhat.com,
        fenghua.yu@intel.com, luto@kernel.org, gregkh@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, jroedel@suse.de,
        peterz@infradead.org
Reply-To: rian@alum.mit.edu, tony.luck@intel.com, sherry.hurwitz@amd.com,
          kirill.shutemov@linux.intel.com, dwmw2@infradead.org,
          reinette.chatre@intel.com, puwen@hygon.cn,
          linux-kernel@vger.kernel.org, corbet@lwn.net, rafael@kernel.org,
          hpa@zytor.com, dima@arista.com, Thomas.Lendacky@amd.com,
          kstewart@linuxfoundation.org, qianyue.zj@alibaba-inc.com,
          bp@suse.de, mingo@kernel.org, chang.seok.bae@intel.com,
          brijesh.singh@amd.com, jannh@google.com, Babu.Moger@amd.com,
          fenghua.yu@intel.com, luto@kernel.org, tglx@linutronix.de,
          mingo@redhat.com, peterz@infradead.org,
          suravee.suthikulpanit@amd.com, gregkh@linuxfoundation.org,
          jroedel@suse.de, davem@davemloft.net, jpoimboe@redhat.com,
          linux-doc@vger.kernel.org, xiaochen.shen@intel.com,
          arnd@arndb.de, vkuznets@redhat.com, babu.moger@amd.com,
          pombredanne@nexb.com, mchehab+samsung@kernel.org,
          akpm@linux-foundation.org, pbonzini@redhat.com
In-Reply-To: <20181121202811.4492-7-babu.moger@amd.com>
References: <20181121202811.4492-7-babu.moger@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Bring cbm_validate() into the resource
 structure
Git-Commit-ID: a36c5ff560fb32d17c020fa3e7f4c70f753d8834
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

Commit-ID:  a36c5ff560fb32d17c020fa3e7f4c70f753d8834
Gitweb:     https://git.kernel.org/tip/a36c5ff560fb32d17c020fa3e7f4c70f753d8834
Author:     Babu Moger <Babu.Moger@amd.com>
AuthorDate: Wed, 21 Nov 2018 20:28:35 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 22 Nov 2018 20:16:19 +0100

x86/resctrl: Bring cbm_validate() into the resource structure

Bring all the functions that are different between the vendors into the
resource structure and initialize them dynamically. Add _intel suffix to
the Intel-specific functions.

cbm_validate() which does cache bitmask validation, differs between the
vendors as AMD allows non-contiguous masks. So, use separate functions
for Intel and AMD.

 [ bp: Massage commit message and fixup rdt_resource members' vertical
   alignment. ]

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
Link: https://lkml.kernel.org/r/20181121202811.4492-7-babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/core.c        |  9 ++++++++-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 ++--
 arch/x86/kernel/cpu/resctrl/internal.h    | 15 +++++++++------
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 3bd245b057c4..ba5a5b8c4681 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -878,7 +878,14 @@ static __init void rdt_init_res_defs_intel(void)
 	struct rdt_resource *r;
 
 	for_each_rdt_resource(r) {
-		if (r->rid == RDT_RESOURCE_MBA) {
+		if (r->rid == RDT_RESOURCE_L3 ||
+		    r->rid == RDT_RESOURCE_L3DATA ||
+		    r->rid == RDT_RESOURCE_L3CODE ||
+		    r->rid == RDT_RESOURCE_L2 ||
+		    r->rid == RDT_RESOURCE_L2DATA ||
+		    r->rid == RDT_RESOURCE_L2CODE)
+			r->cbm_validate = cbm_validate_intel;
+		else if (r->rid == RDT_RESOURCE_MBA) {
 			r->msr_base = MSR_IA32_MBA_THRTL_BASE;
 			r->msr_update = mba_wrmsr_intel;
 			r->parse_ctrlval = parse_bw_intel;
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index a8ae87e756e9..d2e0b99d453f 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -88,7 +88,7 @@ int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
  *	are allowed (e.g. FFFFH, 0FF0H, 003CH, etc.).
  * Additionally Haswell requires at least two bits set.
  */
-static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
+bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r)
 {
 	unsigned long first_bit, zero_bit, val;
 	unsigned int cbm_len = r->cache.cbm_len;
@@ -148,7 +148,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 		return -EINVAL;
 	}
 
-	if (!cbm_validate(data->buf, &cbm_val, r))
+	if (r->cbm_validate && !r->cbm_validate(data->buf, &cbm_val, r))
 		return -EINVAL;
 
 	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 9a643f444723..599cad34a6a8 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -396,9 +396,9 @@ struct rdt_parse_data {
  * struct rdt_resource - attributes of an RDT resource
  * @rid:		The index of the resource
  * @alloc_enabled:	Is allocation enabled on this machine
- * @mon_enabled:		Is monitoring enabled for this feature
+ * @mon_enabled:	Is monitoring enabled for this feature
  * @alloc_capable:	Is allocation available on this machine
- * @mon_capable:		Is monitor feature available on this machine
+ * @mon_capable:	Is monitor feature available on this machine
  * @name:		Name to use in "schemata" file
  * @num_closid:		Number of CLOSIDs available
  * @cache_level:	Which cache level defines scope of this resource
@@ -410,10 +410,11 @@ struct rdt_parse_data {
  * @cache:		Cache allocation related data
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
- * @evt_list:			List of monitoring events
- * @num_rmid:			Number of RMIDs available
- * @mon_scale:			cqm counter * mon_scale = occupancy in bytes
- * @fflags:			flags to choose base and info files
+ * @cbm_validate	Cache bitmask validate function
+ * @evt_list:		List of monitoring events
+ * @num_rmid:		Number of RMIDs available
+ * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
+ * @fflags:		flags to choose base and info files
  */
 struct rdt_resource {
 	int			rid;
@@ -436,6 +437,7 @@ struct rdt_resource {
 	int (*parse_ctrlval)(struct rdt_parse_data *data,
 			     struct rdt_resource *r,
 			     struct rdt_domain *d);
+	bool (*cbm_validate)(char *buf, u32 *data, struct rdt_resource *r);
 	struct list_head	evt_list;
 	int			num_rmid;
 	unsigned int		mon_scale;
@@ -576,5 +578,6 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
+bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
