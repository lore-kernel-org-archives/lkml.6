Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04BAC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7927D2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7927D2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeJCVLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:11:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35021 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJCVLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:11:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w93EMwdw2374120
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 3 Oct 2018 07:22:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w93EMwbD2374117;
        Wed, 3 Oct 2018 07:22:58 -0700
Date:   Wed, 3 Oct 2018 07:22:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Xiaochen Shen <tipbot@zytor.com>
Message-ID: <tip-32ece95d3052e0778eab98fd9c2ffde92c599ce9@git.kernel.org>
Cc:     tony.luck@intel.com, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, tglx@linutronix.de, xiaochen.shen@intel.com,
        mingo@kernel.org, hpa@zytor.com
Reply-To: hpa@zytor.com, mingo@kernel.org, xiaochen.shen@intel.com,
          tglx@linutronix.de, fenghua.yu@intel.com,
          linux-kernel@vger.kernel.org, tony.luck@intel.com
In-Reply-To: <1536796118-60135-1-git-send-email-fenghua.yu@intel.com>
References: <1536796118-60135-1-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Show missing resctrl mount options
Git-Commit-ID: 32ece95d3052e0778eab98fd9c2ffde92c599ce9
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

Commit-ID:  32ece95d3052e0778eab98fd9c2ffde92c599ce9
Gitweb:     https://git.kernel.org/tip/32ece95d3052e0778eab98fd9c2ffde92c599ce9
Author:     Xiaochen Shen <xiaochen.shen@intel.com>
AuthorDate: Wed, 12 Sep 2018 16:48:38 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 3 Oct 2018 16:19:36 +0200

x86/intel_rdt: Show missing resctrl mount options

In resctrl filesystem, mount options exist to enable L3/L2 CDP and MBA
Software Controller features if the platform supports them:

 mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps]] /sys/fs/resctrl

But currently only "cdp" option is displayed in /proc/mounts. "cdpl2" and
"mba_MBps" options are not shown even when they are active.

Before:
 # mount -t resctrl resctrl -o cdp,mba_MBps /sys/fs/resctrl
 # grep resctrl /proc/mounts
 /sys/fs/resctrl /sys/fs/resctrl resctrl rw,relatime,cdp 0 0

After:
 # mount -t resctrl resctrl -o cdp,mba_MBps /sys/fs/resctrl
 # grep resctrl /proc/mounts
 /sys/fs/resctrl /sys/fs/resctrl resctrl rw,relatime,cdp,mba_MBps 0 0

Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H Peter Anvin" <hpa@zytor.com>
Cc: "Tony Luck" <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/1536796118-60135-1-git-send-email-fenghua.yu@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 1b8e86a5d5e1..82a487840eb2 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2795,6 +2795,13 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 {
 	if (rdt_resources_all[RDT_RESOURCE_L3DATA].alloc_enabled)
 		seq_puts(seq, ",cdp");
+
+	if (rdt_resources_all[RDT_RESOURCE_L2DATA].alloc_enabled)
+		seq_puts(seq, ",cdpl2");
+
+	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA]))
+		seq_puts(seq, ",mba_MBps");
+
 	return 0;
 }
 
