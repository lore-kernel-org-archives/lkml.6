Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FE1ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CC220C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CC220C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbeISDSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:18:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38093 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbeISDSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:18:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8ILhxC8928627
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Sep 2018 14:43:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8ILhxmd928624;
        Tue, 18 Sep 2018 14:43:59 -0700
Date:   Tue, 18 Sep 2018 14:43:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-c793da8e4c62d2c002a79c47f44efead450cbcae@git.kernel.org>
Cc:     fenghua.yu@intel.com, hpa@zytor.com, tglx@linutronix.de,
        yu.c.chen@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, xiaochen.shen@intel.com,
        reinette.chatre@intel.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, fenghua.yu@intel.com,
          tony.luck@intel.com, yu.c.chen@intel.com,
          reinette.chatre@intel.com, xiaochen.shen@intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <1537048707-76280-4-git-send-email-fenghua.yu@intel.com>
References: <1537048707-76280-4-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/intel_rdt: Global closid helper to support
 future fixes
Git-Commit-ID: c793da8e4c62d2c002a79c47f44efead450cbcae
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

Commit-ID:  c793da8e4c62d2c002a79c47f44efead450cbcae
Gitweb:     https://git.kernel.org/tip/c793da8e4c62d2c002a79c47f44efead450cbcae
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Sat, 15 Sep 2018 14:58:21 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 18 Sep 2018 23:38:05 +0200

x86/intel_rdt: Global closid helper to support future fixes

The number of CLOSIDs supported by a system is the minimum number of
CLOSIDs supported by any of its resources. Care should be taken when
iterating over the CLOSIDs of a resource since it may be that the number
of CLOSIDs supported on the system is less than the number of CLOSIDs
supported by the resource.

Introduce a helper function that can be used to query the number of
CLOSIDs that is supported by all resources, irrespective of how many
CLOSIDs are supported by a particular resource.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H Peter Anvin" <hpa@zytor.com>
Cc: "Tony Luck" <tony.luck@intel.com>
Cc: "Xiaochen Shen" <xiaochen.shen@intel.com>
Cc: "Chen Yu" <yu.c.chen@intel.com>
Link: https://lkml.kernel.org/r/1537048707-76280-4-git-send-email-fenghua.yu@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.h          | 1 +
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 78266c798280..285eb3ec4200 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -544,6 +544,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
 void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int update_domains(struct rdt_resource *r, int closid);
+int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 32e8bbdf2400..b372923eb209 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -97,6 +97,12 @@ void rdt_last_cmd_printf(const char *fmt, ...)
  *   limited as the number of resources grows.
  */
 static int closid_free_map;
+static int closid_free_map_len;
+
+int closids_supported(void)
+{
+	return closid_free_map_len;
+}
 
 static void closid_init(void)
 {
@@ -111,6 +117,7 @@ static void closid_init(void)
 
 	/* CLOSID 0 is always reserved for the default group */
 	closid_free_map &= ~1;
+	closid_free_map_len = rdt_min_closid;
 }
 
 static int closid_alloc(void)
