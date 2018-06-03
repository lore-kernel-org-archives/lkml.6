Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeFCUQZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 16:16:25 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:32796 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeFCUQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 16:16:24 -0400
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sun, 03 Jun 2018 22:16:23 +0200
X-ME-IP: 90.55.202.35
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Lee Jones <lee.jones@linaro.org>
Cc: patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] mfd: wm97xx-core: platform data can be NULL
Date: Sun,  3 Jun 2018 22:16:17 +0200
Message-Id: <20180603201617.15805-1-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not mandatory that platform data is passed along the ac97
codec. Actually there are configuration without a battery connected to
the ADC of the codec.

This is for example the case for the PXA zylonite platform, so fix the
NULL dereferencing by adding a test.

Fixes: a5c6951c49fb ("mfd: wm97xx-core: core support for wm97xx Codec")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/mfd/wm97xx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/wm97xx-core.c b/drivers/mfd/wm97xx-core.c
index 4141ee52a70b..f5a8347f837f 100644
--- a/drivers/mfd/wm97xx-core.c
+++ b/drivers/mfd/wm97xx-core.c
@@ -278,7 +278,7 @@ static int wm97xx_ac97_probe(struct ac97_codec_device *adev)
 
 	codec_pdata = &wm97xx->codec_pdata;
 	codec_pdata->ac97 = wm97xx->ac97;
-	codec_pdata->batt_pdata = pdata->batt_pdata;
+	codec_pdata->batt_pdata = pdata ? pdata->batt_pdata : NULL;
 
 	switch (adev->vendor_id) {
 	case WM9705_VENDOR_ID:
-- 
2.11.0
