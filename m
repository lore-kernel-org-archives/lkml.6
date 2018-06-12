Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ADFEDC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F191208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWWoGd3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F191208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933624AbeFLIDv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:03:51 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40612 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932448AbeFLIDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:03:48 -0400
Received: by mail-pl0-f68.google.com with SMTP id t12-v6so13894113plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 01:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e30WJON+WcienBTt3dkXZkI8oWzd8tFR4OMY8R/zNUM=;
        b=PWWoGd3XCkCnAF4dhrtA2YefN7f+oa2NzpgGwjm7e15mHm6No8FQFDxR78ENN7allY
         FD1vkSFvcoQNg3n4YZlshk5n9EkWh43EU6MDuz10O+DQaEjJWWl2Is3WDrkkEHJVYaka
         iWNoVSdw6Dib8A8kg/fQX/OsgrgxfcOBtPcZAflJtIYi15xuvKVUKx6oiybpBhURU7WE
         RLVszCYyFO9cT0QU4LqE5v2Zv9kle81M0uLdNPdD1d6cuSJhRyQAisIb3IUAmfxUbg4+
         yUReEhNWf+E3bYTC440aUfn8QBLFFcjNlj1V5JOYMNtbyUtFo2oh0TuilULCwCxvz8rN
         7aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e30WJON+WcienBTt3dkXZkI8oWzd8tFR4OMY8R/zNUM=;
        b=c7NpPgCmubwsjMupmycP0rBaQVwE935qED9qdg3CEIiSDzepTF0P10XMPei8WSUS6u
         6GRRA75SPxOK6O0Vs6RcNV1W6dWWkS4IEVxQ3VmtFT2gL69rlHer/pJvs9cSR1Hwn8Gw
         JIjOMB+PCdjYeWwBC5A7+PF46EmJ6jyOqsnqQtyA7ztFENE3/O7EI/OL0cAcjjkK46zI
         OvKBxvLyc0g3QZWHbe5PARNa5j6Bo0v5RLDASOtjyrzEY1gkwwRS2EmXgXyCOA5nGC8H
         MD2faUk1KLgStEBmJafqQYQYcvNowf1MuvtHq9Bel8fEywp96CyOQgikF+6J62YPFFiR
         8V7Q==
X-Gm-Message-State: APt69E0ih3VKqiDwMpI0RcCiw/IWmyBXT/Sq8K6QHv883c3yXSXNl27t
        i3gi8eAcLAsCRFa61syoxyfmKw==
X-Google-Smtp-Source: ADUXVKIHXaZIX1F+XT+1HynlLeGI6GhyvxYfNy/k1ASAOy4o3HfmMmS+Bo4LiihSQ09RkAWCJC72QQ==
X-Received: by 2002:a17:902:14d:: with SMTP id 71-v6mr2865627plb.275.1528790628281;
        Tue, 12 Jun 2018 01:03:48 -0700 (PDT)
Received: from localhost ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x3-v6sm848065pfm.2.2018.06.12.01.03.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 01:03:47 -0700 (PDT)
From:   Jing Xia <jing.xia.mail@gmail.com>
X-Google-Original-From: Jing Xia <jing.xia@unisoc.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dm bufio: Reduce dm_bufio_lock contention
Date:   Tue, 12 Jun 2018 16:03:28 +0800
Message-Id: <1528790608-19557-1-git-send-email-jing.xia@unisoc.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Performance test in android reports that the phone sometimes gets
hanged and shows black screen for about several minutes.The sysdump shows:
1. kswapd and other tasks who enter the direct-reclaim path are waiting
on the dm_bufio_lock;
2. the task who gets the dm_bufio_lock is stalled for IO completions,
the relevant stack trace as :

PID: 22920  TASK: ffffffc0120f1a00  CPU: 1   COMMAND: "kworker/u8:2"
 #0 [ffffffc0282af3d0] __switch_to at ffffff8008085e48
 #1 [ffffffc0282af3f0] __schedule at ffffff8008850cc8
 #2 [ffffffc0282af450] schedule at ffffff8008850f4c
 #3 [ffffffc0282af470] schedule_timeout at ffffff8008853a0c
 #4 [ffffffc0282af520] schedule_timeout_uninterruptible at ffffff8008853aa8
 #5 [ffffffc0282af530] wait_iff_congested at ffffff8008181b40
 #6 [ffffffc0282af5b0] shrink_inactive_list at ffffff8008177c80
 #7 [ffffffc0282af680] shrink_lruvec at ffffff8008178510
 #8 [ffffffc0282af790] mem_cgroup_shrink_node_zone at ffffff80081793bc
 #9 [ffffffc0282af840] mem_cgroup_soft_limit_reclaim at ffffff80081b6040

This patch aims to reduce the dm_bufio_lock contention when multiple
tasks do shrink_slab() at the same time.It is acceptable that task
will be allowed to reclaim from other shrinkers or reclaim from dm-bufio
next time, rather than stalled for the dm_bufio_lock.

Signed-off-by: Jing Xia <jing.xia@unisoc.com>
Signed-off-by: Jing Xia <jing.xia.mail@gmail.com>
---
 drivers/md/dm-bufio.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index c546b56..402a028 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1647,10 +1647,19 @@ static unsigned long __scan(struct dm_bufio_client *c, unsigned long nr_to_scan,
 static unsigned long
 dm_bufio_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
+	unsigned long count;
+	unsigned long retain_target;
+
 	struct dm_bufio_client *c = container_of(shrink, struct dm_bufio_client, shrinker);
-	unsigned long count = READ_ONCE(c->n_buffers[LIST_CLEAN]) +
+
+	if (!dm_bufio_trylock(c))
+		return 0;
+
+	count = READ_ONCE(c->n_buffers[LIST_CLEAN]) +
 			      READ_ONCE(c->n_buffers[LIST_DIRTY]);
-	unsigned long retain_target = get_retain_buffers(c);
+	retain_target = get_retain_buffers(c);
+
+	dm_bufio_unlock(c);
 
 	return (count < retain_target) ? 0 : (count - retain_target);
 }
-- 
1.9.1

