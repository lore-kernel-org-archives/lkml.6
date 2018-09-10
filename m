Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703B6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331AB20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331AB20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeIJPFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:05:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeIJPFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:05:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AACEW71807706
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:12:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AACDlq1807703;
        Mon, 10 Sep 2018 03:12:13 -0700
Date:   Mon, 10 Sep 2018 03:12:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Morten Rasmussen <tipbot@zytor.com>
Message-ID: <tip-3ba09df4b8b6e3f01ed6381e8fb890840fd0bca3@git.kernel.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de,
        will.deacon@arm.com, peterz@infradead.org, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        morten.rasmussen@arm.com, catalin.marinas@arm.com
Reply-To: catalin.marinas@arm.com, morten.rasmussen@arm.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          peterz@infradead.org, will.deacon@arm.com, tglx@linutronix.de,
          torvalds@linux-foundation.org
In-Reply-To: <1532093554-30504-4-git-send-email-morten.rasmussen@arm.com>
References: <1532093554-30504-4-git-send-email-morten.rasmussen@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology, arch/arm64: Rebuild the
 sched_domain hierarchy when the CPU capacity changes
Git-Commit-ID: 3ba09df4b8b6e3f01ed6381e8fb890840fd0bca3
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

Commit-ID:  3ba09df4b8b6e3f01ed6381e8fb890840fd0bca3
Gitweb:     https://git.kernel.org/tip/3ba09df4b8b6e3f01ed6381e8fb890840fd0bca3
Author:     Morten Rasmussen <morten.rasmussen@arm.com>
AuthorDate: Fri, 20 Jul 2018 14:32:33 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 11:05:47 +0200

sched/topology, arch/arm64: Rebuild the sched_domain hierarchy when the CPU capacity changes

Asymmetric CPU capacity can not necessarily be determined accurately at
the time the initial sched_domain hierarchy is built during boot. It is
therefore necessary to be able to force a full rebuild of the hierarchy
later triggered by the arch_topology driver. A full rebuild requires the
arch-code to implement arch_update_cpu_topology() which isn't yet
implemented for arm64. This patch points the arm64 implementation to
arch_topology driver to ensure that full hierarchy rebuild happens when
needed.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: dietmar.eggemann@arm.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Link: http://lkml.kernel.org/r/1532093554-30504-4-git-send-email-morten.rasmussen@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm64/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 49a0fee4f89b..0524f2438649 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -45,6 +45,9 @@ int pcibus_to_node(struct pci_bus *bus);
 /* Replace task scheduler's default cpu-invariant accounting */
 #define arch_scale_cpu_capacity topology_get_cpu_scale
 
+/* Enable topology flag updates */
+#define arch_update_cpu_topology topology_update_cpu_topology
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_ARM_TOPOLOGY_H */
