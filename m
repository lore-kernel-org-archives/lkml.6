Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F75AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008D920878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g1d3q587"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389902AbfAKSGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:06:55 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41830 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730644AbfAKSFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:05:34 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BI5PsC058838;
        Fri, 11 Jan 2019 12:05:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547229925;
        bh=j/ao8az4BVOlzcvk7SsUEBcFtQXFxEjBZKOCe16j6xw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=g1d3q587HZDI+2YC7d5PMYBZ0492z3AuawDnr1zZScarw2qMpUBk7nCiRU/msEn7G
         NwjC3bS9f8miKf2gnsxso1gg6rJ47RpTog1oTGB8GdaVNERyywWh7tv1agsiYJeTst
         AhI8xBbqDgBiqdmo7sMU21mNsIjFHyXUAMg1Eh/s=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BI5Phq116634
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 12:05:25 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 12:05:25 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 12:05:25 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BI5Pw2025707;
        Fri, 11 Jan 2019 12:05:25 -0600
Received: from localhost (uda0226330.dhcp.ti.com [172.22.109.196])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BI5OU07703;
        Fri, 11 Jan 2019 12:05:24 -0600 (CST)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
CC:     <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 01/14] staging: android: ion: Add proper header information
Date:   Fri, 11 Jan 2019 12:05:10 -0600
Message-ID: <20190111180523.27862-2-afd@ti.com>
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

The filenames in headers add nothing are often wrong after moves, lets
drop them here and add a little description of the files contents.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/staging/android/ion/ion.c               | 2 +-
 drivers/staging/android/ion/ion.h               | 2 +-
 drivers/staging/android/ion/ion_carveout_heap.c | 2 +-
 drivers/staging/android/ion/ion_chunk_heap.c    | 2 +-
 drivers/staging/android/ion/ion_cma_heap.c      | 2 +-
 drivers/staging/android/ion/ion_heap.c          | 2 +-
 drivers/staging/android/ion/ion_page_pool.c     | 2 +-
 drivers/staging/android/ion/ion_system_heap.c   | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index a0802de8c3a1..de1ca5e26a4a 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/staging/android/ion/ion.c
+ * ION Memory Allocator
  *
  * Copyright (C) 2011 Google, Inc.
  */
diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index 47b594cf1ac9..ff455fdde1a8 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * drivers/staging/android/ion/ion.h
+ * ION Memory Allocator kernel interface header
  *
  * Copyright (C) 2011 Google, Inc.
  */
diff --git a/drivers/staging/android/ion/ion_carveout_heap.c b/drivers/staging/android/ion/ion_carveout_heap.c
index e129237a0417..4a9f9c275654 100644
--- a/drivers/staging/android/ion/ion_carveout_heap.c
+++ b/drivers/staging/android/ion/ion_carveout_heap.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/staging/android/ion/ion_carveout_heap.c
+ * ION Memory Allocator carveout heap helper
  *
  * Copyright (C) 2011 Google, Inc.
  */
diff --git a/drivers/staging/android/ion/ion_chunk_heap.c b/drivers/staging/android/ion/ion_chunk_heap.c
index 159d72f5bc42..5a8917d9beac 100644
--- a/drivers/staging/android/ion/ion_chunk_heap.c
+++ b/drivers/staging/android/ion/ion_chunk_heap.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/staging/android/ion/ion_chunk_heap.c
+ * ION memory allocator chunk heap helper
  *
  * Copyright (C) 2012 Google, Inc.
  */
diff --git a/drivers/staging/android/ion/ion_cma_heap.c b/drivers/staging/android/ion/ion_cma_heap.c
index 3fafd013d80a..7b557dd5e78b 100644
--- a/drivers/staging/android/ion/ion_cma_heap.c
+++ b/drivers/staging/android/ion/ion_cma_heap.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/staging/android/ion/ion_cma_heap.c
+ * ION Memory Allocator CMA heap exporter
  *
  * Copyright (C) Linaro 2012
  * Author: <benjamin.gaignard@linaro.org> for ST-Ericsson.
diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
index 31db510018a9..6ee0ac6e4be4 100644
--- a/drivers/staging/android/ion/ion_heap.c
+++ b/drivers/staging/android/ion/ion_heap.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/staging/android/ion/ion_heap.c
+ * ION Memory Allocator generic heap helpers
  *
  * Copyright (C) 2011 Google, Inc.
  */
diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index 0d2a95957ee8..fd4995fb676e 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/staging/android/ion/ion_mem_pool.c
+ * ION Memory Allocator page pool helpers
  *
  * Copyright (C) 2011 Google, Inc.
  */
diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index 0383f7548d48..643b32099488 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/staging/android/ion/ion_system_heap.c
+ * ION Memory Allocator system heap exporter
  *
  * Copyright (C) 2011 Google, Inc.
  */
-- 
2.19.1

