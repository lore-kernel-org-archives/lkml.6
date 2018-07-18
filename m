Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BE8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C961720850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ0egi3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C961720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbeGRMZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:25:34 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36169 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbeGRMZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:25:34 -0400
Received: by mail-yb0-f193.google.com with SMTP id s1-v6so1703674ybk.3;
        Wed, 18 Jul 2018 04:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LYSjvzLNEsrPUz7M/wxT2GmCatf6lvBfkF1VEvp/2X0=;
        b=CJ0egi3f9i0HrI5eu3luAEv292WeMGaw/69dVs8m9a/DLga1GMS4Lsc3qcJvEiJX/v
         yRTHAaOmUPkUghjBzL0lNWH/pgyqYba9XDkpULi/ZtaR3uXRenzJb+kTuBWvVPOkeC6t
         HUFL5lFsEgj+8WfE363GTaaplQthvoG422Rro2Wumh1HNCDcc7xfYTfNjHsHTwHjREbF
         rZbfb7WQ1pUr59ruESm49MR74vxCDc/DT4u95wKgZhri5tO0xU0zISs3N66BmwakSOiH
         MB8DPzaWkM+W7d4jEMYaAP2E2Khe4P+Y2zEPfvA8Z95HfbR3U6487mDj6V2VhKivEQW3
         l/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=LYSjvzLNEsrPUz7M/wxT2GmCatf6lvBfkF1VEvp/2X0=;
        b=X8RZbahAijgo3QT9TYtWnQhDn28JCF/NUyToXsP+0qNVCwAyrBJBl93uZSc1j45MO3
         QDJcn3YE9ucruMPTfNRz68BYhBFybCODG79kqqWn7X927iUmJiSJt7UD/mTV40gjWeSQ
         +7Ux/QEmcspJZSVZezjNguSBQ9v8F7z1T1TAR35Yr3NFkJyUqvu06i4wq3CokkKHJ1S0
         pkrVMM950VwvDL36GEqBH8+d6utf93X4/SocbVfmw+2W0JnTvhbNgIf5rxcIbnyN/iHd
         U8DoCgiara/dCERxj+HDCJmXbvJgb/8xtf85JXQE/r83gW7rw07zkQm+OQq5zvv+CVqs
         9r0w==
X-Gm-Message-State: AOUpUlFlGyLfgJz2InJhBjFiv4wtIF3KFVE0RRMk+naCJpOZwGVtV5kd
        lLjD3olwrYCfdGs/v6PQxqo=
X-Google-Smtp-Source: AAOMgpfHJFvpCYcph/HJZT8MQtdbD+bSLYCRMMCLaAMGvSnLWzgUO9C6zJmGst2gZLB/QEMGMrVl1Q==
X-Received: by 2002:a25:27c7:: with SMTP id n190-v6mr3010145ybn.520.1531914481523;
        Wed, 18 Jul 2018 04:48:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:c229])
        by smtp.gmail.com with ESMTPSA id s206-v6sm1443221ywc.55.2018.07.18.04.48.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 04:48:00 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     michaelcallahan@fb.com, newella@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-api@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/6] blkcg: Track DISCARD statistics and output them in cgroup io.stat
Date:   Wed, 18 Jul 2018 04:47:41 -0700
Message-Id: <20180718114741.2580313-7-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718114741.2580313-1-tj@kernel.org>
References: <20180718114741.2580313-1-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tracking of REQ_OP_DISCARD ios to the per-cgroup io.stat.  Two
fields, dbytes and dios, to respectively count the total bytes and
number of discards are added.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andy Newell <newella@fb.com>
Cc: Michael Callahan <michaelcallahan@fb.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 10 ++++++----
 block/blk-cgroup.c                      | 13 +++++++++----
 include/linux/blk-cgroup.h              |  5 ++++-
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 569ce27b85e5..3afe10fa82bc 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1317,17 +1317,19 @@ IO Interface Files
 	Lines are keyed by $MAJ:$MIN device numbers and not ordered.
 	The following nested keys are defined.
 
-	  ======	===================
+	  ======	=====================
 	  rbytes	Bytes read
 	  wbytes	Bytes written
 	  rios		Number of read IOs
 	  wios		Number of write IOs
