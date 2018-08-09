Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811A1C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC1921B32
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC1921B32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeHIENW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:13:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47388 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725757AbeHIENW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:13:22 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AB3C1529DE0F7;
        Thu,  9 Aug 2018 09:50:59 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Thu, 9 Aug 2018 09:50:56 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>, <gustavo@embeddedor.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/net/usb/r8152: remove the unneeded variable "ret" in rtl8152_system_suspend
Date:   Thu, 9 Aug 2018 09:39:13 +0800
Message-ID: <1533778753-38089-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtl8152_system_suspend defines the variable "ret", but it is not modified
after initialization. So just remove it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/usb/r8152.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 124211a..9774270 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4415,7 +4415,6 @@ static int rtl8152_runtime_suspend(struct r8152 *tp)
 static int rtl8152_system_suspend(struct r8152 *tp)
 {
 	struct net_device *netdev = tp->netdev;
-	int ret = 0;
 
 	netif_device_detach(netdev);
 
@@ -4430,7 +4429,7 @@ static int rtl8152_system_suspend(struct r8152 *tp)
 		napi_enable(napi);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int rtl8152_suspend(struct usb_interface *intf, pm_message_t message)
-- 
1.7.12.4

