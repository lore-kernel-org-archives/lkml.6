Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EC3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D6E218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJmCqB+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfBFXKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:10:23 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43273 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBFXKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:10:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so3829874pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 15:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IW5+9eoUK0l9YrjE71fI7riUMWj4UeJsluIuFcwuFT0=;
        b=BJmCqB+FYNHvoRex8qr4dbAfs5Mf0252hHcfg/OZAboQRNYqmaW7kfkPRwO3dDHRUy
         qF6oEwFeZ5N4GqAKAdY/AmJgMORRj7G4fqYt0V8lAdcOoVofv7Etr+kcHEJmI5Z6p+wD
         0/YTA9ALzW1uaQJQoqUrWR613rH1V+AAV0tadVlh0pz866EFwtAVuI8AwCPuWsRodRdf
         jqkKffwVfPkbN2isTC3ogHDmF8vXsFIRIf8x8oLd4N25YGEalo/7eya4R8/LjPcIVSjC
         lcUL4HitdvQHD9cLYhQfBX5gMyFUIlGwDRPdWY4+6x1lUx5uKJw/Txt2i0FY2k5zwupa
         vYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IW5+9eoUK0l9YrjE71fI7riUMWj4UeJsluIuFcwuFT0=;
        b=NaRubE6KtY2BCH7Tdv48hwX74mQkIvkPDLri4ka47HSmnL7QQ6Sv71ezQvhXlf/oQh
         nkX9cdfdsl2WIPY/5VQ3oFlKuNYPOeHlbQR5SBgMMxHg+DIFqzezwIMHPqawx4h7Eosq
         hxIUXVId2JgHdZYGrj2qMRPHMaVTQrDIcr05Z/MYRe20O4D3I6nzLS/tRSfi8RQMk9Wc
         hqATMuojeB513o6UO6aGneC63ME7ObGWOdUe3s9JbmxFo3Vsb2EztKUOf8/v6UVQSTD4
         dgTsZc1NAQNZ6wCszhrCA4XoX8FOTDVl1ReMDa59N81cLPpz/AE19cYraQo3dkiQ2MSH
         zeyg==
X-Gm-Message-State: AHQUAubdyiH19IW/j+pvzROQOljboQlwPVdPmojDTL8ToPtqlnS1VZt2
        dojPPNhynJXhFbZh/FN0OgCkM7HH
X-Google-Smtp-Source: AHgI3IYugb1cc5BuZx8B30vi/3nzgkFWUW7+hff/o66VImrH+fVFZjDNajITNe9J1IRLJe54p7x8CQ==
X-Received: by 2002:a63:7c41:: with SMTP id l1mr11843148pgn.45.1549494621594;
        Wed, 06 Feb 2019 15:10:21 -0800 (PST)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 4sm10254880pfq.10.2019.02.06.15.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 15:10:20 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Nick Piggin <npiggin@suse.de>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/1] mm: page_cache_add_speculative(): refactor out some code duplication
Date:   Wed,  6 Feb 2019 15:10:16 -0800
Message-Id: <20190206231016.22734-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206231016.22734-1-jhubbard@nvidia.com>
References: <20190206231016.22734-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

This combines the common elements of these routines:

    page_cache_get_speculative()
    page_cache_add_speculative()

This was anticipated by the original author, as shown by the comment
in commit ce0ad7f095258 ("powerpc/mm: Lockless get_user_pages_fast()
for 64-bit (v3)"):

    "Same as above, but add instead of inc (could just be merged)"

There is no intention to introduce any behavioral change, but there is a
small risk of that, due to slightly differing ways of expressing the
TINY_RCU and related configurations.

This also removes the VM_BUG_ON(in_interrupt()) that was in
page_cache_add_speculative(), but not in page_cache_get_speculative(). This
provides slightly less detection of such bugs, but it given that it was
only there on the "add" path anyway, we can likely do without it just fine.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Nick Piggin <npiggin@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/pagemap.h | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e2d7039af6a3..b477a70cc2e4 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -164,7 +164,7 @@ void release_pages(struct page **pages, int nr);
  * will find the page or it will not. Likewise, the old find_get_page could run
  * either before the insertion or afterwards, depending on timing.
  */
-static inline int page_cache_get_speculative(struct page *page)
+static inline int __page_cache_add_speculative(struct page *page, int count)
 {
 #ifdef CONFIG_TINY_RCU
 # ifdef CONFIG_PREEMPT_COUNT
@@ -180,10 +180,10 @@ static inline int page_cache_get_speculative(struct page *page)
 	 * SMP requires.
 	 */
 	VM_BUG_ON_PAGE(page_count(page) == 0, page);
-	page_ref_inc(page);
+	page_ref_add(page, count);
 
 #else
-	if (unlikely(!get_page_unless_zero(page))) {
+	if (unlikely(!page_ref_add_unless(page, count, 0))) {
 		/*
 		 * Either the page has been freed, or will be freed.
 		 * In either case, retry here and the caller should
@@ -197,27 +197,14 @@ static inline int page_cache_get_speculative(struct page *page)
 	return 1;
 }
 
-/*
- * Same as above, but add instead of inc (could just be merged)
- */
-static inline int page_cache_add_speculative(struct page *page, int count)
+static inline int page_cache_get_speculative(struct page *page)
 {
-	VM_BUG_ON(in_interrupt());
-
-#if !defined(CONFIG_SMP) && defined(CONFIG_TREE_RCU)
-# ifdef CONFIG_PREEMPT_COUNT
-	VM_BUG_ON(!in_atomic() && !irqs_disabled());
-# endif
-	VM_BUG_ON_PAGE(page_count(page) == 0, page);
-	page_ref_add(page, count);
-
-#else
-	if (unlikely(!page_ref_add_unless(page, count, 0)))
-		return 0;
-#endif
-	VM_BUG_ON_PAGE(PageCompound(page) && page != compound_head(page), page);
+	return __page_cache_add_speculative(page, 1);
+}
 
-	return 1;
+static inline int page_cache_add_speculative(struct page *page, int count)
+{
+	return __page_cache_add_speculative(page, count);
 }
 
 #ifdef CONFIG_NUMA
-- 
2.20.1

