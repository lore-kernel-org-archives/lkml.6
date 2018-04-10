Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753254AbeDJMnT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:43:19 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:22852 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeDJMnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:43:13 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180410124311epoutp0281a8d30c6c6cd1cc0f1b746cbbeaa3c9~kE6k1hmX-0173301733epoutp02y
X-AuditID: b6c32a45-6d3ff70000000fe4-73-5accb15e1dc7
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 03/17] thermal: add thermal_zone_device_check() helper
Date: Tue, 10 Apr 2018 14:41:57 +0200
Message-id: <1523364131-31059-4-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTURzHO7t3d1drcZqaJwXDiWGCMyPpUFZGGjd6UIgIK7KRt2ltKrs+
        UhKWhvnIpQhpMswXYVOzyWxmG5iPma9CFBE1zVKxBB8YmYWY29X/vj++n9/ve75waEKiE3rQ
        cfFJrCZeoZJSzuTbjsM44KaxX37kVz7CxtJGIZ5b7Qa4oaCLxC+GR4S47eEQwJvfFoS415wp
        wI/KqkhcMzMtwkOtegqvFnQCrF8cF+GZaR2F503uuKl2lMLrreUktk6ugtB9TOaSjWLKpgYo
        5l3ZFxHTPBbMVFt+CJgmQy7FTIxYKKYga5FidCYDYMwj5QTzsWSNZLpHzQJmtcnrqljuHBLD
        quJSWE3g6VvOsVWvvxKJPXng/rq5U6gFOcl5wIlG8Bha+FwE8oAzLYEtAGlXxkT8sAaQZTZX
        uEONbs6TvPEeoJd11UJ++AtQra6NsFMUPIGKHhu2btG0K7yITPW0nSHgcxItT3Q5GBd4Hm2s
        NQrsmoS+aNNUQ9q1GDLolfY7xad5oR5bsSPZCV5A/6xLjjAEi0XINj25DYWhqvlZAa9d0M9u
        k4jXnmjOYAT8QhZAv1ssBG8UbhVqlPD6JOroHnQkEHAvyunYENlfjaAY5WRvIwyqfFKwXf8s
        6luxF7A31gOkX+4lC4FHBdhlAPvZRE6tZLmjiUEyTqHmkuOVstsJ6ibg+CX+4S2g9NOldgBp
        IN0jLvzQJ5cIFSlcmrodIJqQuopVDf1yiThGkZbOahKiNckqlmsHnjQpdRdrL29ZUKlIYu+x
        bCKr2XEFtJOHFlSmh5j/HBIf2PCLqb80FTk8dkUbleuadm3c55zF2HomIzA+PT24NOCUX7NW
        nvFMYy2XqStoWSoMdZO3cIPZttqkyIGg1PrgG0rp7rt1cTIYhq8/9dYhnwcbZpj/ZkEXYQ2P
        8wksrNCq3GzRtLdv2vGoMX3sYo2xJMLpzkEPKcnFKoL8CQ2n+A8oGWqJIQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t9jAd24jWeiDLZdYrfYOGM9q8Wzz8cZ
        Ldb2HmWxmH/lGqvFgcbLjBb/H71mtTi1vYnJomXWIhaLJU8esltc3jWHzeJz7xFGiznvbrNb
        PHnYx2bxYou4xaYVN9gsfu6ax2Kx995nRgdBj6b3x9g8Zt0/y+axc9Zddo+tt0w9Fu95yeSx
        aVUnm8eda3vYPHqb37F59G1Zxeix/do8Zo8T07+zeBy/sZ3J4/MmuQDeKC6blNSczLLUIn27
        BK6MReseMBec7GKs+Ln9CGsDY0dpFyMnh4SAicSN/y9YQGwhgZ2MEo8OR3QxcgHZvxglFu7a
        zwqSYBOwkpjYvoqxi5GDQ0TAW2LLGg6QGmaBmSwSbVOfMoLUCAu4Sfz9vp4JxGYRUJX4v2UJ
        2FBeAQ+JlQ2P2SCWyUmcPDYZbCangKfE773vWUFmCgHVfJtiPYGRZwEjwypGydSC4tz03GKj
        AqO81HK94sTc4tK8dL3k/NxNjMCg33ZYq38H4+Ml8YcYBTgYlXh4Jxw8HSXEmlhWXJl7iFGC
        g1lJhDdn7ZkoId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rz8+ccihQTSE0tSs1NTC1KLYLJMHJxS
        DYwTFtbNYJ/E9K+pUKvJd2oA3wKzN5mhJ99ZN3PMzq3SEZPM3qnx68qrGX9erH80c/+E17/r
        pUJTjwjlWocYnRTu9zBwNXI/cM1Fx8Dc3H9N+WvJ/08dN3WbTZHafj/oUJTxI71rBhPLhcUu
        HM7aIdU3XURzv1k6M5f0/o7sN3KvPxYuD1Pf7KDEUpyRaKjFXFScCAAxGGSEdgIAAA==
