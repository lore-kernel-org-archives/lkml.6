Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC5FECDFB2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05E7214AB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjHJVLKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05E7214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbeGMDjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 23:39:01 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41325 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387615AbeGMDjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 23:39:00 -0400
Received: by mail-pf0-f196.google.com with SMTP id c21-v6so17171990pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 20:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gc/9xeTOIbw53F6nYP89sY5reU1DoIfxCKRmupl9mxU=;
        b=YjHJVLKqS55fOsiVgjemOD4Wrk4FwWz0KMIChBKWZ9vlx5jQSijHM6b6M6a3K30vmv
         pIXstIdYq1ci85VO0Dvxtp6De1Tqimn+qxHz2UF9tBrDm6K968azdwwZMz76/RoLITYa
         dCmoRQtyHgekyWidk5u2xfXZxoiKCCLl2IpqzenwKjpuz69Va/UpwKWovp6l5DLoWaoR
         0hduLLnIJbTwdsirWjGWQlqVTTSF10IQrtTes3Vt6eerDd9SpbULdV62QQ771o2Pkt7E
         OQW47TUIPjzz2TjRrdzJptGiVCMvNpXzgy7ymyfB7mdVFApS1ArEQqAoj7FcsN0d26kc
         CdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=gc/9xeTOIbw53F6nYP89sY5reU1DoIfxCKRmupl9mxU=;
        b=BSNSnadwkYZtoYOA6AZ4WHgzbvA6mOgBb+nHIOI6orHUzSJT33YwnmdvSsD7u7xiai
         CpQ5yLUxjESbXnsjkYCETNUf53m3JzbHZcYmVCtAYz25ljMA1BQMxpsYxa8jFYujMZak
         Pg6i4fsZQ49P+SivKkuNgE/PaNtNY9zpwli0v+oeksI47/K3F9ReEDN9o1BMamQZV0P7
         1cUi5DAbXXNs6SB3chMJrg7WVEChI0TAWCqAtCv+fqnApeVItDUMLPV87NI/+YtYfwRY
         cuNTYdKPFvmUDxAxxBT305EHpd4p3p6mu5+gQAmhA4yIlqJ7CWp6RmcMazisj6edd0XV
         L8cA==
X-Gm-Message-State: AOUpUlHD14qSxPOdSCb6MmJrJ/oVbhNnNcVOew8XiI75xSClYMFIOngz
        9d+G4EftdZ1Mh5b7ppQYpw==
X-Google-Smtp-Source: AAOMgpd69noVRezXFSpuNk8AuGo4WPydicOwcnjAoqVpyGifKrRw8VQrUQiUGfdKsLLbpqUvT/95Xg==
X-Received: by 2002:a62:5290:: with SMTP id g138-v6mr5218677pfb.46.1531452384669;
        Thu, 12 Jul 2018 20:26:24 -0700 (PDT)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id b66-v6sm8867241pgc.15.2018.07.12.20.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 20:26:23 -0700 (PDT)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        xishi.qiuxishi@alibaba-inc.com, zy.zhengyi@alibaba-inc.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] mm: soft-offline: close the race against page allocation
Date:   Fri, 13 Jul 2018 12:26:06 +0900
Message-Id: <1531452366-11661-3-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1531452366-11661-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1531452366-11661-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A process can be killed with SIGBUS(BUS_MCEERR_AR) when it tries to
allocate a page that was just freed on the way of soft-offline.
This is undesirable because soft-offline (which is about corrected error)
is less aggressive than hard-offline (which is about uncorrected error),
and we can make soft-offline fail and keep using the page for good reason
like "system is busy."

Two main changes of this patch are:

- setting migrate type of the target page to MIGRATE_ISOLATE. As done
  in free_unref_page_commit(), this makes kernel bypass pcplist when
  freeing the page. So we can assume that the page is in freelist just
  after put_page() returns,

- setting PG_hwpoison on free page under zone->lock which protects
  freelists, so this allows us to avoid setting PG_hwpoison on a page
  that is decided to be allocated soon.

Reported-by: Xishi Qiu <xishi.qiuxishi@alibaba-inc.com>
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 include/linux/page-flags.h |  5 +++++
 include/linux/swapops.h    | 10 ----------
 mm/memory-failure.c        | 26 +++++++++++++++++++++-----
 mm/migrate.c               |  2 +-
 mm/page_alloc.c            | 29 +++++++++++++++++++++++++++++
 5 files changed, 56 insertions(+), 16 deletions(-)

diff --git v4.18-rc4-mmotm-2018-07-10-16-50/include/linux/page-flags.h v4.18-rc4-mmotm-2018-07-10-16-50_patched/include/linux/page-flags.h
index 901943e..74bee8c 100644
--- v4.18-rc4-mmotm-2018-07-10-16-50/include/linux/page-flags.h
+++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/include/linux/page-flags.h
@@ -369,8 +369,13 @@ PAGEFLAG_FALSE(Uncached)
 PAGEFLAG(HWPoison, hwpoison, PF_ANY)
 TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
 #define __PG_HWPOISON (1UL << PG_hwpoison)
+extern bool set_hwpoison_free_buddy_page(struct page *page);
 #else
 PAGEFLAG_FALSE(HWPoison)
+static inline bool set_hwpoison_free_buddy_page(struct page *page)
+{
+	return 0;
+}
 #define __PG_HWPOISON 0
 #endif
 
