Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA15C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734FC2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="cOjIjLVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734FC2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbeLDJwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:52:54 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:64715 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLDJwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:52:53 -0500
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; 
   d="scan'208";a="23805643"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Dec 2018 02:52:53 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 4 Dec 2018 02:52:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQZjE20IDnmXXt73/jZcsBxEhKYoFeYu/0JcvUi/UiY=;
 b=cOjIjLVPgZuDS5ur0DcTQA/+NEiEYWJ1XGq//JDp/7xd2AlQnROoZw5tsSVOkELlbTGHOcHdAz+uPCaZrnoGhAOouRQI3b6SHI8e1zYgbPAaFjLjqogbMzJteQpJCLhk0BAHXAUaLVEDfcVSqWY4iVlaAPUHAW+r9LoQ+L8OZxo=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2083.namprd11.prod.outlook.com (10.174.112.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 09:52:50 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%5]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 09:52:50 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Andrei.Stefanescu@microchip.com>
Subject: [PATCH v3 3/3] regulator: mcp16502: add regulator driver for MCP16502
Thread-Topic: [PATCH v3 3/3] regulator: mcp16502: add regulator driver for
 MCP16502
Thread-Index: AQHUi7cdNyZ8yFMdVESofGVEn2fa+Q==
Date:   Tue, 4 Dec 2018 09:52:49 +0000
Message-ID: <1543917126-32572-4-git-send-email-andrei.stefanescu@microchip.com>
References: <1543917126-32572-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1543917126-32572-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0214.eurprd07.prod.outlook.com
 (2603:10a6:802:58::17) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2083;6:thP5LThI7CXuL1XZFxIxxCkAR2QgMhWonlKyxMpjj1Zjf+nS0qd1HwTA6dLPj2jGoILGca657ueqzir7HmrR05msqsERXOLl/H3P3OUIq9VycMse9NVdfmZ7gznCKnHq9CPetV42t8ojjT9YENca3riCeIBLSUKf8mGeGJIXWiCuSGXsPNLqXmSCgkVnIf9Kl0lU1Tz8orkf/EG1v8jJRndZqV9g8IX08yX/LMS4kCa3dk9tmWoUmarZFuYcOhW6zcg9PnsWE5jpaBnOwsc+MNEqzcxbk3p7yY8QDeBr2pPJch5UwQBSoJGbvOiKDyU4qGUAnY5Vyko5nqWRF8pr9iCoUmfBj5nFbCGyyHTtOd04/nNsUY5vYsNbrb8REDIPNxHASAQVwWpfVNUHLJw6ES5Z/uO7EgJ8F1VGsvHMbELZ658MKS58mDbQFP6W65AP6csm3NKmcGPRZT2L4tGU9g==;5:Eehb94Q+NZyZpRGZuQbMyRJLVlvXBmP+ucHSp4Rww6YulmD532XbpiqRMyMkf8FEALimdnNLxFjncFS8Xinr4iYlgsMxN0xlaTf2i78ULnPbmF+1jbveafCZT1HPboBfR8KdSGglMyxbE/Ctci+5H6T3+h24cfELOdkY4rbKHMw=;7:BjMQb9tXNGr7yXXFwXkvanZeu6E/KZ14FH2RuZwe2jldONdPk6JepCMXXF3khUVUusXqJU9Q4DtVTJQJ31BFG7fic/fsP51xdCX/cfHpJnAooQt6cPjdz3H1votRZ+uozD1F1MN8KWXCFcwW1mJXuQ==
