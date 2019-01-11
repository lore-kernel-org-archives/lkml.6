Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732FFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E60D20652
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kNRJgLwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbfAKSFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:05:41 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41920 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733134AbfAKSFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:05:37 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BI5VVT058867;
        Fri, 11 Jan 2019 12:05:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547229931;
        bh=1D2MlCtLYhIPabsQzdGn3gtPwyGFeW2PytvSRMYIQ9w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kNRJgLwbjRni2CZ3gCou7R0Yk5geJYage2bBNyigAIx+EveLekbI3lSi/mr22qv3s
         6kyPlzAvUNEQekidVlEqHreWJttQe1CzX+Ggu87BzvxwYzMUYTF9OS76Ch1CVfurs/
         HvIenrrwwGD3XgZJ5DQAlWsqi7BhpAvTnwRUvdxA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BI5V2x009026
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 12:05:31 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 12:05:30 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 12:05:30 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BI5Ufp025779;
        Fri, 11 Jan 2019 12:05:30 -0600
Received: from localhost (uda0226330.dhcp.ti.com [172.22.109.196])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BI5UU07734;
        Fri, 11 Jan 2019 12:05:30 -0600 (CST)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
CC:     <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 07/14] staging: android: ion: Sync comment docs with struct ion_buffer
Date:   Fri, 11 Jan 2019 12:05:16 -0600
Message-ID: <20190111180523.27862-8-afd@ti.com>
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

This struct is no longer documented correctly, fix this.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/staging/android/ion/ion.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index 2ef78c951a6b..e291299fd35f 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -23,8 +23,8 @@
 
 /**
  * struct ion_buffer - metadata for a particular buffer
- * @ref:		reference count
  * @node:		node in the ion_device buffers tree
+ * @list:		element in list of deferred freeable buffers
  * @dev:		back pointer to the ion_device
  * @heap:		back pointer to the heap the buffer came from
  * @flags:		buffer specific flags
@@ -35,7 +35,8 @@
  * @lock:		protects the buffers cnt fields
  * @kmap_cnt:		number of times the buffer is mapped to the kernel
  * @vaddr:		the kernel mapping if kmap_cnt is not zero
- * @sg_table:		the sg table for the buffer if dmap_cnt is not zero
+ * @sg_table:		the sg table for the buffer
+ * @attachments:	list of devices attached to this buffer
  */
 struct ion_buffer {
 	union {
@@ -151,12 +152,16 @@ struct ion_heap {
 	unsigned long flags;
 	unsigned int id;
 	const char *name;
+
+	/* deferred free support */
 	struct shrinker shrinker;
 	struct list_head free_list;
 	size_t free_list_size;
 	spinlock_t free_lock;
 	wait_queue_head_t waitqueue;
 	struct task_struct *task;
+
+	/* heap statistics */
 	u64 num_of_buffers;
 	u64 num_of_alloc_bytes;
 	u64 alloc_bytes_wm;
-- 
2.19.1

