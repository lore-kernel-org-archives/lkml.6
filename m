Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751806AbeCZKHg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 06:07:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12779 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750973AbeCZKHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 06:07:19 -0400
X-UUID: 9bd82568a8c04e8892a6034fc1016dd0-20180326
From: <sean.wang@mediatek.com>
To: <davem@davemloft.net>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <vivien.didelot@savoirfairelinux.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH net 2/2] net: dsa: mt7530: fix module autoloading for OF platform drivers
Date: Mon, 26 Mar 2018 18:07:10 +0800
Message-ID: <cb3bdedb65fca8e206ba081b0dfd69667c3f7804.1522057659.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <2497321afc9156f7954e813721f60a0a95c03bd2.1522057659.git.sean.wang@mediatek.com>
References: <2497321afc9156f7954e813721f60a0a95c03bd2.1522057659.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23742.005
X-TM-AS-Result: No-7.409400-8.000000-10
X-TMASE-MatchedRID: 7hMzTBgpbgRb8Ol7R+ysio9hRjNfZeOXqnabhLgnhmin5yDc9PwlXG9z
        j16rJNcqfgo+DupGOmFiSVnIdboij5Coy9iDotiwngIgpj8eDcBpkajQR5gb3savT21DsLD/UEh
        Wy9W70AEgBwKKRHe+r5ytNT9yrUbMITnJCyPuO5fDphoLRlapHtAAbwh7dxkGD3jldR8wNhM=
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
 drivers/net/dsa/mt7530.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index d31246c..4e53c5c 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1409,6 +1409,7 @@ static const struct of_device_id mt7530_of_match[] = {
 	{ .compatible = "mediatek,mt7530" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, mt7530_of_match);
 
 static struct mdio_driver mt7530_mdio_driver = {
 	.probe  = mt7530_probe,
-- 
2.7.4
