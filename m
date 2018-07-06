Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E52C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B2023C4E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="RTDmL5h9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B2023C4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934093AbeGFRjW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:39:22 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44685 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933821AbeGFRjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:39:16 -0400
Received: by mail-lf0-f66.google.com with SMTP id h7-v6so10413190lfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FpzFoPLnrjXYarQI3Bh9v8guJlLVYF4ZsfSMzi/vbgE=;
        b=RTDmL5h9diMeMiN/sdXx3AM1QQhePpLuZaNkfgyxGu5qMOKxzZxMjmRIDsLv6faZXQ
         cF4puEDP+8iQTTOwHyQka/VNenySYuxkkVJTBXCa4NZL/+qoJmfbqRhuS2vP4bGcuJVt
         RtYb7UhrVvPQWduCzOA4L1oSGgbsYffpB8Qw1fXSKzIwsmMGEgK3+M9Hh8qbPPLDb2u2
         eIEyWf0Om/v6/TV0hutRYGO+hWO6olTGAIQ93LlNmaAK7Dy3eUN11SmknSzJNCnmyzj6
         OcUQXGUZUiDPAwlT6FDhPKX3Cx0UYu+vFlWewIrq7pCaXOnnwohrU0iJvGMlC99CoUDu
         AnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FpzFoPLnrjXYarQI3Bh9v8guJlLVYF4ZsfSMzi/vbgE=;
        b=Idal2wp697mW/2RgJkFet5FnaaSOH+9tIlEYOsZQb7Y/4UiL9mIBlNEOAnPwSh047U
         VYt4gb/8ecwc3y1Urd839mdnouwmKh3uA7H6E2kADLZaX3/ev/dSLTg2G+lQ+USfD42V
         RMRmNhbwx8pz48O9/YE8uwshLfRX32UojOkjp5EQGAeGGc+WjD1XpM6otOjQHnKP8G3Q
         B1FGnyJ74uesnygg2BqLVvvMfITx8/CNCWt/PHuGQxantA/Qu/3Zm+h6apl7xQtT0sae
         zB2Y/C3CQ7H6PqMhxbGoC3k9BTgm60BaLsixjswLVVAES5uPkf67GQdp71Xj23XmZVU6
         uI5A==
X-Gm-Message-State: APt69E1j+eFM/tnbYpH0rSmYlIuajJeLvip3ehCLw68WhnwavFRMNK+d
        LHoaLNdj8oMSEIqpNaeAD/bR4w==
X-Google-Smtp-Source: AAOMgpfkIcyp61bYbGfE0b25GloMiZ0aBhq7bQbEabGHcxQz401f4o/uRIsXA0xVW5bhqqHSxubO2g==
X-Received: by 2002:a19:c403:: with SMTP id u3-v6mr7822238lff.87.1530898754704;
        Fri, 06 Jul 2018 10:39:14 -0700 (PDT)
Received: from Macroninja.cnexlabs.com (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id i69-v6sm2301662lfa.50.2018.07.06.10.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 10:39:13 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, damien.lemoal@wdc.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Subject: [PATCH 1/2] null_blk: move shared definitions to header file
Date:   Fri,  6 Jul 2018 19:38:38 +0200
Message-Id: <20180706173839.28355-2-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180706173839.28355-1-mb@lightnvm.io>
References: <20180706173839.28355-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matias Bjørling <matias.bjorling@wdc.com>

Split the null_blk device driver, such that it can prepare for
zoned block interface support.

Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
---
 drivers/block/null_blk.c | 76 +--------------------------------------------
 drivers/block/null_blk.h | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 75 deletions(-)
 create mode 100644 drivers/block/null_blk.h

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 042c778e5a4e..cd4b0849d3b4 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -7,14 +7,8 @@
 #include <linux/moduleparam.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
-#include <linux/blkdev.h>
 #include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/blk-mq.h>
-#include <linux/hrtimer.h>
-#include <linux/configfs.h>
-#include <linux/badblocks.h>
-#include <linux/fault-inject.h>
+#include "null_blk.h"
 
 #define PAGE_SECTORS_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
 #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
@@ -35,28 +29,6 @@ static inline u64 mb_per_tick(int mbps)
 	return (1 << 20) / TICKS_PER_SEC * ((u64) mbps);
 }
 
