Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9989BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE812075D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O16oOpSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfBMNdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:33:07 -0500
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:34629
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbfBMNdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oPvs3Oa7jwLZ2aU642zhPKnBvU6t2mEAjVTLCR56rE=;
 b=O16oOpSyFe/rrGWl1WstPyLYsRbJ+qiNweNuSxBFIEWBWqaVLsCxztCsqmFh6y9RJIgQ4Dhh1ewCSQtyBGStFDARQhIQpeseXHTwAxzgeXoe/nRXuYvz5LhWHPGTfC3XzH7yOxm/C7ndKL56cP/8Vpd+/okUsBGsR0pq6yoWHKI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3657.eurprd04.prod.outlook.com (52.134.69.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Wed, 13 Feb 2019 13:32:29 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 13:32:29 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Topic: [PATCH V2 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Index: AQHUw6CQ13JKnp8jt0O33OXV5gABVA==
Date:   Wed, 13 Feb 2019 13:32:28 +0000
Message-ID: <1550064410-28417-2-git-send-email-Anson.Huang@nxp.com>
References: <1550064410-28417-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550064410-28417-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c8bd59f-a6a4-492c-4587-08d691b7b2c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3657;
x-ms-traffictypediagnostic: DB3PR0402MB3657:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3657;23:TXB9KQigjDGIl53PnMYTzjuJ0APKhK+77nl38?=
 =?iso-8859-1?Q?fLfUb81CFHQDrbPACxxdS1A/gwaBzjmRyf6A3/3+4bVnspNB9uhkY1ZqoV?=
 =?iso-8859-1?Q?vxXwrAvKVywQDA2PCDuz/plyrJ7pQcGXNoC/V831EqatMaFMiwmxMMlnk6?=
 =?iso-8859-1?Q?cTLaW3lt0jLEJv+vvcMU/u66nPQ9Hsvv1YC70ktOlxEdNF3txBZ36MKdtS?=
 =?iso-8859-1?Q?zgPW3dSNCJnm15eOGl9jFuNPO3vaJliVEFkf8qBxXB0ubGadVEA5Qswv+Q?=
 =?iso-8859-1?Q?4ybhzK4lIRL2aVS6dVuapPixhYf2CxEWAOPw/3Mi/ZW1m/+gzJz4SQEJh7?=
 =?iso-8859-1?Q?Es+VTsyYxAXV3lXeS7Bzev2MpwmIHZTMKUIrdn6eTMkCF9jQ2XhVhqttzu?=
 =?iso-8859-1?Q?zoqa/ZvUULMaYhkrzdayRjyrNEvo8WVD168vvNmGcGfXafeK67v23aWTDl?=
 =?iso-8859-1?Q?BWExYj/xsZqA9rgkU3TwNeEz3YsGEGkj5P17NSXc0vSglZKOowz9iQLDKT?=
 =?iso-8859-1?Q?F3/Ln6szxO2VWW7SGI4EH9BO+7zN+IReP49dZv3OAHkmMwwLPwMoqAaI7X?=
 =?iso-8859-1?Q?e2tervJH4F+fk4XYSUVm5bdh0BKM+u1O9o4M7y6Dj9PdarMkGgKMm7GPTD?=
 =?iso-8859-1?Q?Mg13pFzItrnNTJWlRyKkZZAAaxlnoGmyK40OnOC93P6ir6ATvXNXUSqfVL?=
 =?iso-8859-1?Q?4ZeWSeBDa6QvbI8Y4zzC5+iYTM5UfnzS9wsgnWPHnNprHyMoMIbI/lc6nm?=
 =?iso-8859-1?Q?j+a6iAxvUFvcO6LR/dMEbQGntfmOca4IfhK295bbQdivX7FWXUx+P29w0r?=
 =?iso-8859-1?Q?6M6u03r6px5bvnU+thg0hizfOmDONsg8oWjJXTntpfW9aEgHAJAVH4IUgB?=
 =?iso-8859-1?Q?a23Zy6YDoPtGUpGoVmRX8S9KY+ZetVEbOsWdmk3hQErbstxyVVMWdFsfi2?=
 =?iso-8859-1?Q?FwCOpLhkuqyp941fUByewcptbwEmAsA+kNU5Vb/FVBAglP30fcZJRflFOn?=
 =?iso-8859-1?Q?p4aPdQlLF3dMr4YYZHfD+RBKQFSYS2f5qWeGtljK6NO0bU6cSGv5YJJHSY?=
 =?iso-8859-1?Q?W+Z/s9w0xR8EAEYL/PyH0zNzWF56fnKCuRV6nv1FGUnM7xeQXvFl7gCdIn?=
 =?iso-8859-1?Q?mJifvzFQ1KX0OekqNOjoJBvmTkJ+PapHvzN72Xe39S31PVZvDuayoHSszI?=
 =?iso-8859-1?Q?EXbXzXyHL/nODX/2wHwwR4/0zOT3IbGhPxuosO+bmDVG5jmRdhYTVApLPV?=
 =?iso-8859-1?Q?2rZgttBHlTeXtdEuVk1n/i27l//9HEk0njjZJd58o3ZKYwcOkDyvW+pNwt?=
 =?iso-8859-1?Q?kczqFJRAdtxCq5tI/8kqvvYOD?=
x-microsoft-antispam-prvs: <DB3PR0402MB36578C92C0DAD613461FA755F5660@DB3PR0402MB3657.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(199004)(189003)(54534003)(6436002)(486006)(6486002)(106356001)(11346002)(478600001)(2616005)(53936002)(476003)(26005)(25786009)(52116002)(76176011)(105586002)(14454004)(2201001)(4326008)(186003)(8676002)(8936002)(446003)(50226002)(99286004)(256004)(81166006)(110136005)(86362001)(14444005)(81156014)(316002)(305945005)(7736002)(68736007)(6512007)(6116002)(3846002)(386003)(71190400001)(102836004)(6506007)(71200400001)(2906002)(36756003)(7416002)(66066001)(97736004)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3657;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LM2E0vnlZQZa3cuG08jUrq1fyU+V2XiB8y/SRdkhflWCIpFpmFSUCQPRpbcgyHu+pMX2+r5LumzjMoJwaCfHH2laCVycVkKEwbTtpnEUc54KRa9HcrViaCMvSSW4SXtm6EQFgsbI700Rxj8SUhyLwOSOpRZQrEYyOFyl1/pOBdZ7R8Z0bGYcDXiWBpHLOgZjEIvLLdKmL4C/ryDeYC4yLqCw9HqTp3DeosmoyVyIdbzgYbJYzOsuR6fMH7RUM5nkE1bMJv/eHrwja9mImnnWn+zj32xVdouLBS6kdk6TZSsaPtMShBLOQLCOGxxVDeSB+Io/MlQfgUkaS3jvCRh7XxLzvIGjrdfNs/YjZrqKyG2r7n8fgAs6n5UNl4vmg4tJQ/K8JLxRdK9d/QA/W32YSR3b9LBqLXnDpDt+1IkSp6Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8bd59f-a6a4-492c-4587-08d691b7b2c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 13:32:23.3272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3657
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On NXP's i.MX SoCs with system controller inside, CPU frequency
scaling can ONLY be done by system controller firmware, and it
can ONLY be requested from secure mode, so Linux kernel has to
call ARM SMC to trap to ARM-Trusted-Firmware to request system
controller firmware to do CPU frequency scaling.

This patch adds i.MX system controller CPU frequency scaling support,
it reuses cpufreq-dt driver and implement the CPU frequency scaling
inside SCU clock driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog since V1:
	- reuse cpufreq-dt driver for CPU frequency scaling and implement the CPU
	  frequency scaling inside SCU clock driver.
---
 drivers/clk/imx/clk-scu.c | 47 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 7ccf7ed..65fb63c 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -4,14 +4,32 @@
  *   Dong Aisheng <aisheng.dong@nxp.com>
  */
=20
+#include <linux/arm-smccc.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/slab.h>
=20
 #include "clk-scu.h"
=20
+#ifdef CONFIG_CPUFREQ_DT
+#define IMX_SIP_CPUFREQ			0xC2000001
+#define IMX_SIP_SET_CPUFREQ		0x00
+
 static struct imx_sc_ipc *ccm_ipc_handle;
=20
+struct imx_sc_cpufreq {
+	const char *clk_name;
+	u32 cluster_id;
+};
+
+static const struct imx_sc_cpufreq imx_sc_cpufreq_data[] =3D {
+	{
+		.clk_name =3D "a35_clk",
+		.cluster_id =3D 0,
+	},
+};
+#endif
+
 /*
  * struct clk_scu - Description of one SCU clock
  * @hw: the common clk_hw
@@ -161,6 +179,35 @@ static int clk_scu_set_rate(struct clk_hw *hw, unsigne=
d long rate,
 	struct imx_sc_msg_req_set_clock_rate msg;
 	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
=20
+#ifdef CONFIG_CPUFREQ_DT
+	/* CPU clock can ONLY be done by TF-A */
+	if (clk->clk_type =3D=3D IMX_SC_PM_CLK_CPU) {
+		struct arm_smccc_res res;
+		unsigned int cluster_id;
+		int i;
+
+		for (i =3D 0; i < ARRAY_SIZE(imx_sc_cpufreq_data); i++) {
+			if (!strcmp(clk_hw_get_name(hw),
+				imx_sc_cpufreq_data[i].clk_name)) {
+				cluster_id =3D imx_sc_cpufreq_data[i].cluster_id;
+				break;
+			}
+		}
+
+		/*
+		 * As some other clock types have same value as
+		 * IMX_SC_PM_CLK_CPU, so we need to double check
+		 * the clock being scaled is indeed CPU clock which
+		 * matches the table we define.
+		 */
+		if (i < ARRAY_SIZE(imx_sc_cpufreq_data)) {
+			arm_smccc_smc(IMX_SIP_CPUFREQ, IMX_SIP_SET_CPUFREQ,
+				cluster_id, rate, 0, 0, 0, 0, &res);
+			return 0;
+		}
+	}
+#endif
+
 	hdr->ver =3D IMX_SC_RPC_VERSION;
 	hdr->svc =3D IMX_SC_RPC_SVC_PM;
 	hdr->func =3D IMX_SC_PM_FUNC_SET_CLOCK_RATE;
--=20
2.7.4

