Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C113ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67C6214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="el2EUKH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67C6214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeJJCGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:06:43 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35133 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeJJCGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:06:42 -0400
Received: by mail-yw1-f67.google.com with SMTP id y76-v6so1113381ywd.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 11:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IJnCLRw3K+q3Md8hRn4AAV6ZWYmte8NOr8osfiV9S1M=;
        b=el2EUKH7k0vuEAzqiBypMiUy3RyKKukFBLG0f2cl17Plo4OYPhfACk0S11Jf4PBgRa
         b4cTCDsdeeYj81uWm6iEZDx/TlqhMh6WonLGKHU68SbN9yRHOdh3oowHVP2erFo64mei
         yLcny3Kx2s7peV4X6z8UxNZJo7Emr4+/0/TlBLLnbBXBQd0WTufMOXLdu9ojkrkmoJd5
         WQqVYKT/pDBkGYMiEWUPlkG9e8GPbNmyeU6jFf9IgVJNEX2RvAcU+rHPlY4ml0UdhAGL
         VbiaVpjlKmGyiv+efZ5DRsc3zFholac0xI4hhQ834jskAMLJwwhtTovei1j31saiN2YJ
         OveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IJnCLRw3K+q3Md8hRn4AAV6ZWYmte8NOr8osfiV9S1M=;
        b=pbu6usiC1h/51Dt8+y6p3IatE5gYNs+RykBFxBIFDBzpJSwssINR+NQWW7yeGDkBkT
         hgGXeMwTgzuG3fb2h8MS91UU5ww7qEYmSMfaCLBvryeCWs+ESrj+rjKPi1kQnhhlsO74
         FBmOQvpZ3BGIY9gVMtsOa4fJ4kX5TPjGhh+ie9Uh+Jw+1Tix7oCWv+h+wS1joXaDrUd4
         /hASaeEOBGUbUYK7yr42v3Ovw8rBOx8N3gxsPUvLBJzi5cpGbJHZ/ywlOOqnI25HmDKk
         t/7RlyBxGqOc/s3kBbPirXwbpXMPHMo3rEC13Zj70PuS4sBq2eaH91djG5FzFAH8FogN
         /wNw==
X-Gm-Message-State: ABuFfoh0NbqIFc9Sncy3r2EVK25Cm08Qnd3aW0yX2TEllERIjjsqQXLn
        tiAkvgjUTAuwk/XkG3+jR2VvCQ==
X-Google-Smtp-Source: ACcGV62qRx2HfQJfPX3jBPoOLE9skEPk+s+BCfnqkpFsTggsdSHGjGMixGKyjd7YcA94hpHjdAvWHQ==
X-Received: by 2002:a81:e901:: with SMTP id d1-v6mr16555259ywm.383.1539110901166;
        Tue, 09 Oct 2018 11:48:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::6:14c5])
        by smtp.gmail.com with ESMTPSA id x133-v6sm13947696ywg.66.2018.10.09.11.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 11:48:20 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/4] mm: zero-seek shrinkers
Date:   Tue,  9 Oct 2018 14:47:33 -0400
Message-Id: <20181009184732.762-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009184732.762-1-hannes@cmpxchg.org>
References: <20181009184732.762-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page cache and most shrinkable slab caches hold data that has been
read from disk, but there are some caches that only cache CPU work,
such as the dentry and inode caches of procfs and sysfs, as well as
the subset of radix tree nodes that track non-resident page cache.

Currently, all these are shrunk at the same rate: using DEFAULT_SEEKS
for the shrinker's seeks setting tells the reclaim algorithm that for
every two page cache pages scanned it should scan one slab object.

This is a bogus setting. A virtual inode that required no IO to create
is not twice as valuable as a page cache page; shadow cache entries
with eviction distances beyond the size of memory aren't either.

In most cases, the behavior in practice is still fine. Such virtual
caches don't tend to grow and assert themselves aggressively, and
usually get picked up before they cause problems. But there are
scenarios where that's not true.

Our database workloads suffer from two of those. For one, their file
workingset is several times bigger than available memory, which has
the kernel aggressively create shadow page cache entries for the
non-resident parts of it. The workingset code does tell the VM that
most of these are expendable, but the VM ends up balancing them 2:1 to
cache pages as per the seeks setting. This is a huge waste of memory.

These workloads also deal with tens of thousands of open files and use
/proc for introspection, which ends up growing the proc_inode_cache to
absurdly large sizes - again at the cost of valuable cache space,
which isn't a reasonable trade-off, given that proc inodes can be
re-created without involving the disk.

This patch implements a "zero-seek" setting for shrinkers that results
in a target ratio of 0:1 between their objects and IO-backed
caches. This allows such virtual caches to grow when memory is
available (they do cache/avoid CPU work after all), but effectively
disables them as soon as IO-backed objects are under pressure.

It then switches the shrinkers for procfs and sysfs metadata, as well
as excess page cache shadow nodes, to the new zero-seek setting.

Reported-by: Domas Mituzas <dmituzas@fb.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/kernfs/mount.c |  3 +++
 fs/proc/root.c    |  3 +++
 mm/vmscan.c       | 15 ++++++++++++---
 mm/workingset.c   |  2 +-
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 1bd43f6947f3..7d56b624e0dc 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -251,6 +251,9 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 		sb->s_export_op = &kernfs_export_ops;
 	sb->s_time_gran = 1;
 
+	/* sysfs dentries and inodes don't require IO to create */
+	sb->s_shrink.seeks = 0;
+
 	/* get root inode, initialize and unlock it */
 	mutex_lock(&kernfs_mutex);
 	inode = kernfs_get_inode(sb, info->root->kn);
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 8912a8b57ac3..74975ca77b71 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -127,6 +127,9 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 	 */
 	s->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
 
+	/* procfs dentries and inodes don't require IO to create */
+	s->s_shrink.seeks = 0;
+
 	pde_get(&proc_root);
 	root_inode = proc_get_inode(s, &proc_root);
 	if (!root_inode) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a859f64a2166..62ac0c488624 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -474,9 +474,18 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
 
 	total_scan = nr;
-	delta = freeable >> priority;
-	delta *= 4;
-	do_div(delta, shrinker->seeks);
+	if (shrinker->seeks) {
+		delta = freeable >> priority;
+		delta *= 4;
+		do_div(delta, shrinker->seeks);
+	} else {
+		/*
+		 * These objects don't require any IO to create. Trim
+		 * them aggressively under memory pressure to keep
+		 * them from causing refetches in the IO caches.
+		 */
+		delta = freeable / 2;
+	}
 
 	/*
 	 * Make sure we apply some minimal pressure on default priority
diff --git a/mm/workingset.c b/mm/workingset.c
index cfdf6adf7e7c..97523c4d3496 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -523,7 +523,7 @@ static unsigned long scan_shadow_nodes(struct shrinker *shrinker,
 static struct shrinker workingset_shadow_shrinker = {
 	.count_objects = count_shadow_nodes,
 	.scan_objects = scan_shadow_nodes,
-	.seeks = DEFAULT_SEEKS,
+	.seeks = 0, /* ->count reports only fully expendable nodes */
 	.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
 };
 
-- 
2.19.0

