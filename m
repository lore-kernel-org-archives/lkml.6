Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3921380-1521234524-2-6542388524401925707
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521234524; b=K1Bda8yMMUTEpK3tQT/iKhUPZW2j+ld5PsivRPnKmJ7QU7c
    iO+UMOE3bRJs0mxvWt03GtS5hEhwMsUIBXzlC3rCuRgM6GJQr12faEi632jwIfGP
    KMXLDND5UmdvGdRa1IhZhExnV1KIywRCrU3IIHQGigJ/JhfgKvpZ4IrLpNYlx3mc
    kKtOXzQOkMVp3jFY/qOBetdUrpDaui4ZozPjaxnWWfDWVWmJcOKQt/pNKIK2lj4X
    65yTQWF7wUUdmpBAU12qgDAMxbTOBShyA7d/iIjc+YusCXiDs/1NIhd2loq5jxnr
    qwf5UDXmlt3PDsEuYYYx2EA8+5Cz/75STBoMLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521234524; bh=JyZLku324xsmIyw7zYw1Alow6J
    Pylmgg6aJrzMgpnus=; b=X0J7mYfHndpWxBlDVHkXyPaBc2MIfMnVDLs4Ff6HG5
    7vn5BKP7Tl9yDgN9elenlCjEghlAqfooj2Ca4igJVKTv6XFoGi25VkVZLMExxYz5
    /erH1NQsxsLHjYqYX/l95QTU/4fsVPJZ7GsHyNcSiLSdSXBr4KAaocwcIlWnh1IR
    qbIqlkfrGzywYV8SBMR0nRBZDatMrJCHRN5XAXWddbtq0Er0HXJYjyXPI7Ro5o2X
    8wv0H13zgeaXidQ032kpyDkHMg93greldgWkKx/hEYm+fnrVXqAiG5dKL09uDmXc
    gD4q3iWFPn6RXoss7b3Ys39XFrL94EgTyiCR6TLK0eVA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750826AbeCPVIj (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 17:08:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:22081 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbeCPVIi (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Mar 2018 17:08:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="212069018"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
        Eric Wheeler <linux-mm@lists.ewheeler.net>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCHv2] mm/shmem: Do not wait for lock_page() in shmem_unused_huge_shrink()
Date: Sat, 17 Mar 2018 00:08:30 +0300
Message-Id: <20180316210830.43738-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

shmem_unused_huge_shrink() gets called from reclaim path. Waiting for page
lock may lead to deadlock there.

There was a bug report that may be attributed to this:

http://lkml.kernel.org/r/alpine.LRH.2.11.1801242349220.30642@mail.ewheeler.net

Replace lock_page() with trylock_page() and skip the page if we failed
to lock it. We will get to the page on the next scan.

We can test for the PageTransHuge() outside the page lock as we only
need protection against splitting the page under us. Holding pin oni
the page is enough for this.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reported-by: Eric Wheeler <linux-mm@lists.ewheeler.net>
Fixes: 779750d20b93 ("shmem: split huge pages beyond i_size under memory pressure")
Cc: stable@vger.kernel.org # v4.8+
---
 mm/shmem.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 1907688b75ee..b85919243399 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -493,36 +493,45 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		info = list_entry(pos, struct shmem_inode_info, shrinklist);
 		inode = &info->vfs_inode;
 
-		if (nr_to_split && split >= nr_to_split) {
-			iput(inode);
-			continue;
-		}
+		if (nr_to_split && split >= nr_to_split)
+			goto leave;
 
-		page = find_lock_page(inode->i_mapping,
+		page = find_get_page(inode->i_mapping,
 				(inode->i_size & HPAGE_PMD_MASK) >> PAGE_SHIFT);
 		if (!page)
 			goto drop;
 
+		/* No huge page at the end of the file: nothing to split */
 		if (!PageTransHuge(page)) {
-			unlock_page(page);
 			put_page(page);
 			goto drop;
 		}
 
+		/*
+		 * Leave the inode on the list if we failed to lock
+		 * the page at this time.
+		 *
+		 * Waiting for the lock may lead to deadlock in the
+		 * reclaim path.
+		 */
+		if (!trylock_page(page)) {
+			put_page(page);
+			goto leave;
+		}
+
 		ret = split_huge_page(page);
 		unlock_page(page);
 		put_page(page);
 
-		if (ret) {
-			/* split failed: leave it on the list */
-			iput(inode);
-			continue;
-		}
+		/* If split failed leave the inode on the list */
+		if (ret)
+			goto leave;
 
 		split++;
 drop:
 		list_del_init(&info->shrinklist);
 		removed++;
+leave:
 		iput(inode);
 	}
 
-- 
2.16.1
