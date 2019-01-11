Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A27C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64C820652
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X/FM+Xat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389779AbfAKSGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:06:18 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41952 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732941AbfAKSFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:05:38 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BI5VGV058880;
        Fri, 11 Jan 2019 12:05:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547229932;
        bh=L2Rnpyu+I9LeNHXRM+x4lk3unP8kFqpJcoyBGhfQ/zg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=X/FM+XatFdXhLHhOMEa2YZCXDorEwmdaOdsPPoXCfqwS3pOA/7i6NPeGZcwCYOvx1
         XuapJ0wRURj0+iBZqdc+CApk+m3RSS0/Pg2AuNgPYaOaDjH3ayeiYQs9ALOzWiwZtm
         zK8TbYBzXnm+YPFtXgUN25zu7XnFDUVdJUkXlXeI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BI5VVl116757
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 12:05:31 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 12:05:31 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 12:05:31 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BI5VtM025826;
        Fri, 11 Jan 2019 12:05:31 -0600
Received: from localhost (uda0226330.dhcp.ti.com [172.22.109.196])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BI5VU07740;
        Fri, 11 Jan 2019 12:05:31 -0600 (CST)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
CC:     <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 08/14] staging: android: ion: Remove base from ion_carveout_heap
Date:   Fri, 11 Jan 2019 12:05:17 -0600
Message-ID: <20190111180523.27862-9-afd@ti.com>
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
 drivers/staging/android/ion/ion_carveout_heap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/android/ion/ion_carveout_heap.c b/drivers/staging/android/ion/ion_carveout_heap.c
index be80671df9c8..ab9b72adca9c 100644
--- a/drivers/staging/android/ion/ion_carveout_heap.c
+++ b/drivers/staging/android/ion/ion_carveout_heap.c
@@ -20,7 +20,6 @@
 struct ion_carveout_heap {
 	struct ion_heap heap;
 	struct gen_pool *pool;
-	phys_addr_t base;
 };
 
 static phys_addr_t ion_carveout_allocate(struct ion_heap *heap,
@@ -125,8 +124,7 @@ struct ion_heap *ion_carveout_heap_create(phys_addr_t base, size_t size)
 		kfree(carveout_heap);
 		return ERR_PTR(-ENOMEM);
 	}
-	carveout_heap->base = base;
-	gen_pool_add(carveout_heap->pool, carveout_heap->base, size, -1);
+	gen_pool_add(carveout_heap->pool, base, size, -1);
 	carveout_heap->heap.ops = &carveout_heap_ops;
 	carveout_heap->heap.type = ION_HEAP_TYPE_CARVEOUT;
 	carveout_heap->heap.flags = ION_HEAP_FLAG_DEFER_FREE;
-- 
2.19.1

