Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CABC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD33206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD33206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeIKLRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:17:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38061 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeIKLRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:17:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8B6JW3m2135543
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 23:19:32 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8B6JVnM2135540;
        Mon, 10 Sep 2018 23:19:31 -0700
Date:   Mon, 10 Sep 2018 23:19:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for He Zhe <tipbot@zytor.com>
Message-ID: <tip-b1e3a25f5879017fc50ca17f03118b26a19df49a@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        zhe.he@windriver.com, torvalds@linux-foundation.org,
        peterz@infradead.org, mingo@kernel.org, hpa@zytor.com
Reply-To: peterz@infradead.org, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, zhe.he@windriver.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <1534260823-87917-2-git-send-email-zhe.he@windriver.com>
References: <1534260823-87917-2-git-send-email-zhe.he@windriver.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/corruption-check: Use pr_*() instead of printk()
Git-Commit-ID: b1e3a25f5879017fc50ca17f03118b26a19df49a
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

Commit-ID:  b1e3a25f5879017fc50ca17f03118b26a19df49a
Gitweb:     https://git.kernel.org/tip/b1e3a25f5879017fc50ca17f03118b26a19df49a
Author:     He Zhe <zhe.he@windriver.com>
AuthorDate: Tue, 14 Aug 2018 23:33:43 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 14:47:33 +0200

x86/corruption-check: Use pr_*() instead of printk()

pr_*() is the preferred style.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: gregkh@linuxfoundation.org
Cc: kstewart@linuxfoundation.org
Cc: pombredanne@nexb.com
Link: http://lkml.kernel.org/r/1534260823-87917-2-git-send-email-zhe.he@windriver.com
[ Moved all console output into a single line. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/check.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/check.c b/arch/x86/kernel/check.c
index cc8258a5378b..1979a76bfadd 100644
--- a/arch/x86/kernel/check.c
+++ b/arch/x86/kernel/check.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/kthread.h>
@@ -41,6 +44,7 @@ static __init int set_corruption_check(char *arg)
 		return ret;
 
 	memory_corruption_check = val;
+
 	return 0;
 }
 early_param("memory_corruption_check", set_corruption_check);
@@ -128,7 +132,7 @@ void __init setup_bios_corruption_check(void)
 	}
 
 	if (num_scan_areas)
-		printk(KERN_INFO "Scanning %d areas for low memory corruption\n", num_scan_areas);
+		pr_info("Scanning %d areas for low memory corruption\n", num_scan_areas);
 }
 
 
@@ -147,8 +151,7 @@ void check_for_bios_corruption(void)
 		for (; size; addr++, size -= sizeof(unsigned long)) {
 			if (!*addr)
 				continue;
-			printk(KERN_ERR "Corrupted low memory at %p (%lx phys) = %08lx\n",
-			       addr, __pa(addr), *addr);
+			pr_err("Corrupted low memory at %p (%lx phys) = %08lx\n", addr, __pa(addr), *addr);
 			corruption = 1;
 			*addr = 0;
 		}
@@ -172,11 +175,11 @@ static int start_periodic_check_for_corruption(void)
 	if (!num_scan_areas || !memory_corruption_check || corruption_check_period == 0)
 		return 0;
 
-	printk(KERN_INFO "Scanning for low memory corruption every %d seconds\n",
-	       corruption_check_period);
+	pr_info("Scanning for low memory corruption every %d seconds\n", corruption_check_period);
 
 	/* First time we run the checks right away */
 	schedule_delayed_work(&bios_check_work, 0);
+
 	return 0;
 }
 device_initcall(start_periodic_check_for_corruption);
