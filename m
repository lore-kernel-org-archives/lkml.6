Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753173AbeBSPpP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:45:15 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56987 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753004AbeBSPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:45:06 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180219154503euoutp01e6a00a0bf5d355875958a63ffc9fd0f7~UxJFpZ3hR0897708977euoutp01d
X-AuditID: cbfec7f2-5ffe19c000011644-48-5a8af0fb6cec
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
Subject: [PATCH 2/8] media: s5p-jpeg: Use bulk clk API
Date: Mon, 19 Feb 2018 16:44:00 +0100
Message-id: <1519055046-2399-3-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0iTURjGO99dcXKY0g6WRqOiBDPD6nTBbgYfJBHUPw26rPxSyVltXiqt
        1CzdyktW3iqxKAuv25qVitGmuLJyWSle8gJ2cWWpW3YVbXP63+88z/O+D+dwOFJspn24qJhY
        QRkjj5Yy7tTD5j+WgH+jGtmK4usS3F3VSuPM1ucELrKmU1hXUE3jd+MjDB69XAjwyD0Ng3P7
        cyjcU6Ol8PC3CgI3VbYTeKivjcKFz9JpnD34lcQWi5bFr1KHWawf7KDx2KU+Gr+tu8HgS9oa
        GhdYnhDYdK0B4BJrN4Urm3pZXKqfIHBbyzbcOOxYMtmho3DBFSuD7U9zyU1+/NuONpIf6TzP
        8lf/6Wi+tqiX5fVlaoZ/9HOA5vsvmgn+wZ2zvCHboWcZygBv1/vx75pS2J0eMvcN4UJ0VLyg
        DAw54B5ZZrPRxz75nhgst1DJ4A3SADcOwWBUOnqOcLIY3gdIO+CvAe4OtgOkSztPzoYmjFrC
        ZZQClJ01BVyHKYBemP+wGsBxDPRHFen7nQPesBmg4towZ4aEP1mU89cInIYXXI2qBm/STqbg
        YqT90TddLYJb0W9DO+tq80NdrerpZjcYigbqGxjnIgQ7WDT2vXwmFIoKbl+kXeyFvpgNM/p8
        pM4wEi5ORG3jdYyLk1BKj3Ymsx7Zcw3TBST0RLkP80nnBRAUoYwLYleER79ujMyMbkYPdGm0
        64nyAbpWw+YAnxIwpwxIhDiVIkJQBcUICctVcoUqLiZi+aGjCj1wfK8Xk2bbYzD+5qAJQA5I
        PUSwVyMT0/J41UmFCSCOlHqLwjodkihcfvKUoDy6XxkXLahMYB5HSSWifUvPyMQwQh4rHBGE
        Y4Jy1iU4N59kULELhtQ3VzTKbp0YavG1L5IesoU0qwszg3v8Pr422V6utQdo9uxdGrh7kbF6
        HZtGofdwtP34ltg4nBo89iFnpXdKb8CniR2ndQuX9G9ctn1uUL9nYurnNXeNAX8rF3RaWQ/J
        r7wuWd5wgnWsqqhUsWrn78MTVHi9m3rJpN6eVK6VUqpIeZA/qVTJ/wM1XjvzWgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHe89d2+iwhA5WBkOLNE0p5AVFIguOIBQFfRiFnvKgllPZcSOF
        yBklLu8pqS0wk4p5aZv3RMklaooub8vMbcbKGpmapiSu2Zb07ff8/s/lw0OhkkeYP5WansUr
        0rk0KeGLjbgHLaGbKxpZuN6KwtnmMRwWjb1FYI0zH4OGqpc4nFpfJuBKWTWAy881BCy3l2Lw
        Y5seg4s/GhHY3zSNwG+2cQxWD+XjsMTxHYVms56Eo3mLJDQ6LDj8WWjD4eQrLQEL9W04rDL3
        ItBU2QNgrXMWg039VhI+M7oQOD58Fr5Z9CxxWwwYrHrgJODa63L0VAA7aRlH2eWZuyRbsWXA
        2a4aK8kadQUE27Exj7P2+4MI21J/m20t8fjiVh1g14wB7FS/mjwvkvlGJ/FpqSpecTwm0TdF
        t7qKZy4cvOloMGO5YILRAB+KoU8yrj49ogG+lISuB0xTpw7dKdQIU7et9iQURdDBTGN+gtf7
        0QOA+TT3FPdOo7SLZIpzM728l45kmh2P/3mMDmL0v2yIl8V0LPO7dZrcuRbAfBgrQL3sQ59h
        5rt7CC9LPD1m+wRRCkS1YJcO+PFKQZ4sFyLCBE4uKNOTw65lyI3A87L2gc2WTjBhuGgCNAWk
        IjFt1cgkOKcSsuUmwFCo1E8cP+NR4iQuO4dXZCQolGm8YAL7KUy6T2wOz5ZJ6GQui7/B85m8
        4n+KUD7+uYCzRakih0JOBMWUV0fZ3aF/irbaZX3bNXA4dvSodrdq9EuXct2R6Aox9G405o1s
        Oecq43pfrM2GtVzptk3dOqz9emDp0CY9I1ToS5curx7pYQI7rssCtZUNd85pLu2RX3Zd6B48
        ppbFicHCVVHzwyfvDYZ38XU57jLT6c/3opOkmJDCRQSjCoH7C+Xv4JWuAgAA
