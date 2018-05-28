Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424725AbeE1LQr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424271AbeE1LQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:16:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@axis.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 240/272] net: stmmac: call correct function in stmmac_mac_config_rx_queues_routing()
Date: Mon, 28 May 2018 12:04:33 +0200
Message-Id: <20180528100300.481032328@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <niklas.cassel@axis.com>

[ Upstream commit 13138de01400762f706c5e956e70660770d61962 ]

stmmac_mac_config_rx_queues_routing() incorrectly calls rx_queue_prio()
instead of rx_queue_routing().

This looks like a copy paste issue, since
stmmac_mac_config_rx_queues_prio() already calls rx_queue_prio(),
and both stmmac_mac_config_rx_queues_routing() and
stmmac_mac_config_rx_queues_prio() are very similar in structure.

Fixes: abe80fdc6ee6 ("net: stmmac: RX queue routing configuration")
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2435,7 +2435,7 @@ static void stmmac_mac_config_rx_queues_
 			continue;
 
 		packet = priv->plat->rx_queues_cfg[queue].pkt_route;
-		priv->hw->mac->rx_queue_prio(priv->hw, packet, queue);
+		priv->hw->mac->rx_queue_routing(priv->hw, packet, queue);
 	}
 }
 
