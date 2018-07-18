Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987E5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FA420850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="og4Ja7H4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FA420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbeGRMZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:25:33 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:37791 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731374AbeGRMZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:25:32 -0400
Received: by mail-yb0-f196.google.com with SMTP id r3-v6so1699693ybo.4;
        Wed, 18 Jul 2018 04:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+uFtafGXCm6zahl3ZieLQaXkyxLgn2fA6aRVY5eZnoM=;
        b=og4Ja7H4Hm3JR93wrSK3W+Xv9f54Qmx4Ik/PrFpdcl0eaUfGW85+rQgUZCLppW+bqa
         EY9VjeQJ+1E7LsQ0TtdXkQw6WIekbdpXP4kj+hbYiuGhOwdsB3Vu/raZWbO6WxiF0AK6
         pZ4nP1ZwWrJT92baBM8S8cobkgJT9Nq0ARPuHwsnwaXa0pPweT7SKGD5tSx6t6wbEBJn
         NyCJ5KkL07litj6rGO0MGRxAF3xpY6QbaZZDLeIvCCWMWzBefPnc9bhJH95GCanDzmIr
         HZKviH7tSjAp+2aDmF2YOITWEaGKQ5tqzivCU9gTvLwFu0dAtUGwAKenx9UPqjy37/f6
         Xorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=+uFtafGXCm6zahl3ZieLQaXkyxLgn2fA6aRVY5eZnoM=;
        b=YlNkZWY8H1yB7o+sN7usW8KC7C77lCAq0RsvyTXnFqk6AuEpKzy1NqJ/yJ3AUzeJBl
         oiJ87zQuid9S8lPpOaTpVkZlu+iZxmpMHwP97l2NMrydDWgbiFkfTVm3kIkw0LLVDe+I
         t0oqMIzr0SlPe2VPFL9DQoXeuozcyqQkFX+5XHiq6vgwx87zocYz4+GpyBSauiwuAJAQ
         c028v5ehzEO8VfcUk6LPVqXA7PafkR7DDvP0SjiRo8Se0KywAhc2PGjElquo3iyGbipz
         p/1hfcRPyvGQXJQo2wEPe2BK/gF75L8X6Ht+kkAJJhmGBwCWlC+lQjiZ+iR/4iK7UQtN
         xW8w==
X-Gm-Message-State: AOUpUlG2V5UKt5kZgBMzWrPf/kxRXXdtYnEgCF10n02dyuuH3Mnau/GG
        vXI1gNeGY/MGNH50EwQa8xSqHW1x
X-Google-Smtp-Source: AAOMgpfduCG8zCqyRgBJis0sMRzCkBoGPxaWDfxciKNoQMZRXJaeFYCsfM3tU/qre+mHJRplGOHULA==
X-Received: by 2002:a25:3409:: with SMTP id b9-v6mr3023225yba.275.1531914478940;
        Wed, 18 Jul 2018 04:47:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:c229])
        by smtp.gmail.com with ESMTPSA id x6-v6sm1494848ywf.54.2018.07.18.04.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 04:47:58 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     michaelcallahan@fb.com, newella@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-api@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/6] block: Track DISCARD statistics and output them in stat and diskstat
Date:   Wed, 18 Jul 2018 04:47:40 -0700
Message-Id: <20180718114741.2580313-6-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718114741.2580313-1-tj@kernel.org>
References: <20180718114741.2580313-1-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Callahan <michaelcallahan@fb.com>

Add tracking of REQ_OP_DISCARD ios to the partition statistics and
append them to the various stat files in /sys as well as
/proc/diskstats.  These are tracked with the same four stats as reads
and writes:

Number of discard ios completed.
Number of discard ios merged
Number of discard sectors completed
Milliseconds spent on discard requests

This is done via adding a new STAT_DISCARD define to genhd.h and then
using it to index that stat field for discard requests.

tj: Refreshed on top of v4.17 and other previous updates.

Signed-off-by: Michael Callahan <michaelcallahan@fb.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andy Newell <newella@fb.com>
---
 Documentation/ABI/testing/procfs-diskstats | 10 ++++++++
 Documentation/block/stat.txt               | 28 ++++++++++++----------
 Documentation/iostats.txt                  | 15 ++++++++++++
 block/genhd.c                              | 13 +++++++---
 block/partition-generic.c                  |  9 +++++--
 include/linux/blk_types.h                  |  8 +++++++
 include/linux/genhd.h                      |  3 ++-
 7 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/procfs-diskstats b/Documentation/ABI/testing/procfs-diskstats
