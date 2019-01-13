Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB5FC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 14:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87ED20879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 14:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfAMOXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 09:23:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36987 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAMOXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 09:23:03 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0DELvKM1627836
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 13 Jan 2019 06:21:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0DELtlN1627833;
        Sun, 13 Jan 2019 06:21:55 -0800
Date:   Sun, 13 Jan 2019 06:21:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Huang Zijiang <tipbot@zytor.com>
Message-ID: <tip-345dca4ca7e65a46bf0b6e2e6b8ab2e998ec6e91@git.kernel.org>
Cc:     rppt@linux.vnet.ibm.com, m.mizuma@jp.fujitsu.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        n-horiguchi@ah.jp.nec.com, hpa@zytor.com, huang.zijiang@zte.com.cn,
        bp@suse.de, mhocko@suse.com, joe@perches.com, x86@kernel.org,
        tglx@linutronix.de, akpm@linux-foundation.org, mingo@redhat.com
Reply-To: akpm@linux-foundation.org, tglx@linutronix.de, joe@perches.com,
          x86@kernel.org, mingo@redhat.com, m.mizuma@jp.fujitsu.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          rppt@linux.vnet.ibm.com, huang.zijiang@zte.com.cn, hpa@zytor.com,
          bp@suse.de, mhocko@suse.com, n-horiguchi@ah.jp.nec.com
In-Reply-To: <1547277384-22156-1-git-send-email-wang.yi59@zte.com.cn>
References: <1547277384-22156-1-git-send-email-wang.yi59@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/e820: Replace kmalloc() + memcpy() with
 kmemdup()
Git-Commit-ID: 345dca4ca7e65a46bf0b6e2e6b8ab2e998ec6e91
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

Commit-ID:  345dca4ca7e65a46bf0b6e2e6b8ab2e998ec6e91
Gitweb:     https://git.kernel.org/tip/345dca4ca7e65a46bf0b6e2e6b8ab2e998ec6e91
Author:     Huang Zijiang <huang.zijiang@zte.com.cn>
AuthorDate: Sat, 12 Jan 2019 15:16:24 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sun, 13 Jan 2019 15:11:35 +0100

x86/e820: Replace kmalloc() + memcpy() with kmemdup()

Use the equivalent kmemdup() directly instead of kmalloc() + memcpy().

No functional changes.

 [ bp: rewrite commit message. ]

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: jschoenh@amazon.de
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: xue.zhihong@zte.com.cn
Link: https://lkml.kernel.org/r/1547277384-22156-1-git-send-email-wang.yi59@zte.com.cn
---
 arch/x86/kernel/e820.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 50895c2f937d..a687d10da417 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -671,21 +671,18 @@ __init void e820__reallocate_tables(void)
 	int size;
 
 	size = offsetof(struct e820_table, entries) + sizeof(struct e820_entry)*e820_table->nr_entries;
-	n = kmalloc(size, GFP_KERNEL);
+	n = kmemdup(e820_table, size, GFP_KERNEL);
 	BUG_ON(!n);
-	memcpy(n, e820_table, size);
 	e820_table = n;
 
 	size = offsetof(struct e820_table, entries) + sizeof(struct e820_entry)*e820_table_kexec->nr_entries;
-	n = kmalloc(size, GFP_KERNEL);
+	n = kmemdup(e820_table_kexec, size, GFP_KERNEL);
 	BUG_ON(!n);
-	memcpy(n, e820_table_kexec, size);
 	e820_table_kexec = n;
 
 	size = offsetof(struct e820_table, entries) + sizeof(struct e820_entry)*e820_table_firmware->nr_entries;
-	n = kmalloc(size, GFP_KERNEL);
+	n = kmemdup(e820_table_firmware, size, GFP_KERNEL);
 	BUG_ON(!n);
-	memcpy(n, e820_table_firmware, size);
 	e820_table_firmware = n;
 }
 
