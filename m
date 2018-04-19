Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753444AbeDSM6Q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:58:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33760 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751375AbeDSM6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:58:13 -0400
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] drm/sun4i: Add missing frontend compatibles for A10, A13, A20 and A31
Date: Thu, 19 Apr 2018 14:56:38 +0200
Message-Id: <20180419125638.11683-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although frontend nodes are defined in the device-trees of the
aforementioned platforms, there are no matching compatibles defined in
the driver. This makes it impossible to probe the frontend on these
platforms.

Adding the appropriate compatibles to the driver fixes the issue.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 85f75046712c..c5a3de11817d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -658,6 +658,10 @@ static const struct dev_pm_ops sun4i_frontend_pm_ops = {
 };
 
 const struct of_device_id sun4i_frontend_of_table[] = {
+	{ .compatible = "allwinner,sun7i-a10-display-frontend" },
+	{ .compatible = "allwinner,sun7i-a13-display-frontend" },
+	{ .compatible = "allwinner,sun7i-a20-display-frontend" },
+	{ .compatible = "allwinner,sun7i-a31-display-frontend" },
 	{ .compatible = "allwinner,sun8i-a33-display-frontend" },
 	{ }
 };
-- 
2.16.3
