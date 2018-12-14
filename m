Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4DAC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D31B20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vyWHeDDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D31B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeLNIUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:20:30 -0500
Received: from mail-eopbgr150072.outbound.protection.outlook.com ([40.107.15.72]:19406
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbeLNIU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt0qzYM6yA0I3og7i6/5uAS1P2qtI8a7ByAqyDkcfog=;
 b=vyWHeDDbtN80W4BffgTXONWc+MnDI6qb98g4otH1WAviY8NToFFpUCQBe0VtbMThqigz0sHU3xMHzwFM4tKP2kiX3gNlHDlGITKDQFEOHSByhJa9fz9AZD98MPuMu8vW+xBSQ3r/eqyhtUIU4b9zsFpyJxcCQhE+6wF851BR+sM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3740.eurprd04.prod.outlook.com (52.134.71.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 08:20:26 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 08:20:26 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/2] ARM: imx: add i.MX7ULP SoC revision support
Thread-Topic: [PATCH 2/2] ARM: imx: add i.MX7ULP SoC revision support
Thread-Index: AQHUk4Xd7cd4IKNeQkCChu5fxRF0KA==
Date:   Fri, 14 Dec 2018 08:20:26 +0000
Message-ID: <1544775260-25458-2-git-send-email-Anson.Huang@nxp.com>
References: <1544775260-25458-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544775260-25458-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0071.apcprd04.prod.outlook.com
 (2603:1096:202:15::15) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3740;6:0KR7cpweVMzxgRzOAadFps/Q1+0Qz4GzQtOTKEHKjh8aadNJtkUre128j8Te+a4cpoz1pPRD4U+m15aqIWf1dXyTiI7fJd8o8qAWJL4+KOevocn47JaQc7PBq7w+Q287yIlmNgjs94SALhgCjFP0AMg+FOYCIG3ncRfSCp+QbSRSchvcpMRe7u/p2VQ0jRSBqNtfZgk4dvwUuOA43PQebzLxY2WtU2b2qOfm8G7nPL0vL1JIhZj6u0xGSHjVWjxdWjyr/Q1KLDB2zmWhMYqc9KQpTvjam9BdKLqSG4tRHsgmpLgLxRcDIUgePMxSpCNxMHcsINCPTkbK51X0/ghVMYXoaipogaqQgl3Bk+zDzIl8Itl7ecEw8XNUUr9gaM5+KlHj1Bd+8a1Ihxg9eCBoF8uHOVWOq3Wj4D0Zhsx1anPIhF7An4TqjEM4jWBZbStNeZhY5YP5Goyf9Tdp5MbCRg==;5:52Kavtuo7xsR98LU/n1JGCFeRKp/sLfiEC3KYWTcleCUtgE6J35N3nEq5aFXIr3IDRWxyna7y21VbyXRF3UKUC+LXoKyCnqc0jVZkhWS/Xe0LvHLqd02fEpGhmO+AyFFVRlY2FX040uhPPw1BBBJHpu5pMU8WYDPmmXteX4SEOA=;7:paObto5sKqrod5u2Xz3Y7UtNRW4K268MW47+doIxhjwusb2rh5KSRg9AvCjmuMlW2bA3z107LQT9KNBABsssLHyIDMZP0ymrwPNFEnVfZKmTtptAf82O1cYqFC9TW4MmVh3qn88A8oMxHTkfniZ5Aw==
x-ms-office365-filtering-correlation-id: 6013d17e-3409-4ab0-6774-08d6619d0016
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3740;
x-ms-traffictypediagnostic: DB3PR0402MB3740:
x-microsoft-antispam-prvs: <DB3PR0402MB3740C2E66FB056077DF829EEF5A10@DB3PR0402MB3740.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3740;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3740;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(136003)(39860400002)(199004)(189003)(7736002)(476003)(305945005)(575784001)(86362001)(66066001)(2201001)(486006)(2616005)(446003)(6116002)(3846002)(71190400001)(256004)(71200400001)(11346002)(316002)(36756003)(110136005)(99286004)(8676002)(81156014)(81166006)(105586002)(50226002)(52116002)(6436002)(68736007)(53936002)(5660300001)(25786009)(386003)(102836004)(6506007)(76176011)(186003)(106356001)(2906002)(26005)(8936002)(6486002)(14454004)(2501003)(478600001)(97736004)(6512007)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3740;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PsEJc3jrPkaWeRthBJa/iq8ngQEAVZewV6LV2brgX8Yw8DG+5QptwA1Yy2hItpzc0EnzNh8Ov6UFRQDQGkCBhPUwnMRWRDB7mEsiZ2Rk0IbZFChJ6UCUCYGeogMv3EnDnT819aD4u2XxObUigZ+OyhQ70PGlxCsvXWhBuuaxzEglKpfx4u06GkbA9x2m60TX5YqdXVoWCCQjm/eqUZ65lsbCLi1gqdL2fGQ+CaAN6lWpKP1cpiOaOfFL0LhFNLGpe7lacb6Mgv/YnLvUcx3/DquWIEhXxVwPmW6fF8ANi2WOtMZiFQN1lVh+DTIy4ccY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6013d17e-3409-4ab0-6774-08d6619d0016
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 08:20:26.0923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3740
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP SoC's revision info is inside the SIM module,
bit[31:28] of JTAG_ID register defines revision as below
from B0:

0001        B0
0010        B1

This patch adds SoC revision support for i.MX7ULP, test
result as below:

root@imx7ulp-evk ~$ cat /sys/devices/soc0/revision
2.1

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/mach-imx7ulp.c | 39 ++++++++++++++++++++++++++++++++++++=
+++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx7ulp.c b/arch/arm/mach-imx/mach-imx7=
ulp.c
index f7c9d01..95efb2d 100644
--- a/arch/arm/mach-imx/mach-imx7ulp.c
+++ b/arch/arm/mach-imx/mach-imx7ulp.c
@@ -6,18 +6,57 @@
  */
=20
 #include <linux/irqchip.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of_platform.h>
+#include <linux/regmap.h>
 #include <asm/mach/arch.h>
=20
 #include "common.h"
 #include "cpuidle.h"
 #include "hardware.h"
=20
+#define SIM_JTAG_ID_REG		0x8c
+
+static void __init imx7ulp_set_revision(void)
+{
+	struct regmap *sim;
+	u32 revision;
+
+	sim =3D syscon_regmap_lookup_by_compatible("fsl,imx7ulp-sim");
+	if (IS_ERR(sim)) {
+		pr_warn("failed to find fsl,imx7ulp-sim regmap!\n");
+		return;
+	}
+
+	if (regmap_read(sim, SIM_JTAG_ID_REG, &revision)) {
+		pr_warn("failed to read sim regmap!\n");
+		return;
+	}
+
+	/*
+	 * bit[31:28] of JTAG_ID register defines revision as below from B0:
+	 * 0001        B0
+	 * 0010        B1
+	 */
+	switch (revision >> 28) {
+	case 1:
+		imx_set_soc_revision(IMX_CHIP_REVISION_2_0);
+		break;
+	case 2:
+		imx_set_soc_revision(IMX_CHIP_REVISION_2_1);
+		break;
+	default:
+		imx_set_soc_revision(IMX_CHIP_REVISION_1_0);
+		break;
+	}
+}
+
 static void __init imx7ulp_init_machine(void)
 {
 	imx7ulp_pm_init();
=20
 	mxc_set_cpu_type(MXC_CPU_IMX7ULP);
+	imx7ulp_set_revision();
 	of_platform_default_populate(NULL, NULL, imx_soc_device_init());
 }
=20
--=20
2.7.4

