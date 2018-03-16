Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2753674-1521197977-8-11341974085285857256
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
    t=1521197976; b=cNKR42BAsXO1a7rbLwqhZtgUuLD3vsBMJPi8zQ0qDPuzgwH
    Vj4eP37gqCSWuq2UKDPvqQFsexSjoLY4ITUGUpVpdynF86X4qFLgWE7vFSV0X1jF
    4G29zP8cbpm8t3BGHMDRoBPP56Ks0VHn+Bh6779GqdyN3jwErE8hOYFCglxqezGV
    rAv80sxc9bEX3Uk+FgUleR3ZNTaMb7D/+jalgs/R8ifxP6d96v9Wmh3BiMPPpfge
    JjF6og8HcoODHXKFC+823leyrVw/gUm86BzYZpaZdWvq7LYdbq/NIfQeXNROGCXH
    z09GaOBVbN/N9mSnNIiFqpzu8WljLgWZLJtjEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521197976; bh=FGGMy1WPRLDf3bFOjvAYCewjjF
    YprfARJaehZR45ZSQ=; b=rW4Z+TBGKGRlzD7FLK4iQSI68YxBDXkseUVR4J0eZl
    ck+b5jq+w5Iwmpx1A2q5JlRoJSGLRi9kTqswihVZ4vZ+WGLErl+Deyr68C9NWzul
    dvbU1GAr08QvThSUzSzLmhppSWgq4Flup5r+g0VyRWCNnVdKIHPaj3OkUcUfW7kB
    Wtw3sXRUzlKPetHIf20twBro5BK4Md2MppXreleLcZbdn9kP87g5FE/KUIXg5rl/
    AFcurmzS6+HoFdbFMWu6aCRrkf4Z3myYrjco1wDiGTFJJTzr4IHmYA5ifCqdMbS/
    mvLSEFVbOgva+MTpF4lvzWkbYT9/uG+KZXEU2w33I/qg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
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
        id S1753460AbeCPK7b (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 06:59:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:59582 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753368AbeCPK7a (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Mar 2018 06:59:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,315,1517904000";
   d="scan'208";a="42566577"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH] mm/shmem: Do not wait for lock_page() in shmem_unused_huge_shrink()
Date: Fri, 16 Mar 2018 13:59:08 +0300
Message-Id: <20180316105908.62516-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

shmem_unused_huge_shrink() gets called from reclaim path. Waiting for page
lock may lead to deadlock there.

Replace lock_page() with trylock_page() and skip the page if we failed
to lock it. We will get to the page on the next scan.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 779750d20b93 ("shmem: split huge pages beyond i_size under memory pressure")
Cc: stable@vger.kernel.org # v4.8+
---
 mm/shmem.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 1907688b75ee..2afe809d4bd4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -498,31 +498,42 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 			continue;
 		}
 
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
