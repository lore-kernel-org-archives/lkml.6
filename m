Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70298C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7CE2177F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="0l/jvN1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7CE2177F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeHUTYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:24:52 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:39806 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeHUTYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:24:51 -0400
Received: by mail-yb0-f195.google.com with SMTP id c4-v6so6147352ybl.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=HQveg+wwOvTMgdq8w8V2TDKUdmzAZcRDjRhbO3q1zV8=;
        b=0l/jvN1YJk7d1P79vzNblx2RXEFZ05NKLc8X7lXMrwjyeWL8pCT5aqWoohrk+lsppp
         Zkh1FJTP/GVyTfoCHUBwZvt/vRq1Grva0fuG/+ocLK9jR4mX4BHCLGNpLytptrmD/HUo
         ekuSezfHj9CEUVzoMrFbKK8QXyhtddhDsjDicxzwwF7Ejnzp8rtwwI3+5OfABBap5ObG
         0B+PTiAICHD470ZOQf1QtlXk0atuMOw4JzYy/SjzEfLoJoaiNb39csjsaBPktqZitd6b
         6DW3ceomGLxsrWsHBBiOfcmgq0vbAnHIUKZTUiBGBaNcSwDQ/XWKB24bDd8C/FRwDzoM
         Djpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HQveg+wwOvTMgdq8w8V2TDKUdmzAZcRDjRhbO3q1zV8=;
        b=S3fL9cabzozKXWB+JFj7xi9ozr7Y+ANdLqiLP0eBsXwkayAJNMp8ZNCRuRIlgtyww+
         +ngIW48UR6YI2rspo1cVFqwxyECY53UObI9jbtQQ5ldIqYngwfv4luw1yZuBUIlkqMIT
         PsWqkC2naPHl/k1mHwL5ctJwZgUcok07wxdBVZR5WMr0cjlYNgQdqKkG7mpwoP9+s4qY
         sYB2VkdIBD7r/mKdkZzoSOqwYEDVFPBCjBUfNAOx5E3uhJaUr6dAdN+ZMNApgLVCl/YP
         BNaCQ3Ys80uYVpv2MfqWUrdvJb7Y1HmrVOU+HB/OC3VhLpWBX5x3wMalqyL+wrJsPbMi
         G5gg==
X-Gm-Message-State: AOUpUlH4alpMG2n+XQR5HEM2VqM6b2MaOVtXjwG+QazFIXcRocRe1XpA
        sz+GKMdLGpWheJ9uwaFo8q4H+E2jEZ0=
X-Google-Smtp-Source: AA+uWPzz2SYm4t38tYNRDX2IVM27FnQJipEbSpZGjMl67ghF+9S6xDAjYUfvmJKQlug9khxlvRqyAg==
X-Received: by 2002:a25:bc92:: with SMTP id e18-v6mr5831218ybk.182.1534867448241;
        Tue, 21 Aug 2018 09:04:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:17a0])
        by smtp.gmail.com with ESMTPSA id r3-v6sm7043691ywr.80.2018.08.21.09.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 09:04:07 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Dmitry Vyukov <dvyukov@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: memcontrol: print proper OOM header when no eligible victim left
Date:   Tue, 21 Aug 2018 12:04:06 -0400
Message-Id: <20180821160406.22578-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the memcg OOM killer runs out of killable tasks, it currently
prints a WARN with no further OOM context. This has caused some user
confusion.

Warnings indicate a kernel problem. In a reported case, however, the
situation was triggered by a non-sensical memcg configuration (hard
limit set to 0). But without any VM context this wasn't obvious from
the report, and it took some back and forth on the mailing list to
identify what is actually a trivial issue.

Handle this OOM condition like we handle it in the global OOM killer:
dump the full OOM context and tell the user we ran out of tasks.

This way the user can identify misconfigurations easily by themselves
and rectify the problem - without having to go through the hassle of
running into an obscure but unsettling warning, finding the
appropriate kernel mailing list and waiting for a kernel developer to
remote-analyze that the memcg configuration caused this.

If users cannot make sense of why the OOM killer was triggered or why
it failed, they will still report it to the mailing list, we know that
from experience. So in case there is an actual kernel bug causing
this, kernel developers will very likely hear about it.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c |  2 --
 mm/oom_kill.c   | 13 ++++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4e3c1315b1de..29d9d1a69b36 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1701,8 +1701,6 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
 	if (mem_cgroup_out_of_memory(memcg, mask, order))
 		return OOM_SUCCESS;
 
-	WARN(1,"Memory cgroup charge failed because of no reclaimable memory! "
-		"This looks like a misconfiguration or a kernel bug.");
 	return OOM_FAILED;
 }
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index b5b25e4dcbbb..95fbbc46f68f 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1103,10 +1103,17 @@ bool out_of_memory(struct oom_control *oc)
 	}
 
 	select_bad_process(oc);
-	/* Found nothing?!?! Either we hang forever, or we panic. */
-	if (!oc->chosen && !is_sysrq_oom(oc) && !is_memcg_oom(oc)) {
+	/* Found nothing?!?! */
+	if (!oc->chosen) {
 		dump_header(oc, NULL);
-		panic("Out of memory and no killable processes...\n");
+		pr_warn("Out of memory and no killable processes...\n");
+		/*
+		 * If we got here due to an actual allocation at the
+		 * system level, we cannot survive this and will enter
+		 * an endless loop in the allocator. Bail out now.
+		 */
+		if (!is_sysrq_oom(oc) && !is_memcg_oom(oc))
+			panic("System is deadlocked on memory\n");
 	}
 	if (oc->chosen && oc->chosen != (void *)-1UL)
 		oom_kill_process(oc, !is_memcg_oom(oc) ? "Out of memory" :
-- 
2.18.0

