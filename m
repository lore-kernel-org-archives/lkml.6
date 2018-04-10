Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbeDJMn2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:43:28 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:57414 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeDJMnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:43:23 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180410124321epoutp031ba426c078416247fc1de2cfbf9d63c6~kE6uco5E30588705887epoutp03T
X-AuditID: b6c32a48-8d9ff70000000ff2-40-5accb169e3cc
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
Subject: [PATCH 04/17] thermal: do sensor checking explicitly in drivers
Date: Tue, 10 Apr 2018 14:41:58 +0200
Message-id: <1523364131-31059-5-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRzGfXfOzo7S4jQ1X2b6YWSglKYpvZhIYcTJLPwSxIJs5EmX25Qd
        NQ1CU/EG81aQrqWhSbFNxnTmnBNN01leupgmZYomVipqGJmalbv47fm/z+/5X+AlMYGKKySl
        inRGqZDIRIQH/qw3MOKI1DgkPvp3RIiM1QYuml+zAdSk6sNR3ftxLuq+MwrQv9lFLnrVlsdB
        Bep6HD2em+GhUYuGQGuqFwBplj/x0NxMGYG+mXxQ89MJAm1YanHUObUGTu6j81b6CVo9PUzQ
        7erPPLr1YwTdYP3OoZu1JQQ9OW4laFX+MkGXmbSAbhuvxeiB++s4bZto49Brzf7xfLFHVCIj
        k2YyypDoqx7Jr6uGsbSWUpBVZDqeC2zppcCdhFQ4HKwvwUuBBymgzABuD5RznMU6gG90udxd
        Sr1lclEdAP4sXATOYnMnkl9J2CmCioSVRdodgyS9qHPQpCftDEbV4HB1sg+zM54UDUsqv3Ls
        GqcC4Gr/gkPzd96N5U085zR/+LL/rmOyO3UWbnWucO2NIFXOg9sGnWul03BTX0A4tSdcsJlc
        YV84rzUCZyAfwF9mK+Y0KgC0GgROfQL22t46GmHUXljcu82zbw0pPiwudCE01C/9cfU/BWfn
        tgnnxRoAdVV6UAGEj4CbFuxn0lh5EsOGpYUHsxI5m6FICr6WKm8Gjk8SRJtB90hcD6BIINrD
        R12DYgFXkslmy3sAJDGRF1/WNCQW8BMl2bcYZWqCMkPGsD3Al8RFPvzc8zsWlSRJZ1IYJo1R
        7roc0l2YC+KjpVcsqZfZOG9R1O8ZrMZ7fUT+IDalQTn6RHiwamyprfjdoetfcgILw8hYa/uH
        Rs10fGFF/e0sbcCBw10tRR1l1sbnDy8pqrOO1bFnEm3GCw0BkWM/dDlh9yovSkMrzFOEn8Y9
        IeZGq1EUshySb7NM8mIG3HTarfibG36TswYRziZLQoMwJSv5DxtZnFogAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsVy+t9jAd3MjWeiDKYs57PYOGM9q8Wzz8cZ
        Ldb2HmWxmH/lGqvFgcbLjBb/H71mtTi1vYnJomXWIhaLJU8esltc3jWHzeJz7xFGiznvbrNb
        PHnYx2bxYou4xaYVN9gsfu6ax2Kx995nRgdBj6b3x9g8Zt0/y+axc9Zddo+tt0w9Fu95yeSx
        aVUnm8eda3vYPHqb37F59G1Zxeix/do8Zo8T07+zeBy/sZ3J4/MmuQDeKC6blNSczLLUIn27
        BK6M85POMhds7mKsaN9i3sB4vKSLkZNDQsBEYtbvLSwgtpDATkaJqQdjuhi5gOxfjBItS8+z
        giTYBKwkJravYuxi5OAQEfCW2LKGA6SGWWAmi0Tb1KeMIDXCAh4SnROfM4HYLAKqEh+OvQKz
        eYHiG/vXskMsk5M4eWwy2ExOAU+J33vfs4LMFAKq+TbFegIjzwJGhlWMkqkFxbnpucVGBUZ5
        qeV6xYm5xaV56XrJ+bmbGIEhv+2wVv8OxsdL4g8xCnAwKvHwTjh4OkqINbGsuDL3EKMEB7OS
        CG/O2jNRQrwpiZVVqUX58UWlOanFhxilOViUxHn5849FCgmkJ5akZqemFqQWwWSZODilGhgX
        7zL8ccTj1xrrgAOveVwjvwlPETsTufXYW3MmM7n9hs9fFJgxshyOWiES27m61XDKOi35a5sb
        3R/cDDPPNuaZI2N4/u3Z+bs25663Nt8ZemtijhwX7/4XbN+Xnfn9oDAkeQrv7tNsh98Yhf9X
        ZrVo4VLyLq413uXXF9rvk3z694/CN3duXFBSYinOSDTUYi4qTgQACrB4g3UCAAA=
