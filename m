Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26946C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18552086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwyMpnn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18552086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeKIQ0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:26:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38278 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbeKIQ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:26:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so494340pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zosYmZIH/bMZx2kLa53kE3x2OPdcSq6ez0a9bP/tt24=;
        b=QwyMpnn9c+6gRddzOcen8u+RU89eMBYJSP0wvwfeKtViwuqu/oqR624Hi0FCCd5scq
         Nqo1jwYwCU+YTFBY5GWLyY0bu5tqBIG1L3uAlFT2u7sZQGqL7oLfXLUgtphEhVoy1x1k
         5Pjib0hIlc2NILlQVMGs0xSyX5J9/w2AZT8szVR+3SOOprVcnJu93AUnlRGqgUmGMTHa
         MUU+o/GxHCR2lOwjfotjqwT2Q9NBiRBbMTyUMsR5szQ3PgfQIv67GQPjLAJc85XwLsgY
         oQ5C0ROwHR2LdlrDgtmifzQ1wZeYKP+xG3/NtjcgYW4euG1/v4TW7nxiLOoekbUEXqum
         7WOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=zosYmZIH/bMZx2kLa53kE3x2OPdcSq6ez0a9bP/tt24=;
        b=O5ghegGf/tus6FE2N/ogjO8I1j5TLDieGdKvVi2xZ3Qj5MuvEOBC+agg2djJ14mX+6
         t4L1ZeBHWpkfrAm2oclohD0N2xAGfhE38PJEzLK7yTe2pHGYsFB/Q9eA8SvWX6MjCRC3
         u4Qd6VRHoKoNw1tK60CF7sLZ2i5LegUzrcVg9iSBEaPS1MQhA0Ig2CEl69l1eaFhkc29
         BGATw4A4pRR0P8l7rtOygTkuW4vSO3+Xw2PJIjlG8/Kq7xjZJu6E7HH3VmocMQc9qP0y
         ySPcaoYOqcROyC8zUwXLRoYFvIS+JLsmeCI6zNeKo1FifojO6Tf1gtW8Rid73Rk1/hi9
         Fomg==
X-Gm-Message-State: AGRZ1gJoVZkFjeeiMQ1EUjCsptUoR6uZIirS92Mk6sUs/uub/mSo9Z3E
        ggEgDzVWJr3SkgBM4BaqOA==
X-Google-Smtp-Source: AJdET5cEO3P9TCk3E/SJ1+7RvyDFXdw4xMpccPJrqiypjxfdL6CGqC6goMUHPyet7uFuMIq3r2SceQ==
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr7842901pfb.209.1541746064720;
        Thu, 08 Nov 2018 22:47:44 -0800 (PST)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6808355pfg.97.2018.11.08.22.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 22:47:44 -0800 (PST)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: [RFC][PATCH v1 07/11] mm: remove flag argument from soft offline functions
Date:   Fri,  9 Nov 2018 15:47:11 +0900
Message-Id: <1541746035-13408-8-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The argument @flag no longer affects the behavior of soft_offline_page()
and its variants, so let's remove them.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 drivers/base/memory.c |  2 +-
 include/linux/mm.h    |  2 +-
 mm/madvise.c          |  2 +-
 mm/memory-failure.c   | 27 +++++++++++++--------------
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git v4.19-mmotm-2018-10-30-16-08/drivers/base/memory.c v4.19-mmotm-2018-10-30-16-08_patched/drivers/base/memory.c
index 0e59856..4a554a5 100644
--- v4.19-mmotm-2018-10-30-16-08/drivers/base/memory.c
+++ v4.19-mmotm-2018-10-30-16-08_patched/drivers/base/memory.c
@@ -548,7 +548,7 @@ store_soft_offline_page(struct device *dev,
 	pfn >>= PAGE_SHIFT;
 	if (!pfn_valid(pfn))
 		return -ENXIO;
-	ret = soft_offline_page(pfn_to_page(pfn), 0);
+	ret = soft_offline_page(pfn_to_page(pfn));
 	return ret == 0 ? count : ret;
 }
 
diff --git v4.19-mmotm-2018-10-30-16-08/include/linux/mm.h v4.19-mmotm-2018-10-30-16-08_patched/include/linux/mm.h
index f85b450..6c496da 100644
--- v4.19-mmotm-2018-10-30-16-08/include/linux/mm.h
+++ v4.19-mmotm-2018-10-30-16-08_patched/include/linux/mm.h
@@ -2738,7 +2738,7 @@ extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p, int access);
 extern atomic_long_t num_poisoned_pages __read_mostly;
