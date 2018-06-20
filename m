Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF863C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AE920693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AE920693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754101AbeFTAPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:15:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53525 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752861AbeFTAPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:15:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0Fk083296550
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:15:46 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0FkI73296547;
        Tue, 19 Jun 2018 17:15:46 -0700
Date:   Tue, 19 Jun 2018 17:15:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-c96f83bf49cc9efa568ff74f901554542b23d900@git.kernel.org>
Cc:     reinette.chatre@intel.com, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, reinette.chatre@intel.com
In-Reply-To: <2d44c94263cb89b04a4c01e6d59c8b3357208e9d.1527593970.git.reinette.chatre@intel.com>
References: <2d44c94263cb89b04a4c01e6d59c8b3357208e9d.1527593970.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Make useful functions available
 internally
Git-Commit-ID: c96f83bf49cc9efa568ff74f901554542b23d900
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

Commit-ID:  c96f83bf49cc9efa568ff74f901554542b23d900
Gitweb:     https://git.kernel.org/tip/c96f83bf49cc9efa568ff74f901554542b23d900
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:31 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:28 +0200

x86/intel_rdt: Make useful functions available internally

In support of the work done to enable resource groups to have different
modes some static functions need to be available for sharing amongst
all RDT components.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/2d44c94263cb89b04a4c01e6d59c8b3357208e9d.1527593970.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.h             | 2 ++
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 2 +-
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 7ff1f633bebe..5f3915c2e599 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -465,6 +465,8 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
+int update_domains(struct rdt_resource *r, int closid);
+void closid_free(int closid);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 116d57b248d3..2c23bb136ccc 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -175,7 +175,7 @@ next:
 	return -EINVAL;
 }
 
-static int update_domains(struct rdt_resource *r, int closid)
+int update_domains(struct rdt_resource *r, int closid)
 {
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index fdc55357251b..35e538eed977 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -121,7 +121,7 @@ static int closid_alloc(void)
 	return closid;
 }
 
-static void closid_free(int closid)
+void closid_free(int closid)
 {
 	closid_free_map |= 1 << closid;
 }