X-CMS-MailID: 20180410124321epcas2p3b69098cf09147bb4751d5c035ad506bb
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180410124321epcas2p3b69098cf09147bb4751d5c035ad506bb
X-RootMTR: 20180410124321epcas2p3b69098cf09147bb4751d5c035ad506bb
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124321epcas2p3b69098cf09147bb4751d5c035ad506bb@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Add set_mode_skip_check flag to struct thermal_zone_device_ops and
  set it in drivers that don't check the thermal zone device in their
  ->set_mode method implementations.

* Move thermal_zone_device_check() from ->set_mode implementations to
  the users of thermal_zone_device_toggle() (only place which calls
  ->set_mode). Modify mode_store() in thermal_sysfs.c accordingly.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/acpi/thermal.c                             |  2 ++
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  2 --
 drivers/platform/x86/acerhdf.c                     |  2 ++
 drivers/thermal/broadcom/bcm2835_thermal.c         |  1 +
 drivers/thermal/broadcom/brcmstb_thermal.c         |  1 +
 drivers/thermal/broadcom/ns-thermal.c              |  1 +
 drivers/thermal/db8500_thermal.c                   |  2 ++
 drivers/thermal/hisi_thermal.c                     |  3 +++
 drivers/thermal/imx_thermal.c                      |  2 --
 drivers/thermal/int340x_thermal/int3400_thermal.c  |  1 +
 drivers/thermal/max77620_thermal.c                 |  1 +
 drivers/thermal/mtk_thermal.c                      |  1 +
 drivers/thermal/of-thermal.c                       |  2 --
 drivers/thermal/qcom-spmi-temp-alarm.c             |  1 +
 drivers/thermal/qcom/tsens.c                       |  1 +
 drivers/thermal/qoriq_thermal.c                    |  1 +
 drivers/thermal/rcar_gen3_thermal.c                |  1 +
 drivers/thermal/rcar_thermal.c                     |  4 +++-
 drivers/thermal/rockchip_thermal.c                 | 17 +++++++++++++----
 drivers/thermal/samsung/exynos_tmu.c               |  1 +
 drivers/thermal/tango_thermal.c                    |  4 +++-
 drivers/thermal/tegra/soctherm.c                   |  1 +
 drivers/thermal/tegra/tegra-bpmp-thermal.c         |  1 +
 drivers/thermal/thermal-generic-adc.c              |  1 +
 drivers/thermal/thermal_sysfs.c                    |  3 +++
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  1 +
 drivers/thermal/uniphier_thermal.c                 |  1 +
 drivers/thermal/zx2967_thermal.c                   |  1 +
 include/linux/thermal.h                            |  2 ++
 29 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index b8b275e1..a7e3d9e 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -879,6 +879,8 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 	.get_crit_temp = thermal_get_crit_temp,
 	.get_trend = thermal_get_trend,
 	.notify = thermal_notify,