X-CMS-MailID: 20180410124310epcas2p4082a61fa96384a9a88c7cfef3ef18675
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180410124310epcas2p4082a61fa96384a9a88c7cfef3ef18675
X-RootMTR: 20180410124310epcas2p4082a61fa96384a9a88c7cfef3ef18675
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124310epcas2p4082a61fa96384a9a88c7cfef3ef18675@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rename static thermal_zone_device_check() helper in thermal_core.c
  to thermal_zone_device_work_check().

* Add thermal_zone_device_check() helper. Then update core code and
  drivers to use it.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/acpi/thermal.c                             |  3 +--
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  3 ++-
 drivers/platform/x86/acerhdf.c                     |  4 +++-
 drivers/regulator/max8973-regulator.c              |  3 +--
 drivers/thermal/da9062-thermal.c                   |  7 ++-----
 drivers/thermal/db8500_thermal.c                   |  3 ++-
 drivers/thermal/hisi_thermal.c                     |  4 +---
 drivers/thermal/imx_thermal.c                      |  5 +++--
 drivers/thermal/intel_bxt_pmic_thermal.c           |  3 +--
 drivers/thermal/intel_soc_dts_iosf.c               |  3 +--
 drivers/thermal/max77620_thermal.c                 |  3 +--
 drivers/thermal/of-thermal.c                       |  3 ++-
 drivers/thermal/qcom-spmi-temp-alarm.c             |  2 +-
 drivers/thermal/rcar_gen3_thermal.c                |  3 +--
 drivers/thermal/rcar_thermal.c                     |  3 +--
 drivers/thermal/rockchip_thermal.c                 |  3 +--
 drivers/thermal/samsung/exynos_tmu.c               |  2 +-
 drivers/thermal/st/st_thermal_memmap.c             |  3 +--
 drivers/thermal/thermal_core.c                     | 14 ++++++--------
 drivers/thermal/thermal_helpers.c                  |  6 ++++++
 drivers/thermal/thermal_sysfs.c                    |  6 +++---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  2 +-
 drivers/thermal/uniphier_thermal.c                 |  2 +-
 drivers/thermal/x86_pkg_temp_thermal.c             |  2 +-
 include/linux/thermal.h                            |  1 +
 25 files changed, 45 insertions(+), 48 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 551b71a..b8b275e1 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -520,8 +520,7 @@ static void acpi_thermal_check(void *data)
 	if (!tz->tz_enabled)
 		return;
 
-	thermal_zone_device_update(tz->thermal_zone,
-				   THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(tz->thermal_zone);
 }
 
 /* sys I/F for generic thermal sysfs support */
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index d866c98..7513359 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -197,7 +197,8 @@ static int mlxsw_thermal_set_mode(struct thermal_zone_device *tzdev,
 	mutex_unlock(&tzdev->lock);
 
 	thermal->mode = mode;
-	thermal_zone_device_update(tzdev, THERMAL_EVENT_UNSPECIFIED);
+
+	thermal_zone_device_check(tzdev);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index ea22591..19b9bc9 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -405,7 +405,9 @@ static inline void acerhdf_enable_kernelmode(void)
 	kernelmode = 1;
 
 	thz_dev->polling_delay = interval*1000;
-	thermal_zone_device_update(thz_dev, THERMAL_EVENT_UNSPECIFIED);
+
+	thermal_zone_device_check(thz_dev);
+
 	pr_notice("kernel mode fan control ON\n");
 }
 
diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index e0c747a..1f15a6d 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -495,8 +495,7 @@ static irqreturn_t max8973_thermal_irq(int irq, void *data)
 {
 	struct max8973_chip *mchip = data;
 
-	thermal_zone_device_update(mchip->tz_device,
-				   THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(mchip->tz_device);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index dd8dd94..8c6721b 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -102,9 +102,7 @@ static void da9062_thermal_poll_on(struct work_struct *work)
 		mutex_lock(&thermal->lock);
 		thermal->temperature = DA9062_MILLI_CELSIUS(125);
 		mutex_unlock(&thermal->lock);
-		thermal_zone_device_update(thermal->zone,
-					   THERMAL_EVENT_UNSPECIFIED);
-
+		thermal_zone_device_check(thermal->zone);
 		delay = msecs_to_jiffies(thermal->zone->passive_delay);
 		schedule_delayed_work(&thermal->work, delay);
 		return;
@@ -113,8 +111,7 @@ static void da9062_thermal_poll_on(struct work_struct *work)
 	mutex_lock(&thermal->lock);
 	thermal->temperature = DA9062_MILLI_CELSIUS(0);
 	mutex_unlock(&thermal->lock);
-	thermal_zone_device_update(thermal->zone,
-				   THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(thermal->zone);
 
 err_enable_irq:
 	enable_irq(thermal->irq);
diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index f491faf..ab66b2d7 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -306,7 +306,8 @@ static void db8500_thermal_work(struct work_struct *work)
 	if (cur_mode == THERMAL_DEVICE_DISABLED)
 		return;
 
-	thermal_zone_device_update(pzone->therm_dev, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(pzone->therm_dev);
+
 	dev_dbg(&pzone->therm_dev->device, "thermal work finished.\n");
 }
 
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index d7237d1..8cfe3d2 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -461,9 +461,7 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 		dev_crit(&data->pdev->dev, "THERMAL ALARM: %d > %d\n",
 			 temp, sensor->thres_temp);
 
-		thermal_zone_device_update(data->sensor.tzd,
-					   THERMAL_EVENT_UNSPECIFIED);
-
+		thermal_zone_device_check(data->sensor.tzd);
 	} else {
 		dev_crit(&data->pdev->dev, "THERMAL ALARM stopped: %d < %d\n",
 			 temp, sensor->thres_temp);
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index c30dc21..2cd1921 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -388,7 +388,8 @@ static int imx_set_mode(struct thermal_zone_device *tz,
 	}
 
 	data->mode = mode;
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+
+	thermal_zone_device_check(tz);
 
 	return 0;
 }
@@ -636,7 +637,7 @@ static irqreturn_t imx_thermal_alarm_irq_thread(int irq, void *dev)
 	dev_dbg(&data->tz->device, "THERMAL ALARM: T > %d\n",
 		data->alarm_temp / 1000);
 
-	thermal_zone_device_update(data->tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(data->tz);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/intel_bxt_pmic_thermal.c b/drivers/thermal/intel_bxt_pmic_thermal.c
index 94cfd00..73fe97b 100644
--- a/drivers/thermal/intel_bxt_pmic_thermal.c
+++ b/drivers/thermal/intel_bxt_pmic_thermal.c
@@ -203,8 +203,7 @@ static irqreturn_t pmic_thermal_irq_handler(int irq, void *data)
 
 			tzd = thermal_zone_get_zone_by_name(td->maps[i].handle);
 			if (!IS_ERR(tzd))
-				thermal_zone_device_update(tzd,
-						THERMAL_EVENT_UNSPECIFIED);
+				thermal_zone_device_check(tzd);
 
 			/* Clear the appropriate irq */
 			regmap_write(regmap, reg, reg_val & mask);
diff --git a/drivers/thermal/intel_soc_dts_iosf.c b/drivers/thermal/intel_soc_dts_iosf.c
index e0813df..caa8776 100644
--- a/drivers/thermal/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel_soc_dts_iosf.c
@@ -391,8 +391,7 @@ void intel_soc_dts_iosf_interrupt_handler(struct intel_soc_dts_sensors *sensors)
 
 		for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
 			pr_debug("TZD update for zone %d\n", i);
-			thermal_zone_device_update(sensors->soc_dts[i].tzone,
-						   THERMAL_EVENT_UNSPECIFIED);
+			thermal_zone_device_check(sensors->soc_dts[i].tzone);
 		}
 	} else
 		spin_unlock_irqrestore(&sensors->intr_notify_lock, flags);
diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 337d695..f896a97 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -82,8 +82,7 @@ static irqreturn_t max77620_thermal_irq(int irq, void *data)
 	else if (irq == mtherm->irq_tjalarm2)
 		dev_crit(mtherm->dev, "Junction Temp Alarm2(140C) occurred\n");
 
-	thermal_zone_device_update(mtherm->tz_device,
-				   THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(mtherm->tz_device);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 890e272..a65b515 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -285,7 +285,8 @@ static int of_thermal_set_mode(struct thermal_zone_device *tz,
 	mutex_unlock(&tz->lock);
 
 	data->mode = mode;
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+
+	thermal_zone_device_check(tz);
 
 	return 0;
 }
diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
index cb46555..fa42517 100644
--- a/drivers/thermal/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom-spmi-temp-alarm.c
@@ -150,7 +150,7 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
 {
 	struct qpnp_tm_chip *chip = data;
 
-	thermal_zone_device_update(chip->tz_dev, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(chip->tz_dev);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 5d26aab..69142c2 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -265,8 +265,7 @@ static irqreturn_t rcar_gen3_thermal_irq_thread(int irq, void *data)
 	int i;
 
 	for (i = 0; i < priv->num_tscs; i++)
-		thermal_zone_device_update(priv->tscs[i]->zone,
-					   THERMAL_EVENT_UNSPECIFIED);
+		thermal_zone_device_check(priv->tscs[i]->zone);
 
 	spin_lock_irqsave(&priv->lock, flags);
 	rcar_thermal_irq_set(priv, true);
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 5c2a42d..080e6ec 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -358,8 +358,7 @@ static void rcar_thermal_work(struct work_struct *work)
 		return;
 
 	if (nctemp != cctemp)
-		thermal_zone_device_update(priv->zone,
-					   THERMAL_EVENT_UNSPECIFIED);
+		thermal_zone_device_check(priv->zone);
 }
 
 static u32 rcar_thermal_had_changed(struct rcar_thermal_priv *priv, u32 status)
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index c41bb6c..d0e4042 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1032,8 +1032,7 @@ static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void *dev)
 	thermal->chip->irq_ack(thermal->regs);
 
 	for (i = 0; i < thermal->chip->chn_num; i++)
-		thermal_zone_device_update(thermal->sensors[i].tzd,
-					   THERMAL_EVENT_UNSPECIFIED);
+		thermal_zone_device_check(thermal->sensors[i].tzd);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index cbe5471..5b07a8f 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -263,7 +263,7 @@ static void exynos_report_trigger(struct exynos_tmu_data *p)
 		return;
 	}
 
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(tz);
 
 	mutex_lock(&tz->lock);
 	/* Find the level for which trip happened */
diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index 91d4231..323c42f 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -42,8 +42,7 @@ static irqreturn_t st_mmap_thermal_trip_handler(int irq, void *sdata)
 {
 	struct st_thermal_sensor *sensor = sdata;
 
-	thermal_zone_device_update(sensor->thermal_dev,
-				   THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(sensor->thermal_dev);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d64325e..50085c0 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -504,12 +504,12 @@ void thermal_notify_framework(struct thermal_zone_device *tz, int trip)
 }
 EXPORT_SYMBOL_GPL(thermal_notify_framework);
 
-static void thermal_zone_device_check(struct work_struct *work)
+static void thermal_zone_device_work_check(struct work_struct *work)
 {
 	struct thermal_zone_device *tz = container_of(work, struct
 						      thermal_zone_device,
 						      poll_queue.work);
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(tz);
 }
 
 /*
@@ -993,8 +993,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
 	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(pos, &thermal_tz_list, node)
 		if (atomic_cmpxchg(&pos->need_update, 1, 0))
-			thermal_zone_device_update(pos,
-						   THERMAL_EVENT_UNSPECIFIED);
+			thermal_zone_device_check(pos);
 	mutex_unlock(&thermal_list_lock);
 
 	return cdev;
@@ -1276,12 +1275,12 @@ struct thermal_zone_device *
 	/* Bind cooling devices for this zone */
 	bind_tz(tz);
 
-	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
+	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_work_check);
 
 	thermal_zone_device_reset(tz);
 	/* Update the new thermal zone and mark it as already updated. */
 	if (atomic_cmpxchg(&tz->need_update, 1, 0))
-		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+		thermal_zone_device_check(tz);
 
 	return tz;
 
@@ -1505,8 +1504,7 @@ static int thermal_pm_notify(struct notifier_block *nb,
 		atomic_set(&in_suspend, 0);
 		list_for_each_entry(tz, &thermal_tz_list, node) {
 			thermal_zone_device_reset(tz);
-			thermal_zone_device_update(tz,
-						   THERMAL_EVENT_UNSPECIFIED);
+			thermal_zone_device_check(tz);
 		}
 		break;
 	default:
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index d5db101..bd10b4d 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -242,3 +242,9 @@ int thermal_zone_device_toggle(struct thermal_zone_device *tz, bool on)
 		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_toggle);
+
+void thermal_zone_device_check(struct thermal_zone_device *tz)
+{
+	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_check);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 343f52b..109be2f 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -144,7 +144,7 @@
 	if (ret)
 		return ret;
 
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(tz);
 
 	return count;
 }
