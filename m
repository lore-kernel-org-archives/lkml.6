Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753307AbeE3MQv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:16:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34137 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbeE3MQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:16:29 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180530121627euoutp02cfc17c175e328a25e0a816c08828d47f~zazgMJDg00060000600euoutp02O
X-AuditID: cbfec7f4-b4fc79c0000043e4-76-5b0e9619be7c
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v2 03/10] drm/exynos: move connector creation to attach
 callback
Date: Wed, 30 May 2018 14:15:54 +0200
Message-id: <1527682561-1386-4-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTYRjG+7Zz2/LkYVp+XZAaKNHFbgZfFyxN4kARlQWVUR3zsGVus51m
        N7sZmtvSvNVWeU9n6cxaWqlpoZKUpYlRKZnBwFomVjOhKM159L/f8zwv7wVeSqpIxmdRh7RH
        eb2Wi1UScuzBs99ti2denRa51NzgjbrvtOEote25BCWmDODonrUSR/nNY96bX4MEyuxNx9CX
        jx0Yuuzsl6L29rskepX4jUTGjGISOZxvcdRZm0Mga3uDBBW4ujFU0dxDopJ3HRKUVN9MImuW
        i0C/a/Ow9dNZe54dsJ1pqRK25noPyd5IuYazjjIjwT4c/oSzveYWCXu/+CybVlUGWLfDf6t8
        j3xtNB97KJ7XLwk5IFc7u4uJuJu+xysvvcPPATdjAjIKMsGweeQNaQJySsHcArCuqEIiCjeA
        g44/5GTV5+qeicAGoLGrDhPFKIAFRbWECVAUwSyA9ov7Pb4vUwbg/fcDwCOkzBUcvs7vxz2t
        fJjt0FF/d5wxJgB+d72SeJhmNkDrz1wgjvOHXW1GqaepjAmH5Y9DRDuLhIWmCJHDYU31qFRk
        H/i1pWpi0zmwM8uMiayDSX3OCf84bEhtxUVeA5taOsZZykyDmQ8s46MgQ8OUZIVYwsKS7OuE
        eKMFwNHkVJAOZhaAKWXAjzcIGhUvLNfyx4IETiMYtKqggzqNA4x9R+tIy9AjUPs3qhEwFFB6
        0Ut30ZEKnIsXTmgaAaSkSl/aUO8VqaCjuRMneb1uv94QywuNYDaFKf3offPP7FEwKu4of5jn
        43j9ZCqhZLPOgYUvm9Q/YlynM3yOvNRxCaUR1f7mGV2yHedzXj904KuEUu/+D6tlq7X/LC9K
        7PRcizHwSYfNQIQN3dv9dFCVbc0eHgqjT52fWul+Fhpo9/vWG2CzJa+8zarLt23ZOLrC9iHz
        Rmbhpj5jwl7eHlO6fOcir+8puVGbZwRw7nkXQtcFKzFBzS1bINUL3H9rzpfaGQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t/xy7oS0/iiDV6flrK4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsErozHt5awFSwWqVjfc521gfGzQBcjJ4eEgInE8613mboYuTiEBJYwSsx7NJEVwmlk
        krj/YD1bFyMHB5uAlsSa9niQuIjAKkaJqX/vsIM4zAKzWSVePZrACDJKWCBAYu2ETWA2i4Cq
        xIeXZ5lAbF4BZ4kZn+YyQqyTk7h5rpMZZCingIvE6j12IGEhoJJ9LZ2MExh5FjAyrGIUSS0t
        zk3PLTbSK07MLS7NS9dLzs/dxAgM/G3Hfm7Zwdj1LvgQowAHoxIPr0EEb7QQa2JZcWXuIUYJ
        DmYlEd7SvTzRQrwpiZVVqUX58UWlOanFhxilOViUxHnPG1RGCQmkJ5akZqemFqQWwWSZODil
        GhgzLsU+ZNPkfOnR3r4j9MDjUoVVM37897zRFnb7SYRK3z7LouVnSibOV/1mKu264CxjymMJ
        ufYFp1e32toFz0rPWvFoW/WFgM8fZVQXrE/6+2/+kVklSkvnVX4KzN46+U3GfPcIVoGZpR4b
        LsT/Vw9Umzp1ctcZObVyv5fr1p5x1Gu8LM5RxX5FiaU4I9FQi7moOBEAtuAUBHgCAAA=
X-CMS-MailID: 20180530121624eucas1p2678b6a5424cb8df286b6142cd3754b65
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180530121624eucas1p2678b6a5424cb8df286b6142cd3754b65
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
        <CGME20180530121624eucas1p2678b6a5424cb8df286b6142cd3754b65@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation assumes that the only possible peripheral
device for DSIM is a panel. Using an output bridge should also be
possible.

If an output bridge in available, don't create a new connector.
Instead add bridge to DSIM encdoer in dsi_host_attach().

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 35 +++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 85eb2262..7b50bad 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1501,7 +1501,28 @@ static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
 				  struct mipi_dsi_device *device)
 {
 	struct exynos_dsi *dsi = host_to_dsi(host);
-	struct drm_device *drm = dsi->connector.dev;
+	struct drm_encoder *encoder = &dsi->encoder;
+	struct drm_device *drm = encoder->dev;
+	struct drm_bridge *out_bridge;
+
+	out_bridge  = of_drm_find_bridge(device->dev.of_node);
+	if (out_bridge) {
+		drm_bridge_attach(encoder, out_bridge, NULL);
+	} else {
+		int ret = exynos_dsi_create_connector(encoder);
+
+		if (ret) {
+			DRM_ERROR("failed to create connector ret = %d\n", ret);
+			drm_encoder_cleanup(encoder);
+			return ret;
+		}
+
+		dsi->panel = of_drm_find_panel(device->dev.of_node);
+		if (dsi->panel) {
+			drm_panel_attach(dsi->panel, &dsi->connector);
+			dsi->connector.status = connector_status_connected;
+		}
+	}
 
 	/*
 	 * This is a temporary solution and should be made by more generic way.
@@ -1520,11 +1541,6 @@ static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
 	dsi->lanes = device->lanes;
 	dsi->format = device->format;
 	dsi->mode_flags = device->mode_flags;
-	dsi->panel = of_drm_find_panel(device->dev.of_node);
-	if (dsi->panel) {
-		drm_panel_attach(dsi->panel, &dsi->connector);
-		dsi->connector.status = connector_status_connected;
-	}
 	exynos_drm_crtc_get_by_type(drm, EXYNOS_DISPLAY_TYPE_LCD)->i80_mode =
 			!(dsi->mode_flags & MIPI_DSI_MODE_VIDEO);
 
@@ -1653,13 +1669,6 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
 	if (ret < 0)
 		return ret;
 
-	ret = exynos_dsi_create_connector(encoder);
-	if (ret) {
-		DRM_ERROR("failed to create connector ret = %d\n", ret);
-		drm_encoder_cleanup(encoder);
-		return ret;
-	}
-
 	if (dsi->mic_bridge_node) {
 		mic_bridge = of_drm_find_bridge(dsi->mic_bridge_node);
 		if (mic_bridge)
-- 
2.7.4
