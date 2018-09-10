Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78AFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E5F20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E5F20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeIJPGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:06:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37751 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIJPGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:06:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AACklq1807755
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:12:46 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AACjAF1807752;
        Mon, 10 Sep 2018 03:12:45 -0700
Date:   Mon, 10 Sep 2018 03:12:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Morten Rasmussen <tipbot@zytor.com>
Message-ID: <tip-e1799a80a4f5a463f252b7325da8bb66dfd55471@git.kernel.org>
Cc:     linux@armlinux.org.uk, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, morten.rasmussen@arm.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Reply-To: linux@armlinux.org.uk, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          morten.rasmussen@arm.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org
In-Reply-To: <1532093554-30504-5-git-send-email-morten.rasmussen@arm.com>
References: <1532093554-30504-5-git-send-email-morten.rasmussen@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology, arch/arm: Rebuild sched_domain
 hierarchy when CPU capacity changes
Git-Commit-ID: e1799a80a4f5a463f252b7325da8bb66dfd55471
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

Commit-ID:  e1799a80a4f5a463f252b7325da8bb66dfd55471
Gitweb:     https://git.kernel.org/tip/e1799a80a4f5a463f252b7325da8bb66dfd55471
Author:     Morten Rasmussen <morten.rasmussen@arm.com>
AuthorDate: Fri, 20 Jul 2018 14:32:34 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 11:05:48 +0200

sched/topology, arch/arm: Rebuild sched_domain hierarchy when CPU capacity changes

Asymmetric CPU capacity can not necessarily be determined accurately at
the time the initial sched_domain hierarchy is built during boot. It is
therefore necessary to be able to force a full rebuild of the hierarchy
later triggered by the arch_topology driver. A full rebuild requires the
arch-code to implement arch_update_cpu_topology() which isn't yet
implemented for arm. This patch points the arm implementation to
arch_topology driver to ensure that full hierarchy rebuild happens when
needed.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Link: http://lkml.kernel.org/r/1532093554-30504-5-git-send-email-morten.rasmussen@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 5d88d2f22b2c..2a786f54d8b8 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -33,6 +33,9 @@ const struct cpumask *cpu_coregroup_mask(int cpu);
 /* Replace task scheduler's default cpu-invariant accounting */
 #define arch_scale_cpu_capacity topology_get_cpu_scale
 
+/* Enable topology flag updates */
+#define arch_update_cpu_topology topology_update_cpu_topology
+
 #else
 
 static inline void init_cpu_topology(void) { }
