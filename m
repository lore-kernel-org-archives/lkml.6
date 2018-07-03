Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C548FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF4D208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="UkVtTGQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF4D208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934046AbeGCPPO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:15:14 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37695 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933329AbeGCPPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:15:11 -0400
Received: by mail-qk0-f195.google.com with SMTP id t79-v6so1173548qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zRqF4UPWwilUKnhGI+by9p/CeiYxnq4DlF5TaiWOPMc=;
        b=UkVtTGQjGh0UGHC11cd6XZNd2cSpTNjlGp0LXggaOz5EuE4qB/aZ9uuq+ut/3NOu6S
         P8ryY2SW2GlwFhlBVqpgjP91Md3j5W4TFawlbK9XfBubB0SvkMAA4DrLylabJH4LmFFv
         y0Hny8+RGMx1VxpZZ3nJptKB9zjOICRgvHBeGJ4MW/UewrpFJw5O4OSFOoTFUdWgIoyk
         dP8DY6SqpLAlNLtA5DY5GzVNpCmw+hwSc5cTufVTs6+7T1PIQjGCM4MOOuYsFCfCAE88
         3UjEmYYUiSKKsNUIClkTTp1zlIocbSsbJuv/FOgVo8kxhwimr5Urjpt8iqsu8SVzGM9z
         gvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zRqF4UPWwilUKnhGI+by9p/CeiYxnq4DlF5TaiWOPMc=;
        b=fgxzaunzZydt9JocAQklQwXG8X7+KHK46vADh3D6bGaaIrVGLgXr5rHHHFzaBYbvly
         83zvSttFcD6KCDlFZ6/vzL9sMxsW+Aqp6LkFNsSEee+aOai1NTlF88dGVnzNgxZX5EGz
         SxZM3PhjXQ2skqnPcSj99Q+SgPp/VwP7s4fguamcAtIITBZGzXZkYxI97hkJGqGW0aP9
         Szf1Ibqm2Px+4vYnCWbMqhjlmNr+tCaJB5KS/0fkkUVxwZ/ri3MSOjl/v673+QiBjcjc
         khNOGUQj6FORE7OMurZcJBnFi8lQiM3JUHt8zCeM1tQVKpUNT3927nx2tvwVjAhZEWRQ
         d00w==
X-Gm-Message-State: APt69E3/k7ORo6A0vvKUEBUndWGaEu6ajmNJc87QwYyuZVfcH4xu2hbJ
        eDG+i+9WNpol2Ws24Gznm4jCcw==
X-Google-Smtp-Source: AAOMgpe4YZKLle31UKewz0OK3GNDQIaljHPgVp5J4f/nyaa2wKbTsxdgAkJFWqaA/fn00/zuYR/tQg==
X-Received: by 2002:a37:f44:: with SMTP id z65-v6mr25574581qkg.93.1530630910770;
        Tue, 03 Jul 2018 08:15:10 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h44-v6sm948612qta.74.2018.07.03.08.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:15:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 03/14] blk-cgroup: allow controllers to output their own stats
Date:   Tue,  3 Jul 2018 11:14:52 -0400
Message-Id: <20180703151503.2549-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180703151503.2549-1-josef@toxicpanda.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
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
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c         | 47 +++++++++++++++++++++++++++++++++++++++++++---
 include/linux/blk-cgroup.h |  3 +++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index eb85cb87c40f..7dc6f05cc44b 100644
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
@@ -975,9 +989,33 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 
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
+next:
+		if (has_stats) {
+			off += scnprintf(buf+off, size-off, "\n");
+			seq_commit(sf, off);
+		}
 	}
 
 	rcu_read_unlock();
@@ -1547,3 +1585,6 @@ void blkcg_policy_unregister(struct blkcg_policy *pol)
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

