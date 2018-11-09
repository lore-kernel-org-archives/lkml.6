Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C572CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACB720883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElkJIby2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACB720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeKIQ0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:26:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45590 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeKIQ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:26:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so435378pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RtdH+8fxry6h6Pbb8TY5o2YMHv5QWx+98Zgkeuvb6yk=;
        b=ElkJIby278Z9CaOTZIBqEFv9pFIG/BYuKQHgnezzaRdylmojC0zbp8sBRtVX/oV8PC
         yHBNaT2B8o841kQMAdzwDZGY39pWLzykg7ApEESA4gMcaGk42bMEVpbfzW1z38Aatuo3
         LHzq3XwPNzxzYKCURxEt9WeQ6/wCS5tLxGid6QSkWRiG3ohbmZ/XNCEOZPI30urS22cL
         pik/Y9uAs1WaHup86v7sr8O5anrg6+B4SIaah/7QZJKWtHLwtvSSHoJm0HabxjLfbGJw
         dGY4ptfGWhQfR4Qtl+EU/zbwdclwjpwLmSkKbzpNI64knX6ATyQ7s03LyiFtzJ8ypdLz
         6nDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=RtdH+8fxry6h6Pbb8TY5o2YMHv5QWx+98Zgkeuvb6yk=;
        b=CFp52yW+YJ4VdVNl2fXVMSCdk4PgRSVT/Irkp+jYpHgGfA3Hv2fljN8uRdL5zBhTrC
         BAQBxIs0wvJ3IwK/qxV6gGjYC21tmOf8+vztxZt8yOmucQMaOSQ3sSQ95zVbz0PyMiM3
         touYMbUNJS7d7XIXyHdM1Eg5AoKoXtuC0AFp0arq+wBa0W4Umd7T550msd7n/hQ/Hvxy
         gKwOY5JLmJryMz9vUJJTTyCd17P0HPq1iAKziOapo0RoCCt9cmVNH4bl/f1/e7EGbC1A
         bUkoE4uhn+YhHPQbyXqGdLqurTYX8lKoRQxLzewY5X6MqJNIxOk6Ybj0nZFfbJqbMHEN
         hBXg==
X-Gm-Message-State: AGRZ1gIA5El91/pn4zmjBYzuSRGULHQzxMfFi7rEhFHSyBxJWgfuw1EL
        29XaotuUuYpt7hf/KaIWzg==
X-Google-Smtp-Source: AJdET5dLYkKAGMikx0AVM1cpBD5gra2rJpxrwthuU9y4IFa1nzMP838s9nBknpVJS7aYq3HFCeZBkw==
X-Received: by 2002:a62:7d10:: with SMTP id y16-v6mr7716522pfc.245.1541746053458;
        Thu, 08 Nov 2018 22:47:33 -0800 (PST)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6808355pfg.97.2018.11.08.22.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 22:47:32 -0800 (PST)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: [RFC][PATCH v1 02/11] mm: soft-offline: add missing error check of set_hwpoison_free_buddy_page()
Date:   Fri,  9 Nov 2018 15:47:06 +0900
Message-Id: <1541746035-13408-3-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_hwpoison_free_buddy_page() could fail, then the target page is
finally not isolated, so it's better to report -EBUSY for userspace
to know the failure and chance of retry.

And for consistency, this patch moves set_hwpoison_free_buddy_page()
in unmap_and_move() to __soft_offline_page().

Fixes: 6bc9b56433b7 ("mm: fix race on soft-offlining free huge pages")
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 mm/memory-failure.c | 15 ++++++++++++---
 mm/migrate.c        |  9 ---------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git v4.19-mmotm-2018-10-30-16-08/mm/memory-failure.c v4.19-mmotm-2018-10-30-16-08_patched/mm/memory-failure.c
index 9f09bf3..11e283e 100644
--- v4.19-mmotm-2018-10-30-16-08/mm/memory-failure.c
+++ v4.19-mmotm-2018-10-30-16-08_patched/mm/memory-failure.c
@@ -1719,14 +1719,18 @@ static int soft_offline_huge_page(struct page *page, int flags)
 		/*
 		 * We set PG_hwpoison only when the migration source hugepage
 		 * was successfully dissolved, because otherwise hwpoisoned
-		 * hugepage remains on free hugepage list, then userspace will
-		 * find it as SIGBUS by allocation failure. That's not expected
-		 * in soft-offlining.
+		 * hugepage remains on free hugepage list. The allocator ignores
+		 * such a hwpoisoned page so it's never allocated, but it could
+		 * kill a process because of no-memory rather than hwpoison.
+		 * Soft-offline never impacts the userspace, so this is
+		 * undesired.
 		 */
 		ret = dissolve_free_huge_page(page);
 		if (!ret) {
 			if (set_hwpoison_free_buddy_page(page))
 				num_poisoned_pages_inc();
+			else
+				ret = -EBUSY;
 		}
 	}
 	return ret;
@@ -1804,6 +1808,11 @@ static int __soft_offline_page(struct page *page, int flags)
 				pfn, ret, page->flags, &page->flags);
 			if (ret > 0)
 				ret = -EIO;
+		} else {
+			if (set_hwpoison_free_buddy_page(page))
+				num_poisoned_pages_inc();
+			else
+				ret = -EBUSY;
 		}
 	} else {
 		pr_info("soft offline: %#lx: isolation failed: %d, page count %d, type %lx (%pGp)\n",
diff --git v4.19-mmotm-2018-10-30-16-08/mm/migrate.c v4.19-mmotm-2018-10-30-16-08_patched/mm/migrate.c
index f7e4bfd..1742372 100644
--- v4.19-mmotm-2018-10-30-16-08/mm/migrate.c
+++ v4.19-mmotm-2018-10-30-16-08_patched/mm/migrate.c
@@ -1199,15 +1199,6 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 	 */
 	if (rc == MIGRATEPAGE_SUCCESS) {
 		put_page(page);
-		if (reason == MR_MEMORY_FAILURE) {
-			/*
-			 * Set PG_HWPoison on just freed page
-			 * intentionally. Although it's rather weird,
-			 * it's how HWPoison flag works at the moment.
-			 */
-			if (set_hwpoison_free_buddy_page(page))
-				num_poisoned_pages_inc();
-		}
 	} else {
 		if (rc != -EAGAIN) {
 			if (likely(!__PageMovable(page))) {
-- 
2.7.0

