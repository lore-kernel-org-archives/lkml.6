Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753790AbeE3MTF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:19:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47701 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeE3MQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:16:30 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180530121628euoutp0135ec624e81396bfa5a515b7dce768c4d~zazhQXbOX0936309363euoutp01a
X-AuditID: cbfec7f2-5ffe19c000011644-3f-5b0e961a1137
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
Subject: [PATCH v2 04/10] drm/exynos: add non-panel path to
 exynos_dsi_enable()
Date: Wed, 30 May 2018 14:15:55 +0200
Message-id: <1527682561-1386-5-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfSzUcRzH+/4e7vdzc/bbYb6pWTu1RSVam2+UtaX127RVs6kx6eQ3zw+7
        Q7SWh013yPPyVOPKMR2K8xRiDXOZOcQKTcxZc44YaSjkHP+93+/Pa+/P57t9aVwoI23p0KhY
        ThIljhDx+ERL36b2nG2hhZ/zQgWBJt9pSZSl7cdQqnyJRA3F70lU3ruXja0v81D+dC6B5n+M
        EChHZ8DR0FA9hQZTFymUnqekkFr3lUSj7a94qHioC0MK/SSB6nqnKFT5bQRDaZ29FCou0PPQ
        ZnsZcdWarS2rBexodhbGtpVOUexLeQnJqlXpPLb1zwzJTmdqMLZRmcRmN6kAu6a2u8335V8O
        4iJC4znJeY8H/JBmQyEeU2ieMDM2iycDGT8DmNGQuQgbV1KwDMCnhUw1gEvNCspk1gCsaGon
        D6mZcgNuGlQBmKKcJExmF8D+vjd7FE3zGEdYKwsw5laMCsDG8SVgNDjzgoTD5Yb9KkvmDhxu
        W8WMmmBOwdyhTJ5RC5hrMGvlM2ZaZwcntOm4sdSM8YQ1Hz2MPZDJoaBSVk2ZGE/479fGwXmW
        cEHTdJAfh6MFmYRJR8O0n7qDPAF2ZQ0c8O6wRzOyr3HGAua3FO3vgowAyp8JTQgL8zqqSNMj
        iwBU5I7xcsFRBTiiAjZcnDQymJO6RHGPnKTiSGlcVLDTw+hINdj7HgM7mtUPYP1LYDdgaCAy
        FzjfE/gJSXG8NDGyG0AaF1kJ4jrN/YSCIHHiY04SHSCJi+Ck3eAYTYhsBPdPP/UVMsHiWC6c
        42I4yeEUo81sk4Gfw8ktw91VudelWZ+QK9TA2RW95i0hW3+tVZdux9jPKWts3HTWZ7wXlxMG
        r4tueu/KP+U1FD3pWJiA/RseFiuLN0q0ZesObmG3eub/9n8PD8wMThoOcrXrhCp/TW+V3n3L
        vtDVh5iLqD+xrawT7ejC9P7jXhd+t06B59lloFJESEPELo64RCr+Dx5EVrkaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsVy+t/xy7qS0/iiDa7MFLC4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsEroytr6cxF0zjqXhw5RFzA2M7VxcjJ4eEgInEg/mvmUFsIYEljBKzu/O6GLmA7EYm
        iRXLzrB3MXJwsAloSaxpjweJiwisYpSY+vcOO4jDLDCbVeLVowmMIN3CAv4S28/sYgOxWQRU
        JSac7wazeQWcJXo/nGCC2CYncfNcJzPIUE4BF4nVe+wgFjtL7GvpZJzAyLOAkWEVo0hqaXFu
        em6xkV5xYm5xaV66XnJ+7iZGYNhvO/Zzyw7GrnfBhxgFOBiVeHgNInijhVgTy4orcw8xSnAw
        K4nwlu7liRbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe96gMkpIID2xJDU7NbUgtQgmy8TBKdXA
        2DF5VXfngk+8Gzn7A5csE0wyW144Ldztl88zyyP3xM/cSL/8beM03297P51tk7s6tUJB6ckr
        AWbdT/F8zczTkj0r5td9/LjIUnTV2zuyD5NLW573RLmGB0dof5m7m+nijZPW739df9tyu477
        ZHZ6X/fv2e5TM/rs7qzV/bqM5/bFjeXBH0R4rZRYijMSDbWYi4oTASo+9AB3AgAA
X-CMS-MailID: 20180530121625eucas1p239693227eda97d090f3bfe530ded0c52
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180530121625eucas1p239693227eda97d090f3bfe530ded0c52
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
        <CGME20180530121625eucas1p239693227eda97d090f3bfe530ded0c52@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As DSIM can now have a bridge connected as a peripheral, it should be
possible to successfully enable exynos_dsi, when there is no panel
provided.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 7b50bad..7f6a0b1 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1382,27 +1382,25 @@ static void exynos_dsi_enable(struct drm_encoder *encoder)
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
+		if (ret < 0)
+			return;
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
