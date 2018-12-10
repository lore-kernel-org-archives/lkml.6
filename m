Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D05C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C722082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C722082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbeLJVCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:02:04 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:49413 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbeLJVCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:02:03 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MbS0X-1h3bi81p3B-00bqzx; Mon, 10 Dec 2018 22:01:41 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Muchun Song <smuchun@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: move capacity_margin definition into #ifdef
Date:   Mon, 10 Dec 2018 22:01:34 +0100
Message-Id: <20181210210139.3336002-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sFhP/E00aT2yakrdFlzHmg5gy3p+lzmEJNGvUoKaL8L2rNWrfT2
 KJjxIYF1eHYECe37uaDuq4URjU4insTc5/Jqc1g6daQtqzWv8jGuSWVsIC5JiX7lH/MzXT5
 43e05NtIVMsT4qq1V4WQ9nHo3/qcwPjAI6cd/ITySPFbxXkXako3VVhdUko2WEDkJhHA/rz
 aThVmfm0jgk6c7i89vPhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MnfSm3sZS00=:pLuQrK5BQHvbE646FlaG/Q
 9eMzmVxEf5skaHAZZIXKDde27FHUwOh3PRLsZaRkf2H+6EJGLFktC+adR/0AF0kUdXhgMldxa
 5j3fpb5z/zipNEz8O78kX0Et6HVkmKaf0ulGt5slPkL2xqAoxB6T4EuNfvVbeo9jCA1j0kiFE
 1Nz9lfSgZ9miiJZ0EVA7PXDBEGcaAozcxLHl8xCqnl/PtF8G1sZQuftmVsmMnwWLAD4k3iiUt
 OgfXw7KGNg1VlESJbWLS/4hQ2CAN93rJiCaDMlgMPAdhySTJAnKmPC6wK3CGQTy9FfuHnXjj5
 hjRM1yX12Y4YqvDZ+9qLch/ftVfg6W18iKO1iXMfKVL+fRoX/GojWCJy+LRgD2VNKIDpJ8GAT
 hNNMez4ldnewuE+v7ku8WTjMO5XVOJgQsoU2QPVHEu1LZBQ863+toKz/Svrf488GhTD3hn5kN
 nIbHjBdhIIkS9TqCb1JixxA2VCsn55CT0swdmLQuIYI3NBRmIupRNLIVrR5+3X+I5JQq7f7E3
 d8mO+zx2RxPo8wABPU+zpE4t1gfBXfDwMd9WBcS2vJDhTiYFkh31S8xZB1OZ+WzV3Tug4AMDL
 WuDxf0cysl7PJGBEJvAes+TSe1hPUXbZeBNvAXXGwbECsJ9DduScD1oCDvhG/1ZS8B7iVOZQS
 BINMN8fB61Alk7TusKMP1XDOhdnQp3iwbWQqzB6forHkHfiOq1dQNHiAcXg7n8T/h/+3gGR7v
 lQCLvSX0KNHHiEMQ/G3Ystdkj5ZvduyQDxxQyg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marking the variable static showed that it's only used for
SMP builds, as seen from this warning:

kernel/sched/fair.c:119:21: error: 'capacity_margin' defined but not used [-Werror=unused-variable]
 static unsigned int capacity_margin   = 1280;

This has apparently been true since the variable has first been
introduced, but only now started causing a compile time warning.

Fixes: ed8885a14433 ("sched/fair: Make some variables static")
Fixes: 3273163c6775 ("sched/fair: Let asymmetric CPU configurations balance at wake-up")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sched/fair.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e30dea59d215..27928809e6ed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -110,14 +110,6 @@ int __weak arch_asym_cpu_priority(int cpu)
 unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
 #endif
 
-/*
- * The margin used when comparing utilization with CPU capacity:
- * util * margin < capacity * 1024
- *
- * (default: ~20%)
- */
-static unsigned int capacity_margin			= 1280;
-
 static inline void update_load_add(struct load_weight *lw, unsigned long inc)
 {
 	lw->weight += inc;
@@ -3046,6 +3038,14 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 }
 
 #ifdef CONFIG_SMP
+/*
+ * The margin used when comparing utilization with CPU capacity:
+ * util * margin < capacity * 1024
+ *
+ * (default: ~20%)
+ */
+static unsigned int capacity_margin			= 1280;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 /**
  * update_tg_load_avg - update the tg's load avg
-- 
2.20.0

