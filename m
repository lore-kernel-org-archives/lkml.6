Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71640C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C3420870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KFAkfYT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbfAKGWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:22:55 -0500
Received: from mail-eopbgr20053.outbound.protection.outlook.com ([40.107.2.53]:42510
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728042AbfAKGWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:22:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RNl0nk1HJ9YCprLzmpGpqsrszr5zUvcMfHu9qro0t0=;
 b=KFAkfYT8xJevKYWqfuKgz/4a69VOz85q2Ll3iqfPxxiPnTtQoEZ9c/GgqK41YhYfjzze9UWfqzbV6BArvyJc0YQt3OMxoW/dVRaRYynsViyfl5UGnMy8SnCLZjktZ7rjVe0iXSRzVygLAI0qL8Mu37QIVqubhIytn2IiywVHn10=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3788.eurprd04.prod.outlook.com (52.134.72.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Fri, 11 Jan 2019 06:22:50 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 06:22:50 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 2/3] ARM: imx: add i.MX7ULP SoC revision support
Thread-Topic: [PATCH V2 2/3] ARM: imx: add i.MX7ULP SoC revision support
Thread-Index: AQHUqXYTfowyprR/GkaKRunxZlhVwA==
Date:   Fri, 11 Jan 2019 06:22:50 +0000
Message-ID: <1547187469-14046-2-git-send-email-Anson.Huang@nxp.com>
References: <1547187469-14046-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1547187469-14046-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0090.apcprd04.prod.outlook.com
 (2603:1096:202:15::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3788;6:V7SNeIKvBkWPfp+qo7yNXFnn70TsU2EbrydzuTsd8VsL1hZzMVdPuHh5jKwZyFEWF2WK+qLsG9a1f2GCzFmnSLtFwDvwFe14m1akyTKgkKhFmH5cCPD3HwSrZTnmyzTuY+q1U+3Mjv2XYzJuo1h3gDk+/grvsUdDg8XyTVnO3yexFxSmUF8RA0SvoYnnoxehCNqO3L6Tl6ckYpA3ypbzHQ1IbBO5kTGDIavlxw+wkQh1BlZueXhOwyrQsVwiLW+RczesMeOe7YXZjPisGMffrOpIn6FNdxngpGoGo2rfCB7zpyXxQj+qDjCk6e9gdRn9z6Yl8wdHWrthZ/kBvocVphTq1s8dK7w4Ix8zRPryqhx60DBFp1l2Cqrar84k4DkHt8OdFxK55iyJzZutgbnLq3EZNnznQuKnREt7I/+SYKPbK1LzvzQc3duq6K2SD3PpOXmoyU2EkUGPt+RMeGrQYg==;5:Ag97wcOxBMVcOSMayVOvUWMjtguhzRgh49ja6H/Y6QBxMey3UUk8NAEskqFMSKLgNLaKcO3WuLzkUEmFM/zyqSdeTK0hU7gpXnf3CjL5heyp3TLOzqMLX/bzY+uv9WRTy8e1vxP2fRWFMHGgTOpGbaZXp+mEraCGtybsNOH6kh75Yx+a0M+uVfPIWOfr1ksTDnw0Qfb+zFmuk9UWqyL8rw==;7:R46jlEg8jSphXSt2WqkKz1CzP/S9RU5drSvcm4m4919DU2Rj3Z6J/7KrGjRQ+H4q8qADNAzLt+BRfQkf9CEd6mMYPhI4mZdVC/eIwVaEPusqYOcW4avs1RYN7wVS5fqeh0Y3jZuaVEWnbx+PCtU+FQ==
x-ms-office365-filtering-correlation-id: 507e45b1-b0e1-44c8-9128-08d6778d3602
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3788;
x-ms-traffictypediagnostic: DB3PR0402MB3788:
x-microsoft-antispam-prvs: <DB3PR0402MB37888684FE1C7ED9EC0D0449F5850@DB3PR0402MB3788.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(396003)(39860400002)(189003)(199004)(4326008)(486006)(106356001)(105586002)(53936002)(316002)(2616005)(102836004)(2906002)(25786009)(26005)(99286004)(186003)(386003)(6506007)(97736004)(6512007)(76176011)(6486002)(52116002)(71190400001)(71200400001)(256004)(2501003)(305945005)(478600001)(7736002)(446003)(36756003)(14454004)(11346002)(6436002)(6116002)(66066001)(476003)(3846002)(5660300001)(81156014)(68736007)(81166006)(8936002)(575784001)(86362001)(8676002)(50226002)(110136005)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3788;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k8YRZJoYrggws1a4lSjcz2jbkrmneNTiqE+C9rav6RR1LHzMoT6Gbq4Ie83d/a3IllIlDJNS3NeiOXCxLY+Js8ZdwxpIHiKOF5wxrLruKo/sATsPrkj7flBD1F3RAf6VfVlv2o4Zfyrn3isV/ObwThV5xQVM7ZMTnFWf5wCMqyw4REb7dCUiRg+up/dr9Djh+haMbmsmOLi2oecM+g03UJjZ6+b2FInNzhB86UfaQUsBW3yNjR0b2Yronrzy1YsgEBXTJj+ofuJmYrriaaxfRpgXehB50yxEGcnDeh82OIMXpLRtoXqJAJQvkJMheffX+FL8878q2+NOALrKFfEVya4PU9FYi7Jj4IU4ilU+XKGvd+r0BQlIzcgBbG3wCKYMLRpA++JgfG7qSgbf2+5iRQrmPZ7BIDOqc2XoU25YuzE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507e45b1-b0e1-44c8-9128-08d6778d3602
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 06:22:41.1943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3788
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
index 19c5b30..11ac71a 100644
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

