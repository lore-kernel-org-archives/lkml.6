Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE860C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06BA20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06BA20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754311AbeFTAax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:30:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52471 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbeFTAau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:30:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0Uj2g3300257
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:30:45 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0UjbP3300254;
        Tue, 19 Jun 2018 17:30:45 -0700
Date:   Tue, 19 Jun 2018 17:30:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-b880ab2702eb426b2fcebce315a22f1b19003aa9@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, reinette.chatre@intel.com
Reply-To: reinette.chatre@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <1200798a50791186cd959d75aa3145409ca5151a.1527593971.git.reinette.chatre@intel.com>
References: <1200798a50791186cd959d75aa3145409ca5151a.1527593971.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Create resctrl debug area
Git-Commit-ID: b880ab2702eb426b2fcebce315a22f1b19003aa9
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

Commit-ID:  b880ab2702eb426b2fcebce315a22f1b19003aa9
Gitweb:     https://git.kernel.org/tip/b880ab2702eb426b2fcebce315a22f1b19003aa9
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:58 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:38 +0200

x86/intel_rdt: Create resctrl debug area

In preparation for support of debugging of RDT sub features the user can
now enable a RDT debugfs region.

The debug area is always enabled when CONFIG_DEBUG_FS is set as advised in
http://lkml.kernel.org/r/20180523080501.GA6822@kroah.com

Also from same discussion in above linked email, no error checking on the
debugfs creation return value since code should not behave differently when
debugging passes or fails. Even on failure the returned value can be passed
safely to other debugfs calls.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/1200798a50791186cd959d75aa3145409ca5151a.1527593971.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.h          |  2 ++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index c948266d59c8..bd3050c1ab6c 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -432,6 +432,8 @@ extern struct rdt_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 
+extern struct dentry *debugfs_resctrl;
+
 enum {
 	RDT_RESOURCE_L3,
 	RDT_RESOURCE_L3DATA,
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 89ac02f91238..68c8d3654e05 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -22,6 +22,7 @@
 
 #include <linux/cacheinfo.h>
 #include <linux/cpu.h>
+#include <linux/debugfs.h>
 #include <linux/fs.h>
 #include <linux/sysfs.h>
 #include <linux/kernfs.h>
@@ -56,6 +57,8 @@ static struct kernfs_node *kn_mondata;
 static struct seq_buf last_cmd_status;
 static char last_cmd_status_buf[512];
 
+struct dentry *debugfs_resctrl;
+
 void rdt_last_cmd_clear(void)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
@@ -2811,6 +2814,29 @@ int __init rdtgroup_init(void)
 	if (ret)
 		goto cleanup_mountpoint;
 
+	/*
+	 * Adding the resctrl debugfs directory here may not be ideal since
+	 * it would let the resctrl debugfs directory appear on the debugfs
+	 * filesystem before the resctrl filesystem is mounted.
+	 * It may also be ok since that would enable debugging of RDT before
+	 * resctrl is mounted.
+	 * The reason why the debugfs directory is created here and not in
+	 * rdt_mount() is because rdt_mount() takes rdtgroup_mutex and
+	 * during the debugfs directory creation also &sb->s_type->i_mutex_key
+	 * (the lockdep class of inode->i_rwsem). Other filesystem
+	 * interactions (eg. SyS_getdents) have the lock ordering:
+	 * &sb->s_type->i_mutex_key --> &mm->mmap_sem
+	 * During mmap(), called with &mm->mmap_sem, the rdtgroup_mutex
+	 * is taken, thus creating dependency:
+	 * &mm->mmap_sem --> rdtgroup_mutex for the latter that can cause
+	 * issues considering the other two lock dependencies.
+	 * By creating the debugfs directory here we avoid a dependency
+	 * that may cause deadlock (even though file operations cannot
+	 * occur until the filesystem is mounted, but I do not know how to
+	 * tell lockdep that).
+	 */
+	debugfs_resctrl = debugfs_create_dir("resctrl", NULL);
+
 	return 0;
 
 cleanup_mountpoint:
@@ -2823,6 +2849,7 @@ cleanup_root:
 
 void __exit rdtgroup_exit(void)
 {
+	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
 	kernfs_destroy_root(rdt_root);
