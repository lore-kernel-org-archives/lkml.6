Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BCAC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BF820657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Qne8Q/R5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BF820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeJ3B10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:27:26 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34844 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeJ3B1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:27:25 -0400
Received: by mail-it1-f194.google.com with SMTP id p64-v6so10181381itp.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hu4SRygQduE3Ah39+YjJ5DfLsSb40qLLfETVJ69MQec=;
        b=Qne8Q/R59peKayL//DkDF0zKocJo81nHGGU6Fx1JzYRYHOhZbze0azcwjFJabpP8X+
         ABtnKdE1fmHihK1tir7me+SNQzUN69X46KPPXfWirjWcjAl/snCbDzghbEWBXZ0wGu6a
         K+KyoiV6bTtnvR5u2FBiJBc0rwRf36pbB/b3kxLW/S3egAKFjwnfqFfoQZr5ZBLnsCJj
         XBxrogqmOy9kcIiSb6xYhnhD8DROhBh1AchvYOctmYtdbiqxkJmn7yKfiXBRXssTD1Js
         m3B2mgsr7WD4VttVAHgF1XEhU/YAmAcB3H2syrBFi+7t5JKqztU7PHAgFY4nUmH4bSQ0
         8wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hu4SRygQduE3Ah39+YjJ5DfLsSb40qLLfETVJ69MQec=;
        b=KDzz+vzWTqWGhec/WRy1ZMy8k9Wns/dKSMVGqzGmWwJHC0TYGi+bYK2FBa1bBBRqUG
         cQY+vTZyW5l5RSgGUKeY2XXxfSn6FgAbhQsMIcupweO4uMEPCiF0We3luIWmu2Y1DZF5
         O8EnO67X4Lz+19k7E/21U4uYTjvW4r6+vFo7+ipaJ5rVVlsi0jK4P/DlrBdLwj/QzKPj
         NhJjJplySaH+V5znQHjIz8DmgI+p8bZ2ERnZp07/j8+yFSjiyDIttOkRKYFmNIsO/omx
         HWp3G0kd+ndOpTN+rl/8GSyhMxeMIdmVbWn19HT1dVQli77NhbUrqZhlKbMHeTH+ABcD
         zMsA==
X-Gm-Message-State: AGRZ1gIhZp0WCFgcLQuX+CPv/wuuO15d05nzsiJLUcjYmu3MdbWrvqyi
        IiHKxG2iKeRp346ZxdwyHTgi3w==
X-Google-Smtp-Source: AJdET5dyPe1b17iC0D8wHHWNBSOj0Y/26jftcPO2w99nVKDSRdrIi60lcBEFoh16qhUPi0PYmD7ciQ==
X-Received: by 2002:a05:660c:484:: with SMTP id a4mr3990245itk.116.1540831083626;
        Mon, 29 Oct 2018 09:38:03 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q15-v6sm3367019itc.38.2018.10.29.09.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:38:02 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/14] blk-mq: initial support for multiple queue maps
Date:   Mon, 29 Oct 2018 10:37:34 -0600
Message-Id: <20181029163738.10172-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029163738.10172-1-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a queue offset to the tag map. This enables users to map
iteratively, for each queue map type they support.

Bump maximum number of supported maps to 2, we're now fully
able to support more than 1 map.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-cpumap.c  | 9 +++++----
 block/blk-mq-pci.c     | 2 +-
 block/blk-mq-virtio.c  | 2 +-
 include/linux/blk-mq.h | 3 ++-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 6e6686c55984..03a534820271 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -14,9 +14,10 @@
 #include "blk.h"
 #include "blk-mq.h"
 
-static int cpu_to_queue_index(unsigned int nr_queues, const int cpu)
+static int cpu_to_queue_index(struct blk_mq_queue_map *qmap,
+			      unsigned int nr_queues, const int cpu)
 {
-	return cpu % nr_queues;
+	return qmap->queue_offset + (cpu % nr_queues);
 }
 
 static int get_first_sibling(unsigned int cpu)
@@ -44,11 +45,11 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 		 * performace optimizations.
 		 */
 		if (cpu < nr_queues) {
-			map[cpu] = cpu_to_queue_index(nr_queues, cpu);
+			map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
 		} else {
 			first_sibling = get_first_sibling(cpu);
 			if (first_sibling == cpu)
-				map[cpu] = cpu_to_queue_index(nr_queues, cpu);
+				map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
 			else
 				map[cpu] = map[first_sibling];
 		}
diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index 40333d60a850..1dce18553984 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -43,7 +43,7 @@ int blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev *pdev,
 			goto fallback;
 
 		for_each_cpu(cpu, mask)
-			qmap->mq_map[cpu] = queue;
+			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
 
 	return 0;
diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
index 661fbfef480f..370827163835 100644
--- a/block/blk-mq-virtio.c
+++ b/block/blk-mq-virtio.c
@@ -44,7 +44,7 @@ int blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
 			goto fallback;
 
 		for_each_cpu(cpu, mask)
-			qmap->mq_map[cpu] = queue;
+			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
 
 	return 0;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 837087cf07cc..b5ae2b5677c1 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -78,10 +78,11 @@ struct blk_mq_hw_ctx {
 struct blk_mq_queue_map {
 	unsigned int *mq_map;
 	unsigned int nr_queues;
+	unsigned int queue_offset;
 };
 
 enum {
-	HCTX_MAX_TYPES = 1,
+	HCTX_MAX_TYPES = 2,
 };
 
 struct blk_mq_tag_set {
-- 
2.17.1

