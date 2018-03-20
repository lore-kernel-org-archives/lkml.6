Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbeCTNOJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:14:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6657 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753246AbeCTNOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:14:05 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] phy: stm32: fix using 0 as NULL pointer warnings
Date: Tue, 20 Mar 2018 13:19:42 +0000
Message-ID: <1521551982-154471-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warnings:

drivers/phy/st/phy-stm32-usbphyc.c:331:42: warning:
 Using plain integer as NULL pointer
drivers/phy/st/phy-stm32-usbphyc.c:344:52: warning:
 Using plain integer as NULL pointer

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index bc4e78a..48d4086 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -328,7 +328,7 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 	if (IS_ERR(usbphyc->base))
 		return PTR_ERR(usbphyc->base);
 
-	usbphyc->clk = devm_clk_get(dev, 0);
+	usbphyc->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(usbphyc->clk)) {
 		ret = PTR_ERR(usbphyc->clk);
 		dev_err(dev, "clk get failed: %d\n", ret);
@@ -341,7 +341,7 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	usbphyc->rst = devm_reset_control_get(dev, 0);
+	usbphyc->rst = devm_reset_control_get(dev, NULL);
 	if (!IS_ERR(usbphyc->rst)) {
 		reset_control_assert(usbphyc->rst);
 		udelay(2);