index f91a973a37fe..abac31d216de 100644
--- a/Documentation/ABI/testing/procfs-diskstats
+++ b/Documentation/ABI/testing/procfs-diskstats
@@ -5,6 +5,7 @@ Contact:	Jerome Marchand <jmarchan@redhat.com>
 		The /proc/diskstats file displays the I/O statistics
 		of block devices. Each line contains the following 14
 		fields:
+
 		 1 - major number
 		 2 - minor mumber
 		 3 - device name
@@ -19,4 +20,13 @@ Contact:	Jerome Marchand <jmarchan@redhat.com>
 		12 - I/Os currently in progress
 		13 - time spent doing I/Os (ms)
 		14 - weighted time spent doing I/Os (ms)
+
+		Kernel 4.18+ appends four more fields for discard
+		tracking putting the total at 18:
+
+		15 - discards completed successfully
+		16 - discards merged
+		17 - sectors discarded
+		18 - time spent discarding
+
 		For more details refer to Documentation/iostats.txt
diff --git a/Documentation/block/stat.txt b/Documentation/block/stat.txt
index 0dbc946de2ea..0aace9cc536c 100644
--- a/Documentation/block/stat.txt
+++ b/Documentation/block/stat.txt
@@ -31,28 +31,32 @@ write ticks     milliseconds  total wait time for write requests
 in_flight       requests      number of I/Os currently in flight
 io_ticks        milliseconds  total time this block device has been active
 time_in_queue   milliseconds  total wait time for all requests
+discard I/Os    requests      number of discard I/Os processed
+discard merges  requests      number of discard I/Os merged with in-queue I/O
+discard sectors sectors       number of sectors discarded
+discard ticks   milliseconds  total wait time for discard requests
 
-read I/Os, write I/Os
-=====================
+read I/Os, write I/Os, discard I/0s
+===================================
 
 These values increment when an I/O request completes.
 
-read merges, write merges
-=========================
+read merges, write merges, discard merges
+=========================================
 
 These values increment when an I/O request is merged with an
 already-queued I/O request.
 
-read sectors, write sectors
-===========================
+read sectors, write sectors, discard_sectors
+============================================
 
-These values count the number of sectors read from or written to this
-block device.  The "sectors" in question are the standard UNIX 512-byte
-sectors, not any device- or filesystem-specific block size.  The
-counters are incremented when the I/O completes.
+These values count the number of sectors read from, written to, or
+discarded from this block device.  The "sectors" in question are the
+standard UNIX 512-byte sectors, not any device- or filesystem-specific
+block size.  The counters are incremented when the I/O completes.
 
-read ticks, write ticks
-=======================
+read ticks, write ticks, discard ticks
+======================================
 
 These values count the number of milliseconds that I/O requests have
 waited on this block device.  If there are multiple I/O requests waiting,
diff --git a/Documentation/iostats.txt b/Documentation/iostats.txt
index 04d394a2e06c..49df45f90e8a 100644
--- a/Documentation/iostats.txt
+++ b/Documentation/iostats.txt
@@ -31,6 +31,9 @@ and so should not differ.
       3    0   hda 446216 784926 9550688 4382310 424847 312726 5922052 19310380 0 3376340 23705160
       3    1   hda1 35486 38030 38030 38030
 
+   4.18+ diskstats:
+      3    0   hda 446216 784926 9550688 4382310 424847 312726 5922052 19310380 0 3376340 23705160 0 0 0 0
+
 On 2.4 you might execute ``grep 'hda ' /proc/partitions``. On 2.6+, you have
 a choice of ``cat /sys/block/hda/stat`` or ``grep 'hda ' /proc/diskstats``.
 
@@ -101,6 +104,18 @@ Field 11 -- weighted # of milliseconds spent doing I/Os
     last update of this field.  This can provide an easy measure of both
     I/O completion time and the backlog that may be accumulating.
 
+Field 12 -- # of discards completed
+    This is the total number of discards completed successfully.
+
+Field 13 -- # of discards merged
+    See the description of field 2
+
+Field 14 -- # of sectors discarded
+    This is the total number of sectors discarded successfully.
+
+Field 15 -- # of milliseconds spent discarding
+    This is the total number of milliseconds spent by all discards (as
+    measured from __make_request() to end_that_request_last()).
 
 To avoid introducing performance bottlenecks, no locks are held while
 modifying these counters.  This implies that minor inaccuracies may be
