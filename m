Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8A4C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7762147A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCgCM4kx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfBDFVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 00:21:48 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45407 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBDFVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 00:21:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so6203480pfd.12;
        Sun, 03 Feb 2019 21:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R4CKeqTOSmKlGqbqNcuRp8AhVSkNF996muKePf4UyiQ=;
        b=dCgCM4kxkIkNx8+lyGzDwBsFdjtmMfYX9Ec4JWeIZUivWzFtxYJVkSB80D6rlAgUXt
         apMTDk1LWohYbDZuEG/0M/XdQeXxySgj974NdakDIygVov0GdzdX2pAnT2F/LkGteN29
         9kFxQ5oupLMOwDR/m7805Q2dlqRRW2TTo67oIR/RcHYDMCJeYD5lZI2rujNzyv7U/pKM
         9Ic07Tv/rivdrPTddLlgR703NdoAvU4UYSE9bErMcbUgA2K1ZKlIascnv+vTLQFhsK6N
         yQ/7vmOMgW3iojCLDyrbIAA2cUJNPl3wLnr6BazZPAL8dN5O4ikJTYdkDOuy+5ITVBYv
         WXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4CKeqTOSmKlGqbqNcuRp8AhVSkNF996muKePf4UyiQ=;
        b=dgLbwC69gIe3czItUaNPTKgSoob/Uk/RpDDPpv6wR5dSJkL+LEQMOZd+dFVC/SlLAp
         mM0Ojn/sMrzEuYmnEueSWNZF/HVEFJJ1VrLxeclWT2aAtzgcU+1q/MM9Y4P6ZSmdUg3s
         c0vIMFYJdrloekwPBQiZdwqI/HmPiB2OCNZpqjprS/NcJikcced4JbG4/wnhEZvlQz/b
         fIdPtZkUl09xTdGceKuurkvHTfMoMZW40R3gD1BDQbB3CRgiOwLKU0xLyV86l8shHT88
         DMUNkWb4yP+ox767oE5mLlxI58rMIJ/qqdKRF1JdhtfL2/eEQ6CaxzMbyL2TLYG/9wN4
         KlIQ==
X-Gm-Message-State: AJcUukdRKbUy7rsjSXBpgwBh9XJUMpF5LVfdE6lSKSdQCsvugVBkP0Dy
        VUd1wRPcrk7DCax4boDXdWk=
X-Google-Smtp-Source: ALg8bN6krfQfG2WWpOOlWKb1k4NMAXG/wa4T0P0f3PRSih/YugmwJosjeTH7sTGtR69+kLBSK2MARg==
X-Received: by 2002:a62:e201:: with SMTP id a1mr48715738pfi.75.1549257704697;
        Sun, 03 Feb 2019 21:21:44 -0800 (PST)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id m9sm33428844pgd.32.2019.02.03.21.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 21:21:43 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Nick Piggin <npiggin@suse.de>,
        Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/6] mm: page_cache_add_speculative(): refactoring
Date:   Sun,  3 Feb 2019 21:21:32 -0800
Message-Id: <20190204052135.25784-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204052135.25784-1-jhubbard@nvidia.com>
References: <20190204052135.25784-1-jhubbard@nvidia.com>
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

An upcoming patch for get_user_pages() tracking will use these routines,
so let's remove the duplication now.

There is no intention to introduce any behavioral change, but there is a
small risk of that, due to slightly differing ways of expressing the
TINY_RCU and related configurations.

Cc: Nick Piggin <npiggin@suse.de>
Cc: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/pagemap.h | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e2d7039af6a3..5c8a9b59cbdc 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -164,8 +164,10 @@ void release_pages(struct page **pages, int nr);
  * will find the page or it will not. Likewise, the old find_get_page could run
  * either before the insertion or afterwards, depending on timing.
  */
-static inline int page_cache_get_speculative(struct page *page)
+static inline int __page_cache_add_speculative(struct page *page, int count)
 {
+	VM_BUG_ON(in_interrupt());
+
 #ifdef CONFIG_TINY_RCU
 # ifdef CONFIG_PREEMPT_COUNT
 	VM_BUG_ON(!in_atomic() && !irqs_disabled());
@@ -180,10 +182,10 @@ static inline int page_cache_get_speculative(struct page *page)
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
@@ -197,27 +199,14 @@ static inline int page_cache_get_speculative(struct page *page)
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

