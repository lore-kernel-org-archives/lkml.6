Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeBFIw3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 03:52:29 -0500
Received: from sauhun.de ([88.99.104.3]:36842 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752270AbeBFIwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 03:52:23 -0500
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] can: m_can: change comparison to bitshift when dealing with a mask
Date: Tue,  6 Feb 2018 09:52:07 +0100
Message-Id: <20180206085207.3882-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a typo, the mask was destroyed by a comparison instead of a bit
shift.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Only build tested.

 drivers/net/can/m_can/m_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2594f7779c6f14..74170b0d23cf1c 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -253,7 +253,7 @@ enum m_can_mram_cfg {
 
 /* Rx FIFO 0/1 Configuration (RXF0C/RXF1C) */
 #define RXFC_FWM_SHIFT	24
-#define RXFC_FWM_MASK	(0x7f < RXFC_FWM_SHIFT)
+#define RXFC_FWM_MASK	(0x7f << RXFC_FWM_SHIFT)
 #define RXFC_FS_SHIFT	16
 #define RXFC_FS_MASK	(0x7f << RXFC_FS_SHIFT)
 
-- 
2.11.0
