Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeDIIpg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 04:45:36 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:56403 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeDIIpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 04:45:34 -0400
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <tony@atomide.com>, <lee.jones@linaro.org>
CC: <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hns@goldelico.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] mfd: twl-core: Fix clock initialization
Date: Mon, 9 Apr 2018 11:45:39 +0300
Message-ID: <20180409084539.14365-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When looking up the clock we must use the client->dev as device since that
is the one which is probed via DT.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: stable@vger.kernel.org # 4.16+
---
Hi,

Changes since v1:
- Removed the Fixes line and add tag only for v4.16 to avoid possible breakage
  in pre v4.16.
 
Regards,
Peter

 drivers/mfd/twl-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index d3133a371e27..c649344fd7f2 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1177,7 +1177,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	twl_priv->ready = true;
 
 	/* setup clock framework */
-	clocks_init(&pdev->dev, pdata ? pdata->clock : NULL);
+	clocks_init(&client->dev, pdata ? pdata->clock : NULL);
 
 	/* read TWL IDCODE Register */
 	if (twl_class_is_4030()) {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
