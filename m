Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AA4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC45E2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gWjOa9pr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC45E2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeKSLb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:31:29 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55758 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeKSLb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:31:28 -0500
Received: by mail-it1-f195.google.com with SMTP id o19so5820596itg.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 17:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=08RTZHbHI+FX7DFs4z5QY980a6/oJNTmgmTtWQcGnR8=;
        b=gWjOa9przldWulueeHOQsEz8sDSUpPVukBSbfAD00DxaLIJfMa6bbEbn7CC5BgIDxL
         gLm8uqvTQBvZDJx/bHHEsrpM/pMWr/9ZSl998FlZLudlOaRh/2WcCWKLHGG+ASm51eNB
         XT+DU8J6JplI1A6vNifzM0YgGfEyk6CSv7CQ9s+/ZFQhjZykV5rU8MQX7v7QRe8eoQT2
         TW5jbOyY7NHA+m3WIqJROC9YyKN6aG46JdxfS6Uh5ed603q8xM+QBb+kwFurrbNCDgVL
         Whqercs6blapAX2SZe/KPM4GpzGT5xrk3IFfzHwsaKSKEmBd8hzKH3h6RhNYdKBoqA5r
         HEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=08RTZHbHI+FX7DFs4z5QY980a6/oJNTmgmTtWQcGnR8=;
        b=EN8aDcbVuUJUVd/fLOo2unKn1bdQBtJDpXzNjm+3WRnAwLL4ERucKvqyL5UndByyiE
         pe25JT/Nv0KgsbXumKoErBOuxTel0wgauMoBXpbeCJJYxoTlr0hBxM2XGFBUcuP4/pGD
         5tg5vVHlc4y/yl8xV2U9DLL5efU4gMKPhpeFe0RM7SmmWtJ6UImzf8WoLqWZcka2iBO2
         L3rquEXtErfyRZoyFirruszgFcC/mDfjU6MGKazdd7kLg48XEwsDHRHoqCVm3vdsf7gM
         j2kMuXkAfD7wTwqDr+Btkilh05LnUnK/0Blbp+lmjlKRyJozS2vDIGQOwDYlAKQhvOsf
         dkvQ==
X-Gm-Message-State: AA+aEWZN5IA29ZMe4JTRC7SDHsaS8D94wULdtLm4JkeCtDYtFuX1kNUN
        cS9PskfHRLVB1Chq/2gM9dJlAg==
X-Google-Smtp-Source: AFSGD/VAHNKNuVquGMvS36VKmk9MP+2etW7MFWrJAavXCkl6RCMSOLZSQtq+0cCPozlAg2stxEQBAA==
X-Received: by 2002:a24:3796:: with SMTP id r144-v6mr6481688itr.79.1542589773265;
        Sun, 18 Nov 2018 17:09:33 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id t196-v6sm13946809ita.30.2018.11.18.17.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 17:09:31 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Subject: [PATCH v2] mm: fix swap offset when replacing shmem page
Date:   Sun, 18 Nov 2018 18:09:24 -0700
Message-Id: <20181119010924.177177-1-yuzhao@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181119004719.156411-1-yuzhao@google.com>
References: <20181119004719.156411-1-yuzhao@google.com>
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
index d44991ea5ed4..685faa3e0191 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1509,11 +1509,13 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
 {
 	struct page *oldpage, *newpage;
 	struct address_space *swap_mapping;
-	pgoff_t swap_index;
+	swp_entry_t entry;
 	int error;
 
+	VM_BUG_ON(!PageSwapCache(*pagep));
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

