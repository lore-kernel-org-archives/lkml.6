Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D74FC67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C939B21476
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C939B21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJII4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:56:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55464 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726537AbeJII4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:56:19 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 14253F537DE4E;
        Tue,  9 Oct 2018 09:41:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Tue, 9 Oct 2018 09:41:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <oded.gabbay@gmail.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/amdkfd: Remove set but not used variable 'preempt_all_queues'
Date:   Tue, 9 Oct 2018 01:53:00 +0000
Message-ID: <1539049980-186978-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c: In function 'destroy_queue_cpsch':
drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:1366:7: warning:
 variable 'preempt_all_queues' set but not used [-Wunused-but-set-variable]

It never used since introduct in 
commit 992839ad64f2 ("drm/amdkfd: Add static user-mode queues support")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 4f22e74..06d38b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1363,9 +1363,6 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 {
 	int retval;
 	struct mqd_manager *mqd_mgr;
-	bool preempt_all_queues;
-
-	preempt_all_queues = false;
 
 	retval = 0;

