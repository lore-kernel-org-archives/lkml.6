Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2980787-1525375552-2-8752529380275097413
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525375552; b=DbRBEEijyZOKV11i69+wE0IvxKtdM/1m4ZhcXXzTI6lXzm/oSe
    IKmJHHQHEQVu6JAJ458NrHrOlg/OxTBUv1WCGnMAWXlorX67NOqEoMfyia0VWpX5
    CV7sAUjp9oUo4sZWRgaqMFDsyphTR6unCNtgLQUqdAZf6gYwpGDC6IE8FsAxpslq
    +AYYiIebQnJUYOBXErK/lAgF8l7oZtQwTCJjo9HGsNm0ftpunElCMzWFiovSZmce
    DfeeH/hNPuchGiykJSXFSFc7Ua0Mw98d1JmYT0Iuz7cfACBmIXSfItfrTBGDkUA0
    lpBLszKVrnb1pbBX4qyhm8UtxBaQuvwQOALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525375552; bh=
    gToRSOZaTFIbxwSLZgVdCWJZ+QQO4S8xJGeNOt3hbzU=; b=C0ec16mwzH3WtXu6
    438KfFX5DEQrqdzQ85/XhJhEkf72SZ3jazd62x/2f2+LaTcD3Z45NDxFkCQS4aaB
    0Ome4CORQCz6MhvF5h/Y5YF+0mfnMtWjQGDnSW/Fdw3VB7a3LsSDWCKawK36s5De
    i6wUTd4KLlbejusCzKOPIhwS8yt9ZjnjCPUk+z3EpGP60gE2Gi3OWUEsKtq+rT/z
    2K2XO5nzh9tU0WaYACqlkjkdr94CPfzrfH9deLG8W5EBUEcCll2bbxa3Zp2B+idv
    GqJn7I1OJrJLPQ2FsHdgsMTGjgT+txp063asB/1b9WrZtRteD2VKfaLAjLqX7y97
    PdJ8Ag==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG/+tT30qWvcQZ9QmVXVRjF263xshtyZtPHZhFYNT1+YgDDhGhHixFGGWVv0SCN2NTZCmcYjjWbj5FdQTvfialMLhpmgNvc++bUHuo1hQe5gSwx3Cd84
    cqWxDf7Bv+3UUXFS9unXT6cCtIDiFpYWBty82TKI33rGaIRwUW4/MXNMnUrLs61N3XAmNDodR+IDBXPARtM46TiyqRkGy+l70isv/9Pnt0xsaMmMGurlgir8
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=reC6arp316tXTA_nZF4A:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751653AbeECTY5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 15:24:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:8165 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751316AbeECTYh (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 3 May 2018 15:24:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,359,1520924400";
   d="scan'208";a="225573205"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm@lists.01.org, stable@vger.kernel.org
Subject: [PATCH 5/5] radix tree: fix multi-order iteration race
Date: Thu,  3 May 2018 13:24:30 -0600
Message-Id: <20180503192430.7582-6-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
References: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix a race in the multi-order iteration code which causes the kernel to hit
a GP fault.  This was first seen with a production v4.15 based kernel
(4.15.6-300.fc27.x86_64) utilizing a DAX workload which used order 9 PMD
DAX entries.

The race has to do with how we tear down multi-order sibling entries when
we are removing an item from the tree.  Remember for example that an order
2 entry looks like this:

struct radix_tree_node.slots[] = [entry][sibling][sibling][sibling]

where 'entry' is in some slot in the struct radix_tree_node, and the three
slots following 'entry' contain sibling pointers which point back to
'entry.'

When we delete 'entry' from the tree, we call :
  radix_tree_delete()
    radix_tree_delete_item()
      __radix_tree_delete()
        replace_slot()

replace_slot() first removes the siblings in order from the first to the
last, then at then replaces 'entry' with NULL.  This means that for a brief
period of time we end up with one or more of the siblings removed, so:

struct radix_tree_node.slots[] = [entry][NULL][sibling][sibling]

This causes an issue if you have a reader iterating over the slots in the
tree via radix_tree_for_each_slot() while only under
rcu_read_lock()/rcu_read_unlock() protection.  This is a common case in
mm/filemap.c.

The issue is that when __radix_tree_next_slot() => skip_siblings() tries to
skip over the sibling entries in the slots, it currently does so with an
exact match on the slot directly preceding our current slot.  Normally this
works:
                                    V preceding slot
struct radix_tree_node.slots[] = [entry][sibling][sibling][sibling]
                                            ^ current slot

This lets you find the first sibling, and you skip them all in order.

But in the case where one of the siblings is NULL, that slot is skipped and
then our sibling detection is interrupted:

                                           V preceding slot
struct radix_tree_node.slots[] = [entry][NULL][sibling][sibling]
                                                  ^ current slot

This means that the sibling pointers aren't recognized since they point all
the way back to 'entry', so we think that they are normal internal radix
tree pointers.  This causes us to think we need to walk down to a struct
radix_tree_node starting at the address of 'entry'.

In a real running kernel this will crash the thread with a GP fault when
you try and dereference the slots in your broken node starting at 'entry'.

We fix this race by fixing the way that skip_siblings() detects sibling
nodes.  Instead of testing against the preceding slot we instead look for
siblings via is_sibling_entry() which compares against the position of the
struct radix_tree_node.slots[] array.  This ensures that sibling entries
are properly identified, even if they are no longer contiguous with the
'entry' they point to.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Reported-by: CR, Sapthagirish <sapthagirish.cr@intel.com>
Fixes: commit 148deab223b2 ("radix-tree: improve multiorder iterators")
Cc: <stable@vger.kernel.org>
---
 lib/radix-tree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index da9e10c827df..43e0cbedc3a0 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1612,11 +1612,9 @@ static void set_iter_tags(struct radix_tree_iter *iter,
 static void __rcu **skip_siblings(struct radix_tree_node **nodep,
 			void __rcu **slot, struct radix_tree_iter *iter)
 {
-	void *sib = node_to_entry(slot - 1);
-
 	while (iter->index < iter->next_index) {
 		*nodep = rcu_dereference_raw(*slot);
-		if (*nodep && *nodep != sib)
+		if (*nodep && !is_sibling_entry(iter->node, *nodep))
 			return slot;
 		slot++;
 		iter->index = __radix_tree_iter_add(iter, 1);
@@ -1631,7 +1629,7 @@ void __rcu **__radix_tree_next_slot(void __rcu **slot,
 				struct radix_tree_iter *iter, unsigned flags)
 {
 	unsigned tag = flags & RADIX_TREE_ITER_TAG_MASK;
-	struct radix_tree_node *node = rcu_dereference_raw(*slot);
+	struct radix_tree_node *node;
 
 	slot = skip_siblings(&node, slot, iter);
 
-- 
2.14.3
