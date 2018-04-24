Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933786AbeDXNRB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:17:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54508 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933200AbeDXNQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:52 -0400
X-Google-Smtp-Source: AIpwx49N7ZuV14uoz3KL59eDpeFBrRmN8ztQ4j/zRfIvdmI2Yh8XcG3Me9n53hf/ZhiL9VAsUFbV/A==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH] net: ixgbevf: fix ixgbevf_xmit_frame()'s return type
Date: Tue, 24 Apr 2018 15:16:48 +0200
Message-Id: <20180424131649.3955-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 3d9033f26..ce217a2e9 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4137,7 +4137,7 @@ static int ixgbevf_xmit_frame_ring(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-static int ixgbevf_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t ixgbevf_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
 	struct ixgbevf_ring *tx_ring;
-- 
2.17.0
