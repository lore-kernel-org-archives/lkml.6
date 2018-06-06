Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4085606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbeFFOh5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:37:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54635 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752322AbeFFOhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:37:55 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
To: <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gengdongjiu@huawei.com>
Subject: [PATCH v2] usb: xhci: remove the code build warning
Date: Wed, 6 Jun 2018 22:36:59 +0800
Message-ID: <20180606143659.1476-1-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.11.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.45.62.20]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
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
