Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836988-1523364855-2-16509619839012923997
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
    1523364855; b=Kyd8edGtcJFkopPVGrGQ6B/dTD9N8SKTdGRdEKEPCVenIUuEt2
    NF7v1lHSEr/cISGh+tRHRtycgEMYLh0C7XCBO4Z61g4cu4wMI0eN3cAF6DkkVfHZ
    aNopmgQKyYbCMcXdltdl6fjO6B1/nrWdPe6aNT/dF7XYdhVHDOvEi6M29ouvpJcR
    axahwt0ePKFPCWdjg6qf8Oy4/2akkWmue6E6JZTJC2tMxibpLt22WFMNeKucDdsJ
    6Bo7DfzUY8VYx3kG/q2szNGsdEv5aeV6R6OzTTMvNycdwstS0hmlcZi9HxNmmpfE
    OT+Q1ONPK5BrHk0hY8IFVyZ9NGt2XuXNo7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523364855; bh=
    t0/MCIb67clDqBGWGlt8pU9+LYLE4MxtISJ/mGhj3jY=; b=U3QgalL4wwLZtyT3
    xzaB4Ur2LTkU+fp1sCBpPWYzKzALjD4rk4veV7yn3Ljj3HZ+95QAa/EJ5sf8jrv3
    8x2qyZsihx9KV+SxIRrpwCUI08+/bPyw6ifQDaFyXH/C71xR84BNbmcFJ2Yo4d3v
    X2SmmuzQ8G72ui61u8s+94QT5rPRS0AUS23voxWaIrPrbJTen0612QRkTQEnsM1w
    H1HAU0ERb3o4wLN8whfB5Lm5ezoY7ZanZz/B+heHpuSQSi3j0wuSkj9jErfuHBMA
    aLov0PpsE178yLBMzEtOlro5u4DwSP3ZORPws33HumKXbCeMzFANk75Y5tY3dO8O
    FwdDpw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=geZavtue x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=geZavtue x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPfR+rJMrab/9X87cFvfYt2ORGFn9mlQEZO+G/z0NSuusO+vMRg2pGkvQxDnKCZnWiJkENFHdMbnMRqA9lTGDK84Im1dYPkKx43r9ATBwb0eGsD6N2MZ
    Je0r30gmArAp256SjTcH7jRsKRHnuEw9lK9olRhHa9/SR75kl7RNkovI0HMpLiRKi2MdpEZKLb0xpDgAE06uZ9wJA5DcICCU9VKwC0kKOT2u8l4Yf6jijySN
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=yMhMjlubAAAA:8
    a=VwQbUJbxAAAA:8 a=RAu74iQbZOYIzub1VMsA:9 a=SlYinwPCV1lBf_Gh:21
    a=0lZdyOaBekWfuNut:21 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753164AbeDJMyN (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 08:54:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753187AbeDJMx7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 08:53:59 -0400
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
Subject: [PATCH 2/2] page cache: Mask off unwanted GFP flags
Date: Tue, 10 Apr 2018 05:53:51 -0700
Message-Id: <20180410125351.15837-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180410125351.15837-1-willy@infradead.org>
References: <20180410125351.15837-1-willy@infradead.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

The page cache has used the mapping's GFP flags for allocating
radix tree nodes for a long time.  It took care to always mask off the
__GFP_HIGHMEM flag, and masked off other flags in other paths, but the
__GFP_ZERO flag was still able to sneak through.  The __GFP_DMA and
__GFP_DMA32 flags would also have been able to sneak through if they
were ever used.  Fix them all by using GFP_RECLAIM_MASK at the innermost
location, and remove it from earlier in the callchain.

Fixes: 19f99cee206c ("f2fs: add core inode operations")
Reported-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
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
