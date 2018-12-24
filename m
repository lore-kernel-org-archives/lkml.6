Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13815C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 03:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B887720855
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 03:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545622555;
	bh=9VzxXpaUlv59mCO1yF2EnjWYd7M5wgAgJXeZmxue4m0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=h8Q67O0DWs6nCLlmDTpjFktOq1M9R3PhGYLKL+3YgaR4CGkC4WCevxtuYDASmQOuw
	 wT897M++DcPjJYmky4QaK0GrhzRKls3NkhPrmfYpqeWT4SoVA4kWjeJi6qy2pjapoy
	 h9lvTwUlilzhACdR7gmhxXpctamh9Uvpc1u/arps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeLXDfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 22:35:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40259 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbeLXDfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 22:35:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so5278144pfo.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 19:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tdMB3KkhqKum88eGzXCK5uTPtcK8fdX9eQF3HfC56lU=;
        b=bGlTwXsuUjkmyhO2mKQxnwmCqMpMyAcY45Axlax3aoZ+Iy3t26k+qYK13qAvL9j4PB
         PcROh2K767Bg6jqKURS4bC5Rr7Iy6EkUdYntQzqLqD+1vggu+7ujx8UdNXGhUNYgnOEY
         yeByWGm+iBXraf1YJeTNkBXM9f150Yd99Zqv7/ws7kY3hApBBoU5lKkEzRej2EoSmSsZ
         h+SAIigxc5ZydyI8uW2rbpAnuh9HghWY6X6PBAtKvo/AJ/Q55uOdl4Obq2eB7WzAaeYU
         W8zMULLRftADlrFCIaK2c7k3aucaSXlp+a5TFPKCodhxd+q4WqvMR206f33k+bbnczvV
         58NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=tdMB3KkhqKum88eGzXCK5uTPtcK8fdX9eQF3HfC56lU=;
        b=eHSY6N9U2pJBLJslXjTYejjlUOqgM4LdAbUWIR/8EL+tDmA6vlZWh5WPYvAb+FD2p9
         uZe70ZYDLrWG+8nLKX/mKtxeHyga0v4oxISORgmLxQwB20kWvlm71aSj6RRVs/1U9ZpC
         /laQDfEMgNlAGYnfO7bWQRYnjArpp0px/m4QuuAKY6/pqMoW1Ksq2G4xCHCs3I+CijXf
         dFFyFtT45N0lKol5FzSQnXBwY5EP+geBt4b9XOwf4SzZTSQRlQSe3wpBvnbZDfZUwlJR
         0P73fBjhffgm+j1wy9LEmxUZjnj4NGL8j8/ksvY+YbX3rpH0PNjO+ab19JFx43zrjoIn
         Iu0A==
X-Gm-Message-State: AA+aEWadMI7mQMRSqytwF0F9iMaeg2LJ8WNiAEL5w2d42ElD8atIrAUg
        V+VgemX+zmkS7gUZNFPuWt8=
X-Google-Smtp-Source: AFSGD/UDXi1XHS1llhB0aa68p2t6mzD8+GWVbsGezlJ7ABdfqEPwlTrUaWd2Q/3sgLlAK+T18s7tzQ==
X-Received: by 2002:a62:7e13:: with SMTP id z19mr11782227pfc.94.1545622549569;
        Sun, 23 Dec 2018 19:35:49 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id k129sm36392284pgk.29.2018.12.23.19.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 19:35:47 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        joaodias@google.com, srnvs@google.com,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] zram: idle writeback fixes and cleanup
Date:   Mon, 24 Dec 2018 12:35:29 +0900
Message-Id: <20181224033529.19450-1-minchan@kernel.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes some fixes and cleanup for idle-page writeback.

1. writeback_limit interface

Now writeback_limit interface is rather conusing.
For example, once writeback limit budget is exausted, admin can see 0
from /sys/block/zramX/writeback_limit which is same semantic with disable
writeback_limit at this moment. IOW, admin cannot tell that zero came from
disable writeback limit or exausted writeback limit.

To make the interface clear, let's sepatate enable of writeback limit
to another knob - /sys/block/zram0/writeback_limit_enable

* before:
  while true :
    # to re-enable writeback limit once previous one is used up
    echo 0 > /sys/block/zram0/writeback_limit
    echo $((200<<20)) > /sys/block/zram0/writeback_limit
    ..
    .. # used up the writeback limit budget

* new
  # To enable writeback limit, from the beginning, admin should
  # enable it.
  echo $((200<<20)) > /sys/block/zram0/writeback_limit
  echo 1 > /sys/block/zram/0/writeback_limit_enable
  while true :
    echo $((200<<20)) > /sys/block/zram0/writeback_limit
    ..
    .. # used up the writeback limit budget

