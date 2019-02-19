Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36222C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED70D21902
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gZNcKY6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfBSJBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:01:23 -0500
Received: from mail-eopbgr00078.outbound.protection.outlook.com ([40.107.0.78]:53696
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbfBSJBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Dp2FTwaLI0Smk1dCKR30JbI+2Lf5+AGn27pC+eXOJs=;
 b=gZNcKY6Rn280dkzWoRz8hFfg5/5g5XkugSG3/t1joSHcxk6vOJPu9L/hU0esXapn6ZHd6WoYyqTQwV7oPLGDIpoxu0XQAsf5GjFPsiUtEJwy0o6jgLwxJussM33Vo1oshIFT3Zlu0DEacw72nDuMSVFeSvbOXOF+u5rCbqdQmdo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3642.eurprd04.prod.outlook.com (52.134.65.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Tue, 19 Feb 2019 09:01:16 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Tue, 19 Feb 2019
 09:01:16 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] dt-bindings: imx: update scu resource id headfile
Thread-Topic: [PATCH] dt-bindings: imx: update scu resource id headfile
Thread-Index: AQHUyDGr6JcuNwk39kK74/kE/Vm17w==
Date:   Tue, 19 Feb 2019 09:01:15 +0000
Message-ID: <1550566601-11497-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0151.apcprd02.prod.outlook.com
 (2603:1096:201:1f::11) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc78e73a-7225-4921-7e77-08d69648cdf2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3642;
x-ms-traffictypediagnostic: DB3PR0402MB3642:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3642;23:ywsPChIwFi5ljUQ19aqv/mOgLvZ+KNg4a6dhn?=
 =?iso-8859-1?Q?NTcLqoIOWlTHfXEJei+SfsfIqciPiZvY20+7xcCofS36mSNoJhumAiziXe?=
 =?iso-8859-1?Q?VF1RlxD5kA03CE9RCue/bdi4Mt1zv9gKy9JkP+SX4U8KvoHfsMEJmmJivc?=
 =?iso-8859-1?Q?bCNDoW8+rBKOL3onRVXaEl3EzgmfjdDUmg2YY2QFbLf8ECnUwS9xv1ubAe?=
 =?iso-8859-1?Q?wwvgF5MZ+75LYinwtk2Qufape/SKG/BQWRH5C6H967pN7pzfVqAoxUHZOU?=
 =?iso-8859-1?Q?iP3ggfO0mmITucK11wr4w3LYU4eixkQOyQOOI2RdcEknyUK52GFg5oOXWY?=
 =?iso-8859-1?Q?KNuX3f+FeF2QxpU37bA+usI7jl5j9YhIvqqJSWdIka2us9ckiAR0VOtbHM?=
 =?iso-8859-1?Q?tWkoEOLtmlpCyaStLqPsXk1oxtjGOosFOljj5WISOvhXWXt91gCZUzwHl1?=
 =?iso-8859-1?Q?UbhsEn93QiUq7ECwLnB7r8DPZJuqELLbbjH3grv19oHkgx8eoZSQb5THrx?=
 =?iso-8859-1?Q?GIPUYGOthSPhX4uM56WSRSS72bff8vwjcohT253vBrzk0fLIKW6w6Wxqes?=
 =?iso-8859-1?Q?x/lkYJxWaqgN98TkBTJJ/zbo6dLRL6uubgzY4j3ydxJ63tRYq2nrtOliTO?=
 =?iso-8859-1?Q?VkISnYrTyu2gNhYzPQXNZjFJs4iRGEpl/QLU6bffoU5Npx26iaCRV3Y8ff?=
 =?iso-8859-1?Q?bWc8wuHUWBu1eOIEbSza2gOQ3VHONGaOnAPuY63FCaBEWrt6QhP1MMtatT?=
 =?iso-8859-1?Q?q40Zohu8/k2RBOPyuO/Qra3N1FSk0W6suAxEZQ6DzezcgaRFAzJh75T24k?=
 =?iso-8859-1?Q?CH+HSNWOSsxMalDxymnSzD9xXgbQfB0Tx/ROtDcG7Oil4TRMp9PtULdG5Q?=
 =?iso-8859-1?Q?4/xpcw/HuGBpZ6QVdGaKasmW9IJfRpqHShJVcRLZAIYUM10wkh/LmDtUPk?=
 =?iso-8859-1?Q?g4FE6X+oe88nd9y2lN/ugHIEdKgYuz43qR3sxFLL/9sWEAL7nk3jhcTi4T?=
 =?iso-8859-1?Q?aaYp2MaE3BjS/jgPAwHkvgKQ4U0EadmFaDATP3K9vh5tQwocQzrc+ZbFce?=
 =?iso-8859-1?Q?Ocu6Fm9nU2jIUPZcrCi4KgDrjepTi/IVfQ3kwRLt4EIf5SGMl6vCD1nz7v?=
 =?iso-8859-1?Q?QeulvGdc5iTyPD+/smLimFT3mlL4VyRjqA2hWQeUyU8u3xLOiqmtTmnE/3?=
 =?iso-8859-1?Q?fyPvuwr27n8a3jWlhVeuZzOw/1PmxBBvVQVeSiAvwYJkPH+NyhK8qEfJ+V?=
 =?iso-8859-1?Q?avwrZrnTdk2hQo/E7Rxg2XO98qEi2IXTq9PbObAXj+N93AWyrX2YdfpMNR?=
 =?iso-8859-1?Q?aCnc=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3642E723BCF30ED446BCC2D9F57C0@DB3PR0402MB3642.eurprd04.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(39860400002)(346002)(189003)(199004)(52116002)(25786009)(316002)(110136005)(99286004)(2501003)(4326008)(36756003)(106356001)(97736004)(6116002)(3846002)(478600001)(66066001)(105586002)(53936002)(2616005)(486006)(8676002)(6436002)(68736007)(14454004)(8936002)(476003)(305945005)(2906002)(26005)(186003)(7736002)(6512007)(256004)(14444005)(102836004)(7416002)(81156014)(6506007)(5660300002)(386003)(86362001)(2201001)(15650500001)(6486002)(81166006)(50226002)(71190400001)(71200400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3642;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6r7GudruMI69rKNUAc+dv2GDjbJHvMxRs99/7i6cCNVmx1A1Jtp7F6LC7PZrrALT7n5vRJlG+o5EN9coesfbHJTcX8Wx83x/2Sz/6FWx0Wm/5aI1NOIYkDLxs1DQvZCC/O3dEMKCRChcoxCvn+mtHhAv2w9IbKL1CLq9Kp3BJylRXV9U9id/3kFYUisiHCuV82peyEwzrlU/M1onxMxMt9sK6K+RMk/h3MrR+JPg4fdByOs507iCM7GeohNpI7mrbOc84wknqEZ4G3ewTe5MMaSpub4A1187nT7A00xGUyw+6v8ujTAz685ep1GpmJGYw2d4GtLhPvI4O5GRFPz7Zlo5fGmCilbb61uiIjsOjmJWCjgw/9w1lGNVnQMizVLDjeFwBkfpItEZOXh7HfjCpS/FoSW4rDYvbbK6Su71i1w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc78e73a-7225-4921-7e77-08d69648cdf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 09:01:10.0296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3642
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update i.MX SCU resource ID table according to latest
system controller firmware.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 include/dt-bindings/firmware/imx/rsrc.h | 39 +++++++++++++++++++----------=
----
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/=
firmware/imx/rsrc.h
index 4481f2d..ad747a8 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -36,15 +36,15 @@
 #define IMX_SC_R_DC_0_BLIT1		20
 #define IMX_SC_R_DC_0_BLIT2		21
 #define IMX_SC_R_DC_0_BLIT_OUT		22
-#define IMX_SC_R_DC_0_CAPTURE0		23
-#define IMX_SC_R_DC_0_CAPTURE1		24
+#define IMX_SC_R_PERF			23
+#define IMX_SC_R_UNUSED5		24
 #define IMX_SC_R_DC_0_WARP		25
-#define IMX_SC_R_DC_0_INTEGRAL0		26
-#define IMX_SC_R_DC_0_INTEGRAL1		27
+#define IMX_SC_R_UNUSED7		26
+#define IMX_SC_R_UNUSED8		27
 #define IMX_SC_R_DC_0_VIDEO0		28
 #define IMX_SC_R_DC_0_VIDEO1		29
 #define IMX_SC_R_DC_0_FRAC0		30
-#define IMX_SC_R_DC_0_FRAC1		31
+#define IMX_SC_R_UNUSED6		31
 #define IMX_SC_R_DC_0			32
 #define IMX_SC_R_GPU_2_PID0		33
 #define IMX_SC_R_DC_0_PLL_0		34
@@ -53,17 +53,17 @@
 #define IMX_SC_R_DC_1_BLIT1		37
 #define IMX_SC_R_DC_1_BLIT2		38
 #define IMX_SC_R_DC_1_BLIT_OUT		39
-#define IMX_SC_R_DC_1_CAPTURE0		40
-#define IMX_SC_R_DC_1_CAPTURE1		41
+#define IMX_SC_R_UNUSED9		40
+#define IMX_SC_R_UNUSED10		41
 #define IMX_SC_R_DC_1_WARP		42
-#define IMX_SC_R_DC_1_INTEGRAL0		43
-#define IMX_SC_R_DC_1_INTEGRAL1		44
+#define IMX_SC_R_UNUSED11		43
+#define IMX_SC_R_UNUSED12		44
 #define IMX_SC_R_DC_1_VIDEO0		45
 #define IMX_SC_R_DC_1_VIDEO1		46
 #define IMX_SC_R_DC_1_FRAC0		47
-#define IMX_SC_R_DC_1_FRAC1		48
+#define IMX_SC_R_UNUSED13		48
 #define IMX_SC_R_DC_1			49
-#define IMX_SC_R_GPU_3_PID0		50
+#define IMX_SC_R_UNUSED14		50
 #define IMX_SC_R_DC_1_PLL_0		51
 #define IMX_SC_R_DC_1_PLL_1		52
 #define IMX_SC_R_SPI_0			53
@@ -303,8 +303,8 @@
 #define IMX_SC_R_M4_0_UART		287
 #define IMX_SC_R_M4_0_I2C		288
 #define IMX_SC_R_M4_0_INTMUX		289
-#define IMX_SC_R_M4_0_SIM		290
-#define IMX_SC_R_M4_0_WDOG		291
+#define IMX_SC_R_UNUSED15		290
+#define IMX_SC_R_UNUSED16		291
 #define IMX_SC_R_M4_0_MU_0B		292
 #define IMX_SC_R_M4_0_MU_0A0		293
 #define IMX_SC_R_M4_0_MU_0A1		294
@@ -323,8 +323,8 @@
 #define IMX_SC_R_M4_1_UART		307
 #define IMX_SC_R_M4_1_I2C		308
 #define IMX_SC_R_M4_1_INTMUX		309
-#define IMX_SC_R_M4_1_SIM		310
-#define IMX_SC_R_M4_1_WDOG		311
+#define IMX_SC_R_UNUSED17		310
+#define IMX_SC_R_UNUSED18		311
 #define IMX_SC_R_M4_1_MU_0B		312
 #define IMX_SC_R_M4_1_MU_0A0		313
 #define IMX_SC_R_M4_1_MU_0A1		314
@@ -337,7 +337,7 @@
 #define IMX_SC_R_IRQSTR_SCU2		321
 #define IMX_SC_R_IRQSTR_DSP		322
 #define IMX_SC_R_ELCDIF_PLL		323
-#define IMX_SC_R_UNUSED6		324
+#define IMX_SC_R_OCRAM			324
 #define IMX_SC_R_AUDIO_PLL_0		325
 #define IMX_SC_R_PI_0			326
 #define IMX_SC_R_PI_0_PWM_0		327
@@ -554,6 +554,11 @@
 #define IMX_SC_R_VPU_MU_3		538
 #define IMX_SC_R_VPU_ENC_1		539
 #define IMX_SC_R_VPU			540
-#define IMX_SC_R_LAST			541
+#define IMX_SC_R_DMA_5_CH0		541
+#define IMX_SC_R_DMA_5_CH1		542
+#define IMX_SC_R_DMA_5_CH2		543
+#define IMX_SC_R_DMA_5_CH3		544
+#define IMX_SC_R_ATTESTATION		545
+#define IMX_SC_R_LAST			546
=20
 #endif /* __DT_BINDINGS_RSCRC_IMX_H */
--=20
2.7.4

