Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65CCECDFBD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A99920850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdhG7tl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A99920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbeGRMZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:25:26 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:41762 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731594AbeGRMZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:25:26 -0400
Received: by mail-yw0-f193.google.com with SMTP id q129-v6so1593148ywg.8;
        Wed, 18 Jul 2018 04:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SiImZP/39dBK5ppu4XvvwDfeC3/XAMgr/5cpNLltrXg=;
        b=OdhG7tl3fp1bUzvM5vJdCMkLzgOz8V8iXfBCb+UJfUPz6CHuzImjbVJCUAV5ETNfzY
         Npuy7clLNXshZH8mwm+APH74pnTv7kGIUg+94evugO3Yk7H0LRaMR9jLMCBgEx+tB4MU
         sTSrzkTuD2wVumxgGuOkzL4bTLkEQ/Z0cAKbiUfwa7UOVnwUdFqPGWOfzLjmn4dhFd10
         alJQZqIWOVaQGEywn+mIJLLyVrQSGekUvLEkTP25wbzJs5EVc4b+93lCCHBbNFqcX7HL
         J/leERhD554nfESJgQqS1nBNmPW96Mg6Nc4Gcm9AgTHk7lOlgz+V6dVlUurLA0QdIcEo
         PePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=SiImZP/39dBK5ppu4XvvwDfeC3/XAMgr/5cpNLltrXg=;
        b=DCuaDFsxyZss4BfpDVRWiBWIos0p7KuQFFgId3YqCGZWbyWlHGPKoOyS5Pq2RshH9q
         R4UtE+g/DI0yt1HF9GRr4xZgJzDxO9qeZQCrqv94HObNf6YuKBdY3BCSmXXwI0yeuKCv
         kkncAopf3dHPzSrN/JQOoz2ugWHKwLO9s5IRAdr9N05Sgmh6QNKuZSaOECqA+OQigEdR
         6J4zZz+MV1XqNc6ftRSr5vV86mwvwn3oETNNXIMWAviP0Mo4q8xiYrqOzyrLk/YAd7Qh
         hawUeOF6/TfOvvGQ6rpsQyA1RSFgCrIziGZ9O5iJHp0vtCtEoD7eybW2DURW/1/x8b2c
         C8UA==
X-Gm-Message-State: AOUpUlEUTnHAbr8YLW2OBSEe5VKnap4mABLuQqYBlpMVlsGMB+F8NKwd
        DQ/K2W3RoTbSLVRTkj3vM4o=
X-Google-Smtp-Source: AAOMgpdFEyXTQDAbVSAzc0viMJ8sHtrIxkzVe12Z/7af/+itZSgrRAStU/31igkuTEP4a2wRNlLXAg==
X-Received: by 2002:a81:5ec6:: with SMTP id s189-v6mr2868919ywb.83.1531914473821;
        Wed, 18 Jul 2018 04:47:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:c229])
        by smtp.gmail.com with ESMTPSA id e22-v6sm1812089ywe.37.2018.07.18.04.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 04:47:53 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     michaelcallahan@fb.com, newella@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-api@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/6] block: Define and use STAT_READ and STAT_WRITE
Date:   Wed, 18 Jul 2018 04:47:38 -0700
Message-Id: <20180718114741.2580313-4-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718114741.2580313-1-tj@kernel.org>
References: <20180718114741.2580313-1-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Callahan <michaelcallahan@fb.com>

Add defines for STAT_READ and STAT_WRITE for indexing the partition
stat entries. This clarifies some fs/ code which has hardcoded 1 for
STAT_WRITE and will make it easier to extend the stats with additional
fields.

tj: Refreshed on top of v4.17.

Signed-off-by: Michael Callahan <michaelcallahan@fb.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
---
 block/genhd.c             | 16 ++++++++--------
 block/partition-generic.c | 16 ++++++++--------
 fs/ext4/super.c           |  5 +++--
 fs/ext4/sysfs.c           |  6 ++++--
 fs/f2fs/f2fs.h            |  2 +-
 fs/f2fs/super.c           |  3 ++-
 include/linux/blk_types.h |  7 +++++++
 include/linux/genhd.h     | 13 +++++++------
 8 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index f1543a45e73b..0711a800d0d4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1337,14 +1337,14 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			   "%u %lu %lu %lu %u %u %u %u\n",
 			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
 			   disk_name(gp, hd->partno, buf),
