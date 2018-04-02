Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754701AbeDBXYY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 19:24:24 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38592 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeDBXYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 19:24:22 -0400
X-Google-Smtp-Source: AIpwx4+3+QhSsbsWptcxR7vFv3BZ285f4pJB/TKwOxz6OHDSjLYwAgqsfuPXhXTpS86ueYr1iD3J5A==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: dsa: mt7530: Use NULL instead of plain integer
Date: Mon,  2 Apr 2018 16:24:14 -0700
Message-Id: <20180402232414.19671-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We would be passing 0 instead of NULL as the rsp argument to
mt7530_fdb_cmd(), fix that.

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/mt7530.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 4e53c5ce23ff..a7f6c0a62fc7 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -917,7 +917,7 @@ mt7530_port_fdb_add(struct dsa_switch *ds, int port,
 
 	mutex_lock(&priv->reg_mutex);
 	mt7530_fdb_write(priv, vid, port_mask, addr, -1, STATIC_ENT);
-	ret = mt7530_fdb_cmd(priv, MT7530_FDB_WRITE, 0);
+	ret = mt7530_fdb_cmd(priv, MT7530_FDB_WRITE, NULL);
 	mutex_unlock(&priv->reg_mutex);
 
 	return ret;
@@ -933,7 +933,7 @@ mt7530_port_fdb_del(struct dsa_switch *ds, int port,
 
 	mutex_lock(&priv->reg_mutex);
 	mt7530_fdb_write(priv, vid, port_mask, addr, -1, STATIC_EMP);
-	ret = mt7530_fdb_cmd(priv, MT7530_FDB_WRITE, 0);
+	ret = mt7530_fdb_cmd(priv, MT7530_FDB_WRITE, NULL);
 	mutex_unlock(&priv->reg_mutex);
 
 	return ret;
@@ -1293,7 +1293,7 @@ mt7530_setup(struct dsa_switch *ds)
 	}
 
 	/* Flush the FDB table */
-	ret = mt7530_fdb_cmd(priv, MT7530_FDB_FLUSH, 0);
+	ret = mt7530_fdb_cmd(priv, MT7530_FDB_FLUSH, NULL);
 	if (ret < 0)
 		return ret;
 
-- 
2.14.1