@@ -249,7 +249,7 @@
 
 	tz->forced_passive = state;
 
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(tz);
 
 	return count;
 }
@@ -316,7 +316,7 @@
 	}
 
 	if (!ret)
-		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+		thermal_zone_device_check(tz);
 
 	return ret ? ret : count;
 }
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 621add3..d1b55d9 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -54,7 +54,7 @@ static void ti_thermal_work(struct work_struct *work)
 	struct ti_thermal_data *data = container_of(work,
 					struct ti_thermal_data, thermal_wq);
 
-	thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(data->ti_thermal);
 
 	dev_dbg(&data->ti_thermal->device, "updated thermal zone %s\n",
 		data->ti_thermal->type);
diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index f83bb3e..f2f8b2b 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -248,7 +248,7 @@ static irqreturn_t uniphier_tm_alarm_irq_thread(int irq, void *_tdev)
 {
 	struct uniphier_tm_dev *tdev = _tdev;
 
-	thermal_zone_device_update(tdev->tz_dev, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_check(tdev->tz_dev);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 1a6c88b..cb6ebc6 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -317,7 +317,7 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 	 * concurrent removal in the cpu offline callback.
 	 */
 	if (tzone)
-		thermal_zone_device_update(tzone, THERMAL_EVENT_UNSPECIFIED);
+		thermal_zone_device_check(tzone);
 
 	mutex_unlock(&thermal_zone_mutex);
 }
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 4fbbabe..4ef79c8 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -468,6 +468,7 @@ struct thermal_cooling_device *
 int thermal_zone_get_slope(struct thermal_zone_device *tz);
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
 int thermal_zone_device_toggle(struct thermal_zone_device *tz, bool on);
+void thermal_zone_device_check(struct thermal_zone_device *tz);
 
 int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
-- 
1.9.1
