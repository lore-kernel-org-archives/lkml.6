Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93E2C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A1E2150F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A1E2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeFWMTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:19:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42963 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeFWMTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:19:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCIwdj464834
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:18:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCIwc0464831;
        Sat, 23 Jun 2018 05:18:58 -0700
Date:   Sat, 23 Jun 2018 05:18:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-bbcee99b67c5a8cc4e8037d561be9ed293961fd3@git.kernel.org>
Cc:     hpa@zytor.com, reinette.chatre@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, reinette.chatre@intel.com, hpa@zytor.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <14fd9494f87ca72a213b3a197d1172d4e66ae196.1529706536.git.reinette.chatre@intel.com>
References: <14fd9494f87ca72a213b3a197d1172d4e66ae196.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Add check to determine if monitoring
 in progress
Git-Commit-ID: bbcee99b67c5a8cc4e8037d561be9ed293961fd3
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

Commit-ID:  bbcee99b67c5a8cc4e8037d561be9ed293961fd3
Gitweb:     https://git.kernel.org/tip/bbcee99b67c5a8cc4e8037d561be9ed293961fd3
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:14 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:47 +0200

x86/intel_rdt: Add check to determine if monitoring in progress

When a resource group is pseudo-locked it is orphaned without a class of
service associated with it. We thus do not want any monitoring in progress
on a resource group that will be used for pseudo-locking.

Introduce a test that can be used to determine if pseudo-locking in
progress on a resource group. Temporarily mark it as unused to avoid
compile warnings until it is used.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/14fd9494f87ca72a213b3a197d1172d4e66ae196.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index dc79b3090ac5..8693dbe602a2 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -13,6 +13,19 @@
 
 #include "intel_rdt.h"
 
+/**
+ * rdtgroup_monitor_in_progress - Test if monitoring in progress
+ * @r: resource group being queried
+ *
+ * Return: 1 if monitor groups have been created for this resource
+ * group, 0 otherwise.
+ */
+static int __attribute__ ((unused))
+rdtgroup_monitor_in_progress(struct rdtgroup *rdtgrp)
+{
+	return !list_empty(&rdtgrp->mon.crdtgrp_list);
+}
+
 /**
  * rdtgroup_locksetup_user_restrict - Restrict user access to group
  * @rdtgrp: resource group needing access restricted
