Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC5CC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985A724BA7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985A724BA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeFWMHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:07:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56091 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbeFWMHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:07:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NC73Ul463152
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:07:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NC71X1463147;
        Sat, 23 Jun 2018 05:07:01 -0700
Date:   Sat, 23 Jun 2018 05:07:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-32206ab36553be8714d9253ce33f4085681d369c@git.kernel.org>
Cc:     reinette.chatre@intel.com, sfr@canb.auug.org.au,
        viro@ZenIV.linux.org.uk, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, dhowells@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: reinette.chatre@intel.com, viro@ZenIV.linux.org.uk,
          sfr@canb.auug.org.au, mingo@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          dhowells@redhat.com
In-Reply-To: <410697ead08978bd12111c0afc4ce9e7bd71a5fe.1529706536.git.reinette.chatre@intel.com>
References: <410697ead08978bd12111c0afc4ce9e7bd71a5fe.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Provide pseudo-locking hooks within
 rdt_mount
Git-Commit-ID: 32206ab36553be8714d9253ce33f4085681d369c
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

Commit-ID:  32206ab36553be8714d9253ce33f4085681d369c
Gitweb:     https://git.kernel.org/tip/32206ab36553be8714d9253ce33f4085681d369c
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:41:52 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 12:53:19 +0200

x86/intel_rdt: Provide pseudo-locking hooks within rdt_mount

Stephen Rothwell reported that the Cache Pseudo-Locking enabling and the
kernfs support for mounting with fs_context are conflicting.

In preparation for a conflict-free merge between the two repos some no-op
hooks are created within the RDT mount function being changed by the two
features. The goal is for this commit to be placed on a minimal no-rebase
branch to be consumed by both features.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Cc: David Howells <dhowells@redhat.com>
Link: https://lkml.kernel.org/r/410697ead08978bd12111c0afc4ce9e7bd71a5fe.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.h          |  9 +++++++++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 10 +++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 39752825e376..be152b3b2543 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -468,4 +468,13 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 
+/*
+ * Define the hooks for Cache Pseudo-Locking to use within rdt_mount().
+ * These are no-ops provided for the new kernfs changes to use as a
+ * baseline in preparation for a conflict-free merge between it
+ * (kernfs changes) and the Cache Pseudo-Locking enabling.
+ */
+static inline int rdt_pseudo_lock_init(void) { return 0; }
+static inline void rdt_pseudo_lock_release(void) { }
+
 #endif /* _ASM_X86_INTEL_RDT_H */
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 749856a2e736..fa668f967062 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1289,10 +1289,16 @@ static struct dentry *rdt_mount(struct file_system_type *fs_type,
 		rdtgroup_default.mon.mon_data_kn = kn_mondata;
 	}
 
+	ret = rdt_pseudo_lock_init();
+	if (ret) {
+		dentry = ERR_PTR(ret);
+		goto out_mondata;
+	}
+
 	dentry = kernfs_mount(fs_type, flags, rdt_root,
 			      RDTGROUP_SUPER_MAGIC, NULL);
 	if (IS_ERR(dentry))
-		goto out_mondata;
+		goto out_psl;
 
 	if (rdt_alloc_capable)
 		static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
@@ -1310,6 +1316,8 @@ static struct dentry *rdt_mount(struct file_system_type *fs_type,
 
 	goto out;
 
+out_psl:
+	rdt_pseudo_lock_release();
 out_mondata:
 	if (rdt_mon_capable)
 		kernfs_remove(kn_mondata);
