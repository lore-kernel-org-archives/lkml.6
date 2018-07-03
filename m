Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF58C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA9724D25
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA9724D25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753364AbeGCGnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:43:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56103 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeGCGnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:43:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w636gq13182621
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Jul 2018 23:42:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w636gqpT182618;
        Mon, 2 Jul 2018 23:42:52 -0700
Date:   Mon, 2 Jul 2018 23:42:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-ce730f1cc1255be152c879a2bc5f295d341d8036@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, reinette.chatre@intel.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, hpa@zytor.com, reinette.chatre@intel.com
In-Reply-To: <ef098ec2a45501e23792289bff80ae3152141e2f.1530421026.git.reinette.chatre@intel.com>
References: <ef098ec2a45501e23792289bff80ae3152141e2f.1530421026.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Move pseudo_lock_region_clear()
Git-Commit-ID: ce730f1cc1255be152c879a2bc5f295d341d8036
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

Commit-ID:  ce730f1cc1255be152c879a2bc5f295d341d8036
Gitweb:     https://git.kernel.org/tip/ce730f1cc1255be152c879a2bc5f295d341d8036
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Sat, 30 Jun 2018 22:03:02 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 3 Jul 2018 08:38:39 +0200

x86/intel_rdt: Move pseudo_lock_region_clear()

The pseudo_lock_region_clear() function is moved to earlier in the file in
preparation for its use in functions that currently appear before it. No
functional change.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/ef098ec2a45501e23792289bff80ae3152141e2f.1530421026.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 46 ++++++++++++++---------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 6e83f61552a5..1860ec10302d 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -246,6 +246,29 @@ out_err:
 	return ret;
 }
 
+/**
+ * pseudo_lock_region_clear - Reset pseudo-lock region data
+ * @plr: pseudo-lock region
+ *
+ * All content of the pseudo-locked region is reset - any memory allocated
+ * freed.
+ *
+ * Return: void
+ */
+static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
+{
+	plr->size = 0;
+	plr->line_size = 0;
+	kfree(plr->kmem);
+	plr->kmem = NULL;
+	plr->r = NULL;
+	if (plr->d)
+		plr->d->plr = NULL;
+	plr->d = NULL;
+	plr->cbm = 0;
+	plr->debugfs_dir = NULL;
+}
+
 /**
  * pseudo_lock_region_init - Initialize pseudo-lock region information
  * @plr: pseudo-lock region
@@ -318,29 +341,6 @@ static int pseudo_lock_init(struct rdtgroup *rdtgrp)
 	return 0;
 }
 
-/**
- * pseudo_lock_region_clear - Reset pseudo-lock region data
- * @plr: pseudo-lock region
- *
- * All content of the pseudo-locked region is reset - any memory allocated
- * freed.
- *
- * Return: void
- */
-static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
-{
-	plr->size = 0;
-	plr->line_size = 0;
-	kfree(plr->kmem);
-	plr->kmem = NULL;
-	plr->r = NULL;
-	if (plr->d)
-		plr->d->plr = NULL;
-	plr->d = NULL;
-	plr->cbm = 0;
-	plr->debugfs_dir = NULL;
-}
-
 /**
  * pseudo_lock_region_alloc - Allocate kernel memory that will be pseudo-locked
  * @plr: pseudo-lock region
