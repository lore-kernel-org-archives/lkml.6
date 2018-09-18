Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36307ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BAF2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BAF2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbeIRODd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:03:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59062 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728985AbeIRODd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:03:33 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 82D29C3DADECC;
        Tue, 18 Sep 2018 16:31:56 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Tue, 18 Sep 2018 16:31:54 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>, <khc@pm.waw.pl>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: wan: remove redundant include
Date:   Tue, 18 Sep 2018 16:19:35 +0800
Message-ID: <1537258775-44025-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module.h already contained moduleparam.h,  so it is safe to remove
the redundant include.

The issue is detected with the help of Coccinelle.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/wan/c101.c      | 1 -
 drivers/net/wan/pci200syn.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/wan/c101.c b/drivers/net/wan/c101.c
index 2371e07..91dbbde 100644
--- a/drivers/net/wan/c101.c
+++ b/drivers/net/wan/c101.c
@@ -24,7 +24,6 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/moduleparam.h>
 #include <linux/netdevice.h>
 #include <linux/hdlc.h>
 #include <linux/delay.h>
diff --git a/drivers/net/wan/pci200syn.c b/drivers/net/wan/pci200syn.c
index 4e437c5..1f8a3f7 100644
--- a/drivers/net/wan/pci200syn.c
+++ b/drivers/net/wan/pci200syn.c
@@ -27,7 +27,6 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/moduleparam.h>
 #include <linux/netdevice.h>
 #include <linux/hdlc.h>
 #include <linux/pci.h>
-- 
1.7.12.4

