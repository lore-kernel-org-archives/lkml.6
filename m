Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeETGxM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 02:53:12 -0400
Received: from sauhun.de ([88.99.104.3]:41462 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750912AbeETGui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 02:50:38 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] i2c: ibm_iic: don't check number of messages in the driver
Date: Sun, 20 May 2018 08:50:33 +0200
Message-Id: <20180520065035.7920-2-wsa@the-dreams.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180520065035.7920-1-wsa@the-dreams.de>
References: <20180520065035.7920-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 1eace8344c02 ("i2c: add param sanity check to
i2c_transfer()"), the I2C core does this check now. We can remove it
from drivers.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Only build tested.

 drivers/i2c/busses/i2c-ibm_iic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 961c5f42d956..6f6e1dfe7cce 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -561,9 +561,6 @@ static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 
 	DBG2("%d: iic_xfer, %d msg(s)\n", dev->idx, num);
 
-	if (!num)
-		return 0;
-
 	/* Check the sanity of the passed messages.
 	 * Uhh, generic i2c layer is more suitable place for such code...
 	 */
-- 
2.11.0
