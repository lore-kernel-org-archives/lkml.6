Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A0DC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E43820855
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E43820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeFWMSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:18:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46163 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbeFWMSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:18:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCISP2464787
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:18:28 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCIRJO464784;
        Sat, 23 Jun 2018 05:18:27 -0700
Date:   Sat, 23 Jun 2018 05:18:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-2a5d76a4fc6469ea9dd6f02fcd4dad3a129bc1c0@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, reinette.chatre@intel.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          reinette.chatre@intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <ab6319d1244366be3f9b7f9fba1c3da4810a274b.1529706536.git.reinette.chatre@intel.com>
References: <ab6319d1244366be3f9b7f9fba1c3da4810a274b.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Utilities to restrict/restore access
 to specific files
Git-Commit-ID: 2a5d76a4fc6469ea9dd6f02fcd4dad3a129bc1c0
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

Commit-ID:  2a5d76a4fc6469ea9dd6f02fcd4dad3a129bc1c0
Gitweb:     https://git.kernel.org/tip/2a5d76a4fc6469ea9dd6f02fcd4dad3a129bc1c0
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:13 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:46 +0200

x86/intel_rdt: Utilities to restrict/restore access to specific files

In support of Cache Pseudo-Locking we need to restrict access to specific
resctrl files to protect the state of a resource group used for
pseudo-locking from being changed in unsupported ways.

Introduce two utilities that can be used to either restrict or restore the
access to all files irrelevant to cache pseudo-locking when pseudo-locking
in progress for the resource group.

At this time introduce a new source file, intel_rdt_pseudo_lock.c, that
will contain most of the code related to cache pseudo-locking.

Temporarily mark these new functions as unused to silence compile warnings
until they are used.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/ab6319d1244366be3f9b7f9fba1c3da4810a274b.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/Makefile                |   3 +-
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 113 ++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 7a40196967cb..c4e02555563a 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -35,7 +35,8 @@ obj-$(CONFIG_CPU_SUP_CENTAUR)		+= centaur.o
 obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+= transmeta.o
 obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
 
-obj-$(CONFIG_INTEL_RDT)	+= intel_rdt.o intel_rdt_rdtgroup.o intel_rdt_monitor.o intel_rdt_ctrlmondata.o
+obj-$(CONFIG_INTEL_RDT)	+= intel_rdt.o intel_rdt_rdtgroup.o intel_rdt_monitor.o
+obj-$(CONFIG_INTEL_RDT)	+= intel_rdt_ctrlmondata.o intel_rdt_pseudo_lock.o
 
 obj-$(CONFIG_X86_MCE)			+= mcheck/
 obj-$(CONFIG_MTRR)			+= mtrr/
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
new file mode 100644
index 000000000000..dc79b3090ac5
--- /dev/null
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Resource Director Technology (RDT)
+ *
+ * Pseudo-locking support built on top of Cache Allocation Technology (CAT)
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Author: Reinette Chatre <reinette.chatre@intel.com>
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include "intel_rdt.h"
+
+/**
+ * rdtgroup_locksetup_user_restrict - Restrict user access to group
+ * @rdtgrp: resource group needing access restricted
+ *
+ * A resource group used for cache pseudo-locking cannot have cpus or tasks
+ * assigned to it. This is communicated to the user by restricting access
+ * to all the files that can be used to make such changes.
+ *
+ * Permissions restored with rdtgroup_locksetup_user_restore()
+ *
+ * Return: 0 on success, <0 on failure. If a failure occurs during the
+ * restriction of access an attempt will be made to restore permissions but
+ * the state of the mode of these files will be uncertain when a failure
+ * occurs.
+ */
+static int __attribute__ ((unused))
+rdtgroup_locksetup_user_restrict(struct rdtgroup *rdtgrp)
+{
+	int ret;
+
+	ret = rdtgroup_kn_mode_restrict(rdtgrp, "tasks");
+	if (ret)
+		return ret;
+
+	ret = rdtgroup_kn_mode_restrict(rdtgrp, "cpus");
+	if (ret)
+		goto err_tasks;
+
+	ret = rdtgroup_kn_mode_restrict(rdtgrp, "cpus_list");
+	if (ret)
+		goto err_cpus;
+
+	if (rdt_mon_capable) {
+		ret = rdtgroup_kn_mode_restrict(rdtgrp, "mon_groups");
+		if (ret)
+			goto err_cpus_list;
+	}
+
+	ret = 0;
+	goto out;
+
+err_cpus_list:
+	rdtgroup_kn_mode_restore(rdtgrp, "cpus_list");
+err_cpus:
+	rdtgroup_kn_mode_restore(rdtgrp, "cpus");
+err_tasks:
+	rdtgroup_kn_mode_restore(rdtgrp, "tasks");
+out:
+	return ret;
+}
+
+/**
+ * rdtgroup_locksetup_user_restore - Restore user access to group
+ * @rdtgrp: resource group needing access restored
+ *
+ * Restore all file access previously removed using
+ * rdtgroup_locksetup_user_restrict()
+ *
+ * Return: 0 on success, <0 on failure.  If a failure occurs during the
+ * restoration of access an attempt will be made to restrict permissions
+ * again but the state of the mode of these files will be uncertain when
+ * a failure occurs.
+ */
+static int __attribute__ ((unused))
+rdtgroup_locksetup_user_restore(struct rdtgroup *rdtgrp)
+{
+	int ret;
+
+	ret = rdtgroup_kn_mode_restore(rdtgrp, "tasks");
+	if (ret)
+		return ret;
+
+	ret = rdtgroup_kn_mode_restore(rdtgrp, "cpus");
+	if (ret)
+		goto err_tasks;
+
+	ret = rdtgroup_kn_mode_restore(rdtgrp, "cpus_list");
+	if (ret)
+		goto err_cpus;
+
+	if (rdt_mon_capable) {
+		ret = rdtgroup_kn_mode_restore(rdtgrp, "mon_groups");
+		if (ret)
+			goto err_cpus_list;
+	}
+
+	ret = 0;
+	goto out;
+
+err_cpus_list:
+	rdtgroup_kn_mode_restrict(rdtgrp, "cpus_list");
+err_cpus:
+	rdtgroup_kn_mode_restrict(rdtgrp, "cpus");
+err_tasks:
+	rdtgroup_kn_mode_restrict(rdtgrp, "tasks");
+out:
+	return ret;
+}
