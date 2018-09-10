Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27C9C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891E020870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891E020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbeIJRcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:32:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40605 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIJRcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:32:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8ACc0761846532
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 05:38:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8ACc0px1846529;
        Mon, 10 Sep 2018 05:38:00 -0700
Date:   Mon, 10 Sep 2018 05:38:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sasha Levin <tipbot@zytor.com>
Message-ID: <tip-16214312df6d5aaa5324864d032ce565e97f8890@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, alexander.levin@microsoft.com,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        Alexander.Levin@microsoft.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org,
          Alexander.Levin@microsoft.com, mingo@kernel.org,
          tglx@linutronix.de, peterz@infradead.org,
          torvalds@linux-foundation.org, alexander.levin@microsoft.com
In-Reply-To: <20180813190527.16853-4-alexander.levin@microsoft.com>
References: <20180813190527.16853-4-alexander.levin@microsoft.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] tools/lib/lockdep: Add dummy task_struct state
 member
Git-Commit-ID: 16214312df6d5aaa5324864d032ce565e97f8890
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

Commit-ID:  16214312df6d5aaa5324864d032ce565e97f8890
Gitweb:     https://git.kernel.org/tip/16214312df6d5aaa5324864d032ce565e97f8890
Author:     Sasha Levin <Alexander.Levin@microsoft.com>
AuthorDate: Mon, 13 Aug 2018 19:05:39 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 13:48:24 +0200

tools/lib/lockdep: Add dummy task_struct state member

Commit:

  8cc05c71ba5f ("locking/lockdep: Move sanity check to inside lockdep_print_held_locks()")

added accesses to the task_struct's state member. Add dummy userspace declaration.

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180813190527.16853-4-alexander.levin@microsoft.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/include/linux/lockdep.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/linux/lockdep.h b/tools/include/linux/lockdep.h
index 6b0c36a58fcb..e56997288f2b 100644
--- a/tools/include/linux/lockdep.h
+++ b/tools/include/linux/lockdep.h
@@ -30,9 +30,12 @@ struct task_struct {
 	struct held_lock held_locks[MAX_LOCK_DEPTH];
 	gfp_t lockdep_reclaim_gfp;
 	int pid;
+	int state;
 	char comm[17];
 };
 
+#define TASK_RUNNING 0
+
 extern struct task_struct *__curr(void);
 
 #define current (__curr())
