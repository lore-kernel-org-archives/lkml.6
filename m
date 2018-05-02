Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeEBMw4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:52:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60299 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbeEBMwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:52:37 -0400
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
To: dri-devel@lists.freedesktop.org
Cc: p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] gpu: ipu-csi: add rgb/bgr888 24bit support to mbus_code_to_bus_cfg
Date: Wed,  2 May 2018 14:52:26 +0200
Message-Id: <20180502125226.24149-1-m.grzeschik@pengutronix.de>
X-Mailer: git-send-email 2.17.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 24bit RGB format configuration is currently missing, we add
it now.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/gpu/ipu-v3/ipu-csi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-csi.c b/drivers/gpu/ipu-v3/ipu-csi.c
index caa05b0702e16..1a0ee65fd4859 100644
--- a/drivers/gpu/ipu-v3/ipu-csi.c
+++ b/drivers/gpu/ipu-v3/ipu-csi.c
@@ -247,6 +247,12 @@ static int mbus_code_to_bus_cfg(struct ipu_csi_bus_config *cfg, u32 mbus_code)
 		cfg->mipi_dt = MIPI_DT_RGB555;
 		cfg->data_width = IPU_CSI_DATA_WIDTH_8;
 		break;
+	case MEDIA_BUS_FMT_RGB888_1X24:
+	case MEDIA_BUS_FMT_BGR888_1X24:
+		cfg->data_fmt = CSI_SENS_CONF_DATA_FMT_RGB_YUV444;
+		cfg->mipi_dt = MIPI_DT_RGB888;
+		cfg->data_width = IPU_CSI_DATA_WIDTH_8;
+		break;
 	case MEDIA_BUS_FMT_UYVY8_2X8:
 		cfg->data_fmt = CSI_SENS_CONF_DATA_FMT_YUV422_UYVY;
 		cfg->mipi_dt = MIPI_DT_YUV422;
-- 
2.17.0