X-CMS-MailID: 20180219154457eucas1p163264992903698a8878aa5abbc8aa17b
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180219154457eucas1p163264992903698a8878aa5abbc8aa17b
X-RootMTR: 20180219154457eucas1p163264992903698a8878aa5abbc8aa17b
References: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
        <CGME20180219154457eucas1p163264992903698a8878aa5abbc8aa17b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using bulk clk functions simplifies the driver's code. Use devm_clk_bulk
functions instead of iterating over an array of clks.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/media/platform/s5p-jpeg/jpeg-core.c | 45 ++++++++++++-----------------
 drivers/media/platform/s5p-jpeg/jpeg-core.h |  2 +-
 2 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.c b/drivers/media/platform/s5p-jpeg/jpeg-core.c
index 79b63da..681a515 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/s5p-jpeg/jpeg-core.c
@@ -2903,7 +2903,7 @@ static int s5p_jpeg_probe(struct platform_device *pdev)
 {
 	struct s5p_jpeg *jpeg;
 	struct resource *res;
-	int i, ret;
+	int ret;
 
 	/* JPEG IP abstraction struct */
 	jpeg = devm_kzalloc(&pdev->dev, sizeof(struct s5p_jpeg), GFP_KERNEL);
@@ -2938,15 +2938,16 @@ static int s5p_jpeg_probe(struct platform_device *pdev)
 	}
 
 	/* clocks */
-	for (i = 0; i < jpeg->variant->num_clocks; i++) {
-		jpeg->clocks[i] = devm_clk_get(&pdev->dev,
-					      jpeg->variant->clk_names[i]);
-		if (IS_ERR(jpeg->clocks[i])) {
-			dev_err(&pdev->dev, "failed to get clock: %s\n",
-				jpeg->variant->clk_names[i]);
-			return PTR_ERR(jpeg->clocks[i]);
-		}
-	}
+	jpeg->clocks = devm_clk_bulk_alloc(&pdev->dev,
+					   jpeg->variant->num_clocks,
+					   jpeg->variant->clk_names);
+	if (IS_ERR(jpeg->clocks))
+		return PTR_ERR(jpeg->clocks);
+
+	ret = devm_clk_bulk_get(&pdev->dev, jpeg->variant->num_clocks,
+				jpeg->clocks);
+	if (ret < 0)
+		return ret;
 
 	/* v4l2 device */
 	ret = v4l2_device_register(&pdev->dev, &jpeg->v4l2_dev);
@@ -3047,7 +3048,6 @@ static int s5p_jpeg_probe(struct platform_device *pdev)
 static int s5p_jpeg_remove(struct platform_device *pdev)
 {
 	struct s5p_jpeg *jpeg = platform_get_drvdata(pdev);
-	int i;
 
 	pm_runtime_disable(jpeg->dev);
 
@@ -3058,8 +3058,8 @@ static int s5p_jpeg_remove(struct platform_device *pdev)
 	v4l2_device_unregister(&jpeg->v4l2_dev);
 
 	if (!pm_runtime_status_suspended(&pdev->dev)) {
-		for (i = jpeg->variant->num_clocks - 1; i >= 0; i--)
-			clk_disable_unprepare(jpeg->clocks[i]);
+		clk_bulk_disable_unprepare(jpeg->variant->num_clocks,
+					   jpeg->clocks);
 	}
 
 	return 0;
@@ -3069,10 +3069,8 @@ static int s5p_jpeg_remove(struct platform_device *pdev)
 static int s5p_jpeg_runtime_suspend(struct device *dev)
 {
 	struct s5p_jpeg *jpeg = dev_get_drvdata(dev);
-	int i;
 
-	for (i = jpeg->variant->num_clocks - 1; i >= 0; i--)
-		clk_disable_unprepare(jpeg->clocks[i]);
+	clk_bulk_disable_unprepare(jpeg->variant->num_clocks, jpeg->clocks);
 
 	return 0;
 }
@@ -3081,16 +3079,11 @@ static int s5p_jpeg_runtime_resume(struct device *dev)
 {
 	struct s5p_jpeg *jpeg = dev_get_drvdata(dev);
 	unsigned long flags;
-	int i, ret;
-
-	for (i = 0; i < jpeg->variant->num_clocks; i++) {
-		ret = clk_prepare_enable(jpeg->clocks[i]);
-		if (ret) {
-			while (--i >= 0)
-				clk_disable_unprepare(jpeg->clocks[i]);
-			return ret;
-		}
-	}
+	int ret;
+
+	ret = clk_bulk_prepare_enable(jpeg->variant->num_clocks, jpeg->clocks);
+	if (ret)
+		return ret;
 
 	spin_lock_irqsave(&jpeg->slock, flags);
 
diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.h b/drivers/media/platform/s5p-jpeg/jpeg-core.h
index a46465e..dc6ed98 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.h
+++ b/drivers/media/platform/s5p-jpeg/jpeg-core.h
@@ -133,7 +133,7 @@ struct s5p_jpeg {
 	void __iomem		*regs;
 	unsigned int		irq;
 	enum exynos4_jpeg_result irq_ret;
-	struct clk		*clocks[JPEG_MAX_CLOCKS];
+	struct clk_bulk_data	*clocks;
 	struct device		*dev;
 	struct s5p_jpeg_variant *variant;
 	u32			irq_status;
-- 
2.7.4
