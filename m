Return-Path: <jefcap@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524788950; cv=none;
        d=google.com; s=arc-20160816;
        b=BtZFIQrqjtIBFE6Ht/l++ZDSZbuLweeGIH6ivb4EFeNiOPjQ/GBVkYcmdMptCsboLq
         XB108NAEct9eTqEz5NzcWSbazJtRvCiMTUKOwyy8RaKPb7nrkoyAgv2DaWIrl7zeqXGV
         rO2wlH09GoO7bez1/sBeYVfhX3LVDhJeZNLOPX5wscVIpNZfrqwLBGw9SY8xVRCfoWrQ
         Tn45tZLPNv+5zgQZmUV2K0T+5fglJnv0FDjACaVyIl6mM8M7A9nQl+8u3EyvK0ll5t5M
         1kZKqsX3YCIefpO3g4PdpDaaTeqo9bUxgdzi+0T0eXoLpaLBdRJtxIti364xILVh03Jo
         LFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=D4jJbi14Gj270d9zfGCzDPnl/vSgDKtrhlw4yjRTw6s=;
        b=O+WKsMTAqMvC/RazPQ0uQCYc1S+05dgeFXwtfA7nBJ3nMSV1ppgtgsFuJaVj2gS966
         8imglQm0WpCBWo3DjzQZGW3Fen9elcoT7ZbDItuAetc6C5QI8T3az1ddgtEfJSVkEZiD
         VvjMR5lLllHrwwvX+gkb+ggWJ4DN7W6xAMzm27bz1Mkr565fuoJ+BgbXYs1Wr9/dG1FM
         bkIifRaNMBRjRhukSbA5YcZCc6KdP0Y/wH3SnJ600VZZxOaKXe3Zhua2hDyhjkyFnVwA
         HiKlhhIVkDaPem/YT1dinlfIn5UNN4wkNIR7AzqBFnIay8UT4xcwyDQRp4HvgmMZc4gv
         QFIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Qgvo4STZ;
       spf=pass (google.com: domain of jefcap@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jefcap@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Qgvo4STZ;
       spf=pass (google.com: domain of jefcap@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jefcap@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrxm41K04KL8bWdQN1oR8SQEQ4Z2G812pvhedjgcOQEYxQ6J/Tknc6/piLnI1gnaNcdspsINw==
Date: Thu, 26 Apr 2018 21:29:09 -0300
From: Jefferson Capovilla <jefcap@gmail.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-eth: fix line over 80 char / extra line in
 mtk_set_link_ksettings()
Message-ID: <20180427002909.GA1605@jefcap-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598857098252793808?=
X-GMAIL-MSGID: =?utf-8?q?1598857098252793808?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix 'line over 80 characters' issue found by checkpatch.pl script in
mtk_set_link_ksettings().
Fix extra line before end of function.

Signed-off-by: Jefferson Capovilla <jefcap@gmail.com>
---
 drivers/staging/mt7621-eth/ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-eth/ethtool.c b/drivers/staging/mt7621-eth/ethtool.c
index 38ba0c0..e9f4092 100644
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
@@ -62,7 +63,6 @@ static int mtk_set_link_ksettings(struct net_device *dev,
 	}
 
 	return phy_ethtool_ksettings_set(mac->phy_dev, cmd);
-
 }
 
 static void mtk_get_drvinfo(struct net_device *dev,
-- 
2.7.4
