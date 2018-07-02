Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61A9C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3629255F8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7NKw7Mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3629255F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932407AbeGBA5z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 20:57:55 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37300 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932286AbeGBA5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 20:57:40 -0400
Received: by mail-oi0-f65.google.com with SMTP id k81-v6so13349293oib.4;
        Sun, 01 Jul 2018 17:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uQq7Rhh2IoBOG5dCp0+cMTRTysWrcwIj4JspKeAqpgw=;
        b=R7NKw7MjzwO2OAqPIqAKIb+0PZqdQgxMlT/+wbZ+5gPFLwCcqC9eAgg2KW5YgQT5nr
         0rPcxMA9dA5mU+0Xds4payqHHKyaxEyjuOpNqGaNwyIbj+l+OFsHqL/aTnPzwLJaho1a
         /ZJvVa2SFD7o4pOnzI2EbaSEIuMfQrDSBkpBssZqRM3cUG8xQKjDChb3iHsVkrIpEB0j
         chJW3e+biapq1UMMntmhfjmG0zAvkiQ3BrrLx497Cy6Q4+9fdZRXVHHghj50apibuluT
         7MmhPuFGnZo+uFsDFm/RmLU159Duko+IY1JXwPburS2vFn2TRyqr+wJDiFxfohXbX6Re
         jYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uQq7Rhh2IoBOG5dCp0+cMTRTysWrcwIj4JspKeAqpgw=;
        b=i+JjfL/yFQsk/pbaYZmlZEgACGF2fkjpEuIs+6IQGpftLJym86oV0swkO4FItz6mt/
         Iscv5Kyyudg3TkdqSRFKr08bOtLxTjoGHiGNo2SVX8fDSmVFjiuTeKkG8PFb/pY+vgWt
         puS2HuResCnvUYPzbMuvnUg286UhL10Lr17LYKcNMcgFzC9lsVLUq3wlbFBTymyYsm/I
         ijy7EIWFVazJZGrir81cpqvEf/8BZXM/+YS261kLGobd2GijxXQT3jHUQ9ciLpS+4l9h
         87XV2nNfqdon+X71GlWEKYue7xVE7CgnjQZKxT+FM84bhHA2opJEMeKwUXruDhiFDhE0
         kkVw==
X-Gm-Message-State: APt69E1gPQASOoA2j9+O+lILAx3K29t9eudvqE9AMfvu5HRq+CC2hk1L
        tsEY/IOw+VAnOIn0M6KKfmQ=
X-Google-Smtp-Source: AAOMgpdg+glJKExTO1EfoZ4DYd7+hfIDaB2gFDtabtdRxzXfyF0VL0cWDVe3gZSE9hDK0mPjFiEaRw==
X-Received: by 2002:aca:5c46:: with SMTP id q67-v6mr12867959oib.17.1530493060311;
        Sun, 01 Jul 2018 17:57:40 -0700 (PDT)
Received: from sandstorm.nvidia.com ([2600:1700:43b0:3120:feaa:14ff:fe9e:34cb])
        by smtp.gmail.com with ESMTPSA id v6-v6sm4111672oix.30.2018.07.01.17.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 17:57:39 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 3/6] mm: introduce zone_gup_lock, for dma-pinned pages
Date:   Sun,  1 Jul 2018 17:56:51 -0700
Message-Id: <20180702005654.20369-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180702005654.20369-1-jhubbard@nvidia.com>
References: <20180702005654.20369-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

The page->dma_pinned_flags and _count fields require
lock protection. A lock at approximately the granularity
of the zone_lru_lock is called for, but adding to the
locking contention of zone_lru_lock is undesirable,
because that is a pre-existing hot spot. Fortunately,
these new dma_pinned_* fields can use an independent
lock, so this patch creates an entirely new lock, right
next to the zone_lru_lock.

Why "zone_gup_lock"?

Most of the naming refers to "DMA-pinned pages", but
"zone DMA lock" has other meanings already, so this is
called zone_gup_lock instead. The "dma pinning" is a result
of get_user_pages (gup) being called, so the name still
helps explain its use.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mmzone.h | 7 +++++++
 mm/page_alloc.c        | 1 +
 2 files changed, 8 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 32699b2dc52a..5b4ceef82657 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -662,6 +662,8 @@ typedef struct pglist_data {
 
 	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
 
+	spinlock_t pinned_dma_lock;
+
 #ifdef CONFIG_COMPACTION
 	int kcompactd_max_order;
 	enum zone_type kcompactd_classzone_idx;
@@ -740,6 +742,11 @@ static inline spinlock_t *zone_lru_lock(struct zone *zone)
 	return &zone->zone_pgdat->lru_lock;
 }
 
+static inline spinlock_t *zone_gup_lock(struct zone *zone)
+{
+	return &zone->zone_pgdat->pinned_dma_lock;
+}
+
 static inline struct lruvec *node_lruvec(struct pglist_data *pgdat)
 {
 	return &pgdat->lruvec;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1521100f1e63..9c493442b57c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6211,6 +6211,7 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 	int nid = pgdat->node_id;
 
 	pgdat_resize_init(pgdat);
+	spin_lock_init(&pgdat->pinned_dma_lock);
 #ifdef CONFIG_NUMA_BALANCING
 	spin_lock_init(&pgdat->numabalancing_migrate_lock);
 	pgdat->numabalancing_migrate_nr_pages = 0;
-- 
2.18.0