-			   part_stat_read(hd, ios[READ]),
-			   part_stat_read(hd, merges[READ]),
-			   part_stat_read(hd, sectors[READ]),
-			   jiffies_to_msecs(part_stat_read(hd, ticks[READ])),
-			   part_stat_read(hd, ios[WRITE]),
-			   part_stat_read(hd, merges[WRITE]),
-			   part_stat_read(hd, sectors[WRITE]),
-			   jiffies_to_msecs(part_stat_read(hd, ticks[WRITE])),
+			   part_stat_read(hd, ios[STAT_READ]),
+			   part_stat_read(hd, merges[STAT_READ]),
+			   part_stat_read(hd, sectors[STAT_READ]),
+			   jiffies_to_msecs(part_stat_read(hd, ticks[STAT_READ])),
+			   part_stat_read(hd, ios[STAT_WRITE]),
+			   part_stat_read(hd, merges[STAT_WRITE]),
+			   part_stat_read(hd, sectors[STAT_WRITE]),
+			   jiffies_to_msecs(part_stat_read(hd, ticks[STAT_WRITE])),
 			   inflight[0],
 			   jiffies_to_msecs(part_stat_read(hd, io_ticks)),
 			   jiffies_to_msecs(part_stat_read(hd, time_in_queue))
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 3dcfd4ec0e11..0ddb06722162 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -132,14 +132,14 @@ ssize_t part_stat_show(struct device *dev,
 		"%8lu %8lu %8llu %8u "
 		"%8u %8u %8u"
 		"\n",
-		part_stat_read(p, ios[READ]),
-		part_stat_read(p, merges[READ]),
-		(unsigned long long)part_stat_read(p, sectors[READ]),
-		jiffies_to_msecs(part_stat_read(p, ticks[READ])),
-		part_stat_read(p, ios[WRITE]),
-		part_stat_read(p, merges[WRITE]),
-		(unsigned long long)part_stat_read(p, sectors[WRITE]),
-		jiffies_to_msecs(part_stat_read(p, ticks[WRITE])),
+		part_stat_read(p, ios[STAT_READ]),
+		part_stat_read(p, merges[STAT_READ]),
+		(unsigned long long)part_stat_read(p, sectors[STAT_READ]),
+		jiffies_to_msecs(part_stat_read(p, ticks[STAT_READ])),
+		part_stat_read(p, ios[STAT_WRITE]),
+		part_stat_read(p, merges[STAT_WRITE]),
+		(unsigned long long)part_stat_read(p, sectors[STAT_WRITE]),
+		jiffies_to_msecs(part_stat_read(p, ticks[STAT_WRITE])),
 		inflight[0],
 		jiffies_to_msecs(part_stat_read(p, io_ticks)),
 		jiffies_to_msecs(part_stat_read(p, time_in_queue)));
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ba2396a7bd04..4b8aef989552 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3514,7 +3514,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_sb_block = sb_block;
 	if (sb->s_bdev->bd_part)
 		sbi->s_sectors_written_start =
-			part_stat_read(sb->s_bdev->bd_part, sectors[1]);
+			part_stat_read(sb->s_bdev->bd_part, sectors[STAT_WRITE]);
 
 	/* Cleanup superblock name */
 	strreplace(sb->s_id, '/', '!');
