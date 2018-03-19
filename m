Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032258AbeCSV0k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:26:40 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:44234 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933624AbeCSV0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:26:37 -0400
From: Stefan Agner <stefan@agner.ch>
To: robdclark@gmail.com, airlied@linux.ie
Cc: architt@codeaurora.org, seanpaul@chromium.org, ssusheel@codeaurora.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] drm/msm/dsi: use correct enum in dsi_get_cmd_fmt
Date: Mon, 19 Mar 2018 22:26:32 +0100
Message-Id: <20180319212632.11260-1-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function dsi_get_cmd_fmt returns enum dsi_cmd_dst_format,
use the correct enum value also for MIPI_DSI_FMT_RGB666/_PACKED.

This has been discovered using clang:
  drivers/gpu/drm/msm/dsi/dsi_host.c:743:35: warning: implicit conversion
        from enumeration type 'enum dsi_vid_dst_format' to different
        enumeration type 'enum dsi_cmd_dst_format' [-Wenum-conversion]
          case MIPI_DSI_FMT_RGB666:       return VID_DST_FORMAT_RGB666;
                                          ~~~~~~ ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 0f7324a686ca..d729b2b4b66d 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -740,7 +740,7 @@ static inline enum dsi_cmd_dst_format dsi_get_cmd_fmt(
 	switch (mipi_fmt) {
 	case MIPI_DSI_FMT_RGB888:	return CMD_DST_FORMAT_RGB888;
 	case MIPI_DSI_FMT_RGB666_PACKED:
-	case MIPI_DSI_FMT_RGB666:	return VID_DST_FORMAT_RGB666;
+	case MIPI_DSI_FMT_RGB666:	return CMD_DST_FORMAT_RGB666;
 	case MIPI_DSI_FMT_RGB565:	return CMD_DST_FORMAT_RGB565;
 	default:			return CMD_DST_FORMAT_RGB888;
 	}
-- 
2.16.2
