Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3216954-1521211360-2-8930707649336736930
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='jp',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521211359; b=dXLvMivFQO4qQXJYbqYQSTi7dWZLgOQP/cXKcG3ODXigvDR
    dNd/PogW662DrZGGFfuVluyERylEpv/HV78LSxZb35tEN2yHfwEuDm32Ti798R4F
    xz1tH3ozmYoAmS8dONTyikTjzk/l6Ub7hS47XCA0HNPrrwNO+KgTdXBRsCLwkiM8
    FS5xY1W0C+PV5YC3g70oy2qGiZ6dpwwgRKbzy4dfghgHCNHapGGrnwD/ZERhg45e
    uzQ8S3bco9yVhwqa5pzUk4sUZAMetHUTbwGfMp+smiAJBGAqWDz8y8K2muOqV43h
    sKIgK/uP7zZstMKMJUakLTmH5ZW/k9h8aut2wMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:subject:from:references:in-reply-to
    :message-id:date:mime-version:content-type:sender:list-id; s=
    arctest; t=1521211359; bh=R7wkcWSLrenkyOgXS5DOXp8qdTv8ewN27vJuvM
    /RI5g=; b=mb+Tz6SdKJditjLnfmWovGM+clNynF8ryXSh/bAZYW70qu9QRlfGUG
    vOc3GHkgSNuEGQz3NynkY7nqr1pjHDj/Mi9JmEhFmNJoN4gs8YyQbzAI08kc01uh
    MgV2XRE16lDfdgDkCELn8zmNPGgUFRGIzLimwKB9oBTOX5SuVE0Obwl7tmnop91L
    iXFc53JLznNmgAu9mh5R2uu2qdDG3kxVmBje9ocThDOz5TJ+bR87PqcXsq9RVMRS
    U4s/4MIUdyd31oV3CWVnDhyJD7YBqG9kTIiiTjma0yehHFVw0m/seBLSnKkY7dAl
    TDPAdPmlwwOm/CJsjoa2p74m50nJJzRQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=i-love.sakura.ne.jp header.result=pass header_org.domain=sakura.ne.jp header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=i-love.sakura.ne.jp header.result=pass header_org.domain=sakura.ne.jp header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeCPOmi (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 10:42:38 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61938 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752875AbeCPOmi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 10:42:38 -0400
To: kirill@shutemov.name
Cc: mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@lists.ewheeler.net
Subject: Re: [PATCH] mm/shmem: Do not wait for lock_page() in shmem_unused_huge_shrink()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180316122508.fv4edpx34hdqybwx@node.shutemov.name>
        <20180316125827.GC11461@dhcp22.suse.cz>
        <20180316130200.rbke66zjyoc6zwzl@node.shutemov.name>
        <201803162214.ECJ30715.StOOFHOFVLJMQF@I-love.SAKURA.ne.jp>
        <20180316133417.hk2lvnvgildsc65n@node.shutemov.name>
In-Reply-To: <20180316133417.hk2lvnvgildsc65n@node.shutemov.name>
Message-Id: <201803162342.IJD26023.MHJQFOOFLFStVO@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Fri, 16 Mar 2018 23:42:24 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Kirill A. Shutemov wrote:

> On Fri, Mar 16, 2018 at 10:14:24PM +0900, Tetsuo Handa wrote:
> > f2fs is doing
> > 
> >   page = f2fs_pagecache_get_page(inode->i_mapping, 0, FGP_LOCK|FGP_NOWAIT, 0);
> > 
> > which calls
> > 
> >   struct page *pagecache_get_page(inode->i_mapping, 0, FGP_LOCK|FGP_NOWAIT, 0);
> > 
> > . Then, can't we define
> > 
> >   static inline struct page *find_trylock_page(struct address_space *mapping,
> >   					     pgoff_t offset)
> >   {
> >   	return pagecache_get_page(mapping, offset, FGP_LOCK|FGP_NOWAIT, 0);
> >   }
> > 
> > and replace find_lock_page() with find_trylock_page() ?
> 
> This won't work in this case. We need to destinct no-page-in-page-cache
> from failed-to-lock-page. We take different routes depending on this.
> 

OK. Then, I think we should avoid reordering trylock_page() and PageTransHuge()
without patch description why it is safe. Below patch preserves the ordering
and sounds safer for stable. But either patch, please add why it is safe to omit
"/* Has the page been truncated? */" check which would have been done for FGP_LOCK
in patch description.

---
 mm/shmem.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 8ead6cb..5e94ca4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -493,16 +493,27 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
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
+		/* No huge page at the end of the file: nothing to split */
 		if (!PageTransHuge(page)) {
 			unlock_page(page);
 			put_page(page);
@@ -513,16 +524,15 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
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
