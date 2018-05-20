Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeETGvc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 02:51:32 -0400
Received: from sauhun.de ([88.99.104.3]:41544 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751657AbeETGus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 02:50:48 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] drm/msm/hdmi: don't check number of messages in the driver
Date: Sun, 20 May 2018 08:50:44 +0200
Message-Id: <20180520065045.8108-1-wsa@the-dreams.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 1eace8344c02 ("i2c: add param sanity check to
i2c_transfer()"), the I2C core does this check now. We can remove it
from drivers.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Only build tested.

 drivers/gpu/drm/msm/hdmi/hdmi_i2c.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
index 73e20219d431..cc8b27d440bb 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
@@ -115,9 +115,6 @@ static int msm_hdmi_i2c_xfer(struct i2c_adapter *i2c,
 
 	WARN_ON(!(hdmi_read(hdmi, REG_HDMI_CTRL) & HDMI_CTRL_ENABLE));
 
-	if (num == 0)
-		return num;
-
 	init_ddc(hdmi_i2c);
 
 	ret = ddc_clear_irq(hdmi_i2c);
-- 
2.11.0
