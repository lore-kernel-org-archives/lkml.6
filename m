Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752996AbeDJMmz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:42:55 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:32552 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbeDJMmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:42:51 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180410124249epoutp01132be7dac7a6204caa09cb3cd35ed13c~kE6QlzQU52465424654epoutp01y
X-AuditID: b6c32a39-591ff70000000ff4-6d-5accb1482a89
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
Subject: [PATCH 01/17] thermal: add thermal_zone_device_toggle() helper
Date: Tue, 10 Apr 2018 14:41:55 +0200
Message-id: <1523364131-31059-2-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHe/Ze9m41eZu3RyWDYWCK1iLpKUsthF7RovrmPlRD39xw6tp0
        ZBB5ibygZiWmQ9TUD7ka4tKcOkvntWZGGWKleb/HjDStTK05/fY/z/93nv85cChMmEW4U/L4
        RFYVL1WISD7+ov2gnx9T2ys5PLXshmqLagg0vdQNkD63E0dlHwcI1JraD9Dm+AKB3jSkcdAd
        bQWOqibHuKi/qYRES7kdAJVYv3DR5FgeiWbrXJHhySCJfjeV4qjl6xII2cukLXaRjHbkLck0
        aoe5TP3nAKbSNMdhDLoskhkaMJFMbrqVZPLqdIBpGCjFmJ5HqzjTPdjAYZYMnhcEEv7JaFYh
        17CqQ0FX+bK15XxMuRBww2LIAynA6pcNeBSkj8LmMj2RDfiUkDYCaK1aIO3FKoA95gpyhxox
        LnLtRjOAGZmfuDZDSP8B0NgXYdMkfQLez9CBbEBRTnQ4rHtG2XiMLsbh96FOzMY40mdh00QO
        ZmNw+gCsKdtnexbQDFyf/saxZ3nC110PCZvm0WFwrWVxazpI3+PCVytt2wOFwtam1O0GRzjf
        Xce1/QlpD/ih85SdTwdwxWjC7Ew+gKYaoV0Hwvbu91sBGO0ArT9zCHuvAGbe3UYYWDXftR11
        GlqHjBz7uiUA1s945wP3crBLB1xYpTouhlWLlQH+ammcOik+xj8qIc4Atg7E57gRdPVFmAFN
        AdEeQX6bRSIkpBp1cpwZQAoTOQkU+l6JUBAtTb7JqhKuqJIUrNoMPChc5CqYivhv0THSRDaW
        ZZWsasflUDz3FODAD1ekJmt5TgoiYfzyzO3Z4c3Rd8FE78Vr3oqw9Q3OXNDfgpeA1MsDn8bK
        q5NcZRZZc//8Oc0RF96ZAnHturOkoyMt9JblktZt48f+wUqN7FgKbg7SBEY+cJwodxZHUtd/
        +RZtFFb7e2G7g0e80oufFwZEoceNxOjK+WjfEBGulknFPphKLf0H81IqaBwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsVy+t9jAV2PjWeiDBqncVlsnLGe1eLZ5+OM
        Fmt7j7JYzL9yjdXiQONlRov/j16zWpza3sRk0TJrEYvFkicP2S0u75rDZvG59wijxZx3t9kt
        njzsY7N4sUXcYtOKG2wWP3fNY7HYe+8zo4OgR9P7Y2wes+6fZfPYOesuu8fWW6Yei/e8ZPLY
        tKqTzePOtT1sHr3N79g8+rasYvTYfm0es8eJ6d9ZPI7f2M7k8XmTXABvFJdNSmpOZllqkb5d
        AlfG7y8TmAtem1ac3tTH2MD4TreLkZNDQsBE4v6O9+xdjFwcQgI7GSUePTvOBuH8YpT4s20P
        M0gVm4CVxMT2VYxdjBwcIgLeElvWcIDUMAvMZJFom/qUEaRGWMBdYtfjHmaQGhYBVYn182VB
        wrwCHhJ/n71hglgmJ3Hy2GRWEJtTwFPi9973rCDlQkA136ZYT2DkWcDIsIpRMrWgODc9t9io
        wDAvtVyvODG3uDQvXS85P3cTIzDktx3W6tvBeH9J/CFGAQ5GJR7eCQdPRwmxJpYVV+YeYpTg
        YFYS4c1ZeyZKiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6p
        BsasaV0R7D1KKpf/Lg+yuDuPe7pNbNye5wZrFI4xXOqfe+vESv9zuaGPBFv8E3ojjU9l5LLu
        UW/5IRVgwPhJNzHyHtNhpWqehEP2D1/4B/IxBgm/nt2edPAYv84vNZbfRgeje5bP53jTfa9Y
        4UxSne6WiORDMzuWVOQxm+7bqGggKu99sfkclxJLcUaioRZzUXEiAOTgZ951AgAA
