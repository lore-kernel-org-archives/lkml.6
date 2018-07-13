Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA94ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F11D214C3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5PKq+1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F11D214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbeGMDi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 23:38:58 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38771 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387615AbeGMDi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 23:38:57 -0400
Received: by mail-pf0-f193.google.com with SMTP id v15-v6so1779212pff.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 20:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5fXt0fl+qc7hqJ8oDMdCmzsKVv7p1HlWSqloKSeYltY=;
        b=s5PKq+1F6Gje2S1bJEfGVv2c7OcZP0V33S8jsckpOYAFuZMCBTHKuEskSJAt2JyoLj
         Pmaieu5J5JJoudDiMews7MRurDbnOcgDEP8mtrE5XfC0s2bL7sj8iaxUUZjYfQv08XBv
         j6LxYdCIbFS9lpdw3he33viz149oXlDk/2IpRinUUGrCXbR2q3+Es5WIiY0/nUcmsxqf
         +xjNLrWeAH/n6QjJ9VfnsXeopkyaR5d0RRKv+wECY4rETyobz3bygCa7FKqn9VmRkOhK
         vgB2UH+GCYSJp7qEonz2iEgoHqy/rA9/DmYCzZJEo3wokOBDwX3XydILIPAFER/9+MVE
         AqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=5fXt0fl+qc7hqJ8oDMdCmzsKVv7p1HlWSqloKSeYltY=;
        b=Z7TpCJbJLjaq1LiRPLxtfQJYqUSO6HZTpcgsrTJPeCCeEmsLbTJIy301iFh0Be71wT
         2mb9H9SZFyTVHwNyYHbeDK+4hLA5e0Ifxj1Difod9qSMusbpsBZL/A/b43ahKdJJBb6H
         Ft4wQ4jgxopEkQn3mKORORiY/pl4JQyM3NuEMjVpYCkC9dVT4npWDyTrUcU0KCgd0P89
         KxfwFDCCU3eZJv4B9A2YBlUdL4QQSDkiRrgxqqhlDTMU7w+lrBOJxTIhVH61Z77d06w0
         JjSk4ReSLHhQUEXsj2MKQs6aIx6uEim6SJY3XK3J/hdBgpl8g7sG/vGSSFYNrpV/xcYI
         aM+Q==
X-Gm-Message-State: AOUpUlFGZwxT8v7jUQ1u1rltxFgftHH9GFB/GISZYFZs/Xy3ZImps+VP
        UQvn/NEMn3+b1ExB27m+YQ==
X-Google-Smtp-Source: AAOMgpdIH6JZjGOut4k9s0b1IRS689VymubaD4ejXurmyO5TOwWSzB2MTIAsi2+hdfTGHlPLyMI+1A==
X-Received: by 2002:a62:98d6:: with SMTP id d83-v6mr5194408pfk.186.1531452381856;
        Thu, 12 Jul 2018 20:26:21 -0700 (PDT)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id b66-v6sm8867241pgc.15.2018.07.12.20.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 20:26:20 -0700 (PDT)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        xishi.qiuxishi@alibaba-inc.com, zy.zhengyi@alibaba-inc.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] mm: fix race on soft-offlining free huge pages
Date:   Fri, 13 Jul 2018 12:26:05 +0900
Message-Id: <1531452366-11661-2-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1531452366-11661-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1531452366-11661-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a race condition between soft offline and hugetlb_fault which
causes unexpected process killing and/or hugetlb allocation failure.

The process killing is caused by the following flow:

  CPU 0               CPU 1              CPU 2

  soft offline
    get_any_page
    // find the hugetlb is free
                      mmap a hugetlb file
                      page fault
                        ...
                          hugetlb_fault
                            hugetlb_no_page
                              alloc_huge_page
                              // succeed
      soft_offline_free_page
      // set hwpoison flag
                                         mmap the hugetlb file
                                         page fault
                                           ...
                                             hugetlb_fault
                                               hugetlb_no_page
                                                 find_lock_page
                                                   return VM_FAULT_HWPOISON
                                           mm_fault_error
                                             do_sigbus
                                             // kill the process


The hugetlb allocation failure comes from the following flow:

  CPU 0                          CPU 1

                                 mmap a hugetlb file
                                 // reserve all free page but don't fault-in
  soft offline
    get_any_page
    // find the hugetlb is free
      soft_offline_free_page
      // set hwpoison flag
        dissolve_free_huge_page
        // fail because all free hugepages are reserved
                                 page fault
                                   ...
                                     hugetlb_fault
                                       hugetlb_no_page
                                         alloc_huge_page
                                           ...
                                             dequeue_huge_page_node_exact
                                             // ignore hwpoisoned hugepage
                                             // and finally fail due to no-mem

