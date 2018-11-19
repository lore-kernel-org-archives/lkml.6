Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A10FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 00:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154D22086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 00:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1eHX+Vg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154D22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbeKSLKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:10:10 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53488 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeKSLKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:10:10 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so4186338ita.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 16:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6gyrhKbOCiv+zElf5LSN4Pe6YN3X6Cu7b8UNoJgG0NU=;
        b=k1eHX+Vgpl6WqlGfklr+LQkfRN+om2NAXFgLvgZuRRiFouWlHWPJDk7oeAbgB6SLJH
         r9lA2AKOiIBm8M5Ixs9Y83pSnPTw8ikNZWvcmxZww8SLN5+woqPipX45LQMQx/sWmUlk
         5uULmwNZLvgGSGTZp2dLT9TbWWmxPIzzxRGdHHHO1Nt4Z6X2RzlJMpdbJ2GHCp9jPTyN
         5ALv6BtLY9nxvwLLGNhxz972JSB/G9/p9PIFIAJmlp0qqttrND/e3TiKnLFRvdYCKomJ
         xlPokBP9l7ep0sNJ3JS4DFVnU0YuYf3liqw6Utd+kvnrD2+nLTznmZVy3O+mlHkEXKx5
         t9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6gyrhKbOCiv+zElf5LSN4Pe6YN3X6Cu7b8UNoJgG0NU=;
        b=FK42Wl0YhiHbX5jHpy3pqWq2Pe84MF+Ey3tpLkiCDHB/0XiDdw9QaOaUB/08vef9VM
         LG7Da05JW3Kw3t3lN+nU9Tg2XYA4wYRI++3i6ZvxMeVp6jl64jxOa4QO+IG43pqkVupz
         YSIRqBBoIV49jY5Fbnu22DaTS3bckkKqlBgLUcGJ0B8fgApmYCN3kIFlcuMuDJgKFEC3
         kroefC/txXv6/OW3M1nm+9ieV8M2Jb/5Y0YNOJHtKmDShyjm4B3v/pofT1n3BJZUD0IW
         UA3lMy4CvAIcT5M2ndbAJtfV1wTtCQszGQuqbxQs3Y/6itZzsfhiNUiZ30ScgSnAL078
         2d+Q==
X-Gm-Message-State: AGRZ1gLuGHf/LLA06oDGIXTsiyhKzE5Bxck5b5RCC+lXuZ3seSCqscoB
        rijcuMnC/FJTMFw/1iwcMIBEnQ==
X-Google-Smtp-Source: AFSGD/WK7PBcEewTJ4jh7nTDYY5yQHwbqXpw1B2TF6BYTwsLAQcW232FT01I4iF+tkYRYiy1rtKarQ==
X-Received: by 2002:a24:1e06:: with SMTP id 6mr5785429itt.46.1542588497085;
        Sun, 18 Nov 2018 16:48:17 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id 131-v6sm13661320itz.31.2018.11.18.16.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 16:48:15 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Subject: [PATCH] mm: fix swap offset when replacing shmem page
Date:   Sun, 18 Nov 2018 17:47:19 -0700
Message-Id: <20181119004719.156411-1-yuzhao@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to have a single swap address space with swp_entry_t.val
as its radix tree index. This is not the case anymore. Now Each
swp_type() has its own address space and should use swp_offset()
as radix tree index.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/shmem.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d44991ea5ed4..a92c6ae26915 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1509,11 +1509,13 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
 {
 	struct page *oldpage, *newpage;
 	struct address_space *swap_mapping;
-	pgoff_t swap_index;
+	swp_entry_t entry;
 	int error;
 
+	VM_BUG_ON(PageSwapCache(*pagep));
+
 	oldpage = *pagep;
-	swap_index = page_private(oldpage);
+	entry.val = page_private(oldpage);
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
@@ -1540,7 +1542,8 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
 	 * a nice clean interface for us to replace oldpage by newpage there.
 	 */
 	xa_lock_irq(&swap_mapping->i_pages);
-	error = shmem_replace_entry(swap_mapping, swap_index, oldpage, newpage);
+	error = shmem_replace_entry(swap_mapping, swp_offset(entry),
+				    oldpage, newpage);
 	if (!error) {
 		__inc_node_page_state(newpage, NR_FILE_PAGES);
 		__dec_node_page_state(oldpage, NR_FILE_PAGES);
-- 
2.19.1.1215.g8438c0b245-goog

