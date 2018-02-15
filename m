Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754867AbeBOGES (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 01:04:18 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:60595 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751776AbeBOGEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 01:04:15 -0500
From: Keerthy <j-keerthy@ti.com>
To: <daniel.lezcano@linaro.org>, <thierry.reding@gmail.com>,
        <tony@atomide.com>, <aaro.koskinen@iki.fi>
CC: <j-keerthy@ti.com>, <Claudiu.Beznea@microchip.com>,
        <narmstrong@baylibre.com>, <linux-pwm@vger.kernel.org>,
        <ladis@linux-mips.org>, <s-anna@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <sebastian.reichel@collabora.co.uk>, <linux-omap@vger.kernel.org>,
        <robh+dt@kernel.org>, <t-kristo@ti.com>, <grygorii.strashko@ti.com>
Subject: [PATCH v11 07/10] clocksource: timer-ti-dm: Populate the timer ops to the pdata
Date: Thu, 15 Feb 2018 11:31:48 +0530
Message-ID: <1518674511-26421-8-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
References: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the timer ops to the platform data

Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Tested-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/clocksource/timer-ti-dm.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 1d6aff8..864019d 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -922,8 +922,33 @@ static int omap_dm_timer_remove(struct platform_device *pdev)
 	return ret;
 }
 
+const static struct omap_dm_timer_ops dmtimer_ops = {
+	.request_by_node = omap_dm_timer_request_by_node,
+	.request_specific = omap_dm_timer_request_specific,
+	.request = omap_dm_timer_request,
+	.set_source = omap_dm_timer_set_source,
+	.get_irq = omap_dm_timer_get_irq,
+	.set_int_enable = omap_dm_timer_set_int_enable,
+	.set_int_disable = omap_dm_timer_set_int_disable,
+	.free = omap_dm_timer_free,
+	.enable = omap_dm_timer_enable,
+	.disable = omap_dm_timer_disable,
+	.get_fclk = omap_dm_timer_get_fclk,
+	.start = omap_dm_timer_start,
+	.stop = omap_dm_timer_stop,
+	.set_load = omap_dm_timer_set_load,
+	.set_match = omap_dm_timer_set_match,
+	.set_pwm = omap_dm_timer_set_pwm,
+	.set_prescaler = omap_dm_timer_set_prescaler,
+	.read_counter = omap_dm_timer_read_counter,
+	.write_counter = omap_dm_timer_write_counter,
+	.read_status = omap_dm_timer_read_status,
+	.write_status = omap_dm_timer_write_status,
+};
+
 static const struct dmtimer_platform_data omap3plus_pdata = {
 	.timer_errata = OMAP_TIMER_ERRATA_I103_I767,
+	.timer_ops = &dmtimer_ops,
 };
 
 static const struct of_device_id omap_timer_match[] = {
-- 
1.9.1
