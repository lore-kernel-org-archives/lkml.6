Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062D2C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53FE20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53FE20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754226AbeFTA3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:29:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44739 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752703AbeFTA3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:29:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0TcKH3299978
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:29:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0Tc3M3299974;
        Tue, 19 Jun 2018 17:29:38 -0700
Date:   Tue, 19 Jun 2018 17:29:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-3b99f70ad03e2108e378c33af0ff13219dd9935e@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, reinette.chatre@intel.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          reinette.chatre@intel.com, mingo@kernel.org
In-Reply-To: <5ae3b3fea500e814f72047572f0cf94c353e9081.1527593971.git.reinette.chatre@intel.com>
References: <5ae3b3fea500e814f72047572f0cf94c353e9081.1527593971.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Resctrl files reflect pseudo-locked
 information
Git-Commit-ID: 3b99f70ad03e2108e378c33af0ff13219dd9935e
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

Commit-ID:  3b99f70ad03e2108e378c33af0ff13219dd9935e
Gitweb:     https://git.kernel.org/tip/3b99f70ad03e2108e378c33af0ff13219dd9935e
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:56 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:38 +0200

x86/intel_rdt: Resctrl files reflect pseudo-locked information

Information about resources as well as resource groups are contained in a
variety of resctrl files. Now that pseudo-locked regions can be created the
files can be updated to present appropriate information to the user.

Update the resource group's schemata file to show only the information of
the pseudo-locked region.

Update the resource group's size file to show the size in bytes of only the
pseudo-locked region.

Update the bit_usage file to use the letter 'P' for all pseudo-locked
regions.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/5ae3b3fea500e814f72047572f0cf94c353e9081.1527593971.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c |  3 +++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 31 +++++++++++++++++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 6f4c0002b2c1..af358ca05160 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -402,6 +402,9 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 			for_each_alloc_enabled_rdt_resource(r)
 				seq_printf(s, "%s:uninitialized\n", r->name);
+		} else if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
+			seq_printf(s, "%s:%d=%x\n", rdtgrp->plr->r->name,
+				   rdtgrp->plr->d->id, rdtgrp->plr->cbm);
 		} else {
 			closid = rdtgrp->closid;
 			for_each_alloc_enabled_rdt_resource(r) {
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 3b21aa2cea4f..4e4b64338f9f 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -771,14 +771,16 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
  *   H - currently used by hardware only but available for software use
  *   S - currently used and shareable by software only
  *   E - currently used exclusively by one resource group
+ *   P - currently pseudo-locked by one resource group
  */
 static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			      struct seq_file *seq, void *v)
 {
 	struct rdt_resource *r = of->kn->parent->priv;
-	u32 sw_shareable, hw_shareable, exclusive;
+	u32 sw_shareable = 0, hw_shareable = 0;
+	u32 exclusive = 0, pseudo_locked = 0;
 	struct rdt_domain *dom;
-	int i, hwb, swb, excl;
+	int i, hwb, swb, excl, psl;
 	enum rdtgrp_mode mode;
 	bool sep = false;
 	u32 *ctrl;
@@ -803,12 +805,15 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			case RDT_MODE_EXCLUSIVE:
 				exclusive |= *ctrl;
 				break;
+			case RDT_MODE_PSEUDO_LOCKSETUP:
 			/*
-			 * Temporarily handle pseudo-locking enums
-			 * to silence compile warnings until handling
-			 * added in later patches.
+			 * RDT_MODE_PSEUDO_LOCKSETUP is possible
+			 * here but not included since the CBM
+			 * associated with this CLOSID in this mode
+			 * is not initialized and no task or cpu can be
+			 * assigned this CLOSID.
 			 */
-			case RDT_MODE_PSEUDO_LOCKSETUP:
+				break;
 			case RDT_MODE_PSEUDO_LOCKED:
 			case RDT_NUM_MODES:
 				WARN(1,
@@ -817,9 +822,11 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			}
 		}
 		for (i = r->cache.cbm_len - 1; i >= 0; i--) {
+			pseudo_locked = dom->plr ? dom->plr->cbm : 0;
 			hwb = test_bit(i, (unsigned long *)&hw_shareable);
 			swb = test_bit(i, (unsigned long *)&sw_shareable);
 			excl = test_bit(i, (unsigned long *)&exclusive);
+			psl = test_bit(i, (unsigned long *)&pseudo_locked);
 			if (hwb && swb)
 				seq_putc(seq, 'X');
 			else if (hwb && !swb)
@@ -828,6 +835,8 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 				seq_putc(seq, 'S');
 			else if (excl)
 				seq_putc(seq, 'E');
+			else if (psl)
+				seq_putc(seq, 'P');
 			else /* Unused bits remain */
 				seq_putc(seq, '0');
 		}
@@ -1147,6 +1156,15 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		return -ENOENT;
 	}
 
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
+		seq_printf(s, "%*s:", max_name_width, rdtgrp->plr->r->name);
+		size = rdtgroup_cbm_to_size(rdtgrp->plr->r,
+					    rdtgrp->plr->d,
+					    rdtgrp->plr->cbm);
+		seq_printf(s, "%d=%u\n", rdtgrp->plr->d->id, size);
+		goto out;
+	}
+
 	for_each_alloc_enabled_rdt_resource(r) {
 		seq_printf(s, "%*s:", max_name_width, r->name);
 		list_for_each_entry(d, &r->domains, list) {
@@ -1164,6 +1182,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		seq_putc(s, '\n');
 	}
 
+out:
 	rdtgroup_kn_unlock(of->kn);
 
 	return 0;