x-ms-office365-filtering-correlation-id: ca103c24-5c32-4785-9253-08d659ce3d6e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2083;
x-ms-traffictypediagnostic: BN6PR1101MB2083:
x-microsoft-antispam-prvs: <BN6PR1101MB2083205BA697A9E632D13919EDAF0@BN6PR1101MB2083.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2083;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2083;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(366004)(45074003)(199004)(189003)(386003)(54906003)(478600001)(186003)(2501003)(72206003)(14454004)(446003)(110136005)(2616005)(107886003)(11346002)(316002)(26005)(102836004)(105586002)(106356001)(6506007)(4326008)(97736004)(39060400002)(36756003)(53946003)(53936002)(68736007)(81166006)(7736002)(81156014)(4744004)(6436002)(256004)(8936002)(8676002)(305945005)(6512007)(6636002)(66066001)(14444005)(86362001)(25786009)(2906002)(476003)(76176011)(486006)(6116002)(99286004)(6486002)(71200400001)(52116002)(5660300001)(71190400001)(575784001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2083;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ib/C5mk1dMQ3eoiSHWwSc2qI8zlmO5g+DNOijNBNYa0Drcd5VF/SskiLaxjEwqWMpeUtnJQSt94jcmZAOBphNfFrvQn0Cz/rDVRv/dq6D3jlA6l/Ol+Wl5OmD+N8uHgoQ2WXyAjw64vYCTcMuyljpC+uhW9mcbT+roFEK1E7Y7hZhObbmov5Y9RTn/X7y40cXAsJml+X3WlOvlVjT7Ok39Ie69sB3KBkSE16AatfkWXa9ka+8xou5DfkYtmv8P4FaL3pFkOM8TAY3P03RmCWYmvbLgAQ6cg4pQFHeIfpir9G8YnMqd6rF6n3IYAH+dPJxOnoKu57lqNF0nT6zZ7wgHqafAQK/DNfum4yIQwvUC0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ca103c24-5c32-4785-9253-08d659ce3d6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 09:52:49.7706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2083
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a regulator driver for the MCP16502 PMIC.
This drivers supports basic operations through the
regulator interface such as:
- setting/reading voltage
- setting/reading operating mode
- reading current status
- transitioning to/from suspend-to-ram and standby
  power states

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 drivers/regulator/Kconfig    |   9 +
 drivers/regulator/Makefile   |   1 +
 drivers/regulator/mcp16502.c | 555 +++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 565 insertions(+)
 create mode 100644 drivers/regulator/mcp16502.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 926cee0..719d9d6 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -567,6 +567,15 @@ config REGULATOR_MC13892
 	  Say y here to support the regulators found on the Freescale MC13892
 	  PMIC.
=20
+config REGULATOR_MCP16502
+	tristate "Microchip MCP16502 PMIC"
+	depends on I2C && OF
+	help
+	  Say y here to support the MCP16502 PMIC. This driver supports
+	  basic operations (get/set voltage, get/set operating mode)
+	  through the regulator interface. In addition it enables
+	  suspend-to-ram/standby transition.
+
 config REGULATOR_MT6311
 	tristate "MediaTek MT6311 PMIC"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 72488ef..b12e1c9 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_REGULATOR_MAX77802) +=3D max77802-regulator.=
o
 obj-$(CONFIG_REGULATOR_MC13783) +=3D mc13783-regulator.o
 obj-$(CONFIG_REGULATOR_MC13892) +=3D mc13892-regulator.o
 obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=3D  mc13xxx-regulator-core.o
+obj-$(CONFIG_REGULATOR_MCP16502) +=3D mcp16502.o
 obj-$(CONFIG_REGULATOR_MT6311) +=3D mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+=3D mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6380)	+=3D mt6380-regulator.o
diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
new file mode 100644
index 0000000..54db3df
--- /dev/null
+++ b/drivers/regulator/mcp16502.c
@@ -0,0 +1,555 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * MCP16502 PMIC driver
+ *
+ * Copyright (C) 2018 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Andrei Stefanescu <andrei.stefanescu@microchip.com>
+ *
+ * Inspired from tps65086-regulator.c
+ */
+
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/suspend.h>
+
+#define VDD_LOW_SEL 0x0D
+#define VDD_HIGH_SEL 0x3F
+
+#define MCP16502_FLT BIT(7)
+#define MCP16502_ENS BIT(0)
+
+/*
+ *
+ * The PMIC has four sets of registers corresponding to four power modes:
+ * Performance, Active, Low-power, Hibernate.
+ *
+ * Registers:
+ * Each regulator has a register for each power mode. To access a register
+ * for a specific regulator and mode BASE_* and OFFSET_* need to be added.
+ *
+ * Operating modes:
+ * In order for the PMIC to transition to operating modes it has to be
+ * controlled via GPIO lines called LPM and HPM.
+ *
+ * The registers are fully configurable such that you can put all regulato=
rs in
+ * a low-power state while the PMIC is in Active mode. They are supposed t=
o be
+ * configured at startup and then simply transition to/from a global low-p=
ower
+ * state by setting the GPIO lpm pin high/low.
+ *
+ * This driver keeps the PMIC in Active mode, Low-power state is set for t=
he
+ * regulators by enabling/disabling operating mode (FPWM or Auto PFM).
+ *
+ * The PMIC's Low-power and Hibernate modes are used during standby/suspen=
d.
+ * To enter standby/suspend the PMIC will go to Low-power mode. From there=
, it
+ * will transition to Hibernate when the PWRHLD line is set to low by the =
MPU.
+ */
+
+/*
+ * This function is useful for iterating over all regulators and accessing=
 their
+ * registers in a generic way or accessing a regulator device by its id.
+ */
+#define MCP16502_BASE(i) (((i) + 1) << 4)
+#define MCP16502_STAT_BASE(i) ((i) + 5)
+
+#define MCP16502_OFFSET_MODE_A 0
+#define MCP16502_OFFSET_MODE_LPM 1
+#define MCP16502_OFFSET_MODE_HIB 2
+
+#define MCP16502_OPMODE_ACTIVE REGULATOR_MODE_NORMAL
+#define MCP16502_OPMODE_LPM REGULATOR_MODE_IDLE
+#define MCP16502_OPMODE_HIB REGULATOR_MODE_STANDBY
+
+#define MCP16502_MODE_AUTO_PFM 0
+#define MCP16502_MODE_FPWM BIT(6)
+
+#define MCP16502_VSEL 0x3F
+#define MCP16502_EN BIT(7)
+#define MCP16502_MODE BIT(6)
+
+#define MCP16502_MIN_REG 0x0
+#define MCP16502_MAX_REG 0x65
+
+static unsigned int mcp16502_of_map_mode(unsigned int mode)
+{
+	if (mode =3D=3D REGULATOR_MODE_NORMAL || mode =3D=3D REGULATOR_MODE_IDLE)
+		return mode;
+
+	return REGULATOR_MODE_INVALID;
+}
+
+#define MCP16502_REGULATOR(_name, _id, _ranges, _ops)			\
+	[_id] =3D {							\
+		.name			=3D _name,			\
+		.regulators_node	=3D of_match_ptr("regulators"),	\
+		.id			=3D _id,				\
+		.ops			=3D &(_ops),			\
+		.type			=3D REGULATOR_VOLTAGE,		\
+		.owner			=3D THIS_MODULE,			\
+		.linear_ranges		=3D _ranges,			\
+		.n_linear_ranges	=3D ARRAY_SIZE(_ranges),		\
+		.of_match		=3D of_match_ptr(_name),		\
+		.of_map_mode		=3D mcp16502_of_map_mode,		\
+		.vsel_reg		=3D (((_id) + 1) << 4),		\
+		.vsel_mask		=3D MCP16502_VSEL,		\
+		.enable_reg		=3D (((_id) + 1) << 4),		\
+		.enable_mask		=3D MCP16502_EN,			\
+	}
+
+enum {
+	BUCK1 =3D 0,
+	BUCK2,
+	BUCK3,
+	BUCK4,
+	LDO1,
+	LDO2,
+	NUM_REGULATORS
+};
+
+/*
+ * struct mcp16502 - PMIC representation
+ * @rdev: the regulators belonging to this chip
+ * @rmap: regmap to be used for I2C communication
+ * @lpm: LPM GPIO descriptor
+ */
+struct mcp16502 {
+	struct regulator_dev *rdev[NUM_REGULATORS];
+	struct regmap *rmap;
+	struct gpio_desc *lpm;
+};
+
+/*
+ * mcp16502_gpio_set_mode() - set the GPIO corresponding value
+ *
+ * Used to prepare transitioning into hibernate or resuming from it.
+ */
+static void mcp16502_gpio_set_mode(struct mcp16502 *mcp, int mode)
+{
+	switch (mode) {
+	case MCP16502_OPMODE_ACTIVE:
+		gpiod_set_value(mcp->lpm, 0);
+		break;
+	case MCP16502_OPMODE_LPM:
+	case MCP16502_OPMODE_HIB:
+		gpiod_set_value(mcp->lpm, 1);
+		break;
+	default:
+		pr_err("%s: %d invalid\n", __func__, mode);
+	}
+}
+
+/*
+ * mcp16502_get_reg() - get the PMIC's configuration register for opmode
+ *
+ * @rdev: the regulator whose register we are searching
+ * @opmode: the PMIC's operating mode ACTIVE, Low-power, Hibernate
+ */
+static int mcp16502_get_reg(struct regulator_dev *rdev, int opmode)
+{
+	int reg =3D MCP16502_BASE(rdev_get_id(rdev));
+
+	switch (opmode) {
+	case MCP16502_OPMODE_ACTIVE:
+		return reg + MCP16502_OFFSET_MODE_A;
+	case MCP16502_OPMODE_LPM:
+		return reg + MCP16502_OFFSET_MODE_LPM;
+	case MCP16502_OPMODE_HIB:
+		return reg + MCP16502_OFFSET_MODE_HIB;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * mcp16502_get_mode() - return the current operating mode of a regulator
+ *
+ * Note: all functions that are not part of entering/exiting standby/suspe=
nd
+ *	 use the Active mode registers.
+ *
+ * Note: this is different from the PMIC's operatig mode, it is the
+ *	 MODE bit from the regulator's register.
+ */
+static unsigned int mcp16502_get_mode(struct regulator_dev *rdev)
+{
+	unsigned int val;
+	int ret, reg;
+	struct mcp16502 *mcp =3D rdev_get_drvdata(rdev);
+
+	reg =3D mcp16502_get_reg(rdev, MCP16502_OPMODE_ACTIVE);
+	if (reg < 0)
+		return reg;
+
+	ret =3D regmap_read(mcp->rmap, reg, &val);
+	if (ret)
+		return ret;
+
+	switch (val & MCP16502_MODE) {
+	case MCP16502_MODE_FPWM:
+		return REGULATOR_MODE_NORMAL;
+	case MCP16502_MODE_AUTO_PFM:
+		return REGULATOR_MODE_IDLE;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+/*
+ * _mcp16502_set_mode() - helper for set_mode and set_suspend_mode
+ *
+ * @rdev: the regulator for which we are setting the mode
+ * @mode: the regulator's mode (the one from MODE bit)
+ * @opmode: the PMIC's operating mode: Active/Low-power/Hibernate
+ */
+static int _mcp16502_set_mode(struct regulator_dev *rdev, unsigned int mod=
e,
+			      unsigned int op_mode)
+{
+	int val;
+	int reg;
+	struct mcp16502 *mcp =3D rdev_get_drvdata(rdev);
+
+	reg =3D mcp16502_get_reg(rdev, op_mode);
+	if (reg < 0)
+		return reg;
+
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		val =3D MCP16502_MODE_FPWM;
+		break;
+	case REGULATOR_MODE_IDLE:
+		val =3D MCP16502_MODE_AUTO_PFM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	reg =3D regmap_update_bits(mcp->rmap, reg, MCP16502_MODE, val);
+	return reg;
+}
+
+/*
+ * mcp16502_set_mode() - regulator_ops set_mode
+ */
+static int mcp16502_set_mode(struct regulator_dev *rdev, unsigned int mode=
)
+{
+	return _mcp16502_set_mode(rdev, mode, MCP16502_OPMODE_ACTIVE);
+}
+
+/*
+ * mcp16502_get_status() - regulator_ops get_status
+ */
+static int mcp16502_get_status(struct regulator_dev *rdev)
+{
+	int ret;
+	unsigned int val;
+	struct mcp16502 *mcp =3D rdev_get_drvdata(rdev);
+
+	ret =3D regmap_read(mcp->rmap, MCP16502_STAT_BASE(rdev_get_id(rdev)),
+			  &val);
+	if (ret)
+		return ret;
+
+	if (val & MCP16502_FLT)
+		return REGULATOR_STATUS_ERROR;
+	else if (val & MCP16502_ENS)
+		return REGULATOR_STATUS_ON;
+	else if (!(val & MCP16502_ENS))
+		return REGULATOR_STATUS_OFF;
+
+	return REGULATOR_STATUS_UNDEFINED;
+}
+
+#ifdef CONFIG_SUSPEND
+/*
+ * mcp16502_suspend_get_target_reg() - get the reg of the target suspend P=
MIC
+ *				       mode
+ */
+static int mcp16502_suspend_get_target_reg(struct regulator_dev *rdev)
+{
+	switch (pm_suspend_target_state) {
+	case PM_SUSPEND_STANDBY:
+		return mcp16502_get_reg(rdev, MCP16502_OPMODE_LPM);
+	case PM_SUSPEND_ON:
+	case PM_SUSPEND_MEM:
+		return mcp16502_get_reg(rdev, MCP16502_OPMODE_HIB);
+	default:
+		dev_err(&rdev->dev, "invalid suspend target: %d\n",
+			pm_suspend_target_state);
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * mcp16502_set_suspend_voltage() - regulator_ops set_suspend_voltage
+ */
+static int mcp16502_set_suspend_voltage(struct regulator_dev *rdev, int uV=
)
+{
+	struct mcp16502 *mcp =3D rdev_get_drvdata(rdev);
+	int sel =3D regulator_map_voltage_linear_range(rdev, uV, uV);
+	int reg =3D mcp16502_suspend_get_target_reg(rdev);
+
+	if (sel < 0)
+		return sel;
+
+	if (reg < 0)
+		return reg;
+
+	return regmap_update_bits(mcp->rmap, reg, MCP16502_VSEL, sel);
+}
+
+/*
+ * mcp16502_set_suspend_mode() - regulator_ops set_suspend_mode
+ */
+static int mcp16502_set_suspend_mode(struct regulator_dev *rdev,
+				     unsigned int mode)
+{
+	switch (pm_suspend_target_state) {
+	case PM_SUSPEND_STANDBY:
+		return _mcp16502_set_mode(rdev, mode, MCP16502_OPMODE_LPM);
+	case PM_SUSPEND_ON:
+	case PM_SUSPEND_MEM:
+		return _mcp16502_set_mode(rdev, mode, MCP16502_OPMODE_HIB);
+	default:
+		dev_err(&rdev->dev, "invalid suspend target: %d\n",
+			pm_suspend_target_state);
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * mcp16502_set_suspend_enable() - regulator_ops set_suspend_enable
+ */
+static int mcp16502_set_suspend_enable(struct regulator_dev *rdev)
+{
+	struct mcp16502 *mcp =3D rdev_get_drvdata(rdev);
+	int reg =3D mcp16502_suspend_get_target_reg(rdev);
+
+	if (reg < 0)
+		return reg;
+
+	return regmap_update_bits(mcp->rmap, reg, MCP16502_EN, MCP16502_EN);
+}
+
+/*
+ * mcp16502_set_suspend_disable() - regulator_ops set_suspend_disable
+ */
+static int mcp16502_set_suspend_disable(struct regulator_dev *rdev)
+{
+	struct mcp16502 *mcp =3D rdev_get_drvdata(rdev);
+	int reg =3D mcp16502_suspend_get_target_reg(rdev);
+
+	if (reg < 0)
+		return reg;
+
+	return regmap_update_bits(mcp->rmap, reg, MCP16502_EN, 0);
+}
+#endif /* CONFIG_SUSPEND */
+
+static const struct regulator_ops mcp16502_buck_ops =3D {
+	.list_voltage			=3D regulator_list_voltage_linear_range,
+	.map_voltage			=3D regulator_map_voltage_linear_range,
+	.get_voltage_sel		=3D regulator_get_voltage_sel_regmap,
+	.set_voltage_sel		=3D regulator_set_voltage_sel_regmap,
+	.enable				=3D regulator_enable_regmap,
+	.disable			=3D regulator_disable_regmap,
+	.is_enabled			=3D regulator_is_enabled_regmap,
+	.get_status			=3D mcp16502_get_status,
+
+	.set_mode			=3D mcp16502_set_mode,
+	.get_mode			=3D mcp16502_get_mode,
+
+#ifdef CONFIG_SUSPEND
+	.set_suspend_voltage		=3D mcp16502_set_suspend_voltage,
+	.set_suspend_mode		=3D mcp16502_set_suspend_mode,
+	.set_suspend_enable		=3D mcp16502_set_suspend_enable,
+	.set_suspend_disable		=3D mcp16502_set_suspend_disable,
+#endif /* CONFIG_SUSPEND */
+};
+
+/*
+ * LDOs cannot change operating modes.
+ */
+static const struct regulator_ops mcp16502_ldo_ops =3D {
+	.list_voltage			=3D regulator_list_voltage_linear_range,
+	.map_voltage			=3D regulator_map_voltage_linear_range,
+	.get_voltage_sel		=3D regulator_get_voltage_sel_regmap,
+	.set_voltage_sel		=3D regulator_set_voltage_sel_regmap,
+	.enable				=3D regulator_enable_regmap,
+	.disable			=3D regulator_disable_regmap,
+	.is_enabled			=3D regulator_is_enabled_regmap,
+	.get_status			=3D mcp16502_get_status,
+
+#ifdef CONFIG_SUSPEND
+	.set_suspend_voltage		=3D mcp16502_set_suspend_voltage,
+	.set_suspend_enable		=3D mcp16502_set_suspend_enable,
+	.set_suspend_disable		=3D mcp16502_set_suspend_disable,
+#endif /* CONFIG_SUSPEND */
+};
+
+static const struct of_device_id mcp16502_ids[] =3D {
+	{ .compatible =3D "microchip,mcp16502", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mcp16502_ids);
+
+static const struct regulator_linear_range b1l12_ranges[] =3D {
+	REGULATOR_LINEAR_RANGE(1200000, VDD_LOW_SEL, VDD_HIGH_SEL, 50000),
+};
+
+static const struct regulator_linear_range b234_ranges[] =3D {
+	REGULATOR_LINEAR_RANGE(600000, VDD_LOW_SEL, VDD_HIGH_SEL, 25000),
+};
+
+static const struct regulator_desc mcp16502_desc[] =3D {
+	/* MCP16502_REGULATOR(_name, _id, ranges, regulator_ops) */
+	MCP16502_REGULATOR("VDD_IO", BUCK1, b1l12_ranges, mcp16502_buck_ops),
+	MCP16502_REGULATOR("VDD_DDR", BUCK2, b234_ranges, mcp16502_buck_ops),
+	MCP16502_REGULATOR("VDD_CORE", BUCK3, b234_ranges, mcp16502_buck_ops),
+	MCP16502_REGULATOR("VDD_OTHER", BUCK4, b234_ranges, mcp16502_buck_ops),
+	MCP16502_REGULATOR("LDO1", LDO1, b1l12_ranges, mcp16502_ldo_ops),
+	MCP16502_REGULATOR("LDO2", LDO2, b1l12_ranges, mcp16502_ldo_ops)
+};
+
+static const struct regmap_range mcp16502_ranges[] =3D {
+	regmap_reg_range(MCP16502_MIN_REG, MCP16502_MAX_REG)
+};
+
+static const struct regmap_access_table mcp16502_yes_reg_table =3D {
+	.yes_ranges =3D mcp16502_ranges,
+	.n_yes_ranges =3D ARRAY_SIZE(mcp16502_ranges),
+};
+
+static const struct regmap_config mcp16502_regmap_config =3D {
+	.reg_bits	=3D 8,
+	.val_bits	=3D 8,
+	.max_register	=3D MCP16502_MAX_REG,
+	.cache_type	=3D REGCACHE_NONE,
+	.rd_table	=3D &mcp16502_yes_reg_table,
+	.wr_table	=3D &mcp16502_yes_reg_table,
+};
+
+/*
+ * set_up_regulators() - initialize all regulators
+ */
+static int setup_regulators(struct mcp16502 *mcp, struct device *dev,
+			    struct regulator_config config)
+{
+	int i;
+
+	for (i =3D 0; i < NUM_REGULATORS; i++) {
+		mcp->rdev[i] =3D devm_regulator_register(dev,
+						       &mcp16502_desc[i],
+						       &config);
+		if (IS_ERR(mcp->rdev[i])) {
+			dev_err(dev,
+				"failed to register %s regulator %ld\n",
+				mcp16502_desc[i].name, PTR_ERR(mcp->rdev[i]));
+			return PTR_ERR(mcp->rdev[i]);
+		}
+	}
+
+	return 0;
+}
+
+static int mcp16502_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct regulator_config config =3D { };
+	struct device *dev;
+	struct mcp16502 *mcp;
+	int ret =3D 0;
+
+	dev =3D &client->dev;
+	config.dev =3D dev;
+
+	mcp =3D devm_kzalloc(dev, sizeof(*mcp), GFP_KERNEL);
+	if (!mcp)
+		return -ENOMEM;
+
+	mcp->rmap =3D devm_regmap_init_i2c(client, &mcp16502_regmap_config);
+	if (IS_ERR(mcp->rmap)) {
+		ret =3D PTR_ERR(mcp->rmap);
+		dev_err(dev, "regmap init failed: %d\n", ret);
+		return ret;
+	}
+
+	i2c_set_clientdata(client, mcp);
+	config.regmap =3D mcp->rmap;
+	config.driver_data =3D mcp;
+
+	mcp->lpm =3D devm_gpiod_get(dev, "lpm", GPIOD_OUT_LOW);
+	if (IS_ERR(mcp->lpm)) {
+		dev_err(dev, "failed to get lpm pin: %ld\n", PTR_ERR(mcp->lpm));
+		return PTR_ERR(mcp->lpm);
+	}
+
+	ret =3D setup_regulators(mcp, dev, config);
+	if (ret !=3D 0)
+		return ret;
+
+	mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_ACTIVE);
+
+	return 0;
+}
+
+#ifdef CONFIG_SUSPEND
+static int mcp16502_suspend(struct device *dev)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct mcp16502 *mcp =3D i2c_get_clientdata(client);
+
+	mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_LPM);
+
+	return 0;
+}
+
+static int mcp16502_resume(struct device *dev)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct mcp16502 *mcp =3D i2c_get_clientdata(client);
+
+	mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_ACTIVE);
+
+	return 0;
+}
+#else /* !CONFIG_SUSPEND */
+#define mcp16502_suspend NULL
+#define mcp16502_resume NULL
+#endif /* !CONFIG_SUSPEND */
+
+#ifdef CONFIG_PM
+static const struct dev_pm_ops mcp16502_pm_ops =3D {
+	SET_SYSTEM_SLEEP_PM_OPS(mcp16502_suspend, mcp16502_resume)
+};
+#endif
+static const struct i2c_device_id mcp16502_i2c_id[] =3D {
+	{ "mcp16502", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mcp16502_i2c_id);
+
+static struct i2c_driver mcp16502_drv =3D {
+	.probe		=3D mcp16502_probe,
+	.driver		=3D {
+		.name	=3D "mcp16502-regulator",
+		.of_match_table	=3D of_match_ptr(mcp16502_ids),
+#ifdef CONFIG_PM
+		.pm =3D &mcp16502_pm_ops,
+#endif
+	},
+	.id_table	=3D mcp16502_i2c_id,
+};
+
+module_i2c_driver(mcp16502_drv);
+
+MODULE_VERSION("1.0");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MCP16502 PMIC driver");
+MODULE_AUTHOR("Andrei Stefanescu andrei.stefanescu@microchip.com");
--=20
2.7.4

