Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933646AbeDXNQQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:16:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56055 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933586AbeDXNQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:01 -0400
X-Google-Smtp-Source: AIpwx4+28vbXNBpbB9iJc0aL9RJEgvM+HE9sK8gdBq1lv8gz0d0k/rIJmWy+SjPkOU0hmIBbQJG4SQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH] mptlan: fix mpt_lan_sdu_send()'s return type
Date: Tue, 24 Apr 2018 15:15:58 +0200
Message-Id: <20180424131558.3010-1-luc.vanoostenryck@gmail.com>
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
 drivers/message/fusion/mptlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/message/fusion/mptlan.c b/drivers/message/fusion/mptlan.c
index 55dd71bbd..4cbed4d06 100644
--- a/drivers/message/fusion/mptlan.c
+++ b/drivers/message/fusion/mptlan.c
@@ -670,7 +670,7 @@ mpt_lan_send_reply(struct net_device *dev, LANSendReply_t *pSendRep)
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-static int
+static netdev_tx_t
 mpt_lan_sdu_send (struct sk_buff *skb, struct net_device *dev)
 {
 	struct mpt_lan_priv *priv = netdev_priv(dev);
-- 
2.17.0
