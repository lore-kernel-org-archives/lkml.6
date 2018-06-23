Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CBDC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD4824BC7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD4824BC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeFWMQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:16:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37579 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbeFWMQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:16:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCGiAj464460
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:16:44 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCGiuV464456;
        Sat, 23 Jun 2018 05:16:44 -0700
Date:   Sat, 23 Jun 2018 05:16:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-f7a6e3f6f5ffa4926818ea2b3e8994ecef00b84f@git.kernel.org>
Cc:     reinette.chatre@intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: reinette.chatre@intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <be9ea3969ffd731dfd90c0ebcd5a0e0a2d135bb2.1529706536.git.reinette.chatre@intel.com>
References: <be9ea3969ffd731dfd90c0ebcd5a0e0a2d135bb2.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Add utility to test if tasks
 assigned to resource group
Git-Commit-ID: f7a6e3f6f5ffa4926818ea2b3e8994ecef00b84f
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

Commit-ID:  f7a6e3f6f5ffa4926818ea2b3e8994ecef00b84f
Gitweb:     https://git.kernel.org/tip/f7a6e3f6f5ffa4926818ea2b3e8994ecef00b84f
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:10 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:45 +0200

x86/intel_rdt: Add utility to test if tasks assigned to resource group

In considering changes to a resource group it becomes necessary to know
whether tasks have been assigned to the resource group in question.

Introduce a new utility that can be used to check if any tasks have been
assigned to a particular resource group.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/be9ea3969ffd731dfd90c0ebcd5a0e0a2d135bb2.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.h          |  1 +
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 7b872f2cc294..11c76c4b9a5e 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -480,6 +480,7 @@ bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_domain *d,
 				  u32 cbm);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
+int rdtgroup_tasks_assigned(struct rdtgroup *r);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int update_domains(struct rdt_resource *r, int closid);
 void closid_free(int closid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 6eb716765a3f..59e1de9fe2d5 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -564,6 +564,32 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	return ret;
 }
 
+/**
+ * rdtgroup_tasks_assigned - Test if tasks have been assigned to resource group
+ * @r: Resource group
+ *
+ * Return: 1 if tasks have been assigned to @r, 0 otherwise
+ */
+int rdtgroup_tasks_assigned(struct rdtgroup *r)
+{
+	struct task_struct *p, *t;
+	int ret = 0;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	rcu_read_lock();
+	for_each_process_thread(p, t) {
+		if ((r->type == RDTCTRL_GROUP && t->closid == r->closid) ||
+		    (r->type == RDTMON_GROUP && t->rmid == r->mon.rmid)) {
+			ret = 1;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
 static int rdtgroup_task_write_permission(struct task_struct *task,
 					  struct kernfs_open_file *of)
 {
