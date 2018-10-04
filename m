Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1728C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42AC2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42AC2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeJDQAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:00:36 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46154 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbeJDQAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:00:36 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id fa0c0c8122796c3e; Thu, 4 Oct 2018 11:08:16 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Subject: [PATCH] sched: core: Fix comment regarding nr_iowait_cpu() and get_iowait_load()
Date:   Thu, 04 Oct 2018 11:05:14 +0200
Message-ID: <3803514.xkx7zY50tF@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The comment related to nr_iowait_cpu() and get_iowait_load() confuses
cpufreq with cpuidle and is not very useful for this reason, so fix it.

Fixes: e33a9bba85a8 "sched/core: move IO scheduling accounting from io_schedule_timeout() into scheduler"
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/kernel/sched/core.c
===================================================================
--- linux-pm.orig/kernel/sched/core.c
+++ linux-pm/kernel/sched/core.c
@@ -2915,10 +2915,10 @@ unsigned long nr_iowait(void)
 }
 
 /*
- * Consumers of these two interfaces, like for example the cpufreq menu
- * governor are using nonsensical data. Boosting frequency for a CPU that has
- * IO-wait which might not even end up running the task when it does become
- * runnable.
+ * Consumers of these two interfaces, like for example the cpuidle menu
+ * governor, are using nonsensical data. Preferring shallow idle state selection
+ * for a CPU that has IO-wait which might not even end up running the task when
+ * it does become runnable.
  */
 
 unsigned long nr_iowait_cpu(int cpu)

