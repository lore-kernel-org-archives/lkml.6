Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ED5C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC0625C84
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="u6gYQf+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC0625C84
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966451AbeF0TOL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:14:11 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40694 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934948AbeF0TJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:09:49 -0400
Received: by mail-qk0-f193.google.com with SMTP id b129-v6so1652514qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vfNRWwh46Tv2e1n+AhCODq/AfAwHegq14TUJjZix/bA=;
        b=u6gYQf+5FRX7tbJBda+cMyyjp/uRagmjjmfkfuiV3fPBdJmkYsGMauYmvqODwMMHlz
         AIkelcp+QCOR7qrU9muU8l+zR1pvE1kEWkW7ofNrJAHNDvrqgLcR5qEy3XuNQQKI28ml
         w8FD3xST1L3kbseDl52gExn06Wj7hmRx3/ui/r6LlDl3SIg0JeQ1mOv346KVVle6V0Ww
         EydkmhkAkTivE/QwPH8nAVS5FcZJ+xntS2TqiHUuIFjma2Gkt69d5WTRvC6EW/mNh6rQ
         QvSIAxdR7rLHtslW9CtpyiSi5EmAsust3xktBfJkXluYxbEygynMaAmZu3O3hG7Mw1Zk
         KXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vfNRWwh46Tv2e1n+AhCODq/AfAwHegq14TUJjZix/bA=;
        b=aJR5OXVUGpVFzGTOwW7q2yMd0s2QLSTUECuMrgRJA+oafYgKHWTN+3lGB575o5kSJI
         10Eb8ufpcb+dxRzBW2VJGOYr6sI69byc4zHg1p9A/QZm+fkbHGG8Ur2dKNcm7SOYxGmC
         k9KKsK8L+9Wbiw1B5mcI24E0sDBCFxAGfXte/KrVuL1UcXHy5LjwNeABxhRuigdX2LDF
         4C+eRmvZDCpieVsnYJoq2/EiTSS03AtU6gBIdDL3gIe/WyDnzBxhYsXQuSsCzQZM2nfr
         wgpI/UrEld/w7MZrKycFr6cRjMLEILZ3C8v+WPxVRxJ5yT2IJwUZwQiA5dQhk0f10/U2
         cs1w==
X-Gm-Message-State: APt69E03wFpXmMo6/71dudMk7RhqpbyPOh2IRZpTJbE6eoejjJZ72enp
        uydfMRuIKE2Sc3XAGk0if15KiA==
X-Google-Smtp-Source: AAOMgpc6OyrmgsthDGkGpVr5ciY1CByEZKhvo5cLwdLwVlrvfv28IJYvn/OFCA2oC27llCgubIoLvQ==
X-Received: by 2002:a37:a316:: with SMTP id m22-v6mr6018997qke.57.1530126588293;
        Wed, 27 Jun 2018 12:09:48 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m128-v6sm3065932qkd.33.2018.06.27.12.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 12:09:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 03/14] blk-cgroup: allow controllers to output their own stats
Date:   Wed, 27 Jun 2018 15:09:29 -0400
Message-Id: <20180627190940.4696-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180627190940.4696-1-josef@toxicpanda.com>
References: <20180627190940.4696-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

blk-iolatency has a few stats that it would like to print out, and
instead of adding a bunch of crap to the generic code just provide a
helper so that controllers can add stuff to the stat line if they want
to.

Hide it behind a boot option since it changes the output of io.stat from
normal, and these stats are only interesting to developers.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 block/blk-cgroup.c         | 49 +++++++++++++++++++++++++++++++++++++++++++---
 include/linux/blk-cgroup.h |  3 +++
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index eb85cb87c40f..b3460f623fca 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -50,6 +50,8 @@ static struct blkcg_policy *blkcg_policy[BLKCG_MAX_POLS];
 
 static LIST_HEAD(all_blkcgs);		/* protected by blkcg_pol_mutex */
 