@@ -4824,7 +4824,8 @@ static int ext4_commit_super(struct super_block *sb, int sync)
 	if (sb->s_bdev->bd_part)
 		es->s_kbytes_written =
 			cpu_to_le64(EXT4_SB(sb)->s_kbytes_written +
-			    ((part_stat_read(sb->s_bdev->bd_part, sectors[1]) -
+			    ((part_stat_read(sb->s_bdev->bd_part,
+					     sectors[STAT_WRITE]) -
 			      EXT4_SB(sb)->s_sectors_written_start) >> 1));
 	else
 		es->s_kbytes_written =
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index f34da0bb8f17..2be9ad790017 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -56,7 +56,8 @@ static ssize_t session_write_kbytes_show(struct ext4_sb_info *sbi, char *buf)
 	if (!sb->s_bdev->bd_part)
 		return snprintf(buf, PAGE_SIZE, "0\n");
 	return snprintf(buf, PAGE_SIZE, "%lu\n",
-			(part_stat_read(sb->s_bdev->bd_part, sectors[1]) -
+			(part_stat_read(sb->s_bdev->bd_part,
+					sectors[STAT_WRITE]) -
 			 sbi->s_sectors_written_start) >> 1);
 }
 
@@ -68,7 +69,8 @@ static ssize_t lifetime_write_kbytes_show(struct ext4_sb_info *sbi, char *buf)
 		return snprintf(buf, PAGE_SIZE, "0\n");
 	return snprintf(buf, PAGE_SIZE, "%llu\n",
 			(unsigned long long)(sbi->s_kbytes_written +
-			((part_stat_read(sb->s_bdev->bd_part, sectors[1]) -
+			((part_stat_read(sb->s_bdev->bd_part,
+					 sectors[STAT_WRITE]) -
 			  EXT4_SB(sb)->s_sectors_written_start) >> 1)));
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4d8b1de83143..6799c3fc44e3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1304,7 +1304,7 @@ static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
  * and the return value is in kbytes. s is of struct f2fs_sb_info.
  */
 #define BD_PART_WRITTEN(s)						 \
-(((u64)part_stat_read((s)->sb->s_bdev->bd_part, sectors[1]) -		 \
+(((u64)part_stat_read((s)->sb->s_bdev->bd_part, sectors[STAT_WRITE]) -   \
 		(s)->sectors_written_start) >> 1)
 
 static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3995e926ba3a..17bcff789c08 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2882,7 +2882,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	/* For write statistics */
 	if (sb->s_bdev->bd_part)
 		sbi->sectors_written_start =
-			(u64)part_stat_read(sb->s_bdev->bd_part, sectors[1]);
+			(u64)part_stat_read(sb->s_bdev->bd_part,
+					    sectors[STAT_WRITE]);
 
 	/* Read accumulated write IO statistics if exists */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index e13449a379a1..d2b44de56bc1 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -357,6 +357,13 @@ enum req_flag_bits {
 #define REQ_NOMERGE_FLAGS \
 	(REQ_NOMERGE | REQ_PREFLUSH | REQ_FUA)
 
+enum stat_group {
+	STAT_READ,
+	STAT_WRITE,
+
+	NR_STAT_GROUPS
+};
+
 #define bio_op(bio) \
 	((bio)->bi_opf & REQ_OP_MASK)
 #define req_op(req) \
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 19f36fa10995..a75445446974 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
 #include <linux/uuid.h>
+#include <linux/blk_types.h>
 
 #ifdef CONFIG_BLOCK
 
@@ -82,10 +83,10 @@ struct partition {
 } __attribute__((packed));
 
 struct disk_stats {
-	unsigned long sectors[2];	/* READs and WRITEs */
-	unsigned long ios[2];
-	unsigned long merges[2];
-	unsigned long ticks[2];
+	unsigned long sectors[NR_STAT_GROUPS];
+	unsigned long ios[NR_STAT_GROUPS];
+	unsigned long merges[NR_STAT_GROUPS];
+	unsigned long ticks[NR_STAT_GROUPS];
 	unsigned long io_ticks;
 	unsigned long time_in_queue;
 };
@@ -354,8 +355,8 @@ static inline void free_part_stats(struct hd_struct *part)
 #endif /* CONFIG_SMP */
 
 #define part_stat_read_accum(part, field)				\
-	(part_stat_read(part, field[0]) +				\
-	 part_stat_read(part, field[1]))
+	(part_stat_read(part, field[STAT_READ]) +			\
+	 part_stat_read(part, field[STAT_WRITE]))
 
 #define part_stat_add(cpu, part, field, addnd)	do {			\
 	__part_stat_add((cpu), (part), field, addnd);			\
-- 
2.17.1

