Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760DBC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EE220894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EE220894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeHBEpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:45:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbeHBEpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:45:44 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5E5E3B16B938A;
        Thu,  2 Aug 2018 10:56:47 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Thu, 2 Aug 2018 10:56:39 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <andy.shevchenko@gmail.com>, <john.garry@huawei.com>,
        <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <aacraid@microsemi.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] scsi:qlogicfas408: remove the same check in qlogicfas408_detect
Date:   Thu, 2 Aug 2018 10:45:01 +0800
Message-ID: <1533177901-19514-3-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1533177901-19514-1-git-send-email-zhongjiang@huawei.com>
References: <1533177901-19514-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we should not use same check in a expression. just remove one
of them.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/scsi/qlogicfas408.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qlogicfas408.c b/drivers/scsi/qlogicfas408.c
index 8b471a9..1409ac1 100644
--- a/drivers/scsi/qlogicfas408.c
+++ b/drivers/scsi/qlogicfas408.c
@@ -567,8 +567,7 @@ void qlogicfas408_setup(int qbase, int id, int int_type)
 int qlogicfas408_detect(int qbase, int int_type)
 {
         REG1;
-	return (((inb(qbase + 0xe) ^ inb(qbase + 0xe)) == 7) &&
-	       ((inb(qbase + 0xe) ^ inb(qbase + 0xe)) == 7));		
+	return (inb(qbase + 0xe) ^ inb(qbase + 0xe)) == 7;
 }
 
 /*
-- 
1.7.12.4

