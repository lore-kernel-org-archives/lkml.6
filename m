Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbeA3AoC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 19:44:02 -0500
Received: from merlin.infradead.org ([205.233.59.134]:32778 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeA3AoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 19:44:00 -0500
To: Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] mm/swap.c: make functions and their kernel-doc agree
Message-ID: <3b42ee3e-04a9-a6ca-6be4-f00752a114fe@infradead.org>
Date: Mon, 29 Jan 2018 16:43:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix some basic kernel-doc notation in mm/swap.c:
- for function lru_cache_add_anon(), make its kernel-doc function name
  match its function name and change colon to hyphen following the
  function name
- for function pagevec_lookup_entries(), change the function parameter
  name from nr_pages to nr_entries since that is more descriptive of
  what the parameter actually is and then it matches the kernel-doc
  comments also

Fix function kernel-doc to match the change in commit 67fd707f4681:
- drop the kernel-doc notation for @nr_pages from pagevec_lookup_range()
  and correct the function description for that change

Fixes: 67fd707f4681
    ("mm: remove nr_pages argument from pagevec_lookup_{,range}_tag()")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
---
 mm/swap.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

v2 changes:
- leave kernel-doc for lru_cache_add_anon() where it is but fix its
  kernel-doc notation
- change pagevec_lookup_entries() parameter from nr_pages to nr_entries

--- lnx-415.orig/mm/swap.c
+++ lnx-415/mm/swap.c
@@ -411,7 +411,7 @@ static void __lru_cache_add(struct page
 }
 
 /**
- * lru_cache_add: add a page to the page lists
+ * lru_cache_add_anon - add a page to the page lists
  * @page: the page to add
  */
 void lru_cache_add_anon(struct page *page)
@@ -930,10 +930,10 @@ EXPORT_SYMBOL(__pagevec_lru_add);
  */
 unsigned pagevec_lookup_entries(struct pagevec *pvec,
 				struct address_space *mapping,
-				pgoff_t start, unsigned nr_pages,
+				pgoff_t start, unsigned nr_entries,
 				pgoff_t *indices)
 {
-	pvec->nr = find_get_entries(mapping, start, nr_pages,
+	pvec->nr = find_get_entries(mapping, start, nr_entries,
 				    pvec->pages, indices);
 	return pagevec_count(pvec);
 }
@@ -965,9 +965,8 @@ void pagevec_remove_exceptionals(struct
  * @mapping:	The address_space to search
  * @start:	The starting page index
  * @end:	The final page index
- * @nr_pages:	The maximum number of pages
  *
- * pagevec_lookup_range() will search for and return a group of up to @nr_pages
+ * pagevec_lookup_range() will search for & return a group of up to PAGEVEC_SIZE
  * pages in the mapping starting from index @start and upto index @end
  * (inclusive).  The pages are placed in @pvec.  pagevec_lookup() takes a
  * reference against the pages in @pvec.
@@ -977,7 +976,7 @@ void pagevec_remove_exceptionals(struct
  * also update @start to index the next page for the traversal.
  *
  * pagevec_lookup_range() returns the number of pages which were found. If this
- * number is smaller than @nr_pages, the end of specified range has been
+ * number is smaller than PAGEVEC_SIZE, the end of specified range has been
  * reached.
  */
 unsigned pagevec_lookup_range(struct pagevec *pvec,