X-CMS-MailID: 20180410124248epcas1p453f74df4e183f9d68de255847c093d4e
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180410124248epcas1p453f74df4e183f9d68de255847c093d4e
X-RootMTR: 20180410124248epcas1p453f74df4e183f9d68de255847c093d4e
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124248epcas1p453f74df4e183f9d68de255847c093d4e@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal_zone_device_toggle() helper. Then update core code and
drivers to use it.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/hisi_thermal.c     | 14 ++------------
 drivers/thermal/of-thermal.c       |  2 +-
 drivers/thermal/rockchip_thermal.c | 22 +++++-----------------
 drivers/thermal/thermal_helpers.c  | 15 +++++++++++++++
 drivers/thermal/thermal_sysfs.c    |  8 +++++---
 include/linux/thermal.h            |  1 +
 6 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 761d055..9428499 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -515,15 +515,6 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 };
 MODULE_DEVICE_TABLE(of, of_hisi_thermal_match);
 
-static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
-				       bool on)
-{
-	struct thermal_zone_device *tzd = sensor->tzd;
-
-	tzd->ops->set_mode(tzd,
-		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
-}
-
 static int hisi_thermal_probe(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data;
@@ -571,7 +562,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		}
 	}
 
-	hisi_thermal_toggle_sensor(&data->sensor, true);
+	thermal_zone_device_toggle((&data->sensor)->tzd, true);
 
 	return 0;
 }
@@ -579,9 +570,8 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 static int hisi_thermal_remove(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
-	struct hisi_thermal_sensor *sensor = &data->sensor;
 
-	hisi_thermal_toggle_sensor(sensor, false);
+	thermal_zone_device_toggle((&data->sensor)->tzd, false);
 
 	data->disable_sensor(data);
 
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index e09f035..f138b78 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -510,7 +510,7 @@ struct thermal_zone_device *
 			tzd = thermal_zone_of_add_sensor(child, sensor_np,
 							 data, ops);
 			if (!IS_ERR(tzd))
-				tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED);
+				thermal_zone_device_toggle(tzd, true);
 
 			of_node_put(sensor_specs.np);
 			of_node_put(child);
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index f36375d..c191e41 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1022,15 +1022,6 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 };
 MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);
 
-static void
-rockchip_thermal_toggle_sensor(struct rockchip_thermal_sensor *sensor, bool on)
-{
-	struct thermal_zone_device *tzd = sensor->tzd;
-
-	tzd->ops->set_mode(tzd,
-		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
-}
-
 static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void *dev)
 {
 	struct rockchip_thermal_data *thermal = dev;
@@ -1292,7 +1283,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	thermal->chip->control(thermal->regs, true);
 
 	for (i = 0; i < thermal->chip->chn_num; i++)
-		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
+		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, true);
 
 	platform_set_drvdata(pdev, thermal);
 
@@ -1311,11 +1302,8 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
 	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < thermal->chip->chn_num; i++) {
-		struct rockchip_thermal_sensor *sensor = &thermal->sensors[i];
-
-		rockchip_thermal_toggle_sensor(sensor, false);
-	}
+	for (i = 0; i < thermal->chip->chn_num; i++)
+		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, false);
 
 	thermal->chip->control(thermal->regs, false);
 
@@ -1332,7 +1320,7 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
 	int i;
 
 	for (i = 0; i < thermal->chip->chn_num; i++)
-		rockchip_thermal_toggle_sensor(&thermal->sensors[i], false);
+		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, false);
 
 	thermal->chip->control(thermal->regs, false);
 
@@ -1383,7 +1371,7 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 	thermal->chip->control(thermal->regs, true);
 
 	for (i = 0; i < thermal->chip->chn_num; i++)
-		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
+		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, true);
 
 	pinctrl_pm_select_default_state(dev);
 
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index eb03d7e..d5db101 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -227,3 +227,18 @@ int thermal_zone_get_offset(struct thermal_zone_device *tz)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_offset);
+
+/**
+ * thermal_zone_device_toggle() - enables/disables thermal zone device
+ * @tz: a valid pointer to a struct thermal_zone_device
+ *
+ * Enables/Disables thermal zone device.
+ *
+ * Return: On success returns 0, an error code otherwise.
+ */
+int thermal_zone_device_toggle(struct thermal_zone_device *tz, bool on)
+{
+	return tz->ops->set_mode(tz,
+		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_toggle);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 23b5e0a..343f52b 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -72,17 +72,19 @@
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	int result;
+	bool on;
 
 	if (!tz->ops->set_mode)
 		return -EPERM;
 
 	if (!strncmp(buf, "enabled", sizeof("enabled") - 1))
-		result = tz->ops->set_mode(tz, THERMAL_DEVICE_ENABLED);
+		on = true;
 	else if (!strncmp(buf, "disabled", sizeof("disabled") - 1))
-		result = tz->ops->set_mode(tz, THERMAL_DEVICE_DISABLED);
+		on = false;
 	else
-		result = -EINVAL;
+		return -EINVAL;
 
+	result = thermal_zone_device_toggle(tz, on);
 	if (result)
 		return result;
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 7834be6..4fbbabe 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -467,6 +467,7 @@ struct thermal_cooling_device *
 int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 int thermal_zone_get_slope(struct thermal_zone_device *tz);
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
+int thermal_zone_device_toggle(struct thermal_zone_device *tz, bool on);
 
 int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
-- 
1.9.1
