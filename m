Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965986AbeE1QUv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936670AbeE1KLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:11:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yelena Krivosheev <yelena@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 108/185] net: mvneta: fix enable of all initialized RXQs
Date: Mon, 28 May 2018 12:02:29 +0200
Message-Id: <20180528100100.714855612@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yelena Krivosheev <yelena@marvell.com>

[ Upstream commit e81b5e01c14add8395dfba7130f8829206bb507d ]

In mvneta_port_up() we enable relevant RX and TX port queues by write
queues bit map to an appropriate register.

q_map must be ZERO in the beginning of this process.

Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvneta.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -748,6 +748,7 @@ static void mvneta_port_up(struct mvneta
 	}
 	mvreg_write(pp, MVNETA_TXQ_CMD, q_map);
 
+	q_map = 0;
 	/* Enable all initialized RXQs. */
 	q_map = 0;
 	for (queue = 0; queue < rxq_number; queue++) {
