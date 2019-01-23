Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB2BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405E121850
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qBFQoxR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfAWG4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:56:38 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1716 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfAWG4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 01:56:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c48100c0000>; Tue, 22 Jan 2019 22:56:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 22 Jan 2019 22:56:36 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 22 Jan 2019 22:56:36 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 23 Jan
 2019 06:56:36 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 23 Jan 2019 06:56:36 +0000
Received: from localhost.localdomain (Not Verified[10.19.225.143]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c4810220000>; Tue, 22 Jan 2019 22:56:35 -0800
From:   Mark Zhang <markz@nvidia.com>
To:     <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, Mark Zhang <markz@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
Subject: [PATCH 1/2] mfd: max77620: Add backup battery charger support
Date:   Wed, 23 Jan 2019 14:56:19 +0800
Message-ID: <20190123065620.22250-1-markz@nvidia.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548226572; bh=OUDyElPhiPwMVEx8CTwkTQaz+hQEf3MSZtYJeqdam4Y=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=qBFQoxR51Ya/f9CpnaojvqgGkffohWJO3vHFzQqkjnCuTzdwYpSdWIWEQHxKD+kI3
         zSHsbjXvQo0tkAB+OP5jFOYUCoKszhuBNCzWs8MHoJULDQ7mYX8zFGR54vDWh5624h
         SkoGd6OXVzZupXOLXS0YDz9Kd1zVzUXFm1nEXK6TkX8ZfGXEz5a7HlQVuQ12NcESmL
         FnE55NN3AgXkEAzOhAiP77wtenjJhhWAXrzwMlLBU1QnlGLfFpfZkrrN2VNPdpSvG2
         INW+lq1Cl/+UdAK0PI42XVCYSxQSnel0T/5oG91ZsETJHbWtlbvWudjQKMhTw9X468
         BZ4U2ymLhOHsQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PMIC configurations for backup battery charger, which
is a constant voltage and constant current style charger
with a series output resistance.

The max77620 register CNFGBBC(addr: 0x04) defines the
parameters of backup battery charger. This patch adds
support for it.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
Signed-off-by: Mark Zhang <markz@nvidia.com>
---
 drivers/mfd/max77620.c | 80 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index d8ddd1a6f304..f58143103185 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -398,6 +398,82 @@ static int max77620_initialise_fps(struct max77620_chi=
p *chip)
 	return 0;
 }
=20
+static int max77620_init_backup_battery_charging(struct max77620_chip *chi=
p)
+{
+	struct device *dev =3D chip->dev;
+	struct device_node *np;
+	u32 pval;
+	u8 config;
+	int charging_current;
+	int charging_voltage;
+	int resistor;
+	int ret;
+
+	np =3D of_get_child_by_name(dev->of_node, "backup-battery");
+	if (!np) {
+		dev_info(dev, "Backup battery charging support disabled\n");
+		ret =3D regmap_update_bits(chip->rmap, MAX77620_REG_CNFGBBC,
+					 MAX77620_CNFGBBC_ENABLE, 0);
+		if (ret < 0)
+			dev_err(dev, "Failed to update CNFGBBC: %d\n", ret);
+		return ret;
+	}
+
+	ret =3D of_property_read_u32(np,
+			"maxim,backup-battery-charging-current", &pval);
+	charging_current =3D (!ret) ? pval : 50;
+
+	ret =3D of_property_read_u32(np,
+			"maxim,backup-battery-charging-voltage", &pval);
+	charging_voltage =3D (!ret) ? pval : 2500000;
+	charging_voltage /=3D 1000;
+
+	ret =3D of_property_read_u32(np,
+			"maxim,backup-battery-output-resister", &pval);
+	resistor =3D (!ret) ? pval : 1000;
+
+	config =3D MAX77620_CNFGBBC_ENABLE;
+	if (charging_current <=3D 50)
+		config |=3D 0 << MAX77620_CNFGBBC_CURRENT_SHIFT;
+	else if (charging_current <=3D 100)
+		config |=3D 3 << MAX77620_CNFGBBC_CURRENT_SHIFT;
+	else if (charging_current <=3D 200)
+		config |=3D 0 << MAX77620_CNFGBBC_CURRENT_SHIFT;
+	else if (charging_current <=3D 400)
+		config |=3D 3 << MAX77620_CNFGBBC_CURRENT_SHIFT;
+	else if (charging_current <=3D 600)
+		config |=3D 1 << MAX77620_CNFGBBC_CURRENT_SHIFT;
+	else
+		config |=3D 2 << MAX77620_CNFGBBC_CURRENT_SHIFT;
+
+	if (charging_current > 100)
+		config |=3D MAX77620_CNFGBBC_LOW_CURRENT_DISABLE;
+
+	if (charging_voltage <=3D 2500)
+		config |=3D 0 << MAX77620_CNFGBBC_VOLTAGE_SHIFT;
+	else if (charging_voltage <=3D 3000)
+		config |=3D 1 << MAX77620_CNFGBBC_VOLTAGE_SHIFT;
+	else if (charging_voltage <=3D 3300)
+		config |=3D 2 << MAX77620_CNFGBBC_VOLTAGE_SHIFT;
+	else
+		config |=3D 3 << MAX77620_CNFGBBC_VOLTAGE_SHIFT;
+
+	if (resistor <=3D 100)
+		config |=3D 0 << MAX77620_CNFGBBC_RESISTOR_SHIFT;
+	else if (resistor <=3D 1000)
+		config |=3D 1 << MAX77620_CNFGBBC_RESISTOR_SHIFT;
+	else if (resistor <=3D 3000)
+		config |=3D 2 << MAX77620_CNFGBBC_RESISTOR_SHIFT;
+	else if (resistor <=3D 6000)
+		config |=3D 3 << MAX77620_CNFGBBC_RESISTOR_SHIFT;
+
+	ret =3D regmap_write(chip->rmap, MAX77620_REG_CNFGBBC, config);
+	if (ret < 0)
+		dev_err(dev, "Reg 0x%02x write failed, %d\n",
+				MAX77620_REG_CNFGBBC, ret);
+	return ret;
+}
+
 static int max77620_read_es_version(struct max77620_chip *chip)
 {
 	unsigned int val;
@@ -483,6 +559,10 @@ static int max77620_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
=20
+	ret =3D max77620_init_backup_battery_charging(chip);
+	if (ret < 0)
+		return ret;
+
 	ret =3D  devm_mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE,
 				    mfd_cells, n_mfd_cells, NULL, 0,
 				    regmap_irq_get_domain(chip->top_irq_data));
--=20
2.19.2

