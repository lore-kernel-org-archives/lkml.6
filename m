Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeEVLR7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 07:17:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35285 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeEVLRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 07:17:46 -0400
X-Google-Smtp-Source: AB8JxZrqe8VjMbm+CM5qZZZLRaXdybnn0mW3fOa4riMPUTT/zF921XlUGbE2aDw6cc5F1zyHA98ryA==
From: "=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?=" <vokac.m@gmail.com>
X-Google-Original-From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com,
        andrew@lunn.ch, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net, michal.vokac@ysoft.com
Subject: [PATCH net-next v2 3/7] net: dsa: qca8k: Enable RXMAC when bringing up a port
Date: Tue, 22 May 2018 13:16:28 +0200
Message-Id: <1526987792-56861-4-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526987792-56861-1-git-send-email-michal.vokac@ysoft.com>
References: <1526987792-56861-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a port is brought up/down do not enable/disable only the TXMAC
but the RXMAC as well. This is essential for the CPU port to work.

Fixes: 6b93fb46480a ("net-next: dsa: add new driver for qca8xxx family")
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:
 - Add "Fixes" tag as pointed out by Florian.
 - Add "Reviewed-by" tags from Andrew and Florian.

 drivers/net/dsa/qca8k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/qca8k.c b/drivers/net/dsa/qca8k.c
index 6a3ffb2..0d224f3 100644
--- a/drivers/net/dsa/qca8k.c
+++ b/drivers/net/dsa/qca8k.c
@@ -516,7 +516,7 @@ qca8k_set_pad_ctrl(struct qca8k_priv *priv, int port, int mode)
 static void
 qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
 {
-	u32 mask = QCA8K_PORT_STATUS_TXMAC;
+	u32 mask = QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
 
 	pr_debug("qca: port %i set status %i\n", port, enable);
 
-- 
2.1.4
