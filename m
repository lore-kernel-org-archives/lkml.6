Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447B3C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CAB24BBF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CAB24BBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeFWMPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:15:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47869 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbeFWMPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:15:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCFdP5464352
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:15:39 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCFd4s464349;
        Sat, 23 Jun 2018 05:15:39 -0700
Date:   Sat, 23 Jun 2018 05:15:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-bb9fec69cb41380428d6b8dab3a303189a9b480a@git.kernel.org>
Cc:     reinette.chatre@intel.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, reinette.chatre@intel.com, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <98d6ca129bbe7dd0932d1fcfeb3cbb65f29a8d9d.1529706536.git.reinette.chatre@intel.com>
References: <98d6ca129bbe7dd0932d1fcfeb3cbb65f29a8d9d.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Introduce the Cache Pseudo-Locking
 modes
Git-Commit-ID: bb9fec69cb41380428d6b8dab3a303189a9b480a
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

Commit-ID:  bb9fec69cb41380428d6b8dab3a303189a9b480a
Gitweb:     https://git.kernel.org/tip/bb9fec69cb41380428d6b8dab3a303189a9b480a
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:08 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:45 +0200

x86/intel_rdt: Introduce the Cache Pseudo-Locking modes

The two modes used to manage Cache Pseudo-Locked regions are introduced.  A
resource group is assigned "pseudo-locksetup" mode when the user indicates
that this resource group will be used for a Cache Pseudo-Locked
region. When the Cache Pseudo-Locked region has been set up successfully
after the user wrote the requested schemata to the "schemata" file, then
the mode will automatically changed to "pseudo-locked".  The user is not
able to modify the mode to "pseudo-locked" by writing "pseudo-locked" to
the "mode" file directly.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/98d6ca129bbe7dd0932d1fcfeb3cbb65f29a8d9d.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.h          | 10 ++++++++++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 13 +++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index ed20e91c28ed..7b872f2cc294 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -84,15 +84,25 @@ enum rdt_group_type {
  * enum rdtgrp_mode - Mode of a RDT resource group
  * @RDT_MODE_SHAREABLE: This resource group allows sharing of its allocations
  * @RDT_MODE_EXCLUSIVE: No sharing of this resource group's allocations allowed
+ * @RDT_MODE_PSEUDO_LOCKSETUP: Resource group will be used for Pseudo-Locking
+ * @RDT_MODE_PSEUDO_LOCKED: No sharing of this resource group's allocations
+ *                          allowed AND the allocations are Cache Pseudo-Locked
  *
  * The mode of a resource group enables control over the allowed overlap
  * between allocations associated with different resource groups (classes
  * of service). User is able to modify the mode of a resource group by
  * writing to the "mode" resctrl file associated with the resource group.
+ *
+ * The "shareable", "exclusive", and "pseudo-locksetup" modes are set by
+ * writing the appropriate text to the "mode" file. A resource group enters
+ * "pseudo-locked" mode after the schemata is written while the resource
+ * group is in "pseudo-locksetup" mode.
  */
 enum rdtgrp_mode {
 	RDT_MODE_SHAREABLE = 0,
 	RDT_MODE_EXCLUSIVE,
+	RDT_MODE_PSEUDO_LOCKSETUP,
+	RDT_MODE_PSEUDO_LOCKED,
 
 	/* Must be last */
 	RDT_NUM_MODES,
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index cde0f4114d4e..fef92b939f0f 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -161,8 +161,10 @@ enum rdtgrp_mode rdtgroup_mode_by_closid(int closid)
 }
 
 static const char * const rdt_mode_str[] = {
-	[RDT_MODE_SHAREABLE]	= "shareable",
-	[RDT_MODE_EXCLUSIVE]	= "exclusive",
+	[RDT_MODE_SHAREABLE]		= "shareable",
+	[RDT_MODE_EXCLUSIVE]		= "exclusive",
+	[RDT_MODE_PSEUDO_LOCKSETUP]	= "pseudo-locksetup",
+	[RDT_MODE_PSEUDO_LOCKED]	= "pseudo-locked",
 };
 
 /**
@@ -759,6 +761,13 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			case RDT_MODE_EXCLUSIVE:
 				exclusive |= *ctrl;
 				break;
+			/*
+			 * Temporarily handle pseudo-locking enums
+			 * to silence compile warnings until handling
+			 * added in later patches.
+			 */
+			case RDT_MODE_PSEUDO_LOCKSETUP:
+			case RDT_MODE_PSEUDO_LOCKED:
 			case RDT_NUM_MODES:
 				WARN(1,
 				     "invalid mode for closid %d\n", i);
