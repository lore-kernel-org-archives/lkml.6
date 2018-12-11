Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2C1C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE9B20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE9B20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeLKP1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:27:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44173 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeLKP1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:27:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFQgHr4041021
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:26:42 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFQgno4041018;
        Tue, 11 Dec 2018 07:26:42 -0800
Date:   Tue, 11 Dec 2018 07:26:42 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-1431a5d2cfa18d7006d9b0e7ab4548d9bb19ce55@git.kernel.org>
Cc:     tglx@linutronix.de, sasha.levin@oracle.com, bvanassche@acm.org,
        johannes@sipsolutions.net, peterz@infradead.org, hpa@zytor.com,
        torvalds@linux-foundation.org, longman@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: peterz@infradead.org, torvalds@linux-foundation.org,
          hpa@zytor.com, longman@redhat.com, tglx@linutronix.de,
          bvanassche@acm.org, sasha.levin@oracle.com,
          johannes@sipsolutions.net, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20181207011148.251812-9-bvanassche@acm.org>
References: <20181207011148.251812-9-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Declare local symbols static
Git-Commit-ID: 1431a5d2cfa18d7006d9b0e7ab4548d9bb19ce55
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

Commit-ID:  1431a5d2cfa18d7006d9b0e7ab4548d9bb19ce55
Gitweb:     https://git.kernel.org/tip/1431a5d2cfa18d7006d9b0e7ab4548d9bb19ce55
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 6 Dec 2018 17:11:32 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 14:54:51 +0100

locking/lockdep: Declare local symbols static

This patch avoids that sparse complains about a missing declaration for
the lock_classes array when building with CONFIG_DEBUG_LOCKDEP=n.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: johannes.berg@intel.com
Cc: tj@kernel.org
Link: https://lkml.kernel.org/r/20181207011148.251812-9-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1efada2dd9dd..7434a00b2b2f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -138,6 +138,9 @@ static struct lock_list list_entries[MAX_LOCKDEP_ENTRIES];
  * get freed - this significantly simplifies the debugging code.
  */
 unsigned long nr_lock_classes;
+#ifndef CONFIG_DEBUG_LOCKDEP
+static
+#endif
 struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
 
 static inline struct lock_class *hlock_class(struct held_lock *hlock)
