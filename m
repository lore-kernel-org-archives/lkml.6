Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405802-2-10950602451143630241
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
    1524405801; b=Lnw0bOZv3hoT4IAVgT9Cw6DkhAqer/9YC83hn/Dcw4FJQ5ViXl
    yhxEPPi1owOhpSXMhrPsdscVWsMi5bL7zyHJ9OoyFkn+7//biP4FXvAnc99L1d3k
    AjyJoh8CQ4YxQYNTipiWOXtQI0LRLpCYCvGLPvFBBL+RYiao1FHv9Zm9xLwUvj7S
    AbWRCXUamqsJZeOz86PSg6I4N8a5m6CDYRke6JF77lPvmvmu2oKFKlCDDPu3qlnb
    X+2k1LoYloAB3OXijVkoVjXAPB0dZcODBD4RM5UWTAfQtxNisdpCXMClXF1s2HNE
    YV157FGMXBY/zbww8EufbZZeVxPbxrv/qiqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405801; bh=czyq5tsiOhp1IR6VOgnCJyi7X5hnnr
    PQE09TQMstQts=; b=OHzj8YTrgtWpnMbrvktrhgInegBG2MfqDvHeqYg+Uc6Y5M
    iHOYni5+6wZA9zm3tRK/+BHc5MFDswb7+ipgU01ToeuVZ/KxE/MPSvSUq6Hem72A
    +/89o5tb/Gg/ucXKej27TpXT5VCW6Nry1M8nwY1qe7tHOmA7EUY7s2FtorLlbkbE
    P9A0rb29XF0rI55M5K38kAGo/hR0I8vBmws1F+opCWGDkdIu+yWbyGFwxjcArj5v
    ic/215NhZCND47W1RHZUR91yXDzdz3pE26gve47uY9kfpkJccXbvt0DFWlz1j9Po
    j3zKntI6nHOXFtpsT5g+qMmy3gx4vX8a2FXWEUcA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfCpf25bBswaxF9BBe2SGZSgonqL0nLyeQpH2KwQHsme3VB2sOHUKDMwv7BU9/nPMD032sGXeDhqXnU4iy5XFXg3rfMH102+UAQwjgiLUWDGAhSqYOR84
    sCJGj7CmUSFY0hjTiEoBu5c7w+KrAO+1u3o4qR6HB6cThONpMrsbQpXmENnloJ7plUoorAicmEoc+Q7lIQGewwlmLCk7XKQXO8E58xZbQaPVKU5kQ4jlMTMe
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=1XWaLZrsAAAA:8
    a=ufHFDILaAAAA:8 a=iox4zFpeAAAA:8 a=Z4Rwk6OoAAAA:8 a=ag1SF4gXAAAA:8
    a=RAu74iQbZOYIzub1VMsA:9 a=pU91lvWdBSU1PCEG:21 a=ftz2M-u5kwRwzFf1:21
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=ZmIg1sZ3JBWsdXgziEIF:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755002AbeDVODL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:03:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49044 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754956AbeDVODH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:03:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Chris Fries <cfries@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 193/196] mm/filemap.c: fix NULL pointer in page_cache_tree_insert()
Date: Sun, 22 Apr 2018 15:53:33 +0200
Message-Id: <20180422135114.264827978@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox <mawilcox@microsoft.com>

commit abc1be13fd113ddef5e2d807a466286b864caed3 upstream.

f2fs specifies the __GFP_ZERO flag for allocating some of its pages.
Unfortunately, the page cache also uses the mapping's GFP flags for
allocating radix tree nodes.  It always masked off the __GFP_HIGHMEM
flag, and masks off __GFP_ZERO in some paths, but not all.  That causes
radix tree nodes to be allocated with a NULL list_head, which causes
backtraces like:

  __list_del_entry+0x30/0xd0
  list_lru_del+0xac/0x1ac
  page_cache_tree_insert+0xd8/0x110

The __GFP_DMA and __GFP_DMA32 flags would also be able to sneak through
if they are ever used.  Fix them all by using GFP_RECLAIM_MASK at the
innermost location, and remove it from earlier in the callchain.

Link: http://lkml.kernel.org/r/20180411060320.14458-2-willy@infradead.org
Fixes: 449dd6984d0e ("mm: keep page cache radix tree nodes in check")
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Reported-by: Chris Fries <cfries@google.com>
Debugged-by: Minchan Kim <minchan@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/filemap.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -785,7 +785,7 @@ int replace_page_cache_page(struct page
 	VM_BUG_ON_PAGE(!PageLocked(new), new);
 	VM_BUG_ON_PAGE(new->mapping, new);
 
-	error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
+	error = radix_tree_preload(gfp_mask & GFP_RECLAIM_MASK);
 	if (!error) {
 		struct address_space *mapping = old->mapping;
 		void (*freepage)(struct page *);
@@ -841,7 +841,7 @@ static int __add_to_page_cache_locked(st
 			return error;
 	}
 
-	error = radix_tree_maybe_preload(gfp_mask & ~__GFP_HIGHMEM);
+	error = radix_tree_maybe_preload(gfp_mask & GFP_RECLAIM_MASK);
 	if (error) {
 		if (!huge)
 			mem_cgroup_cancel_charge(page, memcg, false);
@@ -1584,8 +1584,7 @@ no_page:
 		if (fgp_flags & FGP_ACCESSED)
 			__SetPageReferenced(page);
 
-		err = add_to_page_cache_lru(page, mapping, offset,
-				gfp_mask & GFP_RECLAIM_MASK);
+		err = add_to_page_cache_lru(page, mapping, offset, gfp_mask);
 		if (unlikely(err)) {
 			put_page(page);
 			page = NULL;
@@ -2388,7 +2387,7 @@ static int page_cache_read(struct file *
 		if (!page)
 			return -ENOMEM;
 
-		ret = add_to_page_cache_lru(page, mapping, offset, gfp_mask & GFP_KERNEL);
+		ret = add_to_page_cache_lru(page, mapping, offset, gfp_mask);
 		if (ret == 0)
 			ret = mapping->a_ops->readpage(file, page);
 		else if (ret == -EEXIST)
