Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeEUNbO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:31:14 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34795 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbeEUN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:29:12 -0400
X-Google-Smtp-Source: AB8JxZo9Ifob/sK6Zu8j3lqeERKbT+XTLm5uhDA+sKnwNv0XhF0TSZoVQJEg3N2QWiPlHcVCdW/zuA==
From: "=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?=" <vokac.m@gmail.com>
X-Google-Original-From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: netdev@vger.kernel.org, michal.vokac@ysoft.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com,
        andrew@lunn.ch, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net
Subject: [PATCH net-next 3/7] net: dsa: qca8k: Enable RXMAC when bringing up a port
Date: Mon, 21 May 2018 15:28:09 +0200
Message-Id: <1526909293-56377-4-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526909293-56377-1-git-send-email-michal.vokac@ysoft.com>
References: <1526909293-56377-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a port is brought up/down do not enable/disable only the TXMAC
but the RXMAC as well. This is essential for the CPU port to work.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
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
