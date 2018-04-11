Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1563688-1523426653-2-2698807387091630790
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523426653; b=AE+wrheiSHQmFeC20ttcQp2mVnqWgWKtaE+Ti5oCwf8SAGdJYB
    cpf0QxxJJPeV9dM4p5j/FXawG5uDx0Iym08vtgzRhS/WA8YyQkADz2IEVLG5Cy98
    8vZ0zn4+PqNQWZpFR7mL9Ab7jynCE3KHqTc+JJk5QEf2ckhTcNIQqC62pt/P3sRv
    IDamjv5qe3XksmeXxBktGNiD+MzOyny8heE5EUeDSlUy8symEMhiyOjclPaj3uTg
    XdF3ak0nUBvTNbcUZMGYB2aQmIVx3uILMiHBnYlneZ4wtY8kV87rQYvx0gz7QQjz
    biWnZzuY/wwmMpoabULk+1zusTT8EgnMvE3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523426653; bh=
    Z8T8aforecbTBSlIDPMF5a/yuPPmDJaZvWuH3Q0VUk8=; b=OthitJf4a1hMmwTI
    JagtCxh3N3ivt1YBv5U+8ku9zBist4gK1tp7u/3NO77xkQwOjs/Yw/EY0USE6nZ7
    9GdL1mpYHreHQT9CBUei0K0byFeieQOq2cgpLn5KTbQ0ZiQFUIMwEq+3ldL3OaM7
    r1fPaq0yWdCmZm39f2yVEVfXPpzDZSHUxRGmhLfCVrAVo8hjuLqX82eCi/vC13k6
    o8w4S38oaqkPP+TmaM9weuwFKZVwm44tyFMnuto3ZBYoI6WajPyLE9DLDlRbT9Qa
    hnfGhHzRwmKivs44p1XLJpPJ5+HjKOwCcOCEJIqJGqKOHadoyWYVoEu18edQOUW6
    +aFCLw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=gV56E2bC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=gV56E2bC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMXGgvLtiyEgPxHf5irPoKDMZuS+irTSMNf54q8dTHhfszLyvUDPvVhnClRidr9cvh+TkAS2Ma8JJ9redGkN8hb45YbxmmpsY/YZjTtgrf+QDi24eGI1
    EtdRlW7BIdpoZ/wU6Qf0HWKglUVdxvFlhLj8gcG59GDUzn/32c/3sLvx96HBetRhUJSM1Vzg6ZTlaHR/gELiGPOI64fLxjCUg1hcaSFfCDj+ZbZMT58AfqJr
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=yMhMjlubAAAA:8
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=ufHFDILaAAAA:8 a=iox4zFpeAAAA:8
    a=RAu74iQbZOYIzub1VMsA:9 a=JAEjdA0KE_neGsOu:21 a=Qm6M7ryI5kX0epXQ:21
    a=AjGcO6oz07-iQ99wixmX:22 a=ZmIg1sZ3JBWsdXgziEIF:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbeDKGDa (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 02:03:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbeDKGD3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 02:03:29 -0400
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] Fix NULL pointer in page_cache_tree_insert
Date: Tue, 10 Apr 2018 23:03:19 -0700
Message-Id: <20180411060320.14458-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180411060320.14458-1-willy@infradead.org>
References: <20180411060320.14458-1-willy@infradead.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

f2fs specifies the __GFP_ZERO flag for allocating some of its pages.
Unfortunately, the page cache also uses the mapping's GFP flags for
allocating radix tree nodes.  It always masked off the __GFP_HIGHMEM
flag, and masks off __GFP_ZERO in some paths, but not all.  That causes
radix tree nodes to be allocated with a NULL list_head, which causes
backtraces like:

[<ffffff80086f4de0>] __list_del_entry+0x30/0xd0
[<ffffff8008362018>] list_lru_del+0xac/0x1ac
[<ffffff800830f04c>] page_cache_tree_insert+0xd8/0x110

The __GFP_DMA and __GFP_DMA32 flags would also be able to sneak through
if they are ever used.  Fix them all by using GFP_RECLAIM_MASK at the
innermost location, and remove it from earlier in the callchain.

Fixes: 449dd6984d0e ("mm: keep page cache radix tree nodes in check")
Reported-by: Chris Fries <cfries@google.com>
Debugged-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org
---
 mm/filemap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c2147682f4c3..1a4bfc5ed3dc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -785,7 +785,7 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
 	VM_BUG_ON_PAGE(!PageLocked(new), new);
 	VM_BUG_ON_PAGE(new->mapping, new);
 
-	error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
+	error = radix_tree_preload(gfp_mask & GFP_RECLAIM_MASK);
 	if (!error) {
 		struct address_space *mapping = old->mapping;
 		void (*freepage)(struct page *);
@@ -841,7 +841,7 @@ static int __add_to_page_cache_locked(struct page *page,
 			return error;
 	}
 
-	error = radix_tree_maybe_preload(gfp_mask & ~__GFP_HIGHMEM);
+	error = radix_tree_maybe_preload(gfp_mask & GFP_RECLAIM_MASK);
 	if (error) {
 		if (!huge)
 			mem_cgroup_cancel_charge(page, memcg, false);
@@ -1574,8 +1574,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 		if (fgp_flags & FGP_ACCESSED)
 			__SetPageReferenced(page);
 
-		err = add_to_page_cache_lru(page, mapping, offset,
-				gfp_mask & GFP_RECLAIM_MASK);
+		err = add_to_page_cache_lru(page, mapping, offset, gfp_mask);
 		if (unlikely(err)) {
 			put_page(page);
 			page = NULL;
@@ -2378,7 +2377,7 @@ static int page_cache_read(struct file *file, pgoff_t offset, gfp_t gfp_mask)
 		if (!page)
 			return -ENOMEM;
 
-		ret = add_to_page_cache_lru(page, mapping, offset, gfp_mask & GFP_KERNEL);
+		ret = add_to_page_cache_lru(page, mapping, offset, gfp_mask);
 		if (ret == 0)
 			ret = mapping->a_ops->readpage(file, page);
 		else if (ret == -EEXIST)
-- 
2.16.3
