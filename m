Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A62C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073A4241C4
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073A4241C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeFWMOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:14:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44935 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeFWMOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:14:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCEZ63464083
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:14:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCEZT9464080;
        Sat, 23 Jun 2018 05:14:35 -0700
Date:   Sat, 23 Jun 2018 05:14:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-d9b48c86eb380bb272d0ad8f5338d8dc941f3b32@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org,
        reinette.chatre@intel.com, mingo@kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, reinette.chatre@intel.com, tglx@linutronix.de,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <cc0058014c30adb88ca7d1a5abfadacbfb5edd0d.1529706536.git.reinette.chatre@intel.com>
References: <cc0058014c30adb88ca7d1a5abfadacbfb5edd0d.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Display resource groups'
 allocations' size in bytes
Git-Commit-ID: d9b48c86eb380bb272d0ad8f5338d8dc941f3b32
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

Commit-ID:  d9b48c86eb380bb272d0ad8f5338d8dc941f3b32
Gitweb:     https://git.kernel.org/tip/d9b48c86eb380bb272d0ad8f5338d8dc941f3b32
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:06 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:44 +0200

x86/intel_rdt: Display resource groups' allocations' size in bytes

The schemata file displays the allocations associated with each domain of
each resource. The syntax of this file reflects the capacity bitmask (CBM)
of the actual allocation. In order to determine the actual size of an
allocation the user needs to dig through three different files to query the
variables needed to compute it (the cache size, the CBM length, and the
schemata).

Introduce a new file "size" associated with each resource group that will
mirror the schemata file syntax and display the size in bytes of each
allocation.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/cc0058014c30adb88ca7d1a5abfadacbfb5edd0d.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.h          |  2 +
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 81 ++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 362c8fe695f3..ed20e91c28ed 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -467,6 +467,8 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
 bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
 			   u32 _cbm, int closid, bool exclusive);
+unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_domain *d,
+				  u32 cbm);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int update_domains(struct rdt_resource *r, int closid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index e0ec41a6540e..cde0f4114d4e 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -20,6 +20,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/fs.h>
 #include <linux/sysfs.h>
@@ -1016,6 +1017,78 @@ out:
 	return ret ?: nbytes;
 }
 
+/**
+ * rdtgroup_cbm_to_size - Translate CBM to size in bytes
+ * @r: RDT resource to which @d belongs.
+ * @d: RDT domain instance.
+ * @cbm: bitmask for which the size should be computed.
+ *
+ * The bitmask provided associated with the RDT domain instance @d will be
+ * translated into how many bytes it represents. The size in bytes is
+ * computed by first dividing the total cache size by the CBM length to
+ * determine how many bytes each bit in the bitmask represents. The result
+ * is multiplied with the number of bits set in the bitmask.
+ */
+unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
+				  struct rdt_domain *d, u32 cbm)
+{
+	struct cpu_cacheinfo *ci;
+	unsigned int size = 0;
+	int num_b, i;
+
+	num_b = bitmap_weight((unsigned long *)&cbm, r->cache.cbm_len);
+	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
+	for (i = 0; i < ci->num_leaves; i++) {
+		if (ci->info_list[i].level == r->cache_level) {
+			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
+			break;
+		}
+	}
+
+	return size;
+}
+
+/**
+ * rdtgroup_size_show - Display size in bytes of allocated regions
+ *
+ * The "size" file mirrors the layout of the "schemata" file, printing the
+ * size in bytes of each region instead of the capacity bitmask.
+ *
+ */
+static int rdtgroup_size_show(struct kernfs_open_file *of,
+			      struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	struct rdt_resource *r;
+	struct rdt_domain *d;
+	unsigned int size;
+	bool sep = false;
+	u32 cbm;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		seq_printf(s, "%*s:", max_name_width, r->name);
+		list_for_each_entry(d, &r->domains, list) {
+			if (sep)
+				seq_putc(s, ';');
+			cbm = d->ctrl_val[rdtgrp->closid];
+			size = rdtgroup_cbm_to_size(r, d, cbm);
+			seq_printf(s, "%d=%u", d->id, size);
+			sep = true;
+		}
+		seq_putc(s, '\n');
+	}
+
+	rdtgroup_kn_unlock(of->kn);
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1144,6 +1217,14 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_mode_show,
 		.fflags		= RF_CTRL_BASE,
 	},
+	{
+		.name		= "size",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_size_show,
+		.fflags		= RF_CTRL_BASE,
+	},
+
 };
 
 static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
