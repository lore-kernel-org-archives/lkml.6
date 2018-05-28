Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933309AbeE1JuK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:50:10 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40570 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754237AbeE1Jr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:47:29 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180528094727euoutp028443f87c575d8b53f6dda611f3d2899a~yxe1t9eMS1508215082euoutp02P
X-AuditID: cbfec7f5-b5fff700000028a9-fc-5b0bd02d5633
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
Subject: [PATCH 04/12] drm/exynos: add non-panel path to exynos_dsi_enable()
Date: Mon, 28 May 2018 11:47:08 +0200
Message-id: <1527500833-16005-5-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTURjHO3uvTlcv0/JoIToKwrsYcsRuHxy9kh/60ocUtJUvaumUzWuE
        mqLpvObIZuU1DVnLdIql4ZIlzkttykRLNAtTvCZhBqZkzte+/Z7f+fM8zzkcGhPnEq50vDyF
        U8hlCRJSiHcNbJl9fEbtI/0HChCaajUTqNQ8JEC5hWsEate8IlBd/54b31wnUeVsBY4Wv4zh
        qHxuBUMWSxuFPuauUqjoQROF9HMTBLL2PCWRxmIQoPqlKRy97J+hUPPkmADl9/ZTSKNeItFW
        Ty1+8Sirq9UB1lpWKmC7H89Q7JPCaoLVa4tI9vXvrwQ7W2wSsB1N2WxZpxawG3q3K8II4dkY
        LiE+jVP4nb8ujFstXyaS6xwyCqeH8RxQLFQBOxoyZ2DruAq3sZhpAdA0D1VAuMcbAG4NVpEq
        QO+Har6F8P45gM9mpkm+2AXQvFsCbCGS8YS6+9E278RoAez4tAZsBcY8JOBo3QphCzky4XCy
        +5wNceYUXDSk2AaLmFA4VFVC8Au5wc/mIszGdowUWnsLSN6XU7BPreA5FC7UWDGeHeGyqZPi
        +QS0qotxnpNg/sLcgc+AhtKRg/4h8L1pbJ8x5jCs7HqE8XcUwcICMR9h4bx2kOTfRANg5Ydb
        FcClHhzSAmcuVZkYyykD5Vy6r1KWqEyVx/reTErUg72fMfLXtPkGGHZuGAFDA4mDKGdbGCkm
        ZGnKzEQjgDQmcRIJffaUKEaWeYdTJEUrUhM4pREcp3GJsyjqdFaEmImVpXC3OS6ZU/w/FdB2
        rjkgXG3uEhtEHkHud1dM17QrUfFGS3ZgQ1pjkH1004I73a6yhIYE6vrS873frVZ3uYReiLvn
        0JJl3+ET6b4e6H/kUvfPnWCX738qRNLgt4NhL9Y9mv2810/mmX5cbds+FpAR41XbsCbl7KSN
        YclUvHHNa2JHHyCdHe6Tb43k/XK8LMGVcbIAT0yhlP0DjeL7RRUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t/xy7q6F7ijDfY85bG4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsErow3/a9YC+bzVHTcOcXSwNjN1cXIwSEhYCIx96F1FyMXh5DAEkaJg+s2sUM4jUwS
        b1a9YwYpYhPQkljTHg8SFxFYxSgx9e8dsCJmgdmsEq8eTWAEKRIW8JG4vtMWxGQRUJV4sa+k
        i5GTg1fAReLktB5WEFtCQE7i5rlOZhCbU8BV4vLeNjYQWwioZnvjLJYJjDwLGBlWMYqklhbn
        pucWG+kVJ+YWl+al6yXn525iBAb9tmM/t+xg7HoXfIhRgINRiYdX4ydXtBBrYllxZe4hRgkO
        ZiURXi5doBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe8waVUUIC6YklqdmpqQWpRTBZJg5OqQbG
        qdP3WR0LsLDVN8grLhDTOhD7sUw8cV7RtmvCa+bNtDP5+WDqgrYFvtOmeBstmdU77Va3423Z
        9L9cor2RBrf3JHPu2rsgZ9c66XZGgem/XdcvFC590L/eV6UnSeDb7octvznCRf9pHZm3ye6u
        YEhXh7vw97y+J08P/Gs056xzTH//VnnlxZs7lFiKMxINtZiLihMBu92pr3YCAAA=
X-CMS-MailID: 20180528094725eucas1p2e80e551edb29dd4ab437246f4896d108
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180528094725eucas1p2e80e551edb29dd4ab437246f4896d108
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
        <CGME20180528094725eucas1p2e80e551edb29dd4ab437246f4896d108@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As DSIM can now have a bridge connected as a peripheral, it should be
possible to successfully enable exynos_dsi, when there is no panel
provided.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 8957faf..7d92e50 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1382,27 +1382,26 @@ static void exynos_dsi_enable(struct drm_encoder *encoder)
 	if (dsi->state & DSIM_STATE_ENABLED)
 		return;
 
-	pm_runtime_get_sync(dsi->dev);
-
-	dsi->state |= DSIM_STATE_ENABLED;
-
-	ret = drm_panel_prepare(dsi->panel);
-	if (ret < 0) {
-		dsi->state &= ~DSIM_STATE_ENABLED;
-		return;
+	if (dsi->panel) {
+		ret = drm_panel_prepare(dsi->panel);
+		if (ret < 0) {
+			return;
+		}
 	}
 
 	exynos_dsi_set_display_mode(dsi);
 	exynos_dsi_set_display_enable(dsi, true);
 
-	ret = drm_panel_enable(dsi->panel);
-	if (ret < 0) {
-		dsi->state &= ~DSIM_STATE_ENABLED;
-		exynos_dsi_set_display_enable(dsi, false);
-		drm_panel_unprepare(dsi->panel);
-		return;
+	if (dsi->panel) {
+		ret = drm_panel_enable(dsi->panel);
+		if (ret < 0) {
+			exynos_dsi_set_display_enable(dsi, false);
+			drm_panel_unprepare(dsi->panel);
+			return;
+		}
 	}
 
+	dsi->state |= DSIM_STATE_ENABLED;
 	dsi->state |= DSIM_STATE_VIDOUT_AVAILABLE;
 }
 
-- 
2.7.4
