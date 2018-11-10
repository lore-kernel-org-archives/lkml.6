Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A41C0044B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EBF20883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nntfL9En"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EBF20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbeKJSfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 13:35:18 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42565 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbeKJSfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 13:35:16 -0500
Received: by mail-ot1-f67.google.com with SMTP id n46so3820004otb.9;
        Sat, 10 Nov 2018 00:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MdCfTkrI/mhGPOQj8LTem5BIzNj3M/TunMyugwmPtzk=;
        b=nntfL9En9A6j6EbfAykLM55VbC5NL6c8YbXHQfRUVVqH0FTgiOhtO+yogE1sk+LPqN
         Ak7r5g+tkaB6e3zhCFPDs84/yUz+RqYbyOXY3P0IiRF4DDY4oXOgxHePeJbRGKctAb+a
         dbTpufPwZvW2rH/a55OvfcU6vxK1ujAXxlH9tWNlURBDF6Qd5a1uLgL5yXbGxQ9ou2jA
         0dWDZzGFDa3VY52cYQIBoQTGG7Xu5M8XC6kBLCLDuRkCjbha61jXz8AM5ynXfJfyteVE
         GkzG1PxFug+bzRHmHOZ0qqcB4tzKs6bvcgtxdzPc6ZLsPL0nGo6M5pPshv0WlKZ9RVCN
         4ZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdCfTkrI/mhGPOQj8LTem5BIzNj3M/TunMyugwmPtzk=;
        b=OPE9W+nK9xb4jQQnoJSTD5UT6nEnRWwVViF+a64YKuwXtNxkfB3Y2wOryabJv4LXCc
         PmiAzzxh362vm7hhUDBrh3BrYNlBCQrilmCNLppCOcet+eIdAM6+zwdC936pLYh7UQb6
         G8lbzcxr0U70POlckipYcc/pzB5QylZy2RsQKYUYMeA3tmt+oCu1mygyb51RVsa18npQ
         BQQJEX2+thbX+kbZUMWMlsjoyyp1bl7Gc1sQak/rkxdb2TyZKQDud9deR090MqOBJO+G
         v9ag442MX4fPE/8w9HGAfLfjT3diPpUnlKSoJod76eqSg05dh5k1eUIc5iM4B0kiTmCK
         Lubg==
X-Gm-Message-State: AGRZ1gJQj2DV8ZCoXycOaykWGA7iu2a95iXzme2rbAr7S99DaYCKZeQW
        h7sAy8BoaiTtSoI9bVKtqfU=
X-Google-Smtp-Source: AJdET5f7qGrhl8fE+8g4bqHAz/68dS5xq/SNBL8pFAokjK+e0zr8I3hQr8qRlPDGEqK0ewEb99hBAw==
X-Received: by 2002:a9d:c83:: with SMTP id b3mr7080446otb.70.1541839863305;
        Sat, 10 Nov 2018 00:51:03 -0800 (PST)
Received: from sandstorm.nvidia.com ([2600:1700:43b0:3120:feaa:14ff:fe9e:34cb])
        by smtp.gmail.com with ESMTPSA id c7-v6sm3908683oia.58.2018.11.10.00.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 00:51:02 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 5/6] mm: introduce zone_gup_lock, for dma-pinned pages
Date:   Sat, 10 Nov 2018 00:50:40 -0800
Message-Id: <20181110085041.10071-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181110085041.10071-1-jhubbard@nvidia.com>
References: <20181110085041.10071-1-jhubbard@nvidia.com>
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

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Christopher Lameter <cl@linux.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mmzone.h | 6 ++++++
 mm/page_alloc.c        | 1 +
 2 files changed, 7 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 847705a6d0ec..125a6f34f6ba 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -660,6 +660,7 @@ typedef struct pglist_data {
 	enum zone_type kswapd_classzone_idx;
 
 	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
+	spinlock_t pinned_dma_lock;
 
 #ifdef CONFIG_COMPACTION
 	int kcompactd_max_order;
@@ -729,6 +730,11 @@ static inline spinlock_t *zone_lru_lock(struct zone *zone)
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
index a919ba5cb3c8..7cc0d9bdba17 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6305,6 +6305,7 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 
 	pgdat_page_ext_init(pgdat);
 	spin_lock_init(&pgdat->lru_lock);
+	spin_lock_init(&pgdat->pinned_dma_lock);
 	lruvec_init(node_lruvec(pgdat));
 }
 
-- 
2.19.1

