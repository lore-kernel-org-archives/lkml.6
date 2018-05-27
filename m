Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032975AbeE0R7Q (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 13:59:16 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36096 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032821AbeE0R7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 13:59:13 -0400
X-Google-Smtp-Source: ADUXVKIGZinyCcp+JT5iiUjO6D1FJzgmtRyNzkk5fMUf9+HIuJn8M0h8OKuBOC7XDsfTb1bT9QOOxg==
Date: Sun, 27 May 2018 14:59:08 -0300
From: Jefferson Capovilla <jefcap@gmail.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-eth: fix line over 80 char in
 mtk_set_link_ksettings()
Message-ID: <20180527175908.GA11653@jefcap-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 'line over 80 characters' issue found by checkpatch.pl script in
mtk_set_link_ksettings().

Signed-off-by: Jefferson Capovilla <jefcap@gmail.com>
---
 drivers/staging/mt7621-eth/ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-eth/ethtool.c b/drivers/staging/mt7621-eth/ethtool.c
index 38ba0c0..b565d2a 100644
--- a/drivers/staging/mt7621-eth/ethtool.c
+++ b/drivers/staging/mt7621-eth/ethtool.c
@@ -52,7 +52,8 @@ static int mtk_set_link_ksettings(struct net_device *dev,
 			mac->phy_dev = mac->hw->phy->phy[cmd->base.phy_address];
 			mac->phy_flags = MTK_PHY_FLAG_PORT;
 		} else if (mac->hw->mii_bus) {
-			mac->phy_dev = mdiobus_get_phy(mac->hw->mii_bus, cmd->base.phy_address);
+			mac->phy_dev = mdiobus_get_phy(mac->hw->mii_bus,
+						       cmd->base.phy_address);
 			if (!mac->phy_dev)
 				return -ENODEV;
 			mac->phy_flags = MTK_PHY_FLAG_ATTACH;
-- 
2.7.4
