Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934073AbeCGRCC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:02:02 -0500
Received: from mail.x-arc.de ([217.6.246.34]:39980 "EHLO root.phytec.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933468AbeCGRB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:01:58 -0500
From: Daniel Schultz <d.schultz@phytec.de>
To: lee.jones@linaro.org
Cc: zyw@rock-chips.com, zhangqing@rock-chips.com, chenjh@rock-chips.com,
        linux-kernel@vger.kernel.org, w.egorov@phytec.de
Subject: [PATCH v2 1/2] mfd: rk808: Change DEV_OFF to DEV_OFF_RST for rk818 shutdown
Date: Wed, 7 Mar 2018 18:01:49 +0100
Message-Id: <1520442110-28420-1-git-send-email-d.schultz@phytec.de>
X-Mailer: git-send-email 2.7.4
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 07.03.2018 18:01:55,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 07.03.2018 18:01:55,
        Serialize complete at 07.03.2018 18:01:55
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
Changes:
	v2: Re-submit with recipients from Rockchip.

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
