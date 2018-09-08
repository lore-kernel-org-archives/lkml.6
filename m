Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47156C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F3A20869
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F3A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbeIHPYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:24:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51762 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726568AbeIHPYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:24:02 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6D0781A1ECD5A;
        Sat,  8 Sep 2018 18:38:40 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Sat, 8 Sep 2018 18:38:39 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <schwidefsky@de.ibm.com>, <heiko.carstens@de.ibm.com>,
        <jwi@linux.ibm.com>, <ubraun@linux.ibm.com>, <jdelvare@suse.de>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] s390: vmlogrdr: Use ARRAY_SIZE instead of reimplementing its function
Date:   Sat, 8 Sep 2018 18:26:27 +0800
Message-ID: <1536402388-23872-2-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1536402388-23872-1-git-send-email-zhongjiang@huawei.com>
References: <1536402388-23872-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARRAY_SIZE has implemented its function. we prefer to use the function
rather than the open code.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/s390/char/vmlogrdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index 069b9ef..58333cb 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -153,7 +153,7 @@ static void vmlogrdr_iucv_message_pending(struct iucv_path *,
 	}
 };
 
-#define MAXMINOR  (sizeof(sys_ser)/sizeof(struct vmlogrdr_priv_t))
+#define MAXMINOR  ARRAY_SIZE(sys_ser)
 
 static char FENCE[] = {"EOR"};
 static int vmlogrdr_major = 0;
-- 
1.7.12.4

