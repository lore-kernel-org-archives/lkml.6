Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5983C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5217A20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5217A20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbeG3VKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:10:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59049 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731722AbeG3VKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:10:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6UJXrbE2421730
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 12:33:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6UJXrV82421727;
        Mon, 30 Jul 2018 12:33:53 -0700
Date:   Mon, 30 Jul 2018 12:33:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mukesh Ojha <tipbot@zytor.com>
Message-ID: <tip-d018031f562b9c2eff038969ab1955a370c52d8f@git.kernel.org>
Cc:     mojha@codeaurora.org, hpa@zytor.com, malat@debian.org,
        tglx@linutronix.de, brendan.jackman@arm.com,
        jiangshanlai@gmail.com, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: brendan.jackman@arm.com, jiangshanlai@gmail.com,
          peterz@infradead.org, malat@debian.org, tglx@linutronix.de,
          hpa@zytor.com, mojha@codeaurora.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <1532443668-26810-1-git-send-email-mojha@codeaurora.org>
References: <1532443668-26810-1-git-send-email-mojha@codeaurora.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/hotplug] cpu/hotplug: Clarify CPU hotplug step name for
 timers
Git-Commit-ID: d018031f562b9c2eff038969ab1955a370c52d8f
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

Commit-ID:  d018031f562b9c2eff038969ab1955a370c52d8f
Gitweb:     https://git.kernel.org/tip/d018031f562b9c2eff038969ab1955a370c52d8f
Author:     Mukesh Ojha <mojha@codeaurora.org>
AuthorDate: Tue, 24 Jul 2018 20:17:48 +0530
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 30 Jul 2018 21:30:52 +0200

cpu/hotplug: Clarify CPU hotplug step name for timers

After commit 249d4a9b3246 ("timers: Reinitialize per cpu bases on hotplug")
i.e. the introduction of state CPUHP_TIMERS_PREPARE instead of
CPUHP_TIMERS_DEAD the step name "timers:dead" is not longer accurate.

Rename it to "timers:prepare".

[ tglx: Massaged changelog ]

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: gkohli@codeaurora.org
Cc: neeraju@codeaurora.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Brendan Jackman <brendan.jackman@arm.com>
Cc: Mathieu Malaterre <malat@debian.org>
Link: https://lkml.kernel.org/r/1532443668-26810-1-git-send-email-mojha@codeaurora.org

---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0db8938fbb23..8e6606ac3d72 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1274,7 +1274,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 	 * otherwise a RCU stall occurs.
 	 */
 	[CPUHP_TIMERS_PREPARE] = {
-		.name			= "timers:dead",
+		.name			= "timers:prepare",
 		.startup.single		= timers_prepare_cpu,
 		.teardown.single	= timers_dead_cpu,
 	},
