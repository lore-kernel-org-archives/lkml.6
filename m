Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755516AbeDCMNM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:13:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:55110 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755300AbeDCMNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:13:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,400,1517904000";
   d="scan'208";a="43003623"
Date: Tue, 3 Apr 2018 20:13:03 +0800
From: kbuild test robot <lkp@intel.com>
To: sean.wang@mediatek.com
Cc: kbuild-all@01.org, robh+dt@kernel.org, mark.rutland@arm.com,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>
Subject: [RFC PATCH] Bluetooth: hci_mediatek: mtk_recv_frame() can be static
Message-ID: <20180403121303.GA72575@lkp-sb04>
References: <f0e0a0b7f1dc3845dc6eafb4ccd60284d1675f8d.1522736996.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e0a0b7f1dc3845dc6eafb4ccd60284d1675f8d.1522736996.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 9f2aacacb185 ("Bluetooth: hci_mediatek: Add protocol support for MediaTek serial devices")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 hci_mediatek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_mediatek.c b/drivers/bluetooth/hci_mediatek.c
index 7ac1e7aa..ab02b8b 100644
--- a/drivers/bluetooth/hci_mediatek.c
+++ b/drivers/bluetooth/hci_mediatek.c
@@ -319,7 +319,7 @@ static int mtk_close(struct hci_uart *hu)
 	return 0;
 }
 
-int mtk_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
+static int mtk_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_event_hdr *hdr = (void *)skb->data;
 	struct hci_uart *hu = hci_get_drvdata(hdev);
