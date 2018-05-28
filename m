Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932171AbeE1Jrl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:47:41 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55004 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754200AbeE1Jr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:47:27 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180528094725euoutp01b8a2d04b382ec919adf499b919f641e7~yxe0B3Vaj1908919089euoutp01C
X-AuditID: cbfec7f2-5ffe19c000011644-b7-5b0bd02cadfa
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
Subject: [PATCH 02/12] drm/exynos: move pm_runtime_get_sync() to
 exynos_dsi_init()
Date: Mon, 28 May 2018 11:47:06 +0200
Message-id: <1527500833-16005-3-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduzneV2dC9zRBl/+c1jcWneO1aL33Ekm
        i6aOt6wWG2esZ7WYfwQoduXrezaLSfcnsFi8uHeRxaL/8Wtmi/PnN7BbnG16w27ROXEJu8Wm
        x9dYLS7vmsNmMeP8PiaLBS9vsVisPXKX3WLp9YtMFq17j7BbzJj8ks3i5655LA6iHmvmrWH0
        uNzXy+Sxc9Zddo/ZHTNZPTat6mTz2P7tAavH/e7jTB6bl9R79G1ZxejxeZNcAFcUl01Kak5m
        WWqRvl0CV0bf2262ggW8FV97trM2ME7k7mLk5JAQMJE4ffkpYxcjF4eQwApGid2/ljNBOJ8Z
        JWZc38cOU7VzwmY2iMQyRolfPY9YIJz/jBLHF74AquLgYBPQkljTHg8SFxFYxSix+cZbsLnM
        AlNZJS7Mf80KMkpYIETix4ZdbCANLAKqEj//+4KEeQVcJN58b2SE2CYncfNcJzOIzSngKnF5
        bxvYZgmBbnaJt+vPM4P0SgA1TOpkhagXlnh1fAvUpTISnR0HmSDsfInWZ4+h4hUS+3pPQ9Vb
        Sxw+fhHMZhbgk5i0bTrUSF6JjjYhiBIPiaaGh1APz2CUeHD5EeMERskFjAyrGMVTS4tz01OL
        DfNSy/WKE3OLS/PS9ZLzczcxAlPH6X/HP+1g/Hop6RCjAAejEg+vxk+uaCHWxLLiytxDjBIc
        zEoivFy6QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8cRp1UUIC6YklqdmpqQWpRTBZJg5OqQbG
        6qPiVqGLHveuKU27kmye2TJF7MO9j58a5eLSZBfWCIl+K8tdte3F1tWvPXlO8lRWzpl1RE1m
        bbVOzLpzs4O73i7ds71RvGytG2tzXuk6v3bW+n2x+3Zrnd2zLvNKpPdlm6/T05c87zJKqFGz
        r7N+Pcv1mYfA9P2BVU8kHu26MPVz4NLD0quZlViKMxINtZiLihMBy/TUkhkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsVy+t/xy7raF7ijDa6vkbe4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsEroy+t91sBQt4K772bGdtYJzI3cXIySEhYCKxc8JmNhBbSGAJo8Smt+5djFxAdiOT
        xMRNbUAJDg42AS2JNe3xIHERgVWMElP/3mEHcZgFZrNKvHo0gRGkW1ggROLHhl1gDSwCqhI/
        //uChHkFXCTefG9khFgmJ3HzXCcziM0p4CpxeW8b1GIXie2Ns1gmMPIsYGRYxSiSWlqcm55b
        bKhXnJhbXJqXrpecn7uJERj224793LyD8dLG4EOMAhyMSjy8Db+5ooVYE8uKK3MPMUpwMCuJ
        8HLpAoV4UxIrq1KL8uOLSnNSiw8xSnOwKInznjeojBISSE8sSc1OTS1ILYLJMnFwSjUwmpzb
        YHea9Y6aWur8++sVjq5dJXGUNSp2br+37t3rQYd8V8Y/SlqTcXtZ/k5jG75zC7PYnISTG7Wf
        HX69IPBhWPffU6LLP6bo/n/1VGNfYZBufbhf5QPGixmXrSoX/VARXtG1+lfGi2KXCBOT4ich
        J7RcL6htOczSETp13zrlSweerWN4cfVQtRJLcUaioRZzUXEiAJDlcSh3AgAA
X-CMS-MailID: 20180528094723eucas1p1776829e0b57d2ec6c4e28be872cf88fc
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180528094723eucas1p1776829e0b57d2ec6c4e28be872cf88fc
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
        <CGME20180528094723eucas1p1776829e0b57d2ec6c4e28be872cf88fc@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow bridge drivers to use DSI transfers in their
pre_enable callbacks, pm_runtime_get_sync() should be performed before
exynos_dsi_enable(). DSIM_STATE_ENABLED flag now should not guard
from calling dsi_host_transfer() before enabling.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 9599e6b..94460b0 100644
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
 
@@ -1566,9 +1565,6 @@ static ssize_t exynos_dsi_host_transfer(struct mipi_dsi_host *host,
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
