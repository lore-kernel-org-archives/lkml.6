Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753730AbeE3MSn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:18:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34159 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbeE3MQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:16:32 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180530121629euoutp02a2e5b77f17aa487b9e479647acbeab32~zazi2fIaQ0061000610euoutp02V
X-AuditID: cbfec7f2-5ffe19c000011644-49-5b0e961bbf05
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
Subject: [PATCH v2 06/10] drm/panel: add support for BOE HV070WSA-100 panel
 to simple-panel
Date: Wed, 30 May 2018 14:15:57 +0200
Message-id: <1527682561-1386-7-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduzneV3paXzRBrMvWVncWneO1aL33Ekm
        i6aOt6wWG2esZ7WYfwQoduXrezaLSfcnsFi8uHeRxaL/8Wtmi/PnN7BbnG16w27ROXEJu8Wm
        x9dYLS7vmsNmMeP8PiaLBS9vsVisPXKX3WLp9YtMFq17j7BbzJj8ks3i5655LA6iHmvmrWH0
        uNzXy+Sxc9Zddo/ZHTNZPTat6mTz2P7tAavH/e7jTB6bl9R79G1ZxejxeZNcAFcUl01Kak5m
        WWqRvl0CV8bhi53MBQd5Kl6sPMbewNjC1cXIwSEhYCJx6I9NFyMnh5DACkaJb82pXYxcQPZn
        Rom2U49YQRIgNVufPGKBSCxjlDgxaTYjhPOfUeL5oT+sIJPYBLQk1rTHg8RFBFYxSmy+8Ras
        iFlgKqvEhfmvwUYJC8RKLP14mB3EZhFQlWib8oYZxOYVcJZo/bWfBWKdnMTNc53MIEM5BVwk
        Vu+xA5kjITCZXeL9mo1MEDUuEn9OTmWEsIUlXh3fwg5hy0h0dhyEqsmXaH32GCpeIbGv9zTU
        O9YSh49fBLOZBfgkJm2bzgwJCl6JjjYhiBIPiYc9y5kgwTKdUeL4Sq4JjJILGBlWMYqnlhbn
        pqcWG+allusVJ+YWl+al6yXn525iBKaN0/+Of9rB+PVS0iFGAQ5GJR5egwjeaCHWxLLiytxD
        jBIczEoivKV7eaKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ88Zp1EUJCaQnlqRmp6YWpBbBZJk4
        OKUaGKcvXp0SqbCJf5PYv8978/knrXTdK+MgoDPRauvpSZZPp5sweft9cZPcdcz0mehqL7a9
        G25q/riuJHYn5yi/ZyKjjE3H/rv3jrzLdjZb3v9SMJ+x+lbxxSQ3haxFK+Y2bvf9llPK9j87
        4MT7bbJ8pv4BL1mO3Y47IvUyk9Hdfubc7ryq+YqF7kosxRmJhlrMRcWJAKcbSpAXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t/xy7pS0/iiDW7tsbC4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsErozDFzuZCw7yVLxYeYy9gbGFq4uRk0NCwERi65NHLF2MXBxCAksYJe7ffMEK4TQy
        STx51c7cxcjBwSagJbGmPR4kLiKwilFi6t877CAOs8BsVolXjyYwgowSFoiVuPLkEjuIzSKg
        KtE25Q0ziM0r4CzR+ms/C8Q6OYmb5zrBhnIKuEis3mMHEhYCKtnX0sk4gZFnASPDKkaR1NLi
        3PTcYkO94sTc4tK8dL3k/NxNjMDA33bs5+YdjJc2Bh9iFOBgVOLhNYjgjRZiTSwrrsw9xCjB
        wawkwlu6lydaiDclsbIqtSg/vqg0J7X4EKM0B4uSOO95g8ooIYH0xJLU7NTUgtQimCwTB6dU
        A6P002c1ovaHkq4+fmm7uoxNtmJvlhzDYdusXJ6HPLM2d9xS7K7YHPbru9rcb5Oq9+XbhGdr
        vtXN3rrgKItq+/kqt8C5OsemLLqzdO4r35Z5f4zWr3iw+MyfvMgFKnN2Sk7sUOfQVvvafXN2
        dsYEvppmHmczfZmOpZkG4oHiV/21ppapL8teuEWJpTgj0VCLuag4EQDJKF1deAIAAA==
X-CMS-MailID: 20180530121626eucas1p17699adbe488cfb34da3f648bffe97fa2
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180530121626eucas1p17699adbe488cfb34da3f648bffe97fa2
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
        <CGME20180530121626eucas1p17699adbe488cfb34da3f648bffe97fa2@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrzej Hajda <a.hajda@samsung.com>

The patch adds support for BOE HV070WSA-100 WSVGA 7.01 inch panel
in panel-simple driver. The panel is used in Exynos5250-arndale boards.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index cbf1ab4..d5da58d 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -745,6 +745,28 @@ static const struct panel_desc avic_tm070ddh03 = {
 	},
 };
 
+static const struct drm_display_mode boe_hv070wsa_mode = {
+	.clock = 40800,
+	.hdisplay = 1024,
+	.hsync_start = 1024 + 90,
+	.hsync_end = 1024 + 90 + 90,
+	.htotal = 1024 + 90 + 90 + 90,
+	.vdisplay = 600,
+	.vsync_start = 600 + 3,
+	.vsync_end = 600 + 3 + 4,
+	.vtotal = 600 + 3 + 4 + 3,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc boe_hv070wsa = {
+	.modes = &boe_hv070wsa_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 154,
+		.height = 90,
+	},
+};
+
 static const struct drm_display_mode boe_nv101wxmn51_modes[] = {
 	{
 		.clock = 71900,
@@ -2113,6 +2135,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "avic,tm070ddh03",
 		.data = &avic_tm070ddh03,
 	}, {
+		.compatible = "boe,hv070wsa-100",
+		.data = &boe_hv070wsa
+	}, {
 		.compatible = "boe,nv101wxmn51",
 		.data = &boe_nv101wxmn51,
 	}, {
-- 
2.7.4
