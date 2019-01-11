Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87833C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E5F20652
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lRAtrcLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389621AbfAKSFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:05:43 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44190 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733173AbfAKSFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:05:38 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BI5WX5067738;
        Fri, 11 Jan 2019 12:05:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547229932;
        bh=gzuEnEsPaQcZK2oODLbGLwXYQUoHuT21tgLVqTniWPY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lRAtrcLfJ6Q3KExkcFglz+YVZvMzEKCy7mgl+yZvZpx3DmuCbjiupJVybg5Tz+Wk+
         q1GLLHU47HYINk8uxaqE7N1tyKFhS1TX0Cj1Z9TrC6ubihzF9A0zSePt0ZnrsF3PqT
         Sx/dTbP8u4jHy7KRCDwPC0DuXxjpjEcKzQv/Dzx0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BI5Wna059286
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 12:05:32 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 12:05:32 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 12:05:32 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BI5WoE022660;
        Fri, 11 Jan 2019 12:05:32 -0600
Received: from localhost (uda0226330.dhcp.ti.com [172.22.109.196])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BI5VU07748;
        Fri, 11 Jan 2019 12:05:31 -0600 (CST)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
CC:     <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 09/14] staging: android: ion: Remove base from ion_chunk_heap
Date:   Fri, 11 Jan 2019 12:05:18 -0600
Message-ID: <20190111180523.27862-10-afd@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111180523.27862-1-afd@ti.com>
References: <20190111180523.27862-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The base address is not used anywhere and tracked by the pool
allocator. No need to store this anymore.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/staging/android/ion/ion_chunk_heap.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/android/ion/ion_chunk_heap.c b/drivers/staging/android/ion/ion_chunk_heap.c
index b82eac1c2d7a..899380beeee1 100644
--- a/drivers/staging/android/ion/ion_chunk_heap.c
+++ b/drivers/staging/android/ion/ion_chunk_heap.c
@@ -18,7 +18,6 @@
 struct ion_chunk_heap {
 	struct ion_heap heap;
 	struct gen_pool *pool;
-	phys_addr_t base;
 	unsigned long chunk_size;
 	unsigned long size;
 	unsigned long allocated;
@@ -131,16 +130,14 @@ struct ion_heap *ion_chunk_heap_create(phys_addr_t base, size_t size, size_t chu
 		ret = -ENOMEM;
 		goto error_gen_pool_create;
 	}
-	chunk_heap->base = base;
 	chunk_heap->size = size;
 	chunk_heap->allocated = 0;
 
-	gen_pool_add(chunk_heap->pool, chunk_heap->base, size, -1);
+	gen_pool_add(chunk_heap->pool, base, size, -1);
 	chunk_heap->heap.ops = &chunk_heap_ops;
 	chunk_heap->heap.type = ION_HEAP_TYPE_CHUNK;
 	chunk_heap->heap.flags = ION_HEAP_FLAG_DEFER_FREE;
-	pr_debug("%s: base %pa size %zu\n", __func__,
-		 &chunk_heap->base, size);
+	pr_debug("%s: base %pa size %zu\n", __func__, &base, size);
 
 	return &chunk_heap->heap;
 
-- 
2.19.1