It's much strightforward.

2. fix condition check idle/huge writeback mode check

The mode in writeback_store is not bit opeartion any more so no need
to use bit operations. Furthermore, current condition check is broken
in that it does writeback every pages regardless of huge/idle.

3. clean up idle_store

No need to use goto.

Suggested-by: John Dias <joaodias@google.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 Documentation/ABI/testing/sysfs-block-zram | 11 ++-
 Documentation/blockdev/zram.txt            | 74 ++++++++++++-------
 drivers/block/zram/zram_drv.c              | 86 ++++++++++++++++------
 drivers/block/zram/zram_drv.h              |  5 +-
 4 files changed, 122 insertions(+), 54 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
index 9d2339a485c8a..14b2bf2e5105c 100644
--- a/Documentation/ABI/testing/sysfs-block-zram
+++ b/Documentation/ABI/testing/sysfs-block-zram
@@ -122,11 +122,18 @@ Contact:	Minchan Kim <minchan@kernel.org>
 		statistics (bd_count, bd_reads, bd_writes) in a format
 		similar to block layer statistics file format.
 
+What:		/sys/block/zram<id>/writeback_limit_enable
+Date:		November 2018
+Contact:	Minchan Kim <minchan@kernel.org>
+Description:
+		The writeback_limit_enable file is read-write and specifies
+		eanbe of writeback_limit feature. "1" means eable the feature.
+		No limit "0" is the initial state.
+
 What:		/sys/block/zram<id>/writeback_limit
 Date:		November 2018
 Contact:	Minchan Kim <minchan@kernel.org>
 Description:
 		The writeback_limit file is read-write and specifies the maximum
 		amount of writeback ZRAM can do. The limit could be changed
-		in run time and "0" means disable the limit.
-		No limit is the initial state.
+		in run time.
diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.txt
index 436c5e98e1b60..4df0ce2710857 100644
--- a/Documentation/blockdev/zram.txt
+++ b/Documentation/blockdev/zram.txt
@@ -156,22 +156,23 @@ Per-device statistics are exported as various nodes under /sys/block/zram<id>/
 A brief description of exported device attributes. For more details please
 read Documentation/ABI/testing/sysfs-block-zram.
 
-Name            access            description
-----            ------            -----------
-disksize          RW    show and set the device's disk size
-initstate         RO    shows the initialization state of the device
-reset             WO    trigger device reset
-mem_used_max      WO    reset the `mem_used_max' counter (see later)
-mem_limit         WO    specifies the maximum amount of memory ZRAM can use
-                        to store the compressed data
-writeback_limit   WO    specifies the maximum amount of write IO zram can
-			write out to backing device as 4KB unit
-max_comp_streams  RW    the number of possible concurrent compress operations
-comp_algorithm    RW    show and change the compression algorithm
-compact           WO    trigger memory compaction
-debug_stat        RO    this file is used for zram debugging purposes
-backing_dev	  RW	set up backend storage for zram to write out
-idle		  WO	mark allocated slot as idle
+Name            	access            description
+----            	------            -----------
+disksize          	RW	show and set the device's disk size
+initstate         	RO	shows the initialization state of the device
+reset             	WO	trigger device reset
+mem_used_max      	WO	reset the `mem_used_max' counter (see later)
+mem_limit         	WO	specifies the maximum amount of memory ZRAM can use
+				to store the compressed data
+writeback_limit   	WO	specifies the maximum amount of write IO zram can
+				write out to backing device as 4KB unit
+writeback_limit_enable  RW	show and set writeback_limit feature
+max_comp_streams  	RW	the number of possible concurrent compress operations
+comp_algorithm    	RW	show and change the compression algorithm
+compact           	WO	trigger memory compaction
+debug_stat        	RO	this file is used for zram debugging purposes
+backing_dev	  	RW	set up backend storage for zram to write out
+idle		  	WO	mark allocated slot as idle
 
 
 User space is advised to use the following files to read the device statistics.
@@ -280,32 +281,51 @@ With the command, zram writeback idle pages from memory to the storage.
 If there are lots of write IO with flash device, potentially, it has
 flash wearout problem so that admin needs to design write limitation
 to guarantee storage health for entire product life.
