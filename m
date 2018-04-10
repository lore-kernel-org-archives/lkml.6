Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeDJMnF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:43:05 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:32590 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753028AbeDJMnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:43:03 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180410124301epoutp013a4f4e8b07fd020617ede996c43f012a~kE6b0g0f-2465424654epoutp01z
X-AuditID: b6c32a35-139ff70000000fee-3d-5accb1558e97
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
Subject: [PATCH 02/17] thermal: separate sensor registration and enable
Date: Tue, 10 Apr 2018 14:41:56 +0200
Message-id: <1523364131-31059-3-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTURzHO7uPXUeL29Q8+Qom/pGQKWgcemH08Pr4Q4oKB5ZDL5voVHZV
        VAiXM01N0TRfqJkPrKWJOp8p1HQuy8QXIqWJukorHyQmZmS5q/99fnw/53x/Bw6FSbIJeyoi
        Oo5VR8ujpKQIb+877n7ievOQzGNSdxQ1lzQR6Mu6CaDGHCOOHk9MEujV3XGAdua/E+htR6oA
        pZVV46jWPCdE493lJFrP6QeofOWjEJnnckm0qLdDLU+nSLTVXYmj3k/rwOcwk7o6QDJls+9J
        pqtsRsi0ffBmanqWBEyLLpNkpid7SCZHu0IyuXodYDomKzHmTfEmzpimOgTMeotzkFgmOhvO
        RkUksOqT50NFSnOdDosdliU+bKA0wBiQBawoSHvB8pHnRBYQURK6E8DejYy9YRPAwa0/xL6l
        KSrC+eAlgNUVeowffgOYXtxlsUj6NMzP0IEsQFE2dADUN1C7DkaX4nBt2ojtOta0L5xq/WFh
        nHaFs7laC4tpBubM9wO+zRkODhRY7rSi/eB276plJUhnC2Fd/QzJS5egKXNFwLM1/GbSC3eL
        Ie0Ax4zneF8L4K/OHox38gDsaZLwfAb2mUYtBRh9CK5sPCD4s2J4P31PYeBQ7k+c5wtw9FGl
        gH9wOYDL2/lEHrCvAgd04Agby6kULOcZ6+nOyVVcfLTCPSxG1QIsX8TNuxMUDgcaAE0B6UFx
        3ut3MgkhT+CSVAYAKUxqI45qHJJJxOHypGRWHXNbHR/FcgbgQOFSO/HnwP8RrZDHsZEsG8uq
        91MBZWWvAV5JzX6+IxWBwSm2pdyCIjL+1LEbQ841C9rOuWsKpVKTFjrzt3tGNbHo3t6cXEJt
        e02nbyeGVH2903Wzf63J4PQsM6yWSAk54Fp4teRWaGuw/z0Xp2XlmMtWm9mu3nGpi7SS+Ba+
        KBJrifwI6yuSoDj/Akcf2UWPnSeXA3xSbf2kOKeUe7phak7+DySOiFkeAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsVy+t9jAd3QjWeiDN42s1tsnLGe1eLZ5+OM
        Fmt7j7JYzL9yjdXiQONlRov/j16zWpza3sRk0TJrEYvFkicP2S0u75rDZvG59wijxZx3t9kt
        njzsY7N4sUXcYtOKG2wWP3fNY7HYe+8zo4OgR9P7Y2wes+6fZfPYOesuu8fWW6Yei/e8ZPLY
        tKqTzePOtT1sHr3N79g8+rasYvTYfm0es8eJ6d9ZPI7f2M7k8XmTXABvFJdNSmpOZllqkb5d
        AlfGk6WrmAvORVVMWsPRwHjUu4uRk0NCwESiYdo0li5GLg4hgZ2MEt9XrGbuYuQAcn4xSvxj
        AqlhE7CSmNi+ihEkLCLgLbFlDQdIObPATBaJtqlPGUFqhAXcJW5sfsMMYrMIqErc72sGs3kF
        PCR6Hx1hhNglJ3Hy2GRWEJtTwFPi9973rBCrPCS+TbGewMizgJFhFaNkakFxbnpusVGBYV5q
        uV5xYm5xaV66XnJ+7iZGYLhvO6zVt4Px/pL4Q4wCHIxKPLwTDp6OEmJNLCuuzD3EKMHBrCTC
        m7P2TJQQb0piZVVqUX58UWlOavEhRmkOFiVx3tt5xyKFBNITS1KzU1MLUotgskwcnFINjPUJ
        JaVc8SH1cXM/Gb879af3poHxubQU8501jIptmqpr7m84l7Hf6MGWtFk/l/36fOjZmWWl9r/2
        9lnKcm7gXxNo3e2+ycq86LfA43c/1EVl85/+tMw95lwmtqDdlGvKt+shEbbJx/zPFKyaPKHo
        dMvz5wzsfpKnAxjvZrFbvunv2GLx6njuOyWW4oxEQy3mouJEANG2sbpzAgAA
