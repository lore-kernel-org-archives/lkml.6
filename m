Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ECDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11DF206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11DF206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408246AbeKWRrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:47:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35267 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731655AbeKWRrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:47:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAN73v4e4102917
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 23:03:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAN73v0G4102914;
        Thu, 22 Nov 2018 23:03:57 -0800
Date:   Thu, 22 Nov 2018 23:03:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yafang Shao <tipbot@zytor.com>
Message-ID: <tip-6e662ae7bce6db602f79e57791f5fb887fb7d371@git.kernel.org>
Cc:     laoar.shao@gmail.com, brgerst@gmail.com, peterz@infradead.org,
        mingo@kernel.org, dvlasenk@redhat.com,
        linux-kernel@vger.kernel.org, bp@alien8.de,
        torvalds@linux-foundation.org, luto@amacapital.net,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: laoar.shao@gmail.com, brgerst@gmail.com, peterz@infradead.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          dvlasenk@redhat.com, bp@alien8.de, torvalds@linux-foundation.org,
          tglx@linutronix.de, luto@amacapital.net, hpa@zytor.com
In-Reply-To: <1542798734-12532-1-git-send-email-laoar.shao@gmail.com>
References: <1542798734-12532-1-git-send-email-laoar.shao@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/process: Avoid unnecessary NULL check in
 get_wchan()
Git-Commit-ID: 6e662ae7bce6db602f79e57791f5fb887fb7d371
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

Commit-ID:  6e662ae7bce6db602f79e57791f5fb887fb7d371
Gitweb:     https://git.kernel.org/tip/6e662ae7bce6db602f79e57791f5fb887fb7d371
Author:     Yafang Shao <laoar.shao@gmail.com>
AuthorDate: Wed, 21 Nov 2018 19:12:14 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 23 Nov 2018 07:58:23 +0100

x86/process: Avoid unnecessary NULL check in get_wchan()

Task 'p' is always guaranteed to be non-NULL, because the only call
sites are in fs/proc/ which all guarantee a non-NULL task pointer.

[ mingo: Improved the changelog. ]
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1542798734-12532-1-git-send-email-laoar.shao@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c93fcfdf1673..3c3ee8982577 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -730,7 +730,7 @@ unsigned long get_wchan(struct task_struct *p)
 	unsigned long start, bottom, top, sp, fp, ip, ret = 0;
 	int count = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (p == current || p->state == TASK_RUNNING)
 		return 0;
 
 	if (!try_get_task_stack(p))
