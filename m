Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0296EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CED213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CED213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeJDCru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:47:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37835 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeJDCru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:47:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w93Jvn732469307
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 3 Oct 2018 12:57:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w93Jvn042469304;
        Wed, 3 Oct 2018 12:57:49 -0700
Date:   Wed, 3 Oct 2018 12:57:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-53ed74af05517cf5fe83d87c4bb7ab998adfd631@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, reinette.chatre@intel.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, reinette.chatre@intel.com
In-Reply-To: <bfb9fc31692e0c62d9ca39062e55eceb6a0635b5.1537377064.git.reinette.chatre@intel.com>
References: <bfb9fc31692e0c62d9ca39062e55eceb6a0635b5.1537377064.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Re-enable pseudo-lock measurements
Git-Commit-ID: 53ed74af05517cf5fe83d87c4bb7ab998adfd631
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

Commit-ID:  53ed74af05517cf5fe83d87c4bb7ab998adfd631
Gitweb:     https://git.kernel.org/tip/53ed74af05517cf5fe83d87c4bb7ab998adfd631
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Wed, 19 Sep 2018 10:29:11 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 3 Oct 2018 21:53:35 +0200

x86/intel_rdt: Re-enable pseudo-lock measurements

Commit 4a7a54a55e72 ("x86/intel_rdt: Disable PMU access") disabled
measurements of pseudo-locked regions because of incorrect usage
of the performance monitoring hardware.

Cache pseudo-locking measurements are now done correctly with the
in-kernel perf API and its use can be re-enabled at this time.

The adjustment to the in-kernel perf API also separated the L2 and L3
measurements that can be triggered separately from user space. The
re-enabling of the measurements is thus not a simple revert of the
original disable in order to accommodate the additional parameter
possible.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: peterz@infradead.org
Cc: acme@kernel.org
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/bfb9fc31692e0c62d9ca39062e55eceb6a0635b5.1537377064.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index d68836139cf9..30e6c9f5a0ad 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -1236,7 +1236,7 @@ static ssize_t pseudo_lock_measure_trigger(struct file *file,
 	buf[buf_size] = '\0';
 	ret = kstrtoint(buf, 10, &sel);
 	if (ret == 0) {
-		if (sel != 1)
+		if (sel != 1 && sel != 2 && sel != 3)
 			return -EINVAL;
 		ret = debugfs_file_get(file->f_path.dentry);
 		if (ret)
