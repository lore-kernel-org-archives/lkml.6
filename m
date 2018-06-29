Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA4C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8E623DDF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="bKNNmnMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8E623DDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936950AbeF2T2n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:28:43 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35487 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934665AbeF2TZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:25:50 -0400
Received: by mail-qt0-f194.google.com with SMTP id z6-v6so8839338qti.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 12:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bsgWu1TKdn1eFx08H/mtF5/g/DuCTuFzEleLnBIeP18=;
        b=bKNNmnMOOQdqG9gVduE+k1l3mWUMPXmSaZVJDv3pLGhccaPP8MhLjvFuqQoZXHSivJ
         vlPeVas7YeIhB0hpW1zwsGtNkPEiYnWTmWgDPrnCNYRl/neGHge8Hd49yVuC0slHU4u1
         axe2yloTa3GVzwXHo2IRWaeD8W24mkxhpNvXBR6O+S1lTdYEaE329278sgOQrBoVAglb
         R/j7MjH3ptM/cF4XGJBnZ9LXFzbkkjVnaFlbQKYg2tmukfKLPdBYMQxx+TDanTciwZjb
         ZP0j4hZCj1rvCCpclcN6dvbcf3qqQvhLG4+7069mulACSzSo8DXGXucj0D1+/9b94H5V
         qqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bsgWu1TKdn1eFx08H/mtF5/g/DuCTuFzEleLnBIeP18=;
        b=SdEkJQyQ7YcLqhJbew91E0Dw0ulY+lLLAemft3dpt0Af31DSbfjxWRlwjBBvRQaZEY
         JeqE2AUrXzZ8oMaq9r2K0pksrOajXRdBnqim4jykt/ffCdmI39foCFnIrLtuuYoG5t6c
         VHhPeeVHIgSwGDjZpUEW0yAvnnnT8Yyg34eEzMwevMJPHoD03PR41JGgPk2sr8TZa6QX
         byXD5BSXSkSxrtkI4T5YHqPAKMfnZqdD5wQt58iZEg2tiyVKuXvFwHGrrCiWvwyZOuFo
         8vSFJVpg3d6d0tjOXNpwvQSNVzDKOooazgYgYQZkKri+FycnhNuWdJ3TmEQiSM9g1EaW
         IvGA==
X-Gm-Message-State: APt69E2xmquI1OxeXuxDrn2mICVQnJec2LxGONlCC7aUeKt0TyFI3+V/
        lEz6Kavxmk152NlYSdfoYOneRg==
X-Google-Smtp-Source: AAOMgpc/PJoqOA+brX97+sYIjJ6l5bw6SD2L8aHO0BcpjDIRbsUHpQUNcakbB9wa7WBftmUJUrosYA==
X-Received: by 2002:ac8:367:: with SMTP id w39-v6mr15090245qtg.334.1530300349382;
        Fri, 29 Jun 2018 12:25:49 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z23-v6sm6278893qki.16.2018.06.29.12.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 12:25:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 03/14] blk-cgroup: allow controllers to output their own stats
Date:   Fri, 29 Jun 2018 15:25:31 -0400
Message-Id: <20180629192542.26649-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180629192542.26649-1-josef@toxicpanda.com>
References: <20180629192542.26649-1-josef@toxicpanda.com>
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

