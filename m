Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164246AbeE1M6X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164048AbeE1KyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:54:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 243/496] can: m_can: change comparison to bitshift when dealing with a mask
Date: Mon, 28 May 2018 12:00:28 +0200
Message-Id: <20180528100330.148779668@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit b7db978ac283b237835129ac87f26cbac94d04e7 ]

Due to a typo, the mask was destroyed by a comparison instead of a bit
shift.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/m_can/m_can.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -246,7 +246,7 @@ enum m_can_mram_cfg {
 
 /* Rx FIFO 0/1 Configuration (RXF0C/RXF1C) */
 #define RXFC_FWM_SHIFT	24
-#define RXFC_FWM_MASK	(0x7f < RXFC_FWM_SHIFT)
+#define RXFC_FWM_MASK	(0x7f << RXFC_FWM_SHIFT)
 #define RXFC_FS_SHIFT	16
 #define RXFC_FS_MASK	(0x7f << RXFC_FS_SHIFT)
 
