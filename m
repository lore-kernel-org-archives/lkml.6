Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FDAC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34C420849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34C420849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeLKPXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:23:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37271 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbeLKPXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:23:08 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFM46O4038882
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:22:04 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFM4cU4038877;
        Tue, 11 Dec 2018 07:22:04 -0800
Date:   Tue, 11 Dec 2018 07:22:04 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-2421b7f3573babfe1673a5ffee1677a5013e6df1@git.kernel.org>
Cc:     aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        will.deacon@arm.com, longman@redhat.com, peterz@infradead.org,
        mingo@kernel.org, sasha.levin@oracle.com, tj@kernel.org,
        sergey.senozhatsky@gmail.com, hpa@zytor.com, tglx@linutronix.de,
        pmladek@suse.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Reply-To: sergey.senozhatsky@gmail.com, tj@kernel.org,
          sasha.levin@oracle.com, mingo@kernel.org, peterz@infradead.org,
          will.deacon@arm.com, longman@redhat.com,
          akpm@linux-foundation.org, aryabinin@virtuozzo.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          pmladek@suse.com, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <1542653726-5655-2-git-send-email-longman@redhat.com>
References: <1542653726-5655-2-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Remove ::version from
 lock_class structure
Git-Commit-ID: 2421b7f3573babfe1673a5ffee1677a5013e6df1
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

Commit-ID:  2421b7f3573babfe1673a5ffee1677a5013e6df1
Gitweb:     https://git.kernel.org/tip/2421b7f3573babfe1673a5ffee1677a5013e6df1
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 19 Nov 2018 13:55:10 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 14:54:46 +0100

locking/lockdep: Remove ::version from lock_class structure

It turns out the version field in the lock_class structure isn't used
anywhere. Just remove it.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: iommu@lists.linux-foundation.org
Cc: kasan-dev@googlegroups.com
Link: https://lkml.kernel.org/r/1542653726-5655-2-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/lockdep.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1fd82ff99c65..c5335df2372f 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -97,8 +97,6 @@ struct lock_class {
 	 * Generation counter, when doing certain classes of graph walking,
 	 * to ensure that we check one node only once:
 	 */
-	unsigned int			version;
-
 	int				name_version;
 	const char			*name;
 
