Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1035CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AD820684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AD820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394085AbeKVUy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:54:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37715 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388115AbeKVUy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:54:57 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMAFdRW3744600
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 02:15:39 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMAFdjX3744597;
        Thu, 22 Nov 2018 02:15:39 -0800
Date:   Thu, 22 Nov 2018 02:15:39 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yafang Shao <tipbot@zytor.com>
Message-ID: <tip-c382986fe178d02abdfcd6f4e7b9783c2922872c@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        dvlasenk@redhat.com, peterz@infradead.org, brgerst@gmail.com,
        luto@amacapital.net, hpa@zytor.com, mingo@kernel.org,
        laoar.shao@gmail.com, torvalds@linux-foundation.org, bp@alien8.de
Reply-To: hpa@zytor.com, mingo@kernel.org, laoar.shao@gmail.com,
          bp@alien8.de, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          dvlasenk@redhat.com, peterz@infradead.org, luto@amacapital.net,
          brgerst@gmail.com
In-Reply-To: <1542798734-12532-1-git-send-email-laoar.shao@gmail.com>
References: <1542798734-12532-1-git-send-email-laoar.shao@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/process: Avoid unnecessary NULL check in
 get_wchan()
Git-Commit-ID: c382986fe178d02abdfcd6f4e7b9783c2922872c
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

Commit-ID:  c382986fe178d02abdfcd6f4e7b9783c2922872c
Gitweb:     https://git.kernel.org/tip/c382986fe178d02abdfcd6f4e7b9783c2922872c
Author:     Yafang Shao <laoar.shao@gmail.com>
AuthorDate: Wed, 21 Nov 2018 19:12:14 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 22 Nov 2018 10:07:21 +0100

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
index 8a33d4ad9661..b7cb5348f37f 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -733,7 +733,7 @@ unsigned long get_wchan(struct task_struct *p)
 	unsigned long start, bottom, top, sp, fp, ip, ret = 0;
 	int count = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (p == current || p->state == TASK_RUNNING)
 		return 0;
 
 	if (!try_get_task_stack(p))