+static bool blkcg_debug_stats = false;
+
 static bool blkcg_policy_enabled(struct request_queue *q,
 				 const struct blkcg_policy *pol)
 {
@@ -954,13 +956,25 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
 		const char *dname;
+		char *buf;
 		struct blkg_rwstat rwstat;
 		u64 rbytes, wbytes, rios, wios;
+		size_t size = seq_get_buf(sf, &buf), off = 0;
+		int i;
+		bool has_stats = false;
 
 		dname = blkg_dev_name(blkg);
 		if (!dname)
 			continue;
 
+		/*
+		 * Hooray string manipulation, count is the size written NOT
+		 * INCLUDING THE \0, so size is now count+1 less than what we
+		 * had before, but we want to start writing the next bit from
+		 * the \0 so we only add count to buf.
+		 */
+		off += scnprintf(buf+off, size-off, "%s ", dname);
+
 		spin_lock_irq(blkg->q->queue_lock);
 
 		rwstat = blkg_rwstat_recursive_sum(blkg, NULL,
@@ -975,9 +989,35 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 
 		spin_unlock_irq(blkg->q->queue_lock);
 
-		if (rbytes || wbytes || rios || wios)
-			seq_printf(sf, "%s rbytes=%llu wbytes=%llu rios=%llu wios=%llu\n",
-				   dname, rbytes, wbytes, rios, wios);
+		if (rbytes || wbytes || rios || wios) {
+			has_stats = true;
+			off += scnprintf(buf+off, size-off,
+					 "rbytes=%llu wbytes=%llu rios=%llu wios=%llu",
+					 rbytes, wbytes, rios, wios);
+		}
+
+		if (!blkcg_debug_stats)
+			goto next;
+
+		mutex_lock(&blkcg_pol_mutex);
+		for (i = 0; i < BLKCG_MAX_POLS; i++) {
+			struct blkcg_policy *pol = blkcg_policy[i];
+			size_t written;
+
+			if (!blkg->pd[i] || !pol->pd_stat_fn)
+				continue;
+
+			written = pol->pd_stat_fn(blkg->pd[i], buf+off, size-off);
+			if (written)
+				has_stats = true;
+			off += written;
+		}
+		mutex_unlock(&blkcg_pol_mutex);
+next:
+		if (has_stats) {
+			off += scnprintf(buf+off, size-off, "\n");
+			seq_commit(sf, off);
+		}
 	}
 
 	rcu_read_unlock();
@@ -1547,3 +1587,6 @@ void blkcg_policy_unregister(struct blkcg_policy *pol)
 	mutex_unlock(&blkcg_pol_register_mutex);
 }
 EXPORT_SYMBOL_GPL(blkcg_policy_unregister);
+
+module_param(blkcg_debug_stats, bool, 0644);
+MODULE_PARM_DESC(blkcg_debug_stats, "True if you want debug stats, false if not");
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 69aa71dc0c04..b41292726c0f 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -148,6 +148,8 @@ typedef void (blkcg_pol_online_pd_fn)(struct blkg_policy_data *pd);
 typedef void (blkcg_pol_offline_pd_fn)(struct blkg_policy_data *pd);
 typedef void (blkcg_pol_free_pd_fn)(struct blkg_policy_data *pd);
 typedef void (blkcg_pol_reset_pd_stats_fn)(struct blkg_policy_data *pd);
+typedef size_t (blkcg_pol_stat_pd_fn)(struct blkg_policy_data *pd, char *buf,
+				      size_t size);
 
 struct blkcg_policy {
 	int				plid;
@@ -167,6 +169,7 @@ struct blkcg_policy {
 	blkcg_pol_offline_pd_fn		*pd_offline_fn;
 	blkcg_pol_free_pd_fn		*pd_free_fn;
 	blkcg_pol_reset_pd_stats_fn	*pd_reset_stats_fn;
+	blkcg_pol_stat_pd_fn		*pd_stat_fn;
 };
 
 extern struct blkcg blkcg_root;
-- 
2.14.3

