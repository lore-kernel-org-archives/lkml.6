Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964871AbeCENQt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:16:49 -0500
Received: from mail.x-arc.co.uk ([217.6.246.34]:37963 "EHLO root.phytec.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932084AbeCENQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:16:48 -0500
From: Daniel Schultz <d.schultz@phytec.de>
To: lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc: w.egorov@phytec.de
Subject: [PATCH 1/2] mfd: rk808: Change DEV_OFF to DEV_OFF_RST for rk818 shutdown
Date: Mon, 5 Mar 2018 14:16:40 +0100
Message-Id: <1520255801-8557-1-git-send-email-d.schultz@phytec.de>
X-Mailer: git-send-email 2.7.4
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 05.03.2018 14:16:46,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 05.03.2018 14:16:46,
        Serialize complete at 05.03.2018 14:16:46
X-TNEFEvaluated: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After running "poweroff", the PMIC restarts the SoC instead of shutting
it down.

It seems like the description for those two register bits is swapped.
After changing from DEV_OFF to DEV_OFF_RST, the system can poweroff
correctly.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 drivers/mfd/rk808.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 216fbf6..d138721 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -418,7 +418,7 @@ static void rk818_device_shutdown(void)
 
 	ret = regmap_update_bits(rk808->regmap,
 				 RK818_DEVCTRL_REG,
-				 DEV_OFF, DEV_OFF);
+				 DEV_OFF_RST, DEV_OFF_RST);
 	if (ret)
 		dev_err(&rk808_i2c_client->dev, "power off error!\n");
 }
-- 
2.7.4
