Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A6CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BFE20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfAWIiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:38:22 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbfAWIiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:38:22 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 25F83250E95551360CF3;
        Wed, 23 Jan 2019 16:38:20 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Wed, 23 Jan 2019
 16:38:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <stern@rowland.harvard.edu>, <geoff@infradead.org>,
        <gregkh@linuxfoundation.org>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <mpe@ellerman.id.au>
CC:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-usb@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] usb: host: drop pointless static qualifier
Date:   Wed, 23 Jan 2019 16:37:58 +0800
Message-ID: <20190123083758.8412-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to have the 'dummy_mask' variable static since new
value always be assigned before use it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/host/ehci-ps3.c | 2 +-
 drivers/usb/host/ohci-ps3.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-ps3.c b/drivers/usb/host/ehci-ps3.c
index 454d8c6..91cee02 100644
--- a/drivers/usb/host/ehci-ps3.c
+++ b/drivers/usb/host/ehci-ps3.c
@@ -86,7 +86,7 @@ static int ps3_ehci_probe(struct ps3_system_bus_device *dev)
 	int result;
 	struct usb_hcd *hcd;
 	unsigned int virq;
-	static u64 dummy_mask;
+	u64 dummy_mask;
 
 	if (usb_disabled()) {
 		result = -ENODEV;
diff --git a/drivers/usb/host/ohci-ps3.c b/drivers/usb/host/ohci-ps3.c
index 395f9d3..a1c1bdf 100644
--- a/drivers/usb/host/ohci-ps3.c
+++ b/drivers/usb/host/ohci-ps3.c
@@ -69,7 +69,7 @@ static int ps3_ohci_probe(struct ps3_system_bus_device *dev)
 	int result;
 	struct usb_hcd *hcd;
 	unsigned int virq;
-	static u64 dummy_mask;
+	u64 dummy_mask;
 
 	if (usb_disabled()) {
 		result = -ENODEV;
-- 
2.7.0


