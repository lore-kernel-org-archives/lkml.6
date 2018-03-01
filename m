Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3944463-1519938997-2-12817337032440402704
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519938997; b=u1jG0pfZ8GYIMKfn7CC+Er17rwp/K38fQfbWY3WOqXgku9T
    7ET1EemfBFXNzo1aFI/9L0MNLOAtloJGZPFUkPN7DCIRtDxX1IEz48CWj43cNGye
    oFXi67Gd7GwFlDepcaSGGqPg+VXun/noL2Vp+gFdrfMumh0VjfdIuVSfXVq9mE4D
    RuJdBr1eiLTGKMqQRK37XYCN3eoIlWzw0drxMxEf6hjTNR0QTEUvg5cQ1o4JL7vR
    05no9yrw/2GnMiYHhBWKHvwcRkfut8c/BMdsdzZ+jyBJnpmKRB8rL+xtU4XSjRh/
    liPzgrw6cPPp1mjpgfidUfbADQEIqp974xh0RVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519938997;
    bh=Tf5/QxTGz51eUQBctrP5GbGYlext2zveCCNJ9vksNwE=; b=Ww0sOYTUPGZu
    3OG0BxdWj8WJ5VlS7CUBKSE4MW5xkK/tNEMi92IPsDIrbaPUnkgOQj/jrC9e/jfa
    qezFqHE/1pOaXN0YvCsSEc2qAkt6QSMugFCMvSkgBl2rJgGpqmJXxXBosMNmqdCa
    gNWmSsZKhZXVkwGs6vB6FBWpc4rG24ilaLqVnwB8srQ8rGj9hogEEGtQcOW0x7xB
    0zr50pNhN6hmxJLfTu1iBQRTBpyysPGBipXnF9l96NrATo7/C2YWBysBCcv0LvxC
    hjpFsNJwMp/u3kwsEslqCD1qiXRZFU25GuwzWUa7lLnU5rgS8LONuw2SV9hXg1mC
    iCjuWxaZVA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Jwc4TdSh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Jwc4TdSh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161985AbeCAVQB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 16:16:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49204 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034171AbeCAVPc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Mar 2018 16:15:32 -0500
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org,
        Fengguang Wu <fengguang.wu@intel.com>,
        linux-api@vger.kernel.org
Subject: [PATCH v4 2/4] mm: Split page_type out from _map_count
Date: Thu,  1 Mar 2018 13:15:21 -0800
Message-Id: <20180301211523.21104-3-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180301211523.21104-1-willy@infradead.org>
References: <20180301211523.21104-1-willy@infradead.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

We're already using a union of many fields here, so stop abusing the
_map_count and make page_type its own field.  That implies renaming some
of the machinery that creates PageBuddy, PageBalloon and PageKmemcg;
bring back the PG_buddy, PG_balloon and PG_kmemcg names.

