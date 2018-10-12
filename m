Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0961FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C2420868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C2420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeJLSZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:25:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60431 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJLSZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:25:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9CAps7J2313186
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Oct 2018 03:51:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9CApsnG2313183;
        Fri, 12 Oct 2018 03:51:54 -0700
Date:   Fri, 12 Oct 2018 03:51:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-f703fd374ef8fb06e46713b326d255e20d6278ad@git.kernel.org>
Cc:     tglx@linutronix.de, bp@alien8.de, yuehaibing@huawei.com,
        hpa@zytor.com, torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        andriy.shevchenko@linux.intel.com
Reply-To: bp@alien8.de, tglx@linutronix.de, hpa@zytor.com,
          yuehaibing@huawei.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, torvalds@linux-foundation.org,
          andriy.shevchenko@linux.intel.com, mingo@kernel.org
In-Reply-To: <1539340822-117563-1-git-send-email-yuehaibing@huawei.com>
References: <1539340822-117563-1-git-send-email-yuehaibing@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] x86/cpu: Drop pointless static qualifier in
 punit_dev_state_show()
Git-Commit-ID: f703fd374ef8fb06e46713b326d255e20d6278ad
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

Commit-ID:  f703fd374ef8fb06e46713b326d255e20d6278ad
Gitweb:     https://git.kernel.org/tip/f703fd374ef8fb06e46713b326d255e20d6278ad
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Fri, 12 Oct 2018 10:40:22 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 12 Oct 2018 12:48:44 +0200

x86/cpu: Drop pointless static qualifier in punit_dev_state_show()

There is no need to have the 'struct dentry *dev_state' variable static
since new value always be assigned before use it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-janitors@vger.kernel.org
Link: http://lkml.kernel.org/r/1539340822-117563-1-git-send-email-yuehaibing@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/platform/atom/punit_atom_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/atom/punit_atom_debug.c b/arch/x86/platform/atom/punit_atom_debug.c
index 41dae0f0d898..6cb6076223ba 100644
--- a/arch/x86/platform/atom/punit_atom_debug.c
+++ b/arch/x86/platform/atom/punit_atom_debug.c
@@ -115,7 +115,7 @@ static struct dentry *punit_dbg_file;
 
 static int punit_dbgfs_register(struct punit_device *punit_device)
 {
-	static struct dentry *dev_state;
+	struct dentry *dev_state;
 
 	punit_dbg_file = debugfs_create_dir("punit_atom", NULL);
 	if (!punit_dbg_file)
