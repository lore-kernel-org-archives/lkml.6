Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbeE3MQp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:16:45 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34126 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbeE3MQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:16:28 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180530121626euoutp021fa672beea95199f574cc0b6a83d4856~zazffu8cv0118901189euoutp02c
X-AuditID: cbfec7f4-b4fc79c0000043e4-73-5b0e9618c1c0
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
Subject: [PATCH v2 02/10] drm/exynos: move pm_runtime_get_sync() to
 exynos_dsi_init()
Date: Wed, 30 May 2018 14:15:53 +0200
Message-id: <1527682561-1386-3-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe892Lg5nh2n4qiG0EsvQLPrwQmZSEgci8puimB7zeKFtyo5T
        F5RLXG3eL5iXQvdBxWzezWqolK3EJM1mTgXTkiRv5DA1ozLn9Nvv+T//58LDQwkkObgnlaxI
        45QKViYlRMLut1vD/vCBS1Tg/CdPNNUyjKOC4UEMZetWcNRe2YqjWvOONrb+g0ClM8VC9P3z
        qBAVzS0J0MhIG4neZy+TSF9SR6KOuXEcWUyPCFQ50ochw8KUEDWbp0lUbx3FkLbXTKLKsgUC
        bZlqhCGHGGONETCWwgKMeVE9TTIPdVU409GkJ5hnG7M4M5M3gDGddVlMYVcTYNY6vMNEkaKg
        eE6WnM4pTwXHipI23hiJ1PWDma0rM6QGtIhzgRMF6bOwsbQN2FlCNwJYMJOQC0Q7vAagccJE
        7pvKv37BHIkGALVPbQJHsA3g3W4tngsoiqD9oPF+jF13o5sA7JxYAfZAQJfj8EPtEm5v5UqH
        w7WpdszOQtoHVvWVAHuxmL4EV62sY5o3nBzWC+yyEx0Kn/QE29tAuoyE45p1wuEJhe9e5uMO
        doWLA117mx6Get0rzMEpUDs/t6dnwr6CoT3/Ofh6YHSXBbQLLO2u2J0FaTHU3ZM4LAy0bWsI
        x1UqAFzt8isGHgZwoAm4cypensjxZxRcRgDPynmVIjHgRoq8A+z8xtC/gZ/PgelPXD+gKSB1
        FgdGiKMkOJvOq+X9AFICqZtY1escJRHHs+pbnDIlRqmScXw/8KKEUnfx9eN3IiV0IpvG3eS4
        VE65n8UoJ08NOOKB2F/Viz7WuCDL5O1mfWD0YoUnYcmo5G1ey2HX/Ad7PkZkHI2u+z170XeV
        ixwzmOQTXuHqEu2grUjXYDU8PrF5ftQsl39bzk/ga6p5X1VcBGYM2YzNm/578oLX1Wb9lBxV
        1Xurs2TK5IV6RcxIq7dGljMdY7iiFh273CgV8knsaT+Bkmf/A6KnWIwXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsVy+t/xy7ri0/iiDWYcUbW4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsEroxvR9ewFXzlr1j/9j57A+M63i5GTg4JAROJqY8eMnUxcnEICSxhlPhz4xgrhNPI
        JLF5/hcgh4ODTUBLYk17PEhcRGAVo8TUv3fYQRxmgdmsEq8eTWAEGSUsEC7x+dZGJhCbRUBV
        Yua+iYwgzbwCzhIfridCbJOTuHmukxkkzCngIrF6jx1IWAioYl9LJ+MERp4FjAyrGEVSS4tz
        03OLDfWKE3OLS/PS9ZLzczcxAsN+27Gfm3cwXtoYfIhRgINRiYfXIII3Wog1say4MvcQowQH
        s5IIb+lenmgh3pTEyqrUovz4otKc1OJDjNIcLErivOcNKqOEBNITS1KzU1MLUotgskwcnFIN
        jBGzBHT/T+rQntIT+u/3xQ3Fm74fUXVuW1H8+S7Xjv9r5JkrnnxTabslwKY6OUlrveL2FeZv
        DnNkMO9ol/+ROUlDx3BX4/P/biZrp+abqirzvuFl3yST1bFjqejDBtYqZr5ltdPXrvtd+nQq
        58a2ZO13/+wuXlv4L36mxuTNQvtj2F4HhWfveavEUpyRaKjFXFScCAD3vPPIdwIAAA==
X-CMS-MailID: 20180530121623eucas1p1309b2c054ccd7a52a611b46346709af9
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180530121623eucas1p1309b2c054ccd7a52a611b46346709af9
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
        <CGME20180530121623eucas1p1309b2c054ccd7a52a611b46346709af9@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow bridge drivers to use DSI transfers in their
pre_enable callbacks, pm_runtime_get_sync() should be performed before
exynos_dsi_enable(). DSIM_STATE_ENABLED flag now should not guard
from calling dsi_host_transfer() before enabling.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 9599e6b..85eb2262 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1312,6 +1312,7 @@ static int exynos_dsi_init(struct exynos_dsi *dsi)
 {
 	const struct exynos_dsi_driver_data *driver_data = dsi->driver_data;
 
+	pm_runtime_get_sync(dsi->dev);
 	exynos_dsi_reset(dsi);
 	exynos_dsi_enable_irq(dsi);
 
@@ -1388,7 +1389,6 @@ static void exynos_dsi_enable(struct drm_encoder *encoder)
 	ret = drm_panel_prepare(dsi->panel);
 	if (ret < 0) {
 		dsi->state &= ~DSIM_STATE_ENABLED;
-		pm_runtime_put_sync(dsi->dev);
 		return;
 	}
 
@@ -1400,7 +1400,6 @@ static void exynos_dsi_enable(struct drm_encoder *encoder)
 		dsi->state &= ~DSIM_STATE_ENABLED;
 		exynos_dsi_set_display_enable(dsi, false);
 		drm_panel_unprepare(dsi->panel);
-		pm_runtime_put_sync(dsi->dev);
 		return;
 	}
 
@@ -1422,7 +1421,10 @@ static void exynos_dsi_disable(struct drm_encoder *encoder)
 
 	dsi->state &= ~DSIM_STATE_ENABLED;
 
-	pm_runtime_put_sync(dsi->dev);
+	if (dsi->state & DSIM_STATE_INITIALIZED) {
+		pm_runtime_put_sync(dsi->dev);
+		dsi->state &= ~DSIM_STATE_INITIALIZED;
+	}
 }
 
 static enum drm_connector_status
@@ -1566,9 +1568,6 @@ static ssize_t exynos_dsi_host_transfer(struct mipi_dsi_host *host,
 	struct exynos_dsi_transfer xfer;
 	int ret;
 
-	if (!(dsi->state & DSIM_STATE_ENABLED))
-		return -EINVAL;
-
 	if (!(dsi->state & DSIM_STATE_INITIALIZED)) {
 		ret = exynos_dsi_init(dsi);
 		if (ret)
-- 
2.7.4
