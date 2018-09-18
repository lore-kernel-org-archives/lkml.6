Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA96ECE566
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBC520858
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBC520858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbeIROSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:18:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12603 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728842AbeIROSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:18:42 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 06CD849F76B1C;
        Tue, 18 Sep 2018 16:47:02 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Tue, 18 Sep 2018 16:47:01 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <tomas.winkler@intel.com>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc: remove redundant include moduleparam.h
Date:   Tue, 18 Sep 2018 16:34:42 +0800
Message-ID: <1537259682-44758-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module.h already contains moduleparam.h,  so it is safe to remove
the redundant include.

The issue is detected with the help of Coccinelle.

eePlease enter the commit message for your changes. Lines starting

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/misc/mei/bus-fixup.c      | 1 -
 drivers/misc/vmw_vmci/vmci_host.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index a6f41f9..80215c3 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -17,7 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/uuid.h>
diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index 83e0c95..be732e5 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -15,7 +15,6 @@
 
 #include <linux/vmw_vmci_defs.h>
 #include <linux/vmw_vmci_api.h>
-#include <linux/moduleparam.h>
 #include <linux/miscdevice.h>
 #include <linux/interrupt.h>
 #include <linux/highmem.h>
-- 
1.7.12.4