X-CMS-MailID: 20180410124301epcas1p1ec12971677961efaf55500f743af6a7c
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180410124301epcas1p1ec12971677961efaf55500f743af6a7c
X-RootMTR: 20180410124301epcas1p1ec12971677961efaf55500f743af6a7c
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124301epcas1p1ec12971677961efaf55500f743af6a7c@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move thermal_zone_device_toggle() call to the users of
[devm]_thermal_zone_of_sensor_register().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/broadcom/bcm2835_thermal.c         | 2 ++
 drivers/thermal/broadcom/brcmstb_thermal.c         | 2 ++
 drivers/thermal/broadcom/ns-thermal.c              | 2 ++
 drivers/thermal/hisi_thermal.c                     | 2 ++
 drivers/thermal/max77620_thermal.c                 | 2 ++
 drivers/thermal/mtk_thermal.c                      | 2 ++
 drivers/thermal/of-thermal.c                       | 3 ---
 drivers/thermal/qcom-spmi-temp-alarm.c             | 2 ++
 drivers/thermal/qcom/tsens.c                       | 5 +++++
 drivers/thermal/qoriq_thermal.c                    | 2 ++
 drivers/thermal/rcar_gen3_thermal.c                | 3 +++
 drivers/thermal/rcar_thermal.c                     | 3 +++
 drivers/thermal/rockchip_thermal.c                 | 2 ++
 drivers/thermal/samsung/exynos_tmu.c               | 2 ++
 drivers/thermal/tango_thermal.c                    | 3 +++
 drivers/thermal/tegra/soctherm.c                   | 2 ++
 drivers/thermal/tegra/tegra-bpmp-thermal.c         | 2 ++
 drivers/thermal/thermal-generic-adc.c              | 2 ++
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 2 ++
 drivers/thermal/uniphier_thermal.c                 | 2 ++
 drivers/thermal/zx2967_thermal.c                   | 2 ++
 21 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index a4d6a0e..f5e913c 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -227,6 +227,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
+	thermal_zone_device_toggle(tz, true);
+
 	/*
 	 * right now the FW does set up the HW-block, so we are not
 	 * touching the configuration registers.
diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 1919f91..075c9b7 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -336,6 +336,8 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	thermal_zone_device_toggle(thermal, true);
+
 	priv->thermal = thermal;
 
 	irq = platform_get_irq(pdev, 0);
diff --git a/drivers/thermal/broadcom/ns-thermal.c b/drivers/thermal/broadcom/ns-thermal.c
index 322e741..aa151dd 100644
--- a/drivers/thermal/broadcom/ns-thermal.c
+++ b/drivers/thermal/broadcom/ns-thermal.c
@@ -71,6 +71,8 @@ static int ns_thermal_probe(struct platform_device *pdev)
 		return PTR_ERR(ns_thermal->tz);
 	}
 
+	thermal_zone_device_toggle(ns_thermal->tz, true);
+
 	platform_set_drvdata(pdev, ns_thermal);
 
 	return 0;
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 9428499..d7237d1 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -490,6 +490,8 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 		return ret;
 	}
 
+	thermal_zone_device_toggle(sensor->tzd, true);
+
 	trip = of_thermal_get_trip_points(sensor->tzd);
 
 	for (i = 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 159bbce..337d695 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -126,6 +126,8 @@ static int max77620_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	thermal_zone_device_toggle(mtherm->tz_device, true);
+
 	ret = devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm1, NULL,
 					max77620_thermal_irq,
 					IRQF_ONESHOT | IRQF_SHARED,
diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index e709acb..806df57 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -769,6 +769,8 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		goto err_disable_clk_peri_therm;
 	}
 
+	thermal_zone_device_toggle(tzdev, true);
+
 	return 0;
 
 err_disable_clk_peri_therm:
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index f138b78..890e272 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -509,9 +509,6 @@ struct thermal_zone_device *
 		if (sensor_specs.np == sensor_np && id == sensor_id) {
 			tzd = thermal_zone_of_add_sensor(child, sensor_np,
 							 data, ops);
-			if (!IS_ERR(tzd))
-				thermal_zone_device_toggle(tzd, true);
-
 			of_node_put(sensor_specs.np);
 			of_node_put(child);
 			goto exit;
diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
index 95f987d..cb46555 100644
--- a/drivers/thermal/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom-spmi-temp-alarm.c
@@ -270,6 +270,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return PTR_ERR(chip->tz_dev);
 	}
 
+	thermal_zone_device_toggle(chip->tz_dev, true);
+
 	return 0;
 }
 
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 3f9fe6a..3405dea 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -95,12 +95,17 @@ static int tsens_register(struct tsens_device *tmdev)
 	for (i = 0;  i < tmdev->num_sensors; i++) {
 		tmdev->sensor[i].tmdev = tmdev;
 		tmdev->sensor[i].id = i;
+
 		tzd = devm_thermal_zone_of_sensor_register(tmdev->dev, i,
 							   &tmdev->sensor[i],
 							   &tsens_of_ops);
 		if (IS_ERR(tzd))
 			continue;
+
+		thermal_zone_device_toggle(tzd, true);
+
 		tmdev->sensor[i].tzd = tzd;
+
 		if (tmdev->ops->enable)
 			tmdev->ops->enable(tmdev, i);
 	}
diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index c866cc1..1ce2d93 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -242,6 +242,8 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		goto err_tmu;
 	}
 
+	thermal_zone_device_toggle(data->tz, true);
+
 	/* Enable monitoring */
 	site |= 0x1 << (15 - data->sensor_id);
 	tmu_write(data, site | TMR_ME | TMR_ALPF, &data->regs->tmr);
diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 561a0a3..5d26aab 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -429,6 +429,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			ret = PTR_ERR(zone);
 			goto error_unregister;
 		}
+
+		thermal_zone_device_toggle(zone, true);
+
 		tsc->zone = zone;
 
 		ret = of_thermal_get_ntrips(tsc->zone);
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 73e5fee..5c2a42d 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -515,6 +515,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 		}
 
+		if (rcar_use_of_thermal(dev))
+			thermal_zone_device_toggle(priv->zone, true);
+
 		if (rcar_use_of_thermal(dev)) {
 			/*
 			 * thermal_zone doesn't enable hwmon as default,
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index c191e41..c41bb6c 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1162,6 +1162,8 @@ static int rockchip_configure_from_dt(struct device *dev,
 		return error;
 	}
 
+	thermal_zone_device_toggle(sensor->tzd, true);
+
 	return 0;
 }
 
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 2ec8548..cbe5471 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1403,6 +1403,8 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_sclk;
 	}
 
+	thermal_zone_device_toggle(data->tzd, true);
+
 	ret = exynos_tmu_initialize(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize TMU\n");
diff --git a/drivers/thermal/tango_thermal.c b/drivers/thermal/tango_thermal.c
index 4e67795..6bbd766 100644
--- a/drivers/thermal/tango_thermal.c
+++ b/drivers/thermal/tango_thermal.c
@@ -90,6 +90,9 @@ static int tango_thermal_probe(struct platform_device *pdev)
 	tango_thermal_init(priv);
 
 	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv, &ops);
+	if (!IS_ERR(tzdev))
+		thermal_zone_device_toggle(tzdev, true);
+
 	return PTR_ERR_OR_ZERO(tzdev);
 }
 
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 455b58c..0236e18 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1400,6 +1400,8 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 			goto disable_clocks;
 		}
 
+		thermal_zone_device_toggle(z, true);
+
 		zone->tz = z;
 		tegra->thermctl_tzs[soc->ttgs[i]->id] = z;
 
diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal/tegra/tegra-bpmp-thermal.c
index b0980db..aa40f70 100644
--- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
+++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
@@ -213,6 +213,8 @@ static int tegra_bpmp_thermal_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		thermal_zone_device_toggle(tzd, true);
+
 		zone->tzd = tzd;
 		INIT_WORK(&zone->tz_device_update_work,
 			  tz_device_update_work_fn);
diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 46d3005..f74eebc 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -142,6 +142,8 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	thermal_zone_device_toggle(gti->tz_dev, true);
+
 	return 0;
 }
 
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index b4f981d..621add3 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -197,6 +197,8 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 		return PTR_ERR(data->ti_thermal);
 	}
 
+	thermal_zone_device_toggle(data->ti_thermal, true);
+
 	ti_bandgap_set_sensor_data(bgp, id, data);
 	ti_bandgap_write_update_interval(bgp, data->sensor_id,
 					data->ti_thermal->polling_delay);
diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 9570473..f83bb3e 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -307,6 +307,8 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 		return PTR_ERR(tdev->tz_dev);
 	}
 
+	thermal_zone_device_toggle(tdev->tz_dev, true);
+
 	/* get trip points */
 	trips = of_thermal_get_trip_points(tdev->tz_dev);
 	ntrips = of_thermal_get_ntrips(tdev->tz_dev);
diff --git a/drivers/thermal/zx2967_thermal.c b/drivers/thermal/zx2967_thermal.c
index 6acce0b..ff406a4 100644
--- a/drivers/thermal/zx2967_thermal.c
+++ b/drivers/thermal/zx2967_thermal.c
@@ -168,6 +168,8 @@ static int zx2967_thermal_probe(struct platform_device *pdev)
 		goto disable_clk_all;
 	}
 
+	thermal_zone_device_toggle(priv->tzd, true);
+
 	if (priv->tzd->tzp->slope == 0) {
 		thermal_zone_of_sensor_unregister(&pdev->dev, priv->tzd);
 		dev_err(&pdev->dev, "coefficients of sensor is invalid\n");
-- 
1.9.1
