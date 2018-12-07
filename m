Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AEBC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B727920837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B727920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbeLGPq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:46:27 -0500
Received: from relay.sw.ru ([185.231.240.75]:60908 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeLGPq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:46:27 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gVIKe-00058l-CG; Fri, 07 Dec 2018 18:46:24 +0300
Subject: [PATCH] mm: Remove useless check in pagecache_get_page()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, gorcunov@virtuozzo.com,
        ktkhai@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 Dec 2018 18:46:24 +0300
Message-ID: <154419752044.18559.2452963074922917720.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page always is not NULL, so we may remove this useless check.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/filemap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b1165a311a1f..5da9ce090898 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1601,7 +1601,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 		VM_BUG_ON_PAGE(page->index != offset, page);
 	}
 
-	if (page && (fgp_flags & FGP_ACCESSED))
+	if (fgp_flags & FGP_ACCESSED)
 		mark_page_accessed(page);
 
 no_page:

