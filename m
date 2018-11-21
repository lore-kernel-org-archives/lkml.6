Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43028C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C064206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lPq1BygM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C064206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389942AbeKVIa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:30:58 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34395 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731712AbeKVIa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 03:30:57 -0500
Received: by mail-io1-f66.google.com with SMTP id f6so5200252iob.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 13:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L0Df52YKcoq8bv8YlNhyqk1lTtReHKRExwnYBZ1Z0Bo=;
        b=lPq1BygMDDfKlEgfu9t5zjgld8jO/q6ohZ7y2YIzgXHnpS9QnRVCZEdA8UHKLc6INm
         ySw8rsSsVB1u6L/ZuSOEqaXyr50CJZsL9Iv66mvLsHr1aKtivHFIBdxkyNr/VJ5kAPzI
         k4n0W5QDOEhEzMI8zUkaXT1H6OJCMKFoIjRgStb087DwGAXxvYJpErzSHG67r3kvujAe
         I+XX6P2sWEW8B3K0d9DzvjANuQv0oorGFjL5KGx+HY5E59FYT1Z5RHG+9NHNBJqVTWrQ
         zGMNUMu0zDPKMXWemdPNHfRMXSGOLkIsGDPYD24hXAlQxEyYZ8/XjK9RneoSlYSTwZRl
         lhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L0Df52YKcoq8bv8YlNhyqk1lTtReHKRExwnYBZ1Z0Bo=;
        b=tbBTqhNym1R2ZtYN36nsbfoUYQJup1HZEtpRJxf5YPwvlZVb8z8sQg9RBDNHQKujdK
         6C1OPZ1OwzQ5gUzvW0atzfhQC8g2CbrYrW8aZlT6qdPgs3U3YcgsQ2pErUYgbVuxm4Y8
         X7MXPl5x50oXmgl1ks5FpN/K5eYQVIAk7ffgRFn2wMR3SP3jp/3c/2C9+CC2TmxbxxmB
         pRYShRum+AQpGK0MYH+q6VejyccKEiPLswiagMLzd0EgM/KiGYAsBOjcXD8ilO9MXDX0
         oKs47N0S/J/qrrrzQeTf4qz0CDc/Gpd+S9Do/62H1p+tWO/oQOc0zaf96/YzjnLgmtoA
         4PHQ==
X-Gm-Message-State: AA+aEWYWD3Xc2TfkdAyPCMr3dyBLSzSefzPp8HeY81+CVy9a84cgnF1D
        5N7uVZCNCXWxmwx7yX4GDPJMMw==
X-Google-Smtp-Source: AFSGD/XlPwzbOPnpdoXpFaLjuamJJqgfCZIssAtHHIqFKyT4Ic86RiAOvQH/uHDBapIyVwTR3Dxpdw==
X-Received: by 2002:a6b:710b:: with SMTP id q11mr5448132iog.138.1542837286843;
        Wed, 21 Nov 2018 13:54:46 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id 142-v6sm1113716itw.40.2018.11.21.13.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 13:54:45 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v3] mm: use swp_offset as key in shmem_replace_page()
Date:   Wed, 21 Nov 2018 14:54:42 -0700
Message-Id: <20181121215442.138545-1-yuzhao@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181119010924.177177-1-yuzhao@google.com>
References: <20181119010924.177177-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We changed key of swap cache tree from swp_entry_t.val to
swp_offset. Need to do so in shmem_replace_page() as well.

Fixes: f6ab1f7f6b2d ("mm, swap: use offset of swap entry as key of swap cache")
Cc: stable@vger.kernel.org # v4.9+
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/shmem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d44991ea5ed4..42b70978e814 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1509,11 +1509,13 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
 {
 	struct page *oldpage, *newpage;
 	struct address_space *swap_mapping;
+	swp_entry_t entry;
 	pgoff_t swap_index;
 	int error;
 
 	oldpage = *pagep;
-	swap_index = page_private(oldpage);
+	entry.val = page_private(oldpage);
+	swap_index = swp_offset(entry);
 	swap_mapping = page_mapping(oldpage);
 
 	/*
@@ -1532,7 +1534,7 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
 	__SetPageLocked(newpage);
 	__SetPageSwapBacked(newpage);
 	SetPageUptodate(newpage);
-	set_page_private(newpage, swap_index);
+	set_page_private(newpage, entry.val);
 	SetPageSwapCache(newpage);
 
 	/*
-- 
2.19.1.1215.g8438c0b245-goog

