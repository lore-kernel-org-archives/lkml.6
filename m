Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeFEI3m (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:29:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54507 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751690AbeFEI3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:29:40 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
To: <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: xhci: remove the code build warning
Date: Wed, 6 Jun 2018 00:35:00 +0800
Message-ID: <1528216500-14172-1-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.143.28.90]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the 'err' variate to remove the build warning,
the warning is shown as below:

drivers/usb/host/xhci-tegra.c: In function ‘tegra_xusb_mbox_thread’:
drivers/usb/host/xhci-tegra.c:552:6: warning: ‘err’ may be used uninitialized in this function [-Wuninitialized]
drivers/usb/host/xhci-tegra.c:482:6: note: ‘err’ was declared here

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
How to reproduce:
1. make defconfig ARCH=arm
2. make -j100 CROSS_COMPILE=arm-linux-gnueabi- ARCH=arm

Then you can see below warnings:
drivers/usb/host/xhci-tegra.c: In function ‘tegra_xusb_mbox_thread’:
drivers/usb/host/xhci-tegra.c:552:6: warning: ‘err’ may be used uninitialized in this function [-Wuninitialized]
drivers/usb/host/xhci-tegra.c:482:6: note: ‘err’ was declared here
---
 drivers/usb/host/xhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 2c076ea..1ed87ce 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -479,7 +479,7 @@ static void tegra_xusb_mbox_handle(struct tegra_xusb *tegra,
 	unsigned long mask;
 	unsigned int port;
 	bool idle, enable;
-	int err;
+	int err = 0;
 
 	memset(&rsp, 0, sizeof(rsp));
 
-- 
2.7.4
