Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753240AbeBSPqN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:46:13 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57059 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753059AbeBSPpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:45:10 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180219154508euoutp01a751069217df79f214678ba66fc96c64~UxJKfY_Vl0858208582euoutp016
X-AuditID: cbfec7f2-5ffe19c000011644-5d-5a8af1006e01
From: Maciej Purski <m.purski@samsung.com>
To: linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Kamil Debski <kamil@wypas.org>, Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thibault Saunier <thibault.saunier@osg.samsung.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Hans Verkuil <hansverk@cisco.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 7/8] [media] exynos-gsc: Use clk bulk API
Date: Mon, 19 Feb 2018 16:44:05 +0100
Message-id: <1519055046-2399-8-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTURzGPe9dc3aYRgezBSMphczID6cL0RXeDxJ9iIwF2soXtXTqll20
        iwq6XJrLFKd0mWEaYqXLS2qWruGlaKIuSXOr0EBLW0600qi2Xv32nOf5nef/P3A4UtpNB3IJ
        qjOCWqVMlDM+VFPXr75NXjM6RXjLfAgeeWSlcYG1l8Dlk1oK1xse09g252Tw9xtlADurdQwu
        +qCn8PvGOgpPTdcS2PLwLYEnHP0ULuvR0rhw7CuJ+/rqWPwme4rFprEhGs/kO2g82HqLwfl1
        jTQ29D0nsLmkHWDj5AiFH1rsLK4y/SZw/6sD+OWUu+TPUD2FDTcnGTzbUUTulvGDQ/0k73yX
        w/LFi/U031JuZ3lTTR7DN89/pPkP17oJ/knlFb6h0O1fb6gB/KxJxtssWewhX4XPzlghMeGs
        oN6867hPvOu+kU55JD9fMK6jM8HtIB3w5hCMQC5HM6kDPpwUPgCotzGXEg+zAGX/mGCXqU/a
        CkIMqgCyG1xL1F+ADEN2d8JxDAxFtdoYz4UA2AXQnZZID0PCeRbpFzqBJ/CH29AXq+G/pmAw
        ytb20h4tgftQl95BidNkaNiaR3q0N9yPPra1M54iBB0s6ln8zHqGIXcwbFOIvD/60t2wtGkQ
        yrvaSYg6A/XPtTKivoiy3tctMTvQbFHD/34S+qGiplJSrJSgq7lSEeGRwTJAifYeVGCUi88t
        Bah51MTqQaAReNWA1UKaJilO0GxRCefCNMokTZoqLuxkcpIJuL/X6z/drqdgbuCEGUAOyH0l
        0K5TSGnlWc2FJDNAHCkPkES+c1uSWOWFdEGdHKNOSxQ0ZrCGo+SrJdEbLyukME55RjgtCCmC
        ejklOO/ATKA61ppXO3zpU9lB6B1yDrzecNcVbumJWlethxl+J9pS70XlqpRy6RPdqu3mytKT
        odeKx214rrHdb+WR1gPp0ykdo/RPZ8cz69ryyL22kvFy2eENdrhV1qE+hWoGd3JgMNrJdV5O
        i/xmLFjIif67/vxRYI8I/pqab42oeLHibYqc0sQrt4SSao3yHzJILslaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xa7r/PnRFGZyYrWVxa905VovecyeZ
        LGa9bGex2DhjPavFla/v2Sw+TJzJaPF+eRebxaT7E1gsbm/dwGLx5u0aJosja68yWby4d5HF
        YuaJdlaL/sevmS3On9/AbnG26Q27xabH11gtPvbcY7W4vGsOm0XPhq2sFjPO72OyODR1L6PF
        gpe3WCzWHrnLbrFs0x8mi4unXC0OvwEa8u/aRhaLGZNfsll8PjCJ2UHO4/K1i8we72+0sntM
        +b2R1WPnrLvsHptWdbJ5bP/2gNXjfvdxJo/NS+o9tvQDxfu2rGL0+LxJzuPKkUb2AJ4oLpuU
        1JzMstQifbsEroxPSxewFqxTquh90sXawDhXpouRk0NCwETiYftCpi5GLg4hgSWMEh8234Fy
        Gpkkdh/Ywt7FyMHBJqAlsaY9HiQuInCMUeLhncWsIN3MAn/YJfoaCkBsYQFLiVfnZjCC2CwC
        qhJN7SfBangFnCWOTbjHArFNTuLmuU5mEJtTwEXiwe69bCC2EFDN+fuX2CYw8ixgZFjFKJJa
        WpybnltsqFecmFtcmpeul5yfu4kRGGXbjv3cvIPx0sbgQ4wCHIxKPLwCd7uihFgTy4orcw8x
        SnAwK4nw+twACvGmJFZWpRblxxeV5qQWH2KU5mBREuc9b1AZJSSQnliSmp2aWpBaBJNl4uCU
        amBkl4qu/XWtgSNTWPjSI+kja7y4oyQFFbdkbt7Qoj2r7shrN6W/p5dOybBVUUmtdpA81v5P
        TWE3R4CahbCdVd7UDycM2rdE681zjvR6I3tc07OaffKOc6cC1x663/tnRfTPFo7pB67KuE8z
        so7N2Fx2jfPKxvLyyc1tbz0XnqyqDrs86ZRNmrMSS3FGoqEWc1FxIgCEqztrrgIAAA==
X-CMS-MailID: 20180219154502eucas1p20e8daf3edc6737817f8d62db5a2099f2
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180219154502eucas1p20e8daf3edc6737817f8d62db5a2099f2
X-RootMTR: 20180219154502eucas1p20e8daf3edc6737817f8d62db5a2099f2
References: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
        <CGME20180219154502eucas1p20e8daf3edc6737817f8d62db5a2099f2@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using bulk clk functions simplifies the driver's code. Use devm_clk_bulk