As suggested by Kirill, make page_type a bitmask.  Because it starts out
life as -1 (thanks to sharing the storage with _map_count), setting a
page flag means clearing the appropriate bit.  This gives us space for
probably twenty or so extra bits (depending how paranoid we want to be
about _mapcount underflow).

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 include/linux/mm_types.h   | 13 ++++++++-----
 include/linux/page-flags.h | 45 ++++++++++++++++++++++++++-------------------
 kernel/crash_core.c        |  1 +
 mm/page_alloc.c            | 13 +++++--------
 scripts/tags.sh            |  6 +++---
 5 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index fd1af6b9591d..1c5dea402501 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -94,6 +94,14 @@ struct page {
 	};
 
 	union {
+		/*
+		 * If the page is neither PageSlab nor PageAnon, the value
+		 * stored here may help distinguish it from page cache pages.
+		 * See page-flags.h for a list of page types which are
+		 * currently stored here.
+		 */
+		unsigned int page_type;
+
 		_slub_counter_t counters;
 		unsigned int active;		/* SLAB */
 		struct {			/* SLUB */
@@ -107,11 +115,6 @@ struct page {
 			/*
 			 * Count of ptes mapped in mms, to show when
 			 * page is mapped & limit reverse map searches.
-			 *
-			 * Extra information about page type may be
-			 * stored here for pages that are never mapped,
-			 * in which case the value MUST BE <= -2.
-			 * See page-flags.h for more details.
 			 */
 			atomic_t _mapcount;
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 50c2b8786831..d151f590bbc6 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -630,49 +630,56 @@ PAGEFLAG_FALSE(DoubleMap)
 #endif
 
 /*
- * For pages that are never mapped to userspace, page->mapcount may be
- * used for storing extra information about page type. Any value used
- * for this purpose must be <= -2, but it's better start not too close
- * to -2 so that an underflow of the page_mapcount() won't be mistaken
- * for a special page.
+ * For pages that are never mapped to userspace (and aren't PageSlab),
+ * page_type may be used.  Because it is initialised to -1, we invert the
+ * sense of the bit, so __SetPageFoo *clears* the bit used for PageFoo, and
+ * __ClearPageFoo *sets* the bit used for PageFoo.  We leave a gap in the bit
+ * assignments so that an underflow of page_mapcount() won't be mistaken for
+ * a special page.
  */
-#define PAGE_MAPCOUNT_OPS(uname, lname)					\
+
+#define PAGE_TYPE_BASE	0xff000000
+/* Reserve		0x0000007f to catch underflows of page_mapcount */
+#define PG_buddy	0x00000080
+#define PG_balloon	0x00000100
+#define PG_kmemcg	0x00000200
+
+#define PageType(page, flag)						\
+	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
+
+#define PAGE_TYPE_OPS(uname, lname)					\
 static __always_inline int Page##uname(struct page *page)		\
 {									\
-	return atomic_read(&page->_mapcount) ==				\
-				PAGE_##lname##_MAPCOUNT_VALUE;		\
+	return PageType(page, PG_##lname);				\
 }									\
 static __always_inline void __SetPage##uname(struct page *page)		\
 {									\
-	VM_BUG_ON_PAGE(atomic_read(&page->_mapcount) != -1, page);	\
-	atomic_set(&page->_mapcount, PAGE_##lname##_MAPCOUNT_VALUE);	\
+	VM_BUG_ON_PAGE(!PageType(page, 0), page);			\
+	page->page_type &= ~PG_##lname;					\
 }									\
 static __always_inline void __ClearPage##uname(struct page *page)	\
 {									\
 	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
-	atomic_set(&page->_mapcount, -1);				\
+	page->page_type |= PG_##lname;					\
 }
 
 /*
- * PageBuddy() indicate that the page is free and in the buddy system
+ * PageBuddy() indicates that the page is free and in the buddy system
  * (see mm/page_alloc.c).
  */
-#define PAGE_BUDDY_MAPCOUNT_VALUE		(-128)
-PAGE_MAPCOUNT_OPS(Buddy, BUDDY)
+PAGE_TYPE_OPS(Buddy, buddy)
 
 /*
- * PageBalloon() is set on pages that are on the balloon page list
+ * PageBalloon() is true for pages that are on the balloon page list
  * (see mm/balloon_compaction.c).
  */
-#define PAGE_BALLOON_MAPCOUNT_VALUE		(-256)
-PAGE_MAPCOUNT_OPS(Balloon, BALLOON)
+PAGE_TYPE_OPS(Balloon, balloon)
 
 /*
  * If kmemcg is enabled, the buddy allocator will set PageKmemcg() on
  * pages allocated with __GFP_ACCOUNT. It gets cleared on page free.
  */
-#define PAGE_KMEMCG_MAPCOUNT_VALUE		(-512)
-PAGE_MAPCOUNT_OPS(Kmemcg, KMEMCG)
+PAGE_TYPE_OPS(Kmemcg, kmemcg)
 
 extern bool is_free_buddy_page(struct page *page);
 
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 4f63597c824d..b02340fb99ff 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -458,6 +458,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_NUMBER(PG_hwpoison);
 #endif
 	VMCOREINFO_NUMBER(PG_head_mask);
+#define PAGE_BUDDY_MAPCOUNT_VALUE	(~PG_buddy)
 	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
 #ifdef CONFIG_HUGETLB_PAGE
 	VMCOREINFO_NUMBER(HUGETLB_PAGE_DTOR);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cb416723538f..ac0b24603030 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -744,16 +744,14 @@ static inline void rmv_page_order(struct page *page)
 
 /*
  * This function checks whether a page is free && is the buddy
- * we can do coalesce a page and its buddy if
+ * we can coalesce a page and its buddy if
  * (a) the buddy is not in a hole (check before calling!) &&
  * (b) the buddy is in the buddy system &&
  * (c) a page and its buddy have the same order &&
  * (d) a page and its buddy are in the same zone.
  *
- * For recording whether a page is in the buddy system, we set ->_mapcount
- * PAGE_BUDDY_MAPCOUNT_VALUE.
- * Setting, clearing, and testing _mapcount PAGE_BUDDY_MAPCOUNT_VALUE is
- * serialized by zone->lock.
+ * For recording whether a page is in the buddy system, we set PageBuddy.
+ * Setting, clearing, and testing PageBuddy is serialized by zone->lock.
  *
  * For recording page's order, we use page_private(page).
  */
@@ -798,9 +796,8 @@ static inline int page_is_buddy(struct page *page, struct page *buddy,
  * as necessary, plus some accounting needed to play nicely with other
  * parts of the VM system.
  * At each level, we keep a list of pages, which are heads of continuous
- * free pages of length of (1 << order) and marked with _mapcount
- * PAGE_BUDDY_MAPCOUNT_VALUE. Page's order is recorded in page_private(page)
- * field.
+ * free pages of length of (1 << order) and marked with PageBuddy.
+ * Page's order is recorded in page_private(page) field.
  * So when we are allocating or freeing one, we can derive the state of the
  * other.  That is, if we allocate a small block, and both were
  * free, the remainder of the region must be split into blocks.
diff --git a/scripts/tags.sh b/scripts/tags.sh
index 78e546ff689c..8c3ae36d4ea8 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -188,9 +188,9 @@ regex_c=(
 	'/\<CLEARPAGEFLAG_NOOP(\([[:alnum:]_]*\).*/ClearPage\1/'
 	'/\<__CLEARPAGEFLAG_NOOP(\([[:alnum:]_]*\).*/__ClearPage\1/'
 	'/\<TESTCLEARFLAG_FALSE(\([[:alnum:]_]*\).*/TestClearPage\1/'
-	'/^PAGE_MAPCOUNT_OPS(\([[:alnum:]_]*\).*/Page\1/'
-	'/^PAGE_MAPCOUNT_OPS(\([[:alnum:]_]*\).*/__SetPage\1/'
-	'/^PAGE_MAPCOUNT_OPS(\([[:alnum:]_]*\).*/__ClearPage\1/'
+	'/^PAGE_TYPE_OPS(\([[:alnum:]_]*\).*/Page\1/'
+	'/^PAGE_TYPE_OPS(\([[:alnum:]_]*\).*/__SetPage\1/'
+	'/^PAGE_TYPE_OPS(\([[:alnum:]_]*\).*/__ClearPage\1/'
 	'/^TASK_PFA_TEST([^,]*, *\([[:alnum:]_]*\))/task_\1/'
 	'/^TASK_PFA_SET([^,]*, *\([[:alnum:]_]*\))/task_set_\1/'
 	'/^TASK_PFA_CLEAR([^,]*, *\([[:alnum:]_]*\))/task_clear_\1/'
-- 
2.16.1