The root cause of this is that current soft-offline code is written
based on an assumption that PageHWPoison flag should beset at first to
avoid accessing the corrupted data.  This makes sense for memory_failure()
or hard offline, but does not for soft offline because soft offline is
about corrected (not uncorrected) error and is safe from data lost.
This patch changes soft offline semantics where it sets PageHWPoison flag
only after containment of the error page completes successfully.

Reported-by: Xishi Qiu <xishi.qiuxishi@alibaba-inc.com>
Suggested-by: Xishi Qiu <xishi.qiuxishi@alibaba-inc.com>
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 mm/hugetlb.c        | 11 +++++------
 mm/memory-failure.c | 22 ++++++++++++++++------
 mm/migrate.c        |  2 --
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git v4.18-rc4-mmotm-2018-07-10-16-50/mm/hugetlb.c v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/hugetlb.c
index 430be42..937c142 100644
--- v4.18-rc4-mmotm-2018-07-10-16-50/mm/hugetlb.c
+++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/hugetlb.c
@@ -1479,22 +1479,20 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 /*
  * Dissolve a given free hugepage into free buddy pages. This function does
  * nothing for in-use (including surplus) hugepages. Returns -EBUSY if the
- * number of free hugepages would be reduced below the number of reserved
- * hugepages.
+ * dissolution fails because a give page is not a free hugepage, or because
+ * free hugepages are fully reserved.
  */
 int dissolve_free_huge_page(struct page *page)
 {
-	int rc = 0;
+	int rc = -EBUSY;
 
 	spin_lock(&hugetlb_lock);
 	if (PageHuge(page) && !page_count(page)) {
 		struct page *head = compound_head(page);
 		struct hstate *h = page_hstate(head);
 		int nid = page_to_nid(head);
-		if (h->free_huge_pages - h->resv_huge_pages == 0) {
-			rc = -EBUSY;
+		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
-		}
 		/*
 		 * Move PageHWPoison flag from head page to the raw error page,
 		 * which makes any subpages rather than the error page reusable.
@@ -1508,6 +1506,7 @@ int dissolve_free_huge_page(struct page *page)
 		h->free_huge_pages_node[nid]--;
 		h->max_huge_pages--;
 		update_and_free_page(h, head);
+		rc = 0;
 	}
 out:
 	spin_unlock(&hugetlb_lock);
diff --git v4.18-rc4-mmotm-2018-07-10-16-50/mm/memory-failure.c v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/memory-failure.c
index 9d142b9..c63d982 100644
--- v4.18-rc4-mmotm-2018-07-10-16-50/mm/memory-failure.c
+++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/memory-failure.c
@@ -1598,8 +1598,18 @@ static int soft_offline_huge_page(struct page *page, int flags)
 		if (ret > 0)
 			ret = -EIO;
 	} else {
-		if (PageHuge(page))
-			dissolve_free_huge_page(page);
+		/*
+		 * We set PG_hwpoison only when the migration source hugepage
+		 * was successfully dissolved, because otherwise hwpoisoned
+		 * hugepage remains on free hugepage list, then userspace will
+		 * find it as SIGBUS by allocation failure. That's not expected
+		 * in soft-offlining.
+		 */
+		ret = dissolve_free_huge_page(page);
+		if (!ret) {
+			if (set_hwpoison_free_buddy_page(page))
+				num_poisoned_pages_inc();
+		}
 	}
 	return ret;
 }
@@ -1715,13 +1725,13 @@ static int soft_offline_in_use_page(struct page *page, int flags)
 
 static void soft_offline_free_page(struct page *page)
 {
+	int rc = 0;
 	struct page *head = compound_head(page);
 
-	if (!TestSetPageHWPoison(head)) {
+	if (PageHuge(head))
+		rc = dissolve_free_huge_page(page);
+	if (!rc && !TestSetPageHWPoison(page))
 		num_poisoned_pages_inc();
-		if (PageHuge(head))
-			dissolve_free_huge_page(page);
-	}
 }
 
 /**
diff --git v4.18-rc4-mmotm-2018-07-10-16-50/mm/migrate.c v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/migrate.c
index 198af42..3ae213b 100644
--- v4.18-rc4-mmotm-2018-07-10-16-50/mm/migrate.c
+++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/migrate.c
@@ -1318,8 +1318,6 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 out:
 	if (rc != -EAGAIN)
 		putback_active_hugepage(hpage);
-	if (reason == MR_MEMORY_FAILURE && !test_set_page_hwpoison(hpage))
-		num_poisoned_pages_inc();
 
 	/*
 	 * If migration was not successful and there's a freeing callback, use
-- 
2.7.0

