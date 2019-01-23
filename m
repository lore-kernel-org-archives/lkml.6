Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500A7C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D6521726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rmDXFUZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfAWG4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:56:42 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7568 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfAWG4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 01:56:39 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4810030004>; Tue, 22 Jan 2019 22:56:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 22 Jan 2019 22:56:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 22 Jan 2019 22:56:38 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 23 Jan
 2019 06:56:38 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 23 Jan 2019 06:56:38 +0000
Received: from localhost.localdomain (Not Verified[10.19.225.143]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c4810240003>; Tue, 22 Jan 2019 22:56:38 -0800
From:   Mark Zhang <markz@nvidia.com>
To:     <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, Mark Zhang <markz@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
Subject: [PATCH 2/2] mfd: max77620: Add low battery monitor support
Date:   Wed, 23 Jan 2019 14:56:20 +0800
Message-ID: <20190123065620.22250-2-markz@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190123065620.22250-1-markz@nvidia.com>
References: <20190123065620.22250-1-markz@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548226563; bh=BgG6FUugC1CevREJ1krBzbps1BGj7dMGa+3M+zudQjU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=rmDXFUZTgBkuTV6djIUC6vCbyQgV3cQPkoCjBWdrnd6Q0MXjviYVj1xCZyaHCGFxu
         Py9Xz5myAWfZB9VhuUFq1fnOBnxH2WZbwBXzWHR3m8bDdKkSmG/+iQ7Gjfwls/tGx0
         xRaGvP2bgFxtKZY302Dovwmwcg1ThgSoX7NBfloHemIXhtpFbKfH9j4iNl9/eQO+zd
         Hal5OL0hTkF8o5DDxT2qWaCxIL5u7l1PtIr5/VVSLDo1t1IjcFnZuqUDUZQhH/pZgX
         73k+VXmUPIPeKtEoWcBBhjSU49hd/9xFs7geq2s9pTFarRCWRnawbjYblDr0498gdZ
         LVQ+sJZmmm/6A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds PMIC configurations for low-battery
monitoring by handling max77620 register CNFGGLBL1.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
Signed-off-by: Mark Zhang <markz@nvidia.com>
---
 drivers/mfd/max77620.c | 57 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index f58143103185..9e50d145afd8 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -474,6 +474,57 @@ static int max77620_init_backup_battery_charging(struc=
t max77620_chip *chip)
 	return ret;
 }
=20
+static int max77620_init_low_battery_monitor(struct max77620_chip *chip)
+{
+	struct device *dev =3D chip->dev;
+	struct device_node *np;
+	bool pval;
+	u8 mask =3D 0;
+	u8 val =3D 0;
+	int ret;
+
+	np =3D of_get_child_by_name(dev->of_node, "low-battery-monitor");
+	if (!np) {
+		dev_info(dev, "Low battery monitoring support disabled\n");
+		return 0;
+	}
+
+	pval =3D of_property_read_bool(np, "maxim,low-battery-dac-enable");
+	if (pval) {
+		mask |=3D MAX77620_CNFGGLBL1_LBDAC_EN;
+		val |=3D MAX77620_CNFGGLBL1_LBDAC_EN;
+	}
+
+	pval =3D of_property_read_bool(np, "maxim,low-battery-dac-disable");
+	if (pval)
+		mask |=3D MAX77620_CNFGGLBL1_LBDAC_EN;
+
+	pval =3D of_property_read_bool(np, "maxim,low-battery-shutdown-enable");
+	if (pval) {
+		mask |=3D MAX77620_CNFGGLBL1_MPPLD;
+		val |=3D MAX77620_CNFGGLBL1_MPPLD;
+	}
+
+	pval =3D of_property_read_bool(np, "maxim,low-battery-shutdown-disable");
+	if (pval)
+		mask |=3D MAX77620_CNFGGLBL1_MPPLD;
+
+	pval =3D of_property_read_bool(np, "maxim,low-battery-reset-enable");
+	if (pval) {
+		mask |=3D MAX77620_CNFGGLBL1_LBRSTEN;
+		val |=3D MAX77620_CNFGGLBL1_LBRSTEN;
+	}
+
+	pval =3D of_property_read_bool(np, "maxim,low-battery-reset-disable");
+	if (pval)
+		mask |=3D MAX77620_CNFGGLBL1_LBRSTEN;
+
+	ret =3D regmap_update_bits(chip->rmap, MAX77620_REG_CNFGGLBL1, mask, val)=
;
+	if (ret < 0)
+		dev_err(dev, "Reg CNFGGLBL1 update failed: %d\n", ret);
+	return ret;
+}
+
 static int max77620_read_es_version(struct max77620_chip *chip)
 {
 	unsigned int val;
@@ -563,7 +614,11 @@ static int max77620_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
=20
-	ret =3D  devm_mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE,
+	ret =3D max77620_init_low_battery_monitor(chip);
+	if (ret < 0)
+		return ret;
+
+	ret =3D devm_mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE,
 				    mfd_cells, n_mfd_cells, NULL, 0,
 				    regmap_irq_get_domain(chip->top_irq_data));
 	if (ret < 0) {
--=20
2.19.2

