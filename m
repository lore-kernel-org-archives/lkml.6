Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDECFC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A48E2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdRN1yRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A48E2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeKIQ0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:26:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44157 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeKIQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:26:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id s5-v6so484844plq.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I5gsSunXdH895MmsSOVcjAuo3r5POwuiCmdFP97vCrk=;
        b=sdRN1yRf9dBJRcb+kLIszEwQGdNQOZ/Cr+T69TTOG33+p7+lHSgokccxp12AmGcVIv
         b91zsOA4UMyF4L+oVL6LsmtmQ0mrUPXuofZRoGL2SArKd4t78l8//9OXDgx2DByLzwTH
         bgn+qlrl5d8UAp2EsmA5ST/wxze2XAq74fATX8SIK1LqbWEWaxtnpfmlLifaIrlgvM2T
         +KVOe7h4t1J6EV679ilKNSH27x7hciLKHKWR36KGpRkR3Y8utPdIl0luWG0Zz028cmxA
         W3eGSr7QcHdRS1QEaYGPjeykA6PaFyjQ8LBPWvy/4j6IrhNw8DC3u40Jf+I+3hNC3Iu7
         QedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=I5gsSunXdH895MmsSOVcjAuo3r5POwuiCmdFP97vCrk=;
        b=QTlD7gWMz7tuMaUag/xYQuwFPFATEMItJB217g0d1M1lN9TdckrD/hfoX+5F1onYXT
         joveswHasdg9bMw5XdeS6KNWYVnimeT1Xe0XUwGDvVIG8kyOaUwGhci+d4sXTdKeB/vY
         kNTw44CbZcBe4H/eUwXbAvlb6dGIlgQojud73QlENTLYtNx5xJkozONFBCAmUSDjZf3U
         gJrNhLsLtXjSTxQIG5fcSo+ANi7kBuF29lQpcuasiZhNSbUdWUIbU1gbNTp40tjCW1rQ
         tlyp5m18GzTeAEl9PbyFogLTL05eIFRjeYA0iVlwe5lemDXRmWfXKGAb2uAQydjMmkbJ
         7QXQ==
X-Gm-Message-State: AGRZ1gK6Boy+2q2V2ZhuvLGx0ROvetJ+PGvCVxfOLxUwyKVu99QrBfzC
        JcohnYa5MoeknQ4zFKdONg==
X-Google-Smtp-Source: AJdET5eg902nQvUWpouttJ+YLnryXSQ9Zt4zI710Y5VxL9S/LDzptvX0L/igyGaFSk4UGTH0C2OnIw==
X-Received: by 2002:a17:902:2cc1:: with SMTP id n59-v6mr542277plb.26.1541746055768;
        Thu, 08 Nov 2018 22:47:35 -0800 (PST)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6808355pfg.97.2018.11.08.22.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 22:47:35 -0800 (PST)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: [RFC][PATCH v1 03/11] mm: move definition of num_poisoned_pages_inc/dec to include/linux/mm.h
Date:   Fri,  9 Nov 2018 15:47:07 +0900
Message-Id: <1541746035-13408-4-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

num_poisoned_pages_inc/dec had better be visible to some file like
mm/sparse.c and mm/page_alloc.c (for a subsequent patch). So let's
move it to include/linux/mm.h.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 include/linux/mm.h      | 13 ++++++++++++-
 include/linux/swapops.h | 16 ----------------
 mm/sparse.c             |  2 +-
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git v4.19-mmotm-2018-10-30-16-08/include/linux/mm.h v4.19-mmotm-2018-10-30-16-08_patched/include/linux/mm.h
index 59df394..22623ba 100644
--- v4.19-mmotm-2018-10-30-16-08/include/linux/mm.h
+++ v4.19-mmotm-2018-10-30-16-08_patched/include/linux/mm.h
@@ -2741,7 +2741,7 @@ extern void shake_page(struct page *p, int access);
 extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(struct page *page, int flags);
 
-
+#ifdef CONFIG_MEMORY_FAILURE
 /*
  * Error handlers for various types of pages.
  */
@@ -2777,6 +2777,17 @@ enum mf_action_page_type {
 	MF_MSG_UNKNOWN,
 };
 
+static inline void num_poisoned_pages_inc(void)
+{
+	atomic_long_inc(&num_poisoned_pages);
+}
+
+static inline void num_poisoned_pages_dec(void)
+{
+	atomic_long_dec(&num_poisoned_pages);
+}
+#endif
+
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
 extern void clear_huge_page(struct page *page,
 			    unsigned long addr_hint,
diff --git v4.19-mmotm-2018-10-30-16-08/include/linux/swapops.h v4.19-mmotm-2018-10-30-16-08_patched/include/linux/swapops.h
index 4d96166..88137e9 100644
--- v4.19-mmotm-2018-10-30-16-08/include/linux/swapops.h
+++ v4.19-mmotm-2018-10-30-16-08_patched/include/linux/swapops.h
@@ -320,8 +320,6 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
 
 #ifdef CONFIG_MEMORY_FAILURE
 
-extern atomic_long_t num_poisoned_pages __read_mostly;
-
 /*
  * Support for hardware poisoned pages
  */
@@ -336,16 +334,6 @@ static inline int is_hwpoison_entry(swp_entry_t entry)
 	return swp_type(entry) == SWP_HWPOISON;
 }
 
-static inline void num_poisoned_pages_inc(void)
-{
-	atomic_long_inc(&num_poisoned_pages);
-}
-
-static inline void num_poisoned_pages_dec(void)
-{
-	atomic_long_dec(&num_poisoned_pages);
-}
-
 #else
 
 static inline swp_entry_t make_hwpoison_entry(struct page *page)
@@ -357,10 +345,6 @@ static inline int is_hwpoison_entry(swp_entry_t swp)
 {
 	return 0;
 }
-
-static inline void num_poisoned_pages_inc(void)
-{
-}
 #endif
 
 #if defined(CONFIG_MEMORY_FAILURE) || defined(CONFIG_MIGRATION)
diff --git v4.19-mmotm-2018-10-30-16-08/mm/sparse.c v4.19-mmotm-2018-10-30-16-08_patched/mm/sparse.c
index 33307fc..7ada2e5 100644
--- v4.19-mmotm-2018-10-30-16-08/mm/sparse.c
+++ v4.19-mmotm-2018-10-30-16-08_patched/mm/sparse.c
@@ -726,7 +726,7 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 
 	for (i = 0; i < nr_pages; i++) {
 		if (PageHWPoison(&memmap[i])) {
-			atomic_long_sub(1, &num_poisoned_pages);
+			num_poisoned_pages_dec();
 			ClearPageHWPoison(&memmap[i]);
 		}
 	}
-- 
2.7.0

