Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932211AbeE1Jrs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:47:48 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55016 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754216AbeE1Jr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:47:28 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180528094726euoutp0128457152d56b120324682396e459fe57~yxe04Vyfp1961319613euoutp01S
X-AuditID: cbfec7f5-b45ff700000028a9-fb-5b0bd02d94d5
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
Subject: [PATCH 03/12] drm/exynos: move connector creation to attach
 callback
Date: Mon, 28 May 2018 11:47:07 +0200
Message-id: <1527500833-16005-4-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0gUURjFvTszO+PW2rQa3jTEFsoQtKKCG2YPSBglsCgolLTVnVbRVdvx
        /Ue+Unct31jrA11K0zaf66Pc0EwlSfOVlWaYmSA+UTIFSzTX0f9+3/nOPYcPLoVJUgkbKjAk
        nFWFyIKlQhHe9H6t38lpYI/3iYENAo1W9xEove+DACWqFwhUp60hUEnnlvZ5ZVGIcsazcDT9
        YxBHmZNzGOrvryVRb+I8iTTZpSQyTH4l0JCxSIi0/a0CpJsZxVFV5xiJyoYHBSi5pZNE2twZ
        IVozFuMXDzCVxZWAGcpIFzDNBWMkU6jOJxiDXiNkXq3+JJjxh10Cpr40jslo0ANm2WB3VeQl
        OidngwMjWdXx83dEAfmFRjzsqVW0oTYLjwe/6TRgTkH6NCw3NOBpQERJ6AoAdYVLQn5YBrCu
        vAnbdfWkV2L84jmAH5Obd1ybAC62DZNpgKKEtCOsTPU16Va0HsD6kQVgGjA6j4ADJXOEKcqS
        9oQVCTnAxDh9BBqLG0gTi+nLMKP6GeDr7OC3Ps12tTntBodaUrbbIJ1JwuKZMqGpDW49+N5h
        wfst4WwXnwPpQ1CjfifgORQmT03u6NGwNb2H4NkFdnQNbjNGW8CcpicYHymG6hQJb2GgPnGT
        4I/UAtj24C2eBQ7qgJkeWLMRnFLBcqdC2ChnTqbkIkIUzv6hSgPY+h49G10rr0Hrul87oCkg
        3SuO/yfylhCySC5G2Q4ghUmtxCKnLUksl8XEsqpQX1VEMMu1A1sKl1qLfY7d95LQClk4G8Sy
        YaxqdyugzG3iQRWLvTzTcMu10cGj0dXdzyjCJpIS+vavX38RcIGSCxTXfKKyH/f6TV2R6zYj
        LRUThns3itx1Rz20892Dd+NGctk/3Wml1Z+CzGve/NLb7xudoeUb/vYOSxrbL7FJq7cvPVJ5
        +hbM9sZ5tiurlC55weU33TYOc2Nn1dN/DaFmFZ1SnAuQnXTEVJzsP2iQfPsaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t/xy7o6F7ijDSYckbC4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsEroyZs3exFCwSqdi0YQJLA+MngS5GTg4JAROJ071rmLsYuTiEBJYwSkzY+hzKaWSS
        2NLwk72LkYODTUBLYk17PEhcRGAVo8TUv3fYQRxmgdmsEq8eTWAEGSUs4CuxbNkJZhCbRUBV
        Yte8LewgNq+Ai0TfusWMEOvkJG6e6wSr4RRwlbi8t40NxBYCqtneOItlAiPPAkaGVYwiqaXF
        uem5xYZ6xYm5xaV56XrJ+bmbGIGhv+3Yz807GC9tDD7EKMDBqMTD2/CbK1qINbGsuDL3EKME
        B7OSCC+XLlCINyWxsiq1KD++qDQntfgQozQHi5I473mDyighgfTEktTs1NSC1CKYLBMHp1QD
        o2Ekw5S7wgdXapzNf9gxK3nv9O6vLLc2/Npvuby2auFP7uOpWzdp7LJcufqnYPKFuwHbamOC
        NENMdt2cKGN6cxZP9c11cZr8/IppYv4Ve1fvnzY34Krx/nim+W8zp+fcOf0v3Oe96vc2JWM9
        V2P3nOTChO59aW7L/upxP3w+4X6G99/Xn2qi/ZRYijMSDbWYi4oTAaeOMp95AgAA
X-CMS-MailID: 20180528094724eucas1p17a37e06002ed96d97aaca87231f13bbb
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180528094724eucas1p17a37e06002ed96d97aaca87231f13bbb
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
        <CGME20180528094724eucas1p17a37e06002ed96d97aaca87231f13bbb@eucas1p1.samsung.com>
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
index 94460b0..8957faf 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1498,7 +1498,28 @@ static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
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
@@ -1517,11 +1538,6 @@ static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
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
 
@@ -1650,13 +1666,6 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
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