-To overcome the concern, zram supports "writeback_limit".
-The "writeback_limit"'s default value is 0 so that it doesn't limit
-any writeback. If admin want to measure writeback count in a certain
-period, he could know it via /sys/block/zram0/bd_stat's 3rd column.
+
+To overcome the concern, zram supports "writeback_limit" feature.
+The "writeback_limit_enable"'s default value is 0 so that it doesn't limit
+any writeback. IOW, if admin want to apply writeback budget, he should
+enable writeback_limit_enable via
+
+	$ echo 1 > /sys/block/zramX/writeback_limit_enable
+
+Once writeback_limit_enable is set, zram doesn't allow any writeback
+until admin set the budget via /sys/block/zramX/writeback_limit.
+
+(If admin doesn't enable writeback_limit_enable, writeback_limit's value
+assigned via /sys/block/zramX/writeback_limit is meaninless.)
 
 If admin want to limit writeback as per-day 400M, he could do it
 like below.
 
-    MB_SHIFT=20
-    4K_SHIFT=12
-    echo $((400<<MB_SHIFT>>4K_SHIFT)) > \
-	    /sys/block/zram0/writeback_limit.
+	$ MB_SHIFT=20
+	$ 4K_SHIFT=12
+	$ echo $((400<<MB_SHIFT>>4K_SHIFT)) > \
+		/sys/block/zram0/writeback_limit.
+	$ echo 1 > /sys/block/zram0/writeback_limit_enable
 
-If admin want to allow further write again, he could do it like below
+If admin want to allow further write again once the bugdet is exausted,
+he could do it like below
 
-    echo 0 > /sys/block/zram0/writeback_limit
+	$ echo $((400<<MB_SHIFT>>4K_SHIFT)) > \
+		/sys/block/zram0/writeback_limit
 
 If admin want to see remaining writeback budget since he set,
 
-    cat /sys/block/zram0/writeback_limit
+	$ cat /sys/block/zramX/writeback_limit
+
+If admin want to disable writeback limit, he could do
+
+	$ echo 0 > /sys/block/zramX/writeback_limit_enable
 
 The writeback_limit count will reset whenever you reset zram(e.g.,
 system reboot, echo 1 > /sys/block/zramX/reset) so keeping how many of
 writeback happened until you reset the zram to allocate extra writeback
 budget in next setting is user's job.
 
+If admin want to measure writeback count in a certain period, he could
+know it via /sys/block/zram0/bd_stat's 3rd column.
+
 = memory tracking
 
 With CONFIG_ZRAM_MEMORY_TRACKING, user can know information of the
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 33c5cc879f246..157260584e605 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -316,11 +316,9 @@ static ssize_t idle_store(struct device *dev,
 		 * See the comment in writeback_store.
 		 */
 		zram_slot_lock(zram, index);
-		if (!zram_allocated(zram, index) ||
-				zram_test_flag(zram, index, ZRAM_UNDER_WB))
-			goto next;
-		zram_set_flag(zram, index, ZRAM_IDLE);
-next:
+		if (zram_allocated(zram, index) &&
+				!zram_test_flag(zram, index, ZRAM_UNDER_WB))
+			zram_set_flag(zram, index, ZRAM_IDLE);
 		zram_slot_unlock(zram, index);
 	}
 
@@ -330,6 +328,41 @@ static ssize_t idle_store(struct device *dev,
 }
 
 #ifdef CONFIG_ZRAM_WRITEBACK
+static ssize_t writeback_limit_enable_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	u64 val;
+	ssize_t ret = -EINVAL;
+
+	if (kstrtoull(buf, 10, &val))
+		return ret;
+
+	down_read(&zram->init_lock);
+	spin_lock(&zram->wb_limit_lock);
+	zram->wb_limit_enable = val;
+	spin_unlock(&zram->wb_limit_lock);
+	up_read(&zram->init_lock);
+	ret = len;
+
+	return ret;
+}
+
+static ssize_t writeback_limit_enable_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	bool val;
+	struct zram *zram = dev_to_zram(dev);
+
+	down_read(&zram->init_lock);
+	spin_lock(&zram->wb_limit_lock);
+	val = zram->wb_limit_enable;
+	spin_unlock(&zram->wb_limit_lock);
+	up_read(&zram->init_lock);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
 static ssize_t writeback_limit_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
