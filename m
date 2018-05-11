Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753367AbeEKLRE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 07:17:04 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:50516 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbeEKLRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 07:17:02 -0400
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <nm@ti.com>, <t-kristo@ti.com>
CC: <ssantosh@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lokeshvutla@ti.com>
Subject: [PATCH] firmware: ti_sci: Correct the timeout type in ti_sci_do_xfer()
Date: Fri, 11 May 2018 14:17:26 +0300
Message-ID: <20180511111726.27350-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be 'unsigned long', not int.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/firmware/ti_sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index b74a533ef35b..398a6db4da88 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -419,7 +419,7 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 				 struct ti_sci_xfer *xfer)
 {
 	int ret;
-	int timeout;
+	unsigned long timeout;
 	struct device *dev = info->dev;
 
 	ret = mbox_send_message(info->chan_tx, &xfer->tx_message);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
