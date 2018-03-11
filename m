Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932170AbeCKMZk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 08:25:40 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41412 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932126AbeCKMZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 08:25:38 -0400
X-Google-Smtp-Source: AG47ELvVt2LuUWrlycBsJ1j+u9kQ7M6QB/57Goqy+Jsli7q2zDm2M1Ws3IeZ3KhxMWlpuySZaD9VVg==
From: Roman Lakeev <sunnyddayss@gmail.com>
Cc: Roman Lakeev <sunnyddayss@gmail.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slab.c: remove duplicated check of colour_next
Date: Sun, 11 Mar 2018 15:25:34 +0300
Message-ID: <87bmfulry9.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Sun, 11 Mar 2018 11:05:29 +0300
Signed-off-by: Roman Lakeev <sunnyddayss@gmail.com>
remove check that offset greater than cachep->colour
bacause this is already checked in previous lines

---
 mm/slab.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 324446621b3e..6a48f122bd82 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2674,11 +2674,7 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
 	if (n->colour_next >= cachep->colour)
 		n->colour_next = 0;
 
-	offset = n->colour_next;
-	if (offset >= cachep->colour)
-		offset = 0;
-
-	offset *= cachep->colour_off;
+	offset = n->colour_next * cachep->colour_off;
 
 	/* Get slab management. */
 	freelist = alloc_slabmgmt(cachep, page, offset,
-- 
2.16.2
