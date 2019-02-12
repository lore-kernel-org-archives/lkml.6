Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D375C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D1720836
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EH0qkMTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfBLGo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 01:44:28 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14055 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfBLGoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 01:44:25 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c626b4a0000>; Mon, 11 Feb 2019 22:44:26 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Feb 2019 22:44:25 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Feb 2019 22:44:25 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 Feb
 2019 06:44:24 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Feb 2019 06:44:24 +0000
Received: from localhost.localdomain (Not Verified[10.19.225.143]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c626b460001>; Mon, 11 Feb 2019 22:44:24 -0800
From:   Mark Zhang <markz@nvidia.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, Mark Zhang <markz@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
Subject: [PATCH v3 3/4] mfd: max77620: Add low battery monitor support
Date:   Tue, 12 Feb 2019 14:43:52 +0800
Message-ID: <20190212064353.7451-4-markz@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190212064353.7451-1-markz@nvidia.com>
References: <20190212064353.7451-1-markz@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549953866; bh=J1ZZiaJN/zXyCNQTdB3tpGtybD3cqAaDLI3I75wW7lU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=EH0qkMTRyIV/7Dc6nCcdMQxQX1meWIit5v/jb9LxvvKhP2H3JAtONltrXrC3+Txr/
         pTVupLrs41ybqygtv3GAJLox2okapJpGiIEOEqOM7M3PigwV4qGRkvif3s33DnTWCI
         Gcr2N92EmgIBzdrSSbXvvyY57bz+thNYpfyH8i7jC8tTs3UqZ3SzFgNm6oGoLJsbp2
         YrP/tmzoINt722fX3qSAj8hflcyzRKq24009VQLAAY3CdF627LU4orBSa6UHk5sW5s
         SwipZzg1do+CRpiCrQUwxWFTG61r79V31A7iHwnhaaCmobtrYZrQdkYjmySoMoGEdq
         xfHUzjhBflQOw==
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
 drivers/mfd/max77620.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index 494d98357f65..6f0c85b2ca26 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -474,6 +474,35 @@ static int max77620_init_backup_battery_charging(struc=
t max77620_chip *chip)
 	return ret;
 }
=20
+static int max77620_init_low_battery_monitor(struct max77620_chip *chip)
+{
+	struct device *dev =3D chip->dev;
+	bool bval;
+	int ival;
+	u8 mask =3D 0;
+	u8 val =3D 0;
+	int ret;
+
+	mask |=3D MAX77620_CNFGGLBL1_LBDAC_EN;
+	bval =3D of_property_read_bool(dev->of_node,
+			"maxim,low-battery-dac-enable");
+	if (bval)
+		val |=3D MAX77620_CNFGGLBL1_LBDAC_EN;
+
+	mask |=3D MAX77620_CNFGGLBL1_LBRSTEN | MAX77620_CNFGGLBL1_MPPLD;
+	ival =3D of_property_match_string(dev->of_node,
+			"maxim,low-battery-mode", "shutdown");
+	if (ival < 0)
+		val |=3D MAX77620_CNFGGLBL1_LBRSTEN;
+	else
+		val |=3D MAX77620_CNFGGLBL1_MPPLD;
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
@@ -563,7 +592,11 @@ static int max77620_probe(struct i2c_client *client,
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

