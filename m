Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DFEC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4EA25C2A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="Wd0MTVkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4EA25C2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934828AbeFYPM5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:12:57 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46526 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934776AbeFYPMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:12:51 -0400
Received: by mail-qt0-f196.google.com with SMTP id h5-v6so12210603qtm.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vfNRWwh46Tv2e1n+AhCODq/AfAwHegq14TUJjZix/bA=;
        b=Wd0MTVkDgMVujmI9Af+XnEiBhnamNEyKfc14OHaLFsfJR4TSALylO1FU4Esol0VBm5
         qphJW/lbBOcCu+099vzK8reND80p4JgEXPNCpvk2rsvjrVB7sLJ9VU70fgIhZtBXZxJi
         e4JhcJrmq1qqDuS1fiNwA2+qw8T9YUrge4PqInC2KH0JyPP0wiWV258qLSzWstn9O/Ad
         R4wMHrbpXbgy15OMhLcGomQH7i8bExA2kM8QCXsBO/EJJYVXNy2yZL+9EFEYD9+gAkTM
         Dd1wI8LTphVz1PcvdBUiwg86JiQ1+ZkbaIz3CuUDvcI+QAUdM2Ns+zO1Y7im1n8pvMXo
         dBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vfNRWwh46Tv2e1n+AhCODq/AfAwHegq14TUJjZix/bA=;
        b=Fl8xZYwbbKxwdRV1ic7KZr18fb/BpQjsH6cOLQvIuj4p+/0qJ1rTa+w+OYXOx0a869
         1zxylCm6ngdpCl7t4FI/99nyBsAogPAMq6G68LTZH5aIsvOWThQDzW+KtNYyRnFBFDB6
         lDczXfgc7P68P/BBnds4VwumkrC2UjrLl4bslZzaBn/anl3txIj7s6opIIRahPlbpMhd
         YEJCGiqemE+raYTK3wWYxJLxV+Et4u+0fn03kc91LCHiiTkc2hrB6syCPhGSf+G7WlQU
         g5R19DPJqVCUw6eoz8pVtMOehq6yzIGdVAO0x7LFX2tJDm0NGBpTYG21FJA7wQgN6kiI
         EtJw==
X-Gm-Message-State: APt69E3hAC2fD8K+I8ZU5tzCW6NapF/x0FS67aVctspbA2CFaPjB494E
        BCniwYUNmk3MwUJM2phGYBBBJg==
X-Google-Smtp-Source: ADUXVKKR2JcHhLzfmScguMjIfLG6Qq3YYVCDxim8sIjCl26Kvj5sMh7EwL2Fd7q/hB6hELs/wA846A==
X-Received: by 2002:ac8:27e1:: with SMTP id x30-v6mr11213960qtx.51.1529939570390;
        Mon, 25 Jun 2018 08:12:50 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s39-v6sm12284147qts.42.2018.06.25.08.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 08:12:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 03/15] blk-cgroup: allow controllers to output their own stats
Date:   Mon, 25 Jun 2018 11:12:31 -0400
Message-Id: <20180625151243.2132-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625151243.2132-1-josef@toxicpanda.com>
References: <20180625151243.2132-1-josef@toxicpanda.com>
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