-	  ======	===================
+	  dbytes	Bytes discarded
+	  dios		Number of discard IOs
+	  ======	=====================
 
 	An example read output follows:
 
-	  8:16 rbytes=1459200 wbytes=314773504 rios=192 wios=353
-	  8:0 rbytes=90430464 wbytes=299008000 rios=8950 wios=1252
+	  8:16 rbytes=1459200 wbytes=314773504 rios=192 wios=353 dbytes=0 dios=0
+	  8:0 rbytes=90430464 wbytes=299008000 rios=8950 wios=1252 dbytes=50331648 dios=3021
 
   io.weight
 	A read-write flat-keyed file which exists on non-root cgroups.
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 7e2c19ce1a08..1942357d7165 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -567,6 +567,7 @@ u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 		[BLKG_RWSTAT_WRITE]	= "Write",
 		[BLKG_RWSTAT_SYNC]	= "Sync",
 		[BLKG_RWSTAT_ASYNC]	= "Async",
+		[BLKG_RWSTAT_DISCARD]	= "Discard",
 	};
 	const char *dname = blkg_dev_name(pd->blkg);
 	u64 v;
@@ -580,7 +581,8 @@ u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 			   (unsigned long long)atomic64_read(&rwstat->aux_cnt[i]));
 
 	v = atomic64_read(&rwstat->aux_cnt[BLKG_RWSTAT_READ]) +
-		atomic64_read(&rwstat->aux_cnt[BLKG_RWSTAT_WRITE]);
+		atomic64_read(&rwstat->aux_cnt[BLKG_RWSTAT_WRITE]) +
+		atomic64_read(&rwstat->aux_cnt[BLKG_RWSTAT_DISCARD]);
 	seq_printf(sf, "%s Total %llu\n", dname, (unsigned long long)v);
 	return v;
 }
@@ -959,7 +961,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 		const char *dname;
 		char *buf;
 		struct blkg_rwstat rwstat;
-		u64 rbytes, wbytes, rios, wios;
+		u64 rbytes, wbytes, rios, wios, dbytes, dios;
 		size_t size = seq_get_buf(sf, &buf), off = 0;
 		int i;
 		bool has_stats = false;
@@ -982,19 +984,22 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 					offsetof(struct blkcg_gq, stat_bytes));
 		rbytes = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_READ]);
 		wbytes = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_WRITE]);
+		dbytes = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_DISCARD]);
 
 		rwstat = blkg_rwstat_recursive_sum(blkg, NULL,
 					offsetof(struct blkcg_gq, stat_ios));
 		rios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_READ]);
 		wios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_WRITE]);
+		dios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_DISCARD]);
 
 		spin_unlock_irq(blkg->q->queue_lock);
 
 		if (rbytes || wbytes || rios || wios) {
 			has_stats = true;
 			off += scnprintf(buf+off, size-off,
-					 "rbytes=%llu wbytes=%llu rios=%llu wios=%llu",
-					 rbytes, wbytes, rios, wios);
+					 "rbytes=%llu wbytes=%llu rios=%llu wios=%llu dbytes=%llu dios=%llu",
+					 rbytes, wbytes, rios, wios,
+					 dbytes, dios);
 		}
 
 		if (!blkcg_debug_stats)
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index de57de4831d5..3bed5e02a873 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -35,6 +35,7 @@ enum blkg_rwstat_type {
 	BLKG_RWSTAT_WRITE,
 	BLKG_RWSTAT_SYNC,
 	BLKG_RWSTAT_ASYNC,
+	BLKG_RWSTAT_DISCARD,
 
 	BLKG_RWSTAT_NR,
 	BLKG_RWSTAT_TOTAL = BLKG_RWSTAT_NR,
@@ -649,7 +650,9 @@ static inline void blkg_rwstat_add(struct blkg_rwstat *rwstat,
 {
 	struct percpu_counter *cnt;
 
-	if (op_is_write(op))
+	if (op_is_discard(op))
+		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_DISCARD];
+	else if (op_is_write(op))
 		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_WRITE];
 	else
 		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_READ];
-- 
2.17.1