-struct nullb_cmd {
-	struct list_head list;
-	struct llist_node ll_list;
-	struct __call_single_data csd;
-	struct request *rq;
-	struct bio *bio;
-	unsigned int tag;
-	blk_status_t error;
-	struct nullb_queue *nq;
-	struct hrtimer timer;
-};
-
-struct nullb_queue {
-	unsigned long *tag_map;
-	wait_queue_head_t wait;
-	unsigned int queue_depth;
-	struct nullb_device *dev;
-	unsigned int requeue_selection;
-
-	struct nullb_cmd *cmds;
-};
-
 /*
  * Status flags for nullb_device.
  *
@@ -92,52 +64,6 @@ struct nullb_page {
 #define NULLB_PAGE_LOCK (MAP_SZ - 1)
 #define NULLB_PAGE_FREE (MAP_SZ - 2)
 
-struct nullb_device {
-	struct nullb *nullb;
-	struct config_item item;
-	struct radix_tree_root data; /* data stored in the disk */
-	struct radix_tree_root cache; /* disk cache data */
-	unsigned long flags; /* device flags */
-	unsigned int curr_cache;
-	struct badblocks badblocks;
-
-	unsigned long size; /* device size in MB */
-	unsigned long completion_nsec; /* time in ns to complete a request */
-	unsigned long cache_size; /* disk cache size in MB */
-	unsigned int submit_queues; /* number of submission queues */
-	unsigned int home_node; /* home node for the device */
-	unsigned int queue_mode; /* block interface */
-	unsigned int blocksize; /* block size */
-	unsigned int irqmode; /* IRQ completion handler */
-	unsigned int hw_queue_depth; /* queue depth */
-	unsigned int index; /* index of the disk, only valid with a disk */
-	unsigned int mbps; /* Bandwidth throttle cap (in MB/s) */
-	bool blocking; /* blocking blk-mq device */
-	bool use_per_node_hctx; /* use per-node allocation for hardware context */
-	bool power; /* power on/off the device */
-	bool memory_backed; /* if data is stored in memory */
-	bool discard; /* if support discard */
-};
-
-struct nullb {
-	struct nullb_device *dev;
-	struct list_head list;
-	unsigned int index;
-	struct request_queue *q;
-	struct gendisk *disk;
-	struct blk_mq_tag_set *tag_set;
-	struct blk_mq_tag_set __tag_set;
-	unsigned int queue_depth;
-	atomic_long_t cur_bytes;
-	struct hrtimer bw_timer;
-	unsigned long cache_flush_pos;
-	spinlock_t lock;
-
-	struct nullb_queue *queues;
-	unsigned int nr_queues;
-	char disk_name[DISK_NAME_LEN];
-};
-
 static LIST_HEAD(nullb_list);
 static struct mutex lock;
 static int null_major;
diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
new file mode 100644
index 000000000000..d82c5501806d
--- /dev/null
+++ b/drivers/block/null_blk.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BLK_NULL_BLK_H
+#define __BLK_NULL_BLK_H
+
+#include <linux/blkdev.h>
+#include <linux/slab.h>
+#include <linux/blk-mq.h>
+#include <linux/hrtimer.h>
+#include <linux/configfs.h>
+#include <linux/badblocks.h>
+#include <linux/fault-inject.h>
+
+struct nullb_cmd {
+	struct list_head list;
+	struct llist_node ll_list;
+	struct __call_single_data csd;
+	struct request *rq;
+	struct bio *bio;
+	unsigned int tag;
+	blk_status_t error;
+	struct nullb_queue *nq;
+	struct hrtimer timer;
+};
+
+struct nullb_queue {
+	unsigned long *tag_map;
+	wait_queue_head_t wait;
+	unsigned int queue_depth;
+	struct nullb_device *dev;
+	unsigned int requeue_selection;
+
+	struct nullb_cmd *cmds;
+};
+
+struct nullb_device {
+	struct nullb *nullb;
+	struct config_item item;
+	struct radix_tree_root data; /* data stored in the disk */
+	struct radix_tree_root cache; /* disk cache data */
+	unsigned long flags; /* device flags */
+	unsigned int curr_cache;
+	struct badblocks badblocks;
+
+	unsigned long size; /* device size in MB */
+	unsigned long completion_nsec; /* time in ns to complete a request */
+	unsigned long cache_size; /* disk cache size in MB */
+	unsigned int submit_queues; /* number of submission queues */
+	unsigned int home_node; /* home node for the device */
+	unsigned int queue_mode; /* block interface */
+	unsigned int blocksize; /* block size */
+	unsigned int irqmode; /* IRQ completion handler */
+	unsigned int hw_queue_depth; /* queue depth */
+	unsigned int index; /* index of the disk, only valid with a disk */
+	unsigned int mbps; /* Bandwidth throttle cap (in MB/s) */
+	bool blocking; /* blocking blk-mq device */
+	bool use_per_node_hctx; /* use per-node allocation for hardware context */
+	bool power; /* power on/off the device */
+	bool memory_backed; /* if data is stored in memory */
+	bool discard; /* if support discard */
+};
+
+struct nullb {
+	struct nullb_device *dev;
+	struct list_head list;
+	unsigned int index;
+	struct request_queue *q;
+	struct gendisk *disk;
+	struct blk_mq_tag_set *tag_set;
+	struct blk_mq_tag_set __tag_set;
+	unsigned int queue_depth;
+	atomic_long_t cur_bytes;
+	struct hrtimer bw_timer;
+	unsigned long cache_flush_pos;
+	spinlock_t lock;
+
+	struct nullb_queue *queues;
+	unsigned int nr_queues;
+	char disk_name[DISK_NAME_LEN];
+};
+#endif /* __NULL_BLK_H */
-- 
2.11.0

