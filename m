Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeFCDYP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 23:24:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750931AbeFCDYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 23:24:14 -0400
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH] slab: Clean up the code comment in slab kmem_cache struct
Date: Sun,  3 Jun 2018 11:24:02 +0800
Message-Id: <20180603032402.27526-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit

  3b0efdfa1e7("mm, sl[aou]b: Extract common fields from struct kmem_cache")

The variable 'obj_size' was moved above, however the related code comment
is not updated accordingly. Do it here.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/slab_def.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index d9228e4d0320..3485c58cfd1c 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -67,9 +67,10 @@ struct kmem_cache {
 
 	/*
 	 * If debugging is enabled, then the allocator can add additional
-	 * fields and/or padding to every object. size contains the total
-	 * object size including these internal fields, the following two
-	 * variables contain the offset to the user object and its size.
+	 * fields and/or padding to every object. 'size' contains the total
+	 * object size including these internal fields, while 'obj_offset'
+	 * and 'object_size' contain the offset to the user object and its
+	 * size.
 	 */
 	int obj_offset;
 #endif /* CONFIG_DEBUG_SLAB */
-- 
2.13.6
