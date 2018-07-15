Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BE1ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5E4208DE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5E4208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeGOKc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 06:32:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9239 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbeGOKc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 06:32:58 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4DB87150B85D4;
        Sun, 15 Jul 2018 18:10:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.382.0; Sun, 15 Jul 2018 18:10:09 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: remove unnecessary function extern declare
Date:   Sun, 15 Jul 2018 18:08:56 +0800
Message-ID: <1531649336-20135-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_private_init is called only in core.c, extern declare is
unnecessary and make it static.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/base/base.h | 2 --
 drivers/base/core.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index a75c302..7a419a7 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -84,8 +84,6 @@ struct device_private {
 #define to_device_private_bus(obj)	\
 	container_of(obj, struct device_private, knode_bus)
 
-extern int device_private_init(struct device *dev);
-
 /* initialisation functions */
 extern int devices_init(void);
 extern int buses_init(void);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index df3e1a4..2ba30ce 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1736,7 +1736,7 @@ static void device_remove_sys_dev_entry(struct device *dev)
 	}
 }
 
-int device_private_init(struct device *dev)
+static int device_private_init(struct device *dev)
 {
 	dev->p = kzalloc(sizeof(*dev->p), GFP_KERNEL);
 	if (!dev->p)
-- 
2.7.4

