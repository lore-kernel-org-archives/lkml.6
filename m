Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3944332-1519938938-2-14054168439813348452
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
    t=1519938937; b=DhrhTmOyYBQvcA2QuQRtVYuw/dPeWNtc/UPv5NJo6xfAS7L
    WrsxubGuhqpKyujxd+BdZWzWK9ZWI6sZmpKfYibuwJ0m/ZIfpdJ/TxW9iaasqES9
    P6ZVB537c6FvRkRd/f3prgACgaqNcUQs12b8IR0+xX9kYMjr5bPQxuhh7E0dwvUy
    Z6eB+kPjGrwBg/NUqU7FDzGV+tsP5ioRSBCVHonubA3EmNkaR6/5ZqpG84Q1a4u7
    1vGtGZGEJpuyEFeEaFpTRdcIOTm+4+pznmRu2q2k2aGJOWVHtsn4KRMGZpFdWOFm
    VHDKI3A6m3eKklChDH+EsbofnlIzg90/yvPEJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519938937;
    bh=/l/TbMyn0FrCPQSlPpyoGmxIdJgsz7T4g+cdsstYx3o=; b=PWZ38SJxcIFj
    9YeGLiLsb/2UlnJG8mwGHAeYXu+1aC+Ofye+B0QsVg5T5bEpOH/ZWVZenzoXmNac
    hvOXn5oOo0bPZm7JmrZE1VyoR+xeyQz0Tq3WdmG2NbeBfNxs9HqWqqb8h2liXB6K
    YgfC2WiguV+IcerFkxmZXR3eTsYfnvNOAZ2hgVKNX+D6r6eAiDzbTyj0MDhfAMJZ
    XM7tUiSylwkJTLqCrTOd2FeVmNkOpuohnCZfAGj3cPoAt8dzuRXvwon2f8bBKMlf
    Kn13as787LvsuLl8RKclHjKDHwjNhBKIHfQ8NegSs5GnPmS4txZm+NzwHmEC6YYD
    /Ybj7Lq0Tw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=sb4zLQ8+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=sb4zLQ8+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034216AbeCAVPe (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 16:15:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033870AbeCAVPb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Mar 2018 16:15:31 -0500
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org,
        Fengguang Wu <fengguang.wu@intel.com>,
        linux-api@vger.kernel.org
Subject: [PATCH v4 1/4] s390: Use _refcount for pgtables
Date: Thu,  1 Mar 2018 13:15:20 -0800
Message-Id: <20180301211523.21104-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180301211523.21104-1-willy@infradead.org>
References: <20180301211523.21104-1-willy@infradead.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

s390 borrows the storage used for _mapcount in struct page in order to
account whether the bottom or top half is being used for 2kB page
tables.  I want to use that for something else, so use the top byte of
_refcount instead of the bottom byte of _mapcount.  _refcount may
temporarily be incremented by other CPUs that see a stale pointer to
this page in the page cache, but each CPU can only increment it by one,
and there are no systems with 2^24 CPUs today, so they will not change
the upper byte of _refcount.  We do have to be a little careful not to
lose any of their writes (as they will subsequently decrement the
counter).

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/mm/pgalloc.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index cb364153c43c..412c5f48a8e7 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -189,14 +189,15 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 		if (!list_empty(&mm->context.pgtable_list)) {
 			page = list_first_entry(&mm->context.pgtable_list,
 						struct page, lru);
-			mask = atomic_read(&page->_mapcount);
+			mask = atomic_read(&page->_refcount) >> 24;
 			mask = (mask | (mask >> 4)) & 3;
 			if (mask != 3) {
 				table = (unsigned long *) page_to_phys(page);
 				bit = mask & 1;		/* =1 -> second 2K */
 				if (bit)
 					table += PTRS_PER_PTE;
-				atomic_xor_bits(&page->_mapcount, 1U << bit);
+				atomic_xor_bits(&page->_refcount,
+							1U << (bit + 24));
 				list_del(&page->lru);
 			}
 		}
@@ -217,12 +218,12 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	table = (unsigned long *) page_to_phys(page);
 	if (mm_alloc_pgste(mm)) {
 		/* Return 4K page table with PGSTEs */
-		atomic_set(&page->_mapcount, 3);
+		atomic_xor_bits(&page->_refcount, 3 << 24);
 		memset64((u64 *)table, _PAGE_INVALID, PTRS_PER_PTE);
 		memset64((u64 *)table + PTRS_PER_PTE, 0, PTRS_PER_PTE);
 	} else {
 		/* Return the first 2K fragment of the page */
-		atomic_set(&page->_mapcount, 1);
+		atomic_xor_bits(&page->_refcount, 1 << 24);
 		memset64((u64 *)table, _PAGE_INVALID, 2 * PTRS_PER_PTE);
 		spin_lock_bh(&mm->context.lock);
 		list_add(&page->lru, &mm->context.pgtable_list);
@@ -241,7 +242,8 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 		/* Free 2K page table fragment of a 4K page */
 		bit = (__pa(table) & ~PAGE_MASK)/(PTRS_PER_PTE*sizeof(pte_t));
 		spin_lock_bh(&mm->context.lock);
-		mask = atomic_xor_bits(&page->_mapcount, 1U << bit);
+		mask = atomic_xor_bits(&page->_refcount, 1U << (bit + 24));
+		mask >>= 24;
 		if (mask & 3)
 			list_add(&page->lru, &mm->context.pgtable_list);
 		else
@@ -252,7 +254,6 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 	}
 
 	pgtable_page_dtor(page);
-	atomic_set(&page->_mapcount, -1);
 	__free_page(page);
 }
 
@@ -273,7 +274,8 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 	}
 	bit = (__pa(table) & ~PAGE_MASK) / (PTRS_PER_PTE*sizeof(pte_t));
 	spin_lock_bh(&mm->context.lock);
-	mask = atomic_xor_bits(&page->_mapcount, 0x11U << bit);
+	mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
+	mask >>= 24;
 	if (mask & 3)
 		list_add_tail(&page->lru, &mm->context.pgtable_list);
 	else
@@ -295,12 +297,13 @@ static void __tlb_remove_table(void *_table)
 		break;
 	case 1:		/* lower 2K of a 4K page table */
 	case 2:		/* higher 2K of a 4K page table */
-		if (atomic_xor_bits(&page->_mapcount, mask << 4) != 0)
+		mask = atomic_xor_bits(&page->_refcount, mask << (4 + 24));
+		mask >>= 24;
+		if (mask != 0)
 			break;
 		/* fallthrough */
 	case 3:		/* 4K page table with pgstes */
 		pgtable_page_dtor(page);
-		atomic_set(&page->_mapcount, -1);
 		__free_page(page);
 		break;
 	}
-- 
2.16.1