functions instead of iterating over an array of clks.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/media/platform/exynos-gsc/gsc-core.c | 55 ++++++++++------------------
 drivers/media/platform/exynos-gsc/gsc-core.h |  2 +-
 2 files changed, 20 insertions(+), 37 deletions(-)

diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
index 17854a3..fa7e993 100644
--- a/drivers/media/platform/exynos-gsc/gsc-core.c
+++ b/drivers/media/platform/exynos-gsc/gsc-core.c
@@ -1149,7 +1149,6 @@ static int gsc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct gsc_driverdata *drv_data = of_device_get_match_data(dev);
 	int ret;
-	int i;
 
 	gsc = devm_kzalloc(dev, sizeof(struct gsc_dev), GFP_KERNEL);
 	if (!gsc)
@@ -1187,25 +1186,19 @@ static int gsc_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	for (i = 0; i < gsc->num_clocks; i++) {
-		gsc->clock[i] = devm_clk_get(dev, drv_data->clk_names[i]);
-		if (IS_ERR(gsc->clock[i])) {
-			dev_err(dev, "failed to get clock: %s\n",
-				drv_data->clk_names[i]);
-			return PTR_ERR(gsc->clock[i]);
-		}
-	}
+	gsc->clocks = devm_clk_bulk_alloc(dev, gsc->num_clocks,
+					  drv_data->clk_names);
+	if (IS_ERR(gsc->clocks))
+		return PTR_ERR(gsc->clocks);
 
-	for (i = 0; i < gsc->num_clocks; i++) {
-		ret = clk_prepare_enable(gsc->clock[i]);
-		if (ret) {
-			dev_err(dev, "clock prepare failed for clock: %s\n",
-				drv_data->clk_names[i]);
-			while (--i >= 0)
-				clk_disable_unprepare(gsc->clock[i]);
-			return ret;
-		}
-	}
+	ret = devm_clk_bulk_get(dev, gsc->num_clocks,
+				gsc->clocks);
+	if (ret)
+		return ret;
+
+	ret = clk_bulk_prepare_enable(gsc->num_clocks, gsc->clocks);
+	if (ret)
+		return ret;
 
 	ret = devm_request_irq(dev, res->start, gsc_irq_handler,
 				0, pdev->name, gsc);
@@ -1239,15 +1232,14 @@ static int gsc_probe(struct platform_device *pdev)
 err_v4l2:
 	v4l2_device_unregister(&gsc->v4l2_dev);
 err_clk:
-	for (i = gsc->num_clocks - 1; i >= 0; i--)
-		clk_disable_unprepare(gsc->clock[i]);
+	clk_bulk_disable_unprepare(gsc->num_clocks, gsc->clocks);
+
 	return ret;
 }
 
 static int gsc_remove(struct platform_device *pdev)
 {
 	struct gsc_dev *gsc = platform_get_drvdata(pdev);
-	int i;
 
 	pm_runtime_get_sync(&pdev->dev);
 
@@ -1255,8 +1247,7 @@ static int gsc_remove(struct platform_device *pdev)
 	v4l2_device_unregister(&gsc->v4l2_dev);
 
 	vb2_dma_contig_clear_max_seg_size(&pdev->dev);
-	for (i = 0; i < gsc->num_clocks; i++)
-		clk_disable_unprepare(gsc->clock[i]);
+	clk_bulk_disable_unprepare(gsc->num_clocks, gsc->clocks);
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -1307,18 +1298,12 @@ static int gsc_runtime_resume(struct device *dev)
 {
 	struct gsc_dev *gsc = dev_get_drvdata(dev);
 	int ret = 0;
-	int i;
 
 	pr_debug("gsc%d: state: 0x%lx\n", gsc->id, gsc->state);
 
-	for (i = 0; i < gsc->num_clocks; i++) {
-		ret = clk_prepare_enable(gsc->clock[i]);
-		if (ret) {
-			while (--i >= 0)
-				clk_disable_unprepare(gsc->clock[i]);
-			return ret;
-		}
-	}
+	ret = clk_bulk_prepare_enable(gsc->num_clocks, gsc->clocks);
+	if (ret)
+		return ret;
 
 	gsc_hw_set_sw_reset(gsc);
 	gsc_wait_reset(gsc);
@@ -1331,14 +1316,12 @@ static int gsc_runtime_suspend(struct device *dev)
 {
 	struct gsc_dev *gsc = dev_get_drvdata(dev);
 	int ret = 0;
-	int i;
 
 	ret = gsc_m2m_suspend(gsc);
 	if (ret)
 		return ret;
 
-	for (i = gsc->num_clocks - 1; i >= 0; i--)
-		clk_disable_unprepare(gsc->clock[i]);
+	clk_bulk_disable_unprepare(gsc->num_clocks, gsc->clocks);
 
 	pr_debug("gsc%d: state: 0x%lx\n", gsc->id, gsc->state);
 	return ret;
diff --git a/drivers/media/platform/exynos-gsc/gsc-core.h b/drivers/media/platform/exynos-gsc/gsc-core.h
index 715d9c9d..08ff7b9 100644
--- a/drivers/media/platform/exynos-gsc/gsc-core.h
+++ b/drivers/media/platform/exynos-gsc/gsc-core.h
@@ -334,7 +334,7 @@ struct gsc_dev {
 	struct gsc_variant		*variant;
 	u16				id;
 	int				num_clocks;
-	struct clk			*clock[GSC_MAX_CLOCKS];
+	struct clk_bulk_data		*clocks;
 	void __iomem			*regs;
 	wait_queue_head_t		irq_queue;
 	struct gsc_m2m_device		m2m;
-- 
2.7.4
