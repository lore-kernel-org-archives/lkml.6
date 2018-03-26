Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeCZKF6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 06:05:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33455 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751083AbeCZKF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 06:05:56 -0400
X-UUID: c0163e37f70840f5b88dd3dd5d9b1b3b-20180326
From: <sean.wang@mediatek.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>
CC: <linux-rtc@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH] rtc: mt7622: fix module autoloading for OF platform drivers
Date: Mon, 26 Mar 2018 18:05:52 +0800
Message-ID: <4231c0b6038764f68324297a40b18b15ecda5a92.1522055289.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23742.005
X-TM-AS-Result: No-7.409400-8.000000-10
X-TMASE-MatchedRID: 7hMzTBgpbgRb8Ol7R+ysio9hRjNfZeOXqnabhLgnhmin5yDc9PwlXG9z
        j16rJNcqfgo+DupGOmFiSVnIdboij5Coy9iDotiwngIgpj8eDcBpkajQR5gb3savT21DsLD/UEh
        Wy9W70AEgBwKKRHe+r3YkJXBAdPzjyyHhtEk6E+F2VmR+Gkxf6dKQ79DNHqnvI9BuwczFfU4=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.409400-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23742.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

It's required to create a modules.alias via MODULE_DEVICE_TABLE helper
for the OF platform driver. Otherwise, module autoloading cannot work.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt7622.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-mt7622.c b/drivers/rtc/rtc-mt7622.c
index d79b9ae..147252f 100644
--- a/drivers/rtc/rtc-mt7622.c
+++ b/drivers/rtc/rtc-mt7622.c
@@ -307,6 +307,7 @@ static const struct of_device_id mtk_rtc_match[] = {
 	{ .compatible = "mediatek,soc-rtc" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, mtk_rtc_match);
 
 static int mtk_rtc_probe(struct platform_device *pdev)
 {
-- 
2.7.4
