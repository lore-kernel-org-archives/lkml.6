Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60542C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C212A2088E
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C212A2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933594AbeFQCbA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:31:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8717 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756946AbeFQCa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:30:59 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 377CCDF736133;
        Sun, 17 Jun 2018 10:30:44 +0800 (CST)
Received: from SHA150392835-N.china.huawei.com (10.45.50.98) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.382.0; Sun, 17 Jun 2018 10:30:39 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <gengdongjiu@huawei.com>
Subject: [PATCH v3] usb: xhci: remove the code build warning
Date:   Sun, 17 Jun 2018 10:30:18 +0800
Message-ID: <20180617023018.7952-1-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.11.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.45.50.98]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the 'err' variate to remove the build warning,
the warning is shown as below:

drivers/usb/host/xhci-tegra.c: In function 'tegra_xusb_mbox_thread':
drivers/usb/host/xhci-tegra.c:552:6: warning: 'err' may be used uninitialized in this function [-Wuninitialized]
drivers/usb/host/xhci-tegra.c:482:6: note: 'err' was declared here

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
change since v1:
1. Add 'Acked-by: Thierry Reding <treding@nvidia.com>'

How to reproduce:
1. make defconfig ARCH=arm
2. make -j100 CROSS_COMPILE=arm-linux-gnueabi- ARCH=arm

Then you can see below warnings:
drivers/usb/host/xhci-tegra.c: In function 'tegra_xusb_mbox_thread':
drivers/usb/host/xhci-tegra.c:552:6: warning: 'err' may be used uninitialized in this function [-Wuninitialized]
drivers/usb/host/xhci-tegra.c:482:6: note: 'err' was declared here
---
 drivers/usb/host/xhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index a8c1d07..d50549f 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -481,7 +481,7 @@ static void tegra_xusb_mbox_handle(struct tegra_xusb *tegra,
 	unsigned long mask;
 	unsigned int port;
 	bool idle, enable;
-	int err;
+	int err = 0;
 
 	memset(&rsp, 0, sizeof(rsp));
 
-- 
1.9.1


