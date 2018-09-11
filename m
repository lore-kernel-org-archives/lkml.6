Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0E6C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D303A206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D303A206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeIKLUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:20:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35249 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeIKLUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:20:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8B6Llxa2135852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 23:21:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8B6Lkcg2135849;
        Mon, 10 Sep 2018 23:21:46 -0700
Date:   Mon, 10 Sep 2018 23:21:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for zhong jiang <tipbot@zytor.com>
Message-ID: <tip-ace8031099f91480799b5929b4cccf2dcacc5136@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, zhongjiang@huawei.com
Reply-To: torvalds@linux-foundation.org, zhongjiang@huawei.com,
          mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <1533299852-26941-1-git-send-email-zhongjiang@huawei.com>
References: <1533299852-26941-1-git-send-email-zhongjiang@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology: Make local variables static
Git-Commit-ID: ace8031099f91480799b5929b4cccf2dcacc5136
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

Commit-ID:  ace8031099f91480799b5929b4cccf2dcacc5136
Gitweb:     https://git.kernel.org/tip/ace8031099f91480799b5929b4cccf2dcacc5136
Author:     zhong jiang <zhongjiang@huawei.com>
AuthorDate: Fri, 3 Aug 2018 20:37:32 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 15:10:57 +0200

sched/topology: Make local variables static

Fix the following warnings:

  kernel/sched/topology.c:10:15: warning: symbol 'sched_domains_tmpmask' was not declared. Should it be static?
  kernel/sched/topology.c:11:15: warning: symbol 'sched_domains_tmpmask2' was not declared. Should it be static?

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1533299852-26941-1-git-send-email-zhongjiang@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 7ffad0d3a4eb..9d74371e4aad 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -7,8 +7,8 @@
 DEFINE_MUTEX(sched_domains_mutex);
 
 /* Protected by sched_domains_mutex: */
-cpumask_var_t sched_domains_tmpmask;
-cpumask_var_t sched_domains_tmpmask2;
+static cpumask_var_t sched_domains_tmpmask;
+static cpumask_var_t sched_domains_tmpmask2;
 
 #ifdef CONFIG_SCHED_DEBUG
 
