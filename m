Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CA7ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DBB20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DBB20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbeISDUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:20:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33495 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeISDUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:20:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8ILjfJk930418
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Sep 2018 14:45:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8ILjfp1930415;
        Tue, 18 Sep 2018 14:45:41 -0700
Date:   Tue, 18 Sep 2018 14:45:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-32d736abed4febff4b6bf85d5d240ee24d254322@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        xiaochen.shen@intel.com, reinette.chatre@intel.com,
        mingo@kernel.org, fenghua.yu@intel.com, tony.luck@intel.com,
        yu.c.chen@intel.com
Reply-To: yu.c.chen@intel.com, tony.luck@intel.com, fenghua.yu@intel.com,
          mingo@kernel.org, xiaochen.shen@intel.com,
          reinette.chatre@intel.com, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <1537048707-76280-7-git-send-email-fenghua.yu@intel.com>
References: <1537048707-76280-7-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/intel_rdt: Do not allow pseudo-locking of MBA
 resource
Git-Commit-ID: 32d736abed4febff4b6bf85d5d240ee24d254322
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

Commit-ID:  32d736abed4febff4b6bf85d5d240ee24d254322
Gitweb:     https://git.kernel.org/tip/32d736abed4febff4b6bf85d5d240ee24d254322
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Sat, 15 Sep 2018 14:58:24 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 18 Sep 2018 23:38:06 +0200

x86/intel_rdt: Do not allow pseudo-locking of MBA resource

A system supporting pseudo-locking may have MBA as well as CAT
resources of which only the CAT resources could support cache
pseudo-locking. When the schemata to be pseudo-locked is provided it
should be checked that that schemata does not attempt to pseudo-lock a
MBA resource.

Fixes: e0bdfe8e3 ("x86/intel_rdt: Support creation/removal of pseudo-locked region")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H Peter Anvin" <hpa@zytor.com>
Cc: "Tony Luck" <tony.luck@intel.com>
Cc: "Xiaochen Shen" <xiaochen.shen@intel.com>
Cc: "Chen Yu" <yu.c.chen@intel.com>
Link: https://lkml.kernel.org/r/1537048707-76280-7-git-send-email-fenghua.yu@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index edd5761f7336..0f53049719cd 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -195,6 +195,12 @@ static int parse_line(char *line, struct rdt_resource *r,
 	struct rdt_domain *d;
 	unsigned long dom_id;
 
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
+	    r->rid == RDT_RESOURCE_MBA) {
+		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
+		return -EINVAL;
+	}
+
 next:
 	if (!line || line[0] == '\0')
 		return 0;
