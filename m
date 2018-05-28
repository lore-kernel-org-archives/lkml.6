Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932319AbeE1Jt7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:49:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55047 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754295AbeE1Jra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:47:30 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180528094728euoutp010b3953126a69c060b37898a2a1b91ba9~yxe2_pznb1912619126euoutp013
X-AuditID: cbfec7f2-1dbff70000011644-c5-5b0bd02fa951
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
Subject: [PATCH 06/12] drm/panel: add support for BOE HV070WSA-100 panel to
 simple-panel
Date: Mon, 28 May 2018 11:47:10 +0200
Message-id: <1527500833-16005-7-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTYRTHe3bv3b2bTi5T80lNalSIoE6QeMCoCIP7UUooFLNpFxOd2q6a
        RuULaZvmy9TRytACK5uapWUlTnBJGmNOm1la84XhW2pvNmGllXPz2+/8z49zngMPhYmVhD+V
        mpHNKjJk6RK+EO964zCHhg97xEsN9gA08XiIQBVDb3moWLlCoKfadgI19m9mo/ZvfFQzVY2j
        hckRHFXZljBkNj8hkal4mUQqdROJOmxjBLJ03+EjrbmXh+4uTuCord9KovsfRnioRN9PIm3t
        Ih85uhvwo75Ma0MrYCyVFTzm1W0rydQrbxFMh07FZ16sTRPMVPkAj+lsKmAqn+kAs9oRFCOM
        Ex46x6an5rKK8MNnhefXuw1EVp1n3sMNPV4IJgVlQEBBOhKOmR4RZUBIielmANW/B4GrWAXw
        R1szvm3d+6XmuRoPANS87HFb/wDcmFwiywBF8ekQ2Ho90Zn70DoAOz+ubEkYrSHgcOMS4Rzl
        TcfBIpUJczJO74edT+aAk0V0NJz5tIy51gXB8SHVFgvo49CiL+U7B0G6ioTzg19JlxQNTbU2
        4GJv+GXgmTsPhJbacve7M2HJnM2d58HeCiPh4ij4emBkizHaC9Z03cScF0BaBJWlYpfCwIZr
        Je4rtQCOPTdi1WDXXbBDB/zYHE6ewnIRGezFME4m53IyUsKSM+UdYPN/GP8O/HwJ7O+SDICm
        gMRTFOwQxosJWS6XLzcASGESH5EwdDMSnZPlX2IVmYmKnHSWM4AACpf4ic4EX40T0ymybDaN
        ZbNYxXaXRwn8C8EV/fy+FV+H/aFm1kH4n5w/5jeDbIFcUntB8JG02b3jPq+SrLuF9pjTfcl/
        FD1dubGV7w2j+gvJ0hNGqeW7JiF1WIVfLrq1w+t00+P2M0aPuJ1eBw9o1pashtIX06dM1Z5P
        69Ut0oQK3ef6KPzG8/XGBQ9JX2Qd0XJqT+zthZp0Cc6dl0WEYApO9h/J90ABGwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t/xy7p6F7ijDfZ9sLC4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsErow/uw6xFkzhqVj+dy9LA+M9zi5GTg4JAROJhV8mMnUxcnEICSxhlFjYvIEZwmlk
        kpi57CpjFyMHB5uAlsSa9niQuIjAKkaJqX/vsIM4zAKzWSVePZrACDJKWCBKorHzLDOIzSKg
        KrF5wzOwOK+Ai8TD22+YIdbJSdw81wlmcwq4Slze28YGYgsB1WxvnMUygZFnASPDKkaR1NLi
        3PTcYiO94sTc4tK8dL3k/NxNjMDQ33bs55YdjF3vgg8xCnAwKvHwavzkihZiTSwrrsw9xCjB
        wawkwsulCxTiTUmsrEotyo8vKs1JLT7EKM3BoiTOe96gMkpIID2xJDU7NbUgtQgmy8TBKdXA
        GOLJbpoxZd0nPbVlL9/IcdRweK5qmns5zL1vcYf/gc+7W6o4S+esOb1+pcISkUsbo+3lf7VU
        Ci2e2X8/gLsx46w4r/g/j0TzN5vjWwMkgl9M3FSwOIEtS+1AyLmqUocc9dqyBdXvW/suXp0p
        tDX1YsDknG1Pvob2zZ4yOdraLmnP5Lftu+/MUmIpzkg01GIuKk4EAN7rnIh5AgAA
X-CMS-MailID: 20180528094727eucas1p272478562b72a95dac2fc1b03be57c514
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180528094727eucas1p272478562b72a95dac2fc1b03be57c514
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
        <CGME20180528094727eucas1p272478562b72a95dac2fc1b03be57c514@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
