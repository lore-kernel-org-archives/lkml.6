Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbeFEGQt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:16:49 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:37245 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbeFEGQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:16:46 -0400
From: Nishanth Menon <nm@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Suman Anna <s-anna@ti.com>
Subject: [RFC PATCH 1/8] mailbox: ti-msgmgr: Get rid of unused structure members
Date: Tue, 5 Jun 2018 01:16:22 -0500
Message-ID: <20180605061629.4759-2-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180605061629.4759-1-nm@ti.com>
References: <20180605061629.4759-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though q_proxies and q_slices do describe the hardware configuration,
they are not necessary for operation given that the values are
always default. Hence drop the same.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/mailbox/ti-msgmgr.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 78753a87ba4d..7cd5f9c9c97f 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -42,8 +42,6 @@ struct ti_msgmgr_valid_queue_desc {
  * @queue_count:	Number of Queues
  * @max_message_size:	Message size in bytes
  * @max_messages:	Number of messages
- * @q_slices:		Number of queue engines
- * @q_proxies:		Number of queue proxies per page
  * @data_first_reg:	First data register for proxy data region
  * @data_last_reg:	Last data register for proxy data region
  * @tx_polled:		Do I need to use polled mechanism for tx
@@ -58,8 +56,6 @@ struct ti_msgmgr_desc {
 	u8 queue_count;
 	u8 max_message_size;
 	u8 max_messages;
-	u8 q_slices;
-	u8 q_proxies;
 	u8 data_first_reg;
 	u8 data_last_reg;
 	bool tx_polled;
@@ -494,8 +490,6 @@ static const struct ti_msgmgr_desc k2g_desc = {
 	.queue_count = 64,
 	.max_message_size = 64,
 	.max_messages = 128,
-	.q_slices = 1,
-	.q_proxies = 1,
 	.data_first_reg = 16,
 	.data_last_reg = 31,
 	.tx_polled = false,
-- 
2.15.1
