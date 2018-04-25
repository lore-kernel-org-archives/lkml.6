Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524652921-2-9233274967741981264
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524652920; b=JEqoqf1utrEz+riUpHANw0UhSMLoARU3fol3lJPLqZK6Cyx6xP
    iQknSnv3x+mX3h6a0hi8TRnuk3Pxc5BrHhvy3/6Oqh7VRHF9rCHjCuWtDYhpd4TB
    gMhI0Etwp8/KMx2xr/3kr9GIgc7raz6J2DScl81SgzRgal94vLgntMzY/qm+F4Gt
    oefZoPgAVcQpwn4jO1/HPpLhGaaUXLH43NPuQHOgAlyR39FHWoYRZphmSFJRkajX
    iew2By/qlpogJgg6xS3rjy0omvUEW/yPbNcdx6tIdBW5QI0SRl0jS18a9E7KZu5B
    XEnHCBepI3lWdAVFmdQzotlrnPaOZ/De9P1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652920; bh=rYUe9nOmWzHRIhgKzaAudF9HBjIOaS
    yunqcSpMkP+0I=; b=k+/nLQvps1gXmM4/1PodeRrfST4J1jYpjAy+CwvdKvlR7Z
    Pu0mftwxiqOkogi7sgGFMKOBzc+CYVL4DmHgE67sx7c6Axb6Eq4MsXlc5ufT0PTn
    KZWDWBuiWBChGNLOYJh3HmVAWTLWNxu9h8myfPZfr/pK4B62kl2JnHvkPzmKYc2C
    zlytAqByuaWnfGa3m8hvXh1mJDAw4FI8lp6Nb8gnW2o1DZe9zPkl7UjE3Kq1HnOB
    oQmbnd/ubqIEZQIwz/4W1zWCcWJ+ZwsAQtZjBrONeQZ98YSUokmNfl5gk++Qwi6X
    OTjm83GrZ/YraPghOnUMHnvjXmePsXeOL8qYFZOA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMVQ8yLpuAFNY/DfBRo97djZ1DRfydD4Un0LH6VKHCW9f5Og8QGL7CW4O38PTlJrT6yVdi2t03tZnEAG2lp/2PP28xpOv/5W3A9Um9vmEMWG8yvAMNVK
    PxycyAoLhUxAmFk65zuwNW5vyorwQZNojcmlWwvDCnLZPbiWOTfSA+KsRocWWeC/0DapiN7Zw6pSBWZ+kX2uY+Qu20t1DF69jZ3p2XHuovovn7wMQt6EeVWF
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=R_Myd5XaAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=5UkYvFHTB3ZtRazDmScA:9
    a=QQjlOQC_lGHXFNI9:21 a=PpsJL_Hv1cbKN3Jj:21 a=QEXdDO2ut3YA:10
    a=L2g4Dz8VuBQ37YGmWQah:22 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753846AbeDYKl5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:41:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753997AbeDYKlx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:41:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>,
        Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 116/183] mm: pin address_space before dereferencing it while isolating an LRU page
Date: Wed, 25 Apr 2018 12:35:36 +0200
Message-Id: <20180425103247.100550727@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mel Gorman <mgorman@techsingularity.net>


[ Upstream commit 69d763fc6d3aee787a3e8c8c35092b4f4960fa5d ]

Minchan Kim asked the following question -- what locks protects
address_space destroying when race happens between inode trauncation and
__isolate_lru_page? Jan Kara clarified by describing the race as follows

CPU1                                            CPU2

truncate(inode)                                 __isolate_lru_page()
  ...
  truncate_inode_page(mapping, page);
    delete_from_page_cache(page)
      spin_lock_irqsave(&mapping->tree_lock, flags);
        __delete_from_page_cache(page, NULL)
          page_cache_tree_delete(..)
            ...                                   mapping = page_mapping(page);
            page->mapping = NULL;
            ...
      spin_unlock_irqrestore(&mapping->tree_lock, flags);
      page_cache_free_page(mapping, page)
        put_page(page)
          if (put_page_testzero(page)) -> false
- inode now has no pages and can be freed including embedded address_space

                                                  if (mapping && !mapping->a_ops->migratepage)
- we've dereferenced mapping which is potentially already free.

The race is theoretically possible but unlikely.  Before the
delete_from_page_cache, truncate_cleanup_page is called so the page is
likely to be !PageDirty or PageWriteback which gets skipped by the only
caller that checks the mappping in __isolate_lru_page.  Even if the race
occurs, a substantial amount of work has to happen during a tiny window
with no preemption but it could potentially be done using a virtual
machine to artifically slow one CPU or halt it during the critical
window.

This patch should eliminate the race with truncation by try-locking the
page before derefencing mapping and aborting if the lock was not
acquired.  There was a suggestion from Huang Ying to use RCU as a
side-effect to prevent mapping being freed.  However, I do not like the
solution as it's an unconventional means of preserving a mapping and
it's not a context where rcu_read_lock is obviously protecting rcu data.

Link: http://lkml.kernel.org/r/20180104102512.2qos3h5vqzeisrek@techsingularity.net
Fixes: c82449352854 ("mm: compaction: make isolate_lru_page() filter-aware again")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Minchan Kim <minchan@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmscan.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1436,14 +1436,24 @@ int __isolate_lru_page(struct page *page
 
 		if (PageDirty(page)) {
 			struct address_space *mapping;
+			bool migrate_dirty;
 
 			/*
 			 * Only pages without mappings or that have a
 			 * ->migratepage callback are possible to migrate
-			 * without blocking
+			 * without blocking. However, we can be racing with
+			 * truncation so it's necessary to lock the page
+			 * to stabilise the mapping as truncation holds
+			 * the page lock until after the page is removed
+			 * from the page cache.
 			 */
+			if (!trylock_page(page))
+				return ret;
+
 			mapping = page_mapping(page);
-			if (mapping && !mapping->a_ops->migratepage)
+			migrate_dirty = mapping && mapping->a_ops->migratepage;
+			unlock_page(page);
+			if (!migrate_dirty)
 				return ret;
 		}
 	}
