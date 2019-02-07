Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D61C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C028B21904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfBGTLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:11:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfBGTLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:11:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48CFB3DE0E;
        Thu,  7 Feb 2019 19:11:18 +0000 (UTC)
Received: from redhat.com (ovpn-123-55.rdu2.redhat.com [10.10.123.55])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2D07063F61;
        Thu,  7 Feb 2019 19:11:17 +0000 (UTC)
Date:   Thu, 7 Feb 2019 14:11:16 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org
Subject: [PATCH] mm/page_poison: update comment after code moved
Message-ID: <20190207191113.14039-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 07 Feb 2019 19:11:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm/debug-pagealloc.c is no more, so of course header now needs to be
updated. This seems like something checkpatch should be
able to catch - worth looking into?

Cc: trivial@kernel.org
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org
Fixes: 8823b1dbc05f ("mm/page_poison.c: enable PAGE_POISONING as a separate option")
---
 include/linux/poison.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/poison.h b/include/linux/poison.h
index 15927ebc22f2..5046bad0c1c5 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -30,7 +30,7 @@
  */
 #define TIMER_ENTRY_STATIC	((void *) 0x300 + POISON_POINTER_DELTA)
 
-/********** mm/debug-pagealloc.c **********/
+/********** mm/page_poison.c **********/
 #ifdef CONFIG_PAGE_POISONING_ZERO
 #define PAGE_POISON 0x00
 #else
-- 
MST