-extern int soft_offline_page(struct page *page, int flags);
+extern int soft_offline_page(struct page *page);
 
 #ifdef CONFIG_MEMORY_FAILURE
 /*
diff --git v4.19-mmotm-2018-10-30-16-08/mm/madvise.c v4.19-mmotm-2018-10-30-16-08_patched/mm/madvise.c
index 9fa0225..86453f3 100644
--- v4.19-mmotm-2018-10-30-16-08/mm/madvise.c
+++ v4.19-mmotm-2018-10-30-16-08_patched/mm/madvise.c
@@ -660,7 +660,7 @@ static int madvise_inject_error(int behavior,
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 					pfn, start);
 
-			ret = soft_offline_page(page, 0);
+			ret = soft_offline_page(page);
 			if (ret)
 				return ret;
 			continue;
diff --git v4.19-mmotm-2018-10-30-16-08/mm/memory-failure.c v4.19-mmotm-2018-10-30-16-08_patched/mm/memory-failure.c
index ed347f8..869ff8f 100644
--- v4.19-mmotm-2018-10-30-16-08/mm/memory-failure.c
+++ v4.19-mmotm-2018-10-30-16-08_patched/mm/memory-failure.c
@@ -1482,7 +1482,7 @@ static void memory_failure_work_func(struct work_struct *work)
 		if (!gotten)
 			break;
 		if (entry.flags & MF_SOFT_OFFLINE)
-			soft_offline_page(pfn_to_page(entry.pfn), entry.flags);
+			soft_offline_page(pfn_to_page(entry.pfn));
 		else
 			memory_failure(entry.pfn, entry.flags);
 	}
@@ -1615,7 +1615,7 @@ static struct page *new_page(struct page *p, unsigned long private)
  * that is not free, and 1 for any other page type.
  * For 1 the page is returned with increased page count, otherwise not.
  */
-static int __get_any_page(struct page *p, unsigned long pfn, int flags)
+static int __get_any_page(struct page *p, unsigned long pfn)
 {
 	int ret;
 
@@ -1642,9 +1642,9 @@ static int __get_any_page(struct page *p, unsigned long pfn, int flags)
 	return ret;
 }
 
-static int get_any_page(struct page *page, unsigned long pfn, int flags)
+static int get_any_page(struct page *page, unsigned long pfn)
 {
-	int ret = __get_any_page(page, pfn, flags);
+	int ret = __get_any_page(page, pfn);
 
 	if (ret == 1 && !PageHuge(page) &&
 	    !PageLRU(page) && !__PageMovable(page)) {
@@ -1657,7 +1657,7 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 		/*
 		 * Did it turn free?
 		 */
-		ret = __get_any_page(page, pfn, 0);
+		ret = __get_any_page(page, pfn);
 		if (ret == 1 && !PageLRU(page)) {
 			/* Drop page reference which is from __get_any_page() */
 			put_hwpoison_page(page);
@@ -1669,7 +1669,7 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 	return ret;
 }
 
-static int soft_offline_huge_page(struct page *page, int flags)
+static int soft_offline_huge_page(struct page *page)
 {
 	int ret;
 	unsigned long pfn = page_to_pfn(page);
@@ -1730,7 +1730,7 @@ static int soft_offline_huge_page(struct page *page, int flags)
 	return ret;
 }
 
-static int __soft_offline_page(struct page *page, int flags)
+static int __soft_offline_page(struct page *page)
 {
 	int ret;
 	unsigned long pfn = page_to_pfn(page);
@@ -1815,7 +1815,7 @@ static int __soft_offline_page(struct page *page, int flags)
 	return ret;
 }
 
-static int soft_offline_in_use_page(struct page *page, int flags)
+static int soft_offline_in_use_page(struct page *page)
 {
 	int ret;
 	int mt;
@@ -1847,9 +1847,9 @@ static int soft_offline_in_use_page(struct page *page, int flags)
 	mt = get_pageblock_migratetype(page);
 	set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 	if (PageHuge(page))
-		ret = soft_offline_huge_page(page, flags);
+		ret = soft_offline_huge_page(page);
 	else
-		ret = __soft_offline_page(page, flags);
+		ret = __soft_offline_page(page);
 	set_pageblock_migratetype(page, mt);
 	return ret;
 }
@@ -1873,7 +1873,6 @@ static int soft_offline_free_page(struct page *page)
 /**
  * soft_offline_page - Soft offline a page.
  * @page: page to offline
- * @flags: flags. Same as memory_failure().
  *
  * Returns 0 on success, otherwise negated errno.
  *
@@ -1892,7 +1891,7 @@ static int soft_offline_free_page(struct page *page)
  * This is not a 100% solution for all memory, but tries to be
  * ``good enough'' for the majority of memory.
  */
-int soft_offline_page(struct page *page, int flags)
+int soft_offline_page(struct page *page)
 {
 	int ret;
 	unsigned long pfn = page_to_pfn(page);
@@ -1909,11 +1908,11 @@ int soft_offline_page(struct page *page, int flags)
 	}
 
 	get_online_mems();
-	ret = get_any_page(page, pfn, flags);
+	ret = get_any_page(page, pfn);
 	put_online_mems();
 
 	if (ret > 0)
-		ret = soft_offline_in_use_page(page, flags);
+		ret = soft_offline_in_use_page(page);
 	else if (ret == 0)
 		ret = soft_offline_free_page(page);
 
-- 
2.7.0