diff --git v4.18-rc4-mmotm-2018-07-10-16-50/include/linux/swapops.h v4.18-rc4-mmotm-2018-07-10-16-50_patched/include/linux/swapops.h
index 9c0eb4d..fe8e08b 100644
--- v4.18-rc4-mmotm-2018-07-10-16-50/include/linux/swapops.h
+++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/include/linux/swapops.h
@@ -335,11 +335,6 @@ static inline int is_hwpoison_entry(swp_entry_t entry)
 	return swp_type(entry) == SWP_HWPOISON;
 }
 
-static inline bool test_set_page_hwpoison(struct page *page)
-{
-	return TestSetPageHWPoison(page);
-}
-
 static inline void num_poisoned_pages_inc(void)
 {
 	atomic_long_inc(&num_poisoned_pages);
@@ -362,11 +357,6 @@ static inline int is_hwpoison_entry(swp_entry_t swp)
 	return 0;
 }
 
-static inline bool test_set_page_hwpoison(struct page *page)
-{
-	return false;
-}
-
 static inline void num_poisoned_pages_inc(void)
 {
 }
diff --git v4.18-rc4-mmotm-2018-07-10-16-50/mm/memory-failure.c v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/memory-failure.c
index c63d982..794687a 100644
--- v4.18-rc4-mmotm-2018-07-10-16-50/mm/memory-failure.c
+++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/memory-failure.c
@@ -57,6 +57,7 @@
 #include <linux/mm_inline.h>
 #include <linux/kfifo.h>
 #include <linux/ratelimit.h>
+#include <linux/page-isolation.h>
 #include "internal.h"
 #include "ras/ras_event.h"
 
@@ -1697,6 +1698,7 @@ static int __soft_offline_page(struct page *page, int flags)
 static int soft_offline_in_use_page(struct page *page, int flags)
 {
 	int ret;
+	int mt;
 	struct page *hpage = compound_head(page);
 
 	if (!PageHuge(page) && PageTransHuge(hpage)) {
@@ -1715,23 +1717,37 @@ static int soft_offline_in_use_page(struct page *page, int flags)
 		put_hwpoison_page(hpage);
 	}
 
+	/*
+	 * Setting MIGRATE_ISOLATE here ensures that the page will be linked
+	 * to free list immediately (not via pcplist) when released after
+	 * successful page migration. Otherwise we can't guarantee that the
+	 * page is really free after put_page() returns, so
+	 * set_hwpoison_free_buddy_page() highly likely fails.
+	 */
+	mt = get_pageblock_migratetype(page);
+	set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 	if (PageHuge(page))
 		ret = soft_offline_huge_page(page, flags);
 	else
 		ret = __soft_offline_page(page, flags);
-
+	set_pageblock_migratetype(page, mt);
 	return ret;
 }
 
-static void soft_offline_free_page(struct page *page)
+static int soft_offline_free_page(struct page *page)
 {
 	int rc = 0;
 	struct page *head = compound_head(page);
 
 	if (PageHuge(head))
 		rc = dissolve_free_huge_page(page);
-	if (!rc && !TestSetPageHWPoison(page))
-		num_poisoned_pages_inc();
+	if (!rc) {
+		if (set_hwpoison_free_buddy_page(page))
+			num_poisoned_pages_inc();
+		else
+			rc = -EBUSY;
+	}
+	return rc;
 }
 
 /**
@@ -1775,7 +1791,7 @@ int soft_offline_page(struct page *page, int flags)
 	if (ret > 0)
 		ret = soft_offline_in_use_page(page, flags);
 	else if (ret == 0)
-		soft_offline_free_page(page);
+		ret = soft_offline_free_page(page);
 
 	return ret;
 }
diff --git v4.18-rc4-mmotm-2018-07-10-16-50/mm/migrate.c v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/migrate.c
index 3ae213b..e772323 100644
--- v4.18-rc4-mmotm-2018-07-10-16-50/mm/migrate.c
+++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/migrate.c
@@ -1199,7 +1199,7 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 			 * intentionally. Although it's rather weird,
 			 * it's how HWPoison flag works at the moment.
 			 */
-			if (!test_set_page_hwpoison(page))
+			if (set_hwpoison_free_buddy_page(page))
 				num_poisoned_pages_inc();
 		}
 	} else {
diff --git v4.18-rc4-mmotm-2018-07-10-16-50/mm/page_alloc.c v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/page_alloc.c
index 607deff..3c76d40 100644
--- v4.18-rc4-mmotm-2018-07-10-16-50/mm/page_alloc.c
+++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/page_alloc.c
@@ -8027,3 +8027,32 @@ bool is_free_buddy_page(struct page *page)
 
 	return order < MAX_ORDER;
 }
+
+#ifdef CONFIG_MEMORY_FAILURE
+/*
+ * Set PG_hwpoison flag if a given page is confirmed to be a free page
+ * within zone lock, which prevents the race against page allocation.
+ */
+bool set_hwpoison_free_buddy_page(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long flags;
+	unsigned int order;
+	bool hwpoisoned = false;
+
+	spin_lock_irqsave(&zone->lock, flags);
+	for (order = 0; order < MAX_ORDER; order++) {
+		struct page *page_head = page - (pfn & ((1 << order) - 1));
+
+		if (PageBuddy(page_head) && page_order(page_head) >= order) {
+			if (!TestSetPageHWPoison(page))
+				hwpoisoned = true;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&zone->lock, flags);
+
+	return hwpoisoned;
+}
+#endif
-- 
2.7.0

