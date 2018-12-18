Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75558C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1282184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeLRLwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:52:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60905 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeLRLwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:52:15 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIBpsa72821019
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 03:51:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIBpsAm2821016;
        Tue, 18 Dec 2018 03:51:54 -0800
Date:   Tue, 18 Dec 2018 03:51:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for MogerBabu <tipbot@zytor.com>
Message-ID: <tip-0858ea05ee8b424e7776237b06bdfc7d6de0e014@git.kernel.org>
Cc:     Babu.Moger@amd.com, reinette.chatre@intel.com, mingo@kernel.org,
        babu.moger@amd.com, dan.carpenter@oracle.com, tglx@linutronix.de,
        hpa@zytor.com, fenghua.yu@intel.com, linux-kernel@vger.kernel.org,
        bp@alien8.de
Reply-To: linux-kernel@vger.kernel.org, bp@alien8.de, fenghua.yu@intel.com,
          hpa@zytor.com, tglx@linutronix.de, dan.carpenter@oracle.com,
          reinette.chatre@intel.com, babu.moger@amd.com, mingo@kernel.org,
          Babu.Moger@amd.com
In-Reply-To: <20181128201450.31820-1-babu.moger@amd.com>
References: <20181128201450.31820-1-babu.moger@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Fix the uninitialized variable warning
Git-Commit-ID: 0858ea05ee8b424e7776237b06bdfc7d6de0e014
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

Commit-ID:  0858ea05ee8b424e7776237b06bdfc7d6de0e014
Gitweb:     https://git.kernel.org/tip/0858ea05ee8b424e7776237b06bdfc7d6de0e014
Author:     MogerBabu <Babu.Moger@amd.com>
AuthorDate: Wed, 28 Nov 2018 20:15:02 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 18 Dec 2018 12:47:07 +0100

x86/resctrl: Fix the uninitialized variable warning

Fix the compiler warning caused by a recent change.

Fixes: a36c5ff560fb ("x86/resctrl: Bring cbm_validate() into the resource structure")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "bp@alien8.de" <bp@alien8.de>
Cc: "hpa@zytor.com" <hpa@zytor.com>
Cc: "fenghua.yu@intel.com" <fenghua.yu@intel.com>
Cc: "reinette.chatre@intel.com" <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20181128201450.31820-1-babu.moger@amd.com


---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 3b943ace786c..4b47ae76cccb 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -202,7 +202,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 	      struct rdt_domain *d)
 {
 	struct rdtgroup *rdtgrp = data->rdtgrp;
-	u32 cbm_val;
+	u32 cbm_val = 0;
 
 	if (d->have_new_ctrl) {
 		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