@@ -341,9 +374,9 @@ static ssize_t writeback_limit_store(struct device *dev,
 		return ret;
 
 	down_read(&zram->init_lock);
-	atomic64_set(&zram->stats.bd_wb_limit, val);
-	if (val == 0)
-		zram->stop_writeback = false;
+	spin_lock(&zram->wb_limit_lock);
+	zram->bd_wb_limit = val;
+	spin_unlock(&zram->wb_limit_lock);
 	up_read(&zram->init_lock);
 	ret = len;
 
@@ -357,7 +390,9 @@ static ssize_t writeback_limit_show(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 
 	down_read(&zram->init_lock);
-	val = atomic64_read(&zram->stats.bd_wb_limit);
+	spin_lock(&zram->wb_limit_lock);
+	val = zram->bd_wb_limit;
+	spin_unlock(&zram->wb_limit_lock);
 	up_read(&zram->init_lock);
 
 	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
@@ -588,8 +623,8 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 	return 1;
 }
 
-#define HUGE_WRITEBACK 0x1
-#define IDLE_WRITEBACK 0x2
+#define HUGE_WRITEBACK 1
+#define IDLE_WRITEBACK 2
 
 static ssize_t writeback_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
@@ -602,7 +637,7 @@ static ssize_t writeback_store(struct device *dev,
 	struct page *page;
 	ssize_t ret, sz;
 	char mode_buf[8];
-	unsigned long mode = -1UL;
+	int mode = -1;
 	unsigned long blk_idx = 0;
 
 	sz = strscpy(mode_buf, buf, sizeof(mode_buf));
@@ -618,7 +653,7 @@ static ssize_t writeback_store(struct device *dev,
 	else if (!strcmp(mode_buf, "huge"))
 		mode = HUGE_WRITEBACK;
 
-	if (mode == -1UL)
+	if (mode == -1)
 		return -EINVAL;
 
 	down_read(&zram->init_lock);
@@ -645,10 +680,13 @@ static ssize_t writeback_store(struct device *dev,
 		bvec.bv_len = PAGE_SIZE;
 		bvec.bv_offset = 0;
 
-		if (zram->stop_writeback) {
+		spin_lock(&zram->wb_limit_lock);
+		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
+			spin_unlock(&zram->wb_limit_lock);
 			ret = -EIO;
 			break;
 		}
+		spin_unlock(&zram->wb_limit_lock);
 
 		if (!blk_idx) {
 			blk_idx = alloc_block_bdev(zram);
@@ -667,10 +705,11 @@ static ssize_t writeback_store(struct device *dev,
 				zram_test_flag(zram, index, ZRAM_UNDER_WB))
 			goto next;
 
-		if ((mode & IDLE_WRITEBACK &&
-			  !zram_test_flag(zram, index, ZRAM_IDLE)) &&
-		    (mode & HUGE_WRITEBACK &&
-			  !zram_test_flag(zram, index, ZRAM_HUGE)))
+		if (mode == IDLE_WRITEBACK &&
+			  !zram_test_flag(zram, index, ZRAM_IDLE))
+			goto next;
+		if (mode == HUGE_WRITEBACK &&
+			  !zram_test_flag(zram, index, ZRAM_HUGE))
 			goto next;
 		/*
 		 * Clearing ZRAM_UNDER_WB is duty of caller.
@@ -732,11 +771,10 @@ static ssize_t writeback_store(struct device *dev,
 		zram_set_element(zram, index, blk_idx);
 		blk_idx = 0;
 		atomic64_inc(&zram->stats.pages_stored);
-		if (atomic64_add_unless(&zram->stats.bd_wb_limit,
-					-1 << (PAGE_SHIFT - 12), 0)) {
-			if (atomic64_read(&zram->stats.bd_wb_limit) == 0)
-				zram->stop_writeback = true;
-		}
+		spin_lock(&zram->wb_limit_lock);
+		if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
+			zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
+		spin_unlock(&zram->wb_limit_lock);
 next:
 		zram_slot_unlock(zram, index);
 	}
@@ -1812,6 +1850,7 @@ static DEVICE_ATTR_RW(comp_algorithm);
 static DEVICE_ATTR_RW(backing_dev);
 static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
+static DEVICE_ATTR_RW(writeback_limit_enable);
 #endif
 
 static struct attribute *zram_disk_attrs[] = {
@@ -1828,6 +1867,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_backing_dev.attr,
 	&dev_attr_writeback.attr,
 	&dev_attr_writeback_limit.attr,
+	&dev_attr_writeback_limit_enable.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 4bd3afd15e833..f2fd46daa7604 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -86,7 +86,6 @@ struct zram_stats {
 	atomic64_t bd_count;		/* no. of pages in backing device */
 	atomic64_t bd_reads;		/* no. of reads from backing device */
 	atomic64_t bd_writes;		/* no. of writes from backing device */
-	atomic64_t bd_wb_limit;		/* writeback limit of backing device */
 #endif
 };
 
@@ -114,8 +113,10 @@ struct zram {
 	 */
 	bool claim; /* Protected by bdev->bd_mutex */
 	struct file *backing_dev;
-	bool stop_writeback;
 #ifdef CONFIG_ZRAM_WRITEBACK
+	spinlock_t wb_limit_lock;
+	bool wb_limit_enable;
+	u64 bd_wb_limit;
 	struct block_device *bdev;
 	unsigned int old_block_size;
 	unsigned long *bitmap;
-- 
2.20.1.415.g653613c723-goog

