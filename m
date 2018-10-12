Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20237C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB47F206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svScXGM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB47F206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJLNbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:31:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43206 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbeJLNbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:31:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id 30-v6so5363570plb.10;
        Thu, 11 Oct 2018 23:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r6gf/3+FxFoo0uFxF1HQUrQtpnIyPUJrRDNGoh0sv3k=;
        b=svScXGM87F7pkDY1zQnXkoh0/E1jU6dk0eyAzQUvDSh5Wugzl9qEuvG7+Xu4dUWb8s
         SR8mYLdKbQHzzLAk5dDx+sjo76Sddq81tsZSt/tD+C3LvQ5k9pQhTlRjHosPb+d3GSXm
         /cGIXS5lMJJw+Ap7p+ExA/KOOSa5eRnZ+9tIIUXRqApUVtWqowKabLgR1wH7OvyBpnDH
         IVfAm5wSDyiM5HD46w4QSJQ4oRl/9xFNCEoKmBmFC6f8UFrgAJvf6Jc+fIm3+nTsnSFB
         NwtJ71tK1cupi2Fq3gN5qKUJegKEAjP41drN38u8eWJQbpGVxp5gVE24v49WVEZNnrlK
         LbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r6gf/3+FxFoo0uFxF1HQUrQtpnIyPUJrRDNGoh0sv3k=;
        b=Z8yLJNtZYBXMUYWEu4JduPz+06oWWz5Tq38nYEmLfxXqHhMNKs1HTGroKxLWfZ0J5t
         dunXjP1R0smLrqb8+z5Xr4zBy7RjbWNGPUVk6SFUzK1l5oCLIFOudCCtL5oktZPbnJn/
         Dqj/UGJItf+hdKQLFzV55bFncv9Vykhe3izSNg9kodtYd1NXtW2nuNHEiH4bhjz00dkH
         yrYZsGqad+naPnPYzJ1JEOJqd6LP0I4qnOFAGo6lopWmznagqGYzpJ6dnRowHDYWm6mh
         Nq+QiPNFngdG0bNtRuCPgUBRGRRLRhSfACj1jaxMFMo5zkOQVO5TtGLpibTzkVMCryOj
         sxXA==
X-Gm-Message-State: ABuFfohKe3AWGk638NTv2JXrH+U8deYRlWdveoJaDNGdl/T2JiE6A0ki
        QLK72IIq+d2bqaeyKjQ1+iQ=
X-Google-Smtp-Source: ACcGV63SVIxTN5usiPLLB6gc3qBl/+Vh3uNHa6giBPTmGkEMBVLUqMufOt9kVZRfmZGKcEL9+tf8rg==
X-Received: by 2002:a17:902:124:: with SMTP id 33-v6mr4618125plb.205.1539324035839;
        Thu, 11 Oct 2018 23:00:35 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id z3-v6sm368579pfm.150.2018.10.11.23.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 23:00:34 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 5/6] mm: introduce zone_gup_lock, for dma-pinned pages
Date:   Thu, 11 Oct 2018 23:00:13 -0700
Message-Id: <20181012060014.10242-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181012060014.10242-1-jhubbard@nvidia.com>
References: <20181012060014.10242-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
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
 include/linux/mmzone.h | 6 ++++++
 mm/page_alloc.c        | 1 +
 2 files changed, 7 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d4b0c79d2924..971a63f84ad5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -661,6 +661,7 @@ typedef struct pglist_data {
 	enum zone_type kswapd_classzone_idx;
 
 	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
+	spinlock_t pinned_dma_lock;
 
 #ifdef CONFIG_COMPACTION
 	int kcompactd_max_order;
@@ -730,6 +731,11 @@ static inline spinlock_t *zone_lru_lock(struct zone *zone)
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
index e2ef1c17942f..850f90223cc7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6225,6 +6225,7 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 
 	pgdat_page_ext_init(pgdat);
 	spin_lock_init(&pgdat->lru_lock);
+	spin_lock_init(&pgdat->pinned_dma_lock);
 	lruvec_init(node_lruvec(pgdat));
 }
 
-- 
2.19.1

