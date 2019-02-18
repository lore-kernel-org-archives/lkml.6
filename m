Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1778C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A0B21773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICrn/E3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfBRTMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:12:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34373 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbfBRTMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:12:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id d15so2036956plr.1;
        Mon, 18 Feb 2019 11:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IdPVPuEItDnwPeK60nkAnUjf6UZpWVTdqGrlfCeQJY8=;
        b=ICrn/E3oIZYvK2gWlCUyH0f0zGyqiE+Yo1rohr7Gz+V5VM26o1HPye+N9AFCQ3d+KB
         sJnAuSQJClVTPOomI7AdmiBs1rk0NiUwmervsgh8PYq8CMFOhUlTMxuJdOEYJo55xypF
         KQFDsm0HwgvLCZhlDbzy+CjILmuNXvHXK+QHnx3qxN3RYZZoL5RG6PQWXj6UyJ5yZVS7
         a7uYLgU2vTDdC9pemKgMZj/cXzUrP4XDBhKtVONEjslaAiPVLJHBGqQYTTnRATjBpAby
         yP+TqRHMxAnslIx98Ms4BYdMHnw0wRYXAVH5huh0+kRx8cKOTXr8/+IFHbAjaL8liktZ
         T3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IdPVPuEItDnwPeK60nkAnUjf6UZpWVTdqGrlfCeQJY8=;
        b=U0o4BR/s/ggD0ppxK/Bm3z25TVYkj+cMGYhQxt3Wr4y9KY9Cx57NNYSOKUyIdoVXGo
         FAxwwBpL9j0PQrrTS/5MaxkrPI9W8Bqd4iI5/PLOsIJep/rgAEWVLa6lSlsoDvGuMXg+
         dPsklK+Fkinxn6y5G2vE+RXC5GvWmqTaNB98i16Jvsh8Phtlqq/gudYxnDqQpHzGY5d3
         06ysjJFWtNTel1673b2hRfPCyfIKBZSx0k09fiM7liIIatrU4s6TPas1+rEJpE7gyVpn
         XQf1jii8yOK5zqjpZ6BnPejH2sWIKaQNOZd+r+CUBbHXNF08tlrOhch8wnLJyGoNWP4u
         JT7A==
X-Gm-Message-State: AHQUAubd5kphqDFoNPCkIfRaka5qUF+QILJHsgHGLApXpg6yo95HPF5j
        Vt8NEg5anejkbCt/YZW9xDhABD+B
X-Google-Smtp-Source: AHgI3IZceGKiYaxXuM2X5X63aSHyo5JEJ/G9kexZvF3IcZmOEiDrPUULcuFgj0WwJZ09bDx0169G0w==
X-Received: by 2002:a17:902:5a42:: with SMTP id f2mr16767498plm.157.1550517135092;
        Mon, 18 Feb 2019 11:12:15 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t12sm33189727pgq.68.2019.02.18.11.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:12:14 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] thermal: qoriq: Add support for multiple thremal sites
Date:   Mon, 18 Feb 2019 11:11:41 -0800
Message-Id: <20190218191141.3729-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TMU IP block provides temerature measurement for up to 16 sites,
current implementation of the driver however hardcodes a single site
ID. Change the code so it would be possible to reference multiple
sites as indivudial sensors and get their temperature readings.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 132 ++++++++++++++++++++------------
 1 file changed, 84 insertions(+), 48 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index f746c62789b0..6cc6e6b36fb0 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -24,6 +24,8 @@
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
 #define TMR_ALPF	0x0c000000
+#define TMR_ALPF_MASK	GENMASK(27, 26)
+
 
 #define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
 #define TMTMIR_DEFAULT	0x0000000f
@@ -41,21 +43,32 @@
 #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
 					   * Control Register
 					   */
+struct qoriq_tmu_sensor {
+	struct thermal_zone_device *tz;
+	int id;
+};
+
 /*
  * Thermal zone data
  */
 struct qoriq_tmu_data {
 	struct thermal_zone_device *tz;
 	struct regmap *regmap;
-	int sensor_id;
+	struct qoriq_tmu_sensor sensors[SITES_MAX];
 };
 
+static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_tmu_sensor *s)
+{
+	return container_of(s, struct qoriq_tmu_data, sensors[s->id]);
+}
+
 static int tmu_get_temp(void *p, int *temp)
 {
 	u32 val;
-	struct qoriq_tmu_data *data = p;
+	struct qoriq_tmu_sensor *s = p;
+	struct qoriq_tmu_data *data = qoriq_sensor_to_data(s);
 
-	regmap_read(data->regmap, REGS_TRITSR(data->sensor_id), &val);
+	regmap_read(data->regmap, REGS_TRITSR(s->id), &val);
 	if (!(val & TRITSR_V))
 		return -ENODATA;
 
@@ -63,38 +76,86 @@ static int tmu_get_temp(void *p, int *temp)
 	return 0;
 }
 
