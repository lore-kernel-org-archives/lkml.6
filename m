Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeBWLon (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:44:43 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37091 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbeBWLom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:44:42 -0500
X-Google-Smtp-Source: AH8x2244Lpcly3MQw5qBJ7Cp5URgXirn7iE2mRGmBTCN7PN0ufzSaJNGdF/WL/uHeI0mjOch3SiuOQ==
From: Neil Armstrong <narmstrong@baylibre.com>
To: airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, Jose.Abreu@synopsys.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic Meson GX SoCs
Date: Fri, 23 Feb 2018 12:44:37 +0100
Message-Id: <1519386277-25902-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson GX SoCs, embedded the v2.01a controller, has been also
identified needing this workaround.
This patch adds the corresponding version to enable a single iteration for
this specific version.

Fixes: be41fc55f1aa ("drm: bridge: dw-hdmi: Handle overflow workaround based on device version")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index a38db40..f5018f9 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1637,6 +1637,8 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
 	 * (and possibly on the platform). So far only i.MX6Q (v1.30a) and
 	 * i.MX6DL (v1.31a) have been identified as needing the workaround, with
 	 * 4 and 1 iterations respectively.
+	 * The Amlogic Meson GX SoCs (v2.01a) have been identifies as needing
+	 * the workaround with a single iteration.
 	 */
 
 	switch (hdmi->version) {
@@ -1644,6 +1646,7 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
 		count = 4;
 		break;
 	case 0x131a:
+	case 0x201a:
 		count = 1;
 		break;
 	default:
-- 
2.7.4