+
+	.set_mode_skip_check = true,
 };
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 7513359..6b388b0 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -198,8 +198,6 @@ static int mlxsw_thermal_set_mode(struct thermal_zone_device *tzdev,
 
 	thermal->mode = mode;
 
-	thermal_zone_device_check(tzdev);
-
 	return 0;
 }
 
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 19b9bc9..a4dfd2e 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -495,6 +495,8 @@ static int acerhdf_get_crit_temp(struct thermal_zone_device *thermal,
 	.get_trip_hyst = acerhdf_get_trip_hyst,
 	.get_trip_temp = acerhdf_get_trip_temp,
 	.get_crit_temp = acerhdf_get_crit_temp,
+
+	.set_mode_skip_check = true,
 };
 
 
diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index f5e913c..1270e3f 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -228,6 +228,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 	}
 
 	thermal_zone_device_toggle(tz, true);
+	thermal_zone_device_check(tz);
 
 	/*
 	 * right now the FW does set up the HW-block, so we are not
diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 075c9b7..fead74f 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -337,6 +337,7 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	}
 
 	thermal_zone_device_toggle(thermal, true);
+	thermal_zone_device_check(thermal);
 
 	priv->thermal = thermal;
 
diff --git a/drivers/thermal/broadcom/ns-thermal.c b/drivers/thermal/broadcom/ns-thermal.c
index aa151dd..728b4dc 100644
--- a/drivers/thermal/broadcom/ns-thermal.c
+++ b/drivers/thermal/broadcom/ns-thermal.c
@@ -72,6 +72,7 @@ static int ns_thermal_probe(struct platform_device *pdev)
 	}
 
 	thermal_zone_device_toggle(ns_thermal->tz, true);
+	thermal_zone_device_check(ns_thermal->tz);
 
 	platform_set_drvdata(pdev, ns_thermal);
 
diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index ab66b2d7..c4d0fb1 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -220,6 +220,8 @@ static int db8500_sys_get_crit_temp(struct thermal_zone_device *thermal,
 	.get_trip_type = db8500_sys_get_trip_type,
 	.get_trip_temp = db8500_sys_get_trip_temp,
 	.get_crit_temp = db8500_sys_get_crit_temp,
+
+	.set_mode_skip_check = true,
 };
 
 static void db8500_thermal_update_config(struct db8500_thermal_zone *pzone,
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 8cfe3d2..1936eb4 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -489,6 +489,7 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 	}
 
 	thermal_zone_device_toggle(sensor->tzd, true);
+	thermal_zone_device_check(sensor->tzd);
 
 	trip = of_thermal_get_trip_points(sensor->tzd);
 
@@ -563,6 +564,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 	}
 
 	thermal_zone_device_toggle((&data->sensor)->tzd, true);
+	thermal_zone_device_check((&data->sensor)->tzd);
 
 	return 0;
 }
@@ -572,6 +574,7 @@ static int hisi_thermal_remove(struct platform_device *pdev)
 	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
 
 	thermal_zone_device_toggle((&data->sensor)->tzd, false);
+	thermal_zone_device_check((&data->sensor)->tzd);
 
 	data->disable_sensor(data);
 
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 2cd1921..6bbc70b 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -389,8 +389,6 @@ static int imx_set_mode(struct thermal_zone_device *tz,
 
 	data->mode = mode;
 
-	thermal_zone_device_check(tz);
-
 	return 0;
 }
 
diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index e26b01c..d1f0641 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -305,6 +305,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (priv->uuid_bitmap & 1 << INT3400_THERMAL_PASSIVE_1) {
 		int3400_thermal_ops.get_mode = int3400_thermal_get_mode;
 		int3400_thermal_ops.set_mode = int3400_thermal_set_mode;
+		int3400_thermal_ops.set_mode_skip_check = true;
 	}
 	priv->thermal = thermal_zone_device_register("INT3400 Thermal", 0, 0,
 						priv, &int3400_thermal_ops,
diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index f896a97..ee4ccd9 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -126,6 +126,7 @@ static int max77620_thermal_probe(struct platform_device *pdev)
 	}
 
 	thermal_zone_device_toggle(mtherm->tz_device, true);
+	thermal_zone_device_check(mtherm->tz_device);
 
 	ret = devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm1, NULL,
 					max77620_thermal_irq,
diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 806df57..9743ca2 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -770,6 +770,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	}
 
 	thermal_zone_device_toggle(tzdev, true);
+	thermal_zone_device_check(tzdev);
 
 	return 0;
 
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index a65b515..f60ccf1 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -286,8 +286,6 @@ static int of_thermal_set_mode(struct thermal_zone_device *tz,
 
 	data->mode = mode;
 
-	thermal_zone_device_check(tz);
-
 	return 0;
 }
 
diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
index fa42517..7af3458 100644
--- a/drivers/thermal/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom-spmi-temp-alarm.c
@@ -271,6 +271,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	}
 
 	thermal_zone_device_toggle(chip->tz_dev, true);
+	thermal_zone_device_check(chip->tz_dev);
 
 	return 0;
 }
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 3405dea..0d119c1 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -103,6 +103,7 @@ static int tsens_register(struct tsens_device *tmdev)
 			continue;
 
 		thermal_zone_device_toggle(tzd, true);
+		thermal_zone_device_check(tzd);
 
 		tmdev->sensor[i].tzd = tzd;
 
diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 1ce2d93..cdd6f59 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -243,6 +243,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	}
 
 	thermal_zone_device_toggle(data->tz, true);
+	thermal_zone_device_check(data->tz);
 
 	/* Enable monitoring */
 	site |= 0x1 << (15 - data->sensor_id);
diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 69142c2..87061b1 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -430,6 +430,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		}
 
 		thermal_zone_device_toggle(zone, true);
+		thermal_zone_device_check(zone);
 
 		tsc->zone = zone;
 
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 080e6ec..5c2df6a 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -514,8 +514,10 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 		}
 
-		if (rcar_use_of_thermal(dev))
+		if (rcar_use_of_thermal(dev)) {
 			thermal_zone_device_toggle(priv->zone, true);
+			thermal_zone_device_check(priv->zone);
+		}
 
 		if (rcar_use_of_thermal(dev)) {
 			/*
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index d0e4042..500cfc3 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1162,6 +1162,7 @@ static int rockchip_configure_from_dt(struct device *dev,
 	}
 
 	thermal_zone_device_toggle(sensor->tzd, true);
+	thermal_zone_device_check(sensor->tzd);
 
 	return 0;
 }
@@ -1283,8 +1284,10 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 
 	thermal->chip->control(thermal->regs, true);
 
-	for (i = 0; i < thermal->chip->chn_num; i++)
+	for (i = 0; i < thermal->chip->chn_num; i++) {
 		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, true);
+		thermal_zone_device_check((&thermal->sensors[i])->tzd);
+	}
 
 	platform_set_drvdata(pdev, thermal);
 
@@ -1303,8 +1306,10 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
 	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < thermal->chip->chn_num; i++)
+	for (i = 0; i < thermal->chip->chn_num; i++) {
 		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, false);
+		thermal_zone_device_check((&thermal->sensors[i])->tzd);
+	}
 
 	thermal->chip->control(thermal->regs, false);
 
@@ -1320,8 +1325,10 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
 	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < thermal->chip->chn_num; i++)
+	for (i = 0; i < thermal->chip->chn_num; i++) {
 		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, false);
+		thermal_zone_device_check((&thermal->sensors[i])->tzd);
+	}
 
 	thermal->chip->control(thermal->regs, false);
 
@@ -1371,8 +1378,10 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 
 	thermal->chip->control(thermal->regs, true);
 
-	for (i = 0; i < thermal->chip->chn_num; i++)
+	for (i = 0; i < thermal->chip->chn_num; i++) {
 		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, true);
+		thermal_zone_device_check((&thermal->sensors[i])->tzd);
+	}
 
 	pinctrl_pm_select_default_state(dev);
 
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 5b07a8f..af1902d 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1404,6 +1404,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	}
 
 	thermal_zone_device_toggle(data->tzd, true);
+	thermal_zone_device_check(data->tzd);
 
 	ret = exynos_tmu_initialize(pdev);
 	if (ret) {
diff --git a/drivers/thermal/tango_thermal.c b/drivers/thermal/tango_thermal.c
index 6bbd766..0d2f14e 100644
--- a/drivers/thermal/tango_thermal.c
+++ b/drivers/thermal/tango_thermal.c
@@ -90,8 +90,10 @@ static int tango_thermal_probe(struct platform_device *pdev)
 	tango_thermal_init(priv);
 
 	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv, &ops);
-	if (!IS_ERR(tzdev))
+	if (!IS_ERR(tzdev)) {
 		thermal_zone_device_toggle(tzdev, true);
+		thermal_zone_device_check(tzdev);
+	}
 
 	return PTR_ERR_OR_ZERO(tzdev);
 }
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 0236e18..9554613 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1401,6 +1401,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		}
 
 		thermal_zone_device_toggle(z, true);
+		thermal_zone_device_check(z);
 
 		zone->tz = z;
 		tegra->thermctl_tzs[soc->ttgs[i]->id] = z;
diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal/tegra/tegra-bpmp-thermal.c
index aa40f70..1d89a14 100644
--- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
+++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
@@ -214,6 +214,7 @@ static int tegra_bpmp_thermal_probe(struct platform_device *pdev)
 		}
 
 		thermal_zone_device_toggle(tzd, true);
+		thermal_zone_device_check(tzd);
 
 		zone->tzd = tzd;
 		INIT_WORK(&zone->tz_device_update_work,
diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index f74eebc..6f45dab 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -143,6 +143,7 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 	}
 
 	thermal_zone_device_toggle(gti->tz_dev, true);
+	thermal_zone_device_check(gti->tz_dev);
 
 	return 0;
 }
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 109be2f..d6da2c2 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -88,6 +88,9 @@
 	if (result)
 		return result;
 
+	if (!tz->ops->set_mode_skip_check)
+		thermal_zone_device_check(tz);
+
 	return count;
 }
 
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index d1b55d9..3c2299b 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -198,6 +198,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 	}
 
 	thermal_zone_device_toggle(data->ti_thermal, true);
+	thermal_zone_device_check(data->ti_thermal);
 
 	ti_bandgap_set_sensor_data(bgp, id, data);
 	ti_bandgap_write_update_interval(bgp, data->sensor_id,
diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index f2f8b2b..8070747 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -308,6 +308,7 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 	}
 
 	thermal_zone_device_toggle(tdev->tz_dev, true);
+	thermal_zone_device_check(tdev->tz_dev);
 
 	/* get trip points */
 	trips = of_thermal_get_trip_points(tdev->tz_dev);
diff --git a/drivers/thermal/zx2967_thermal.c b/drivers/thermal/zx2967_thermal.c
index ff406a4..ffd2b07 100644
--- a/drivers/thermal/zx2967_thermal.c
+++ b/drivers/thermal/zx2967_thermal.c
@@ -169,6 +169,7 @@ static int zx2967_thermal_probe(struct platform_device *pdev)
 	}
 
 	thermal_zone_device_toggle(priv->tzd, true);
+	thermal_zone_device_check(priv->tzd);
 
 	if (priv->tzd->tzp->slope == 0) {
 		thermal_zone_of_sensor_unregister(&pdev->dev, priv->tzd);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 4ef79c8..7de102f 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -128,6 +128,8 @@ struct thermal_zone_device_ops {
 			  enum thermal_trend *);
 	int (*notify) (struct thermal_zone_device *, int,
 		       enum thermal_trip_type);
+
+	bool set_mode_skip_check;
 };
 
 struct thermal_cooling_device_ops {
-- 
1.9.1