-static int qoriq_tmu_get_sensor_id(void)
+static const struct thermal_zone_of_device_ops tmu_tz_ops = {
+	.get_temp = tmu_get_temp,
+};
+
+static int qoriq_tmu_populate_sensors(struct device *dev,
+				      struct qoriq_tmu_data *data)
 {
-	int ret, id;
+	int ret, id, i, count = 0;
 	struct of_phandle_args sensor_specs;
 	struct device_node *np, *sensor_np;
+	struct qoriq_tmu_sensor *s;
 
 	np = of_find_node_by_name(NULL, "thermal-zones");
 	if (!np)
 		return -ENODEV;
 
-	sensor_np = of_get_next_child(np, NULL);
-	ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
-			"#thermal-sensor-cells",
-			0, &sensor_specs);
-	if (ret) {
-		id = ret;
-		goto out;
+	for_each_child_of_node(np, sensor_np) {
+		u16 msite;
+
+		ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
+						 "#thermal-sensor-cells",
+						 0, &sensor_specs);
+		if (ret)
+			break;
+
+		if (sensor_specs.args_count != 1) {
+			pr_err("%pOFn: Invalid number of cells in sensor specifier %d\n",
+			       sensor_specs.np, sensor_specs.args_count);
+			ret = -EINVAL;
+			break;
+		}
+
+		id = sensor_specs.args[0];
+		if (id >= SITES_MAX) {
+			ret = -EINVAL;
+			dev_err(dev, "Sensor id %d is out of range\n", id);
+			break;
+		}
+
+		msite = BIT(15 - id);
+		/* Enable monitoring of that particular sensor*/
+		regmap_update_bits(data->regmap, REGS_TMR, msite, msite);
+
+		s = &data->sensors[id];
+		s->id = id;
+		count++;
 	}
 
-	if (sensor_specs.args_count != 1) {
-		pr_err("%pOFn: Invalid number of cells in sensor specifier %d\n",
-		       sensor_specs.np, sensor_specs.args_count);
-		id = -EINVAL;
-		goto out;
+	of_node_put(np);
+	if (ret) {
+		/* We only need to "put" sensor_np if we exited the
+		 * loop early with "break"
+		 */
+		of_node_put(sensor_np);
+		return ret;
 	}
 
-	id = sensor_specs.args[0];
-out:
-	of_node_put(np);
-	of_node_put(sensor_np);
+	/* Enable monitoring */
+	regmap_update_bits(data->regmap, REGS_TMR, TMR_ME | TMR_ALPF_MASK,
+			   TMR_ME | TMR_ALPF);
+
+	for (i = 0; i < count; i++) {
+		s = &data->sensors[i];
+		s->tz = devm_thermal_zone_of_sensor_register(dev, s->id, s,
+							     &tmu_tz_ops);
+		if (IS_ERR(s->tz)) {
+			ret = PTR_ERR(s->tz);
+			dev_err(dev,
+				"Failed to register thermal zone device %d\n",
+				ret);
+			break;
+		}
+
+		ret = devm_thermal_add_hwmon_sysfs(s->tz);
+		if (ret)
+			break;
+
+	}
 
-	return id;
+	return ret;
 }
 
 static int qoriq_tmu_calibration(struct device *dev,
@@ -142,10 +203,6 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
 }
 
-static const struct thermal_zone_of_device_ops tmu_tz_ops = {
-	.get_temp = tmu_get_temp,
-};
-
 static const struct regmap_range qiriq_wr_yes_ranges[] = {
 	regmap_reg_range(REGS_TMR, REGS_TSCFGR),
 	regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(3)),
@@ -187,19 +244,12 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		.max_register		= SZ_4K,
 	};
 	void __iomem *base;
-	u32 site;
 
 	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->sensor_id = qoriq_tmu_get_sensor_id();
-	if (data->sensor_id < 0) {
-		dev_err(dev, "Failed to get sensor id\n");
-		return -ENODEV;
-	}
-
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!io) {
 		dev_err(dev, "Failed to get memory region\n");
@@ -225,21 +275,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	/* Enable monitoring */
-	site = 0x1 << (15 - data->sensor_id);
-	regmap_write(data->regmap, REGS_TMR, site | TMR_ME | TMR_ALPF);
-
-	data->tz = devm_thermal_zone_of_sensor_register(dev,
-							data->sensor_id,
-							data, &tmu_tz_ops);
-	if (IS_ERR(data->tz)) {
-		ret = PTR_ERR(data->tz);
-		dev_err(dev, "Failed to register thermal zone device %d\n",
-			ret);
-		goto disable_monitoring;
-	}
-
-	ret = devm_thermal_add_hwmon_sysfs(data->tz);
+	ret = qoriq_tmu_populate_sensors(dev, data);
 	if (ret)
 		goto disable_monitoring;
 
-- 
2.20.1

