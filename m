Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690E4ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6852086B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjIahVon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6852086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeGQGDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:03:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46673 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeGQGDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:03:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id p23-v6so8317193pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 22:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A7nWFKVutHwD3dCodLh1vnhiiLBP95OUDJsJ6qnyAzM=;
        b=hjIahVonJgkPhqgktFN76RASQn8z1wkil86un5uMN5EL4VS64m/ibVWZyJtMwizrey
         9xsrihPee964CtebxrGks2puXCxKyqeMGp1er2QnWDPfZR2NOVYsNsgqDD0aDGTtUwiX
         qqTCuAh9xHGvIg+c0FK2WxdoqCReQGjii/PFNln0n+SV1GDcic+t4lVfc1AOpfUqzj2j
         ddmKabtOFI6yDQOPw0HqP0ij5EG2CqD5eUxkTGXsgzVgvjvYwU/pyKM29TwUCmS8ntIS
         ai5OOwrQaPxf4UanMy1h8qA1Rtgn6El+gdvri4jHkQW8W83y2LXckCfQQr9WO3r3hOG2
         rk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=A7nWFKVutHwD3dCodLh1vnhiiLBP95OUDJsJ6qnyAzM=;
        b=OA62W8iG8V7ih0DkH6tYQHPEPuZ3JGpt1JYGf5hBsy6qHLlU0JIbQ5uctutRHKNMBp
         uLEJnBywYUU2DJLIZt1tb/FLi/vjqXwBxdmm/dZq+9MO7RcWjgxSyHjlJf4wBpTi9MLN
         xurSgPOjNmWbPNvtP96JJEmaY8eggG2Um1zNnAzid51KkFc9ULpvps8izTEkV7MKADBI
         uVq5TjsdGlv9OjrRSXT18/3eN4z2WoTBNNt3mpWpQELpFFJHWntjJK7Jr4jf2EkL2C6x
         0EYJhunNxbWiCmVZcwD3+o8F2z0aSdr2MD5/orHapgGvWwjUCqjLQm7HFxt3EDgyrx9R
         3DJA==
X-Gm-Message-State: AOUpUlH+1ng19BVxAyzNZC5Jk25PEwDDPyAt2438/PqFr5elOIbDDsZr
        yK70bYAW6ITfcDNzdKjIBw==
X-Google-Smtp-Source: AAOMgpcgmpgHem3+VWmZPecXt92/x0fK5PujA+WHRs158LCMdSgGtdu1g4z7ToYI6hUEDelri64fNA==
X-Received: by 2002:a63:fc44:: with SMTP id r4-v6mr173305pgk.169.1531805567991;
        Mon, 16 Jul 2018 22:32:47 -0700 (PDT)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id y85-v6sm156220pfa.170.2018.07.16.22.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 22:32:46 -0700 (PDT)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        xishi.qiuxishi@alibaba-inc.com, zy.zhengyi@alibaba-inc.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm: fix race on soft-offlining free huge pages
Date:   Tue, 17 Jul 2018 14:32:31 +0900
Message-Id: <1531805552-19547-2-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1531805552-19547-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1531805552-19547-1-git-send-email-n-horiguchi@ah.jp.nec.com>
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
changelog v1->v2:
- don't use set_hwpoison_free_buddy_page() (not defined yet)
- updated comment in soft_offline_huge_page()
---
 mm/hugetlb.c        | 11 +++++------
 mm/memory-failure.c | 24 ++++++++++++++++++------
 mm/migrate.c        |  2 --
 3 files changed, 23 insertions(+), 14 deletions(-)

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
index 9d142b9..9b77f85 100644
--- v4.18-rc4-mmotm-2018-07-10-16-50/mm/memory-failure.c
+++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/memory-failure.c
@@ -1598,8 +1598,20 @@ static int soft_offline_huge_page(struct page *page, int flags)
 		if (ret > 0)
 			ret = -EIO;
 	} else {
-		if (PageHuge(page))
-			dissolve_free_huge_page(page);
+		/*
+		 * We set PG_hwpoison only when the migration source hugepage
+		 * was successfully dissolved, because otherwise hwpoisoned
+		 * hugepage remains on free hugepage list. The allocator ignores
+		 * such a hwpoisoned page so it's never allocated, but it could
+		 * kill a process because of no-memory rather than hwpoison.
+		 * Soft-offline never impacts the userspace, so this is
+		 * undesired.
+		 */
+		ret = dissolve_free_huge_page(page);
+		if (!ret) {
+			if (!TestSetPageHWPoison(page))
+				num_poisoned_pages_inc();
+		}
 	}
 	return ret;
 }
@@ -1715,13 +1727,13 @@ static int soft_offline_in_use_page(struct page *page, int flags)
 
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

