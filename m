Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836BAC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C61220881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C61220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeJPO0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:26:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49887 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeJPO0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:26:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9G6aqlm3981714
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Oct 2018 23:36:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9G6aqUD3981711;
        Mon, 15 Oct 2018 23:36:52 -0700
Date:   Mon, 15 Oct 2018 23:36:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-4766ab5677a2842834f9bc4a21587256a811531c@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, longman@redhat.com,
        will.deacon@arm.com, peterz@infradead.org,
        torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          longman@redhat.com, peterz@infradead.org, will.deacon@arm.com
In-Reply-To: <1539380547-16726-1-git-send-email-longman@redhat.com>
References: <1539380547-16726-1-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Remove duplicated
 'lock_class_ops' percpu array
Git-Commit-ID: 4766ab5677a2842834f9bc4a21587256a811531c
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

Commit-ID:  4766ab5677a2842834f9bc4a21587256a811531c
Gitweb:     https://git.kernel.org/tip/4766ab5677a2842834f9bc4a21587256a811531c
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Fri, 12 Oct 2018 17:42:27 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Oct 2018 08:21:10 +0200

locking/lockdep: Remove duplicated 'lock_class_ops' percpu array

Remove the duplicated 'lock_class_ops' percpu array that is not used
anywhere.

Signed-off-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: 8ca2b56cd7da ("locking/lockdep: Make class->ops a percpu counter and move it under CONFIG_DEBUG_LOCKDEP=y")
Link: http://lkml.kernel.org/r/1539380547-16726-1-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a0f83058d6aa..8a732c856624 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -436,7 +436,6 @@ unsigned int max_lockdep_depth;
  * Various lockdep statistics:
  */
 DEFINE_PER_CPU(struct lockdep_stats, lockdep_stats);
-DEFINE_PER_CPU(unsigned long [MAX_LOCKDEP_KEYS], lock_class_ops);
 #endif
 
 /*
