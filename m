Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932317AbeCLXAu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:00:50 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39514 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbeCLXAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:00:48 -0400
X-Google-Smtp-Source: AG47ELsYNBUSo/PexBIY/vZ9pgycq6feMZ4JzxLuuP0wgZIgiinfla5LEJ1OtutnFYy31CxNzHkujw==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: yxj790222@163.com, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: dsa: Fix dsa_is_user_port() test inversion
Date: Mon, 12 Mar 2018 16:00:40 -0700
Message-Id: <1520895640-28139-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the conversion to dsa_is_user_port(), a condition ended up being
reversed, which would prevent the creation of any user port when using
the legacy binding and/or platform data, fix that.

Fixes: 4a5b85ffe2a0 ("net: dsa: use dsa_is_user_port everywhere")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/legacy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/legacy.c b/net/dsa/legacy.c
index cb54b81d0bd9..42a7b85b84e1 100644
--- a/net/dsa/legacy.c
+++ b/net/dsa/legacy.c
@@ -194,7 +194,7 @@ static int dsa_switch_setup_one(struct dsa_switch *ds,
 		ds->ports[i].dn = cd->port_dn[i];
 		ds->ports[i].cpu_dp = dst->cpu_dp;
 
-		if (dsa_is_user_port(ds, i))
+		if (!dsa_is_user_port(ds, i))
 			continue;
 
 		ret = dsa_slave_create(&ds->ports[i]);
-- 
2.7.4
