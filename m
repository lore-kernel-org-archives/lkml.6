Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204B2C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 08:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDDD219F1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 08:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDDD219F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeHLLYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 07:24:34 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:7311 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727073AbeHLLYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 07:24:34 -0400
X-UUID: 322264067d96408396f6621ed1186783-20180812
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1508881566; Sun, 12 Aug 2018 16:47:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sun, 12 Aug 2018 16:47:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sun, 12 Aug 2018 16:47:00 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 2/2] Bluetooth: mediatek: Add protocol support for MediaTek MT7663U USB devices
Date:   Sun, 12 Aug 2018 16:46:52 +0800
Message-ID: <faa3b96dd4597b59e8ec7395629f3d3cd44657c3.1534062988.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1534062988.git.sean.wang@mediatek.com>
References: <cover.1534062988.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This adds the support of enabling MT7663U Bluetooth function running
on the top of btusb driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 1 +
 drivers/bluetooth/btmtk.h | 1 +
 drivers/bluetooth/btusb.c | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 9e39a0a..d46c25d 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -305,4 +305,5 @@ MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_DESCRIPTION("MediaTek Bluetooth device driver ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(FIRMWARE_MT7663);
 MODULE_FIRMWARE(FIRMWARE_MT7668);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 64fc395..f90292c 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -9,6 +9,7 @@
  *
  */
 
+#define FIRMWARE_MT7663		"mt7663pr2h.bin"
 #define FIRMWARE_MT7668		"mt7668pr2h.bin"
 
 enum {
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 773238b..56f7862 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2494,6 +2494,9 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	}
 
 	switch (dev_id) {
+	case 0x7663:
+		fwname = FIRMWARE_MT7663;
+		break;
 	case 0x7668:
 		fwname = FIRMWARE_MT7668;
 		break;
-- 
2.7.4