diff --git a/block/genhd.c b/block/genhd.c
index 0711a800d0d4..8cc719a37b32 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1333,8 +1333,11 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 		part_round_stats(gp->queue, cpu, hd);
 		part_stat_unlock();
 		part_in_flight(gp->queue, hd, inflight);
-		seq_printf(seqf, "%4d %7d %s %lu %lu %lu "
-			   "%u %lu %lu %lu %u %u %u %u\n",
+		seq_printf(seqf, "%4d %7d %s "
+			   "%lu %lu %lu %u "
+			   "%lu %lu %lu %u "
+			   "%u %u %u "
+			   "%lu %lu %lu %u\n",
 			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
 			   disk_name(gp, hd->partno, buf),
 			   part_stat_read(hd, ios[STAT_READ]),
@@ -1347,7 +1350,11 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			   jiffies_to_msecs(part_stat_read(hd, ticks[STAT_WRITE])),
 			   inflight[0],
 			   jiffies_to_msecs(part_stat_read(hd, io_ticks)),
-			   jiffies_to_msecs(part_stat_read(hd, time_in_queue))
+			   jiffies_to_msecs(part_stat_read(hd, time_in_queue)),
+			   part_stat_read(hd, ios[STAT_DISCARD]),
+			   part_stat_read(hd, merges[STAT_DISCARD]),
+			   part_stat_read(hd, sectors[STAT_DISCARD]),
+			   jiffies_to_msecs(part_stat_read(hd, ticks[STAT_DISCARD]))
 			);
 	}
 	disk_part_iter_exit(&piter);
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 0ddb06722162..5a8975a1201c 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -130,7 +130,8 @@ ssize_t part_stat_show(struct device *dev,
 	return sprintf(buf,
 		"%8lu %8lu %8llu %8u "
 		"%8lu %8lu %8llu %8u "
-		"%8u %8u %8u"
+		"%8u %8u %8u "
+		"%8lu %8lu %8llu %8u"
 		"\n",
 		part_stat_read(p, ios[STAT_READ]),
 		part_stat_read(p, merges[STAT_READ]),
@@ -142,7 +143,11 @@ ssize_t part_stat_show(struct device *dev,
 		jiffies_to_msecs(part_stat_read(p, ticks[STAT_WRITE])),
 		inflight[0],
 		jiffies_to_msecs(part_stat_read(p, io_ticks)),
-		jiffies_to_msecs(part_stat_read(p, time_in_queue)));
+		jiffies_to_msecs(part_stat_read(p, time_in_queue)),
+		part_stat_read(p, ios[STAT_DISCARD]),
+		part_stat_read(p, merges[STAT_DISCARD]),
+		(unsigned long long)part_stat_read(p, sectors[STAT_DISCARD]),
+		jiffies_to_msecs(part_stat_read(p, ticks[STAT_DISCARD])));
 }
 
 ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 2960a96d833c..f6dfb30737d8 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -360,6 +360,7 @@ enum req_flag_bits {
 enum stat_group {
 	STAT_READ,
 	STAT_WRITE,
+	STAT_DISCARD,
 
 	NR_STAT_GROUPS
 };
@@ -401,8 +402,15 @@ static inline bool op_is_sync(unsigned int op)
 		(op & (REQ_SYNC | REQ_FUA | REQ_PREFLUSH));
 }
 
+static inline bool op_is_discard(unsigned int op)
+{
+	return (op & REQ_OP_MASK) == REQ_OP_DISCARD;
+}
+
 static inline int op_stat_group(unsigned int op)
 {
+	if (op_is_discard(op))
+		return STAT_DISCARD;
 	return op_is_write(op);
 }
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index a75445446974..57864422a2c8 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -356,7 +356,8 @@ static inline void free_part_stats(struct hd_struct *part)
 
 #define part_stat_read_accum(part, field)				\
 	(part_stat_read(part, field[STAT_READ]) +			\
-	 part_stat_read(part, field[STAT_WRITE]))
+	 part_stat_read(part, field[STAT_WRITE]) +			\
+	 part_stat_read(part, field[STAT_DISCARD]))
 
 #define part_stat_add(cpu, part, field, addnd)	do {			\
 	__part_stat_add((cpu), (part), field, addnd);			\
-- 
2.17.1

