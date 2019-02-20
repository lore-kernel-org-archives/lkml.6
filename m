Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D314C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFF12083B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mu/balRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfBTMCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:02:03 -0500
Received: from mail-eopbgr150041.outbound.protection.outlook.com ([40.107.15.41]:43489
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726209AbfBTMCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTObylkYCDn/awq+NKWpdJ+e0YFuke1m2ns2FoplYsI=;
 b=Mu/balRYGKg2LpzuBLgYNUkNG/iOF+Qf66Aftxie6P8tjURtRbxxA4tDHb3Ol5vcgpIOp7I8atMJytis1Rh6pJ1S60rCU1n11iDrD9gtbiUi8p3+rgVCTIqVwJQKhrlnGSLxbdNE4yPER+98Vg24Fn6Mv3sXQSlZI7pl/xHUk4o=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3737.eurprd04.prod.outlook.com (52.134.66.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Wed, 20 Feb 2019 12:01:59 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 20 Feb 2019
 12:01:59 +0000
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
Subject: [PATCH V2] dt-bindings: imx: update scu resource id headfile
Thread-Topic: [PATCH V2] dt-bindings: imx: update scu resource id headfile
Thread-Index: AQHUyRQVLoK9IQrYQ0q2GRJpZR6lQQ==
Date:   Wed, 20 Feb 2019 12:01:59 +0000
Message-ID: <1550663846-22698-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:202:16::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4c23177-8812-4663-c0f5-08d6972b3756
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3737;
x-ms-traffictypediagnostic: DB3PR0402MB3737:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3737;23:Pk9NEsiqwKEj/d93y8LlMw4RnG/3vnjBeQ+tv?=
 =?iso-8859-1?Q?xMl8dzDswlF5KCLlBIHLL4sqzNWCnKBIw3zxAk6GTSuV8xhbGteQPSeGTr?=
 =?iso-8859-1?Q?PnWlgZR3mMUeQPeWO+ZSKh2sGGiizQ4H1QqU5T6OZbb/YmlaAv+1K9MZsO?=
 =?iso-8859-1?Q?Yit1lCvhsuh7ER5Pvv3qrtTzBzmYJaLdSya71+udvlK0U8RsATiVlErorJ?=
 =?iso-8859-1?Q?ZMs6lQRoVF/Rymp5UaCEAeOFWT6uPf9ZFCZOl/g+YeOmGSxY/dROSwxRXU?=
 =?iso-8859-1?Q?CPHs4xAxU/H24ATU+unw7a5Ywzkw+tnDTsexsZFhST+IPyvFq9yAoxni0C?=
 =?iso-8859-1?Q?RbWbOadpgVZXMfrlPWhk3xJEZslJs4zoJogZSdIy7CBB9FQRZ8FPD3sJ7v?=
 =?iso-8859-1?Q?/9W6J95WQ2wIyhD1lKPxoAsCOWEKcNsj9yfgcfyeY6GlMVilB0HSj2lXFd?=
 =?iso-8859-1?Q?6hTYOk2NZnfj5qB65+ifMJnAvSt+YnrrvaprBWvdn7u3XvWeqOJbHRXive?=
 =?iso-8859-1?Q?H3qDpgbV/jF/OxuVyZtiFygX4hfuYNlqgULXNfJZUcuvm0BAdXpMASqbN7?=
 =?iso-8859-1?Q?fdjqwCmxCX1xTytjCZcsIV90JfpgUs745hmQLgvG13OvgpNgT5kfZYHnhv?=
 =?iso-8859-1?Q?8fnePgbudRErjh85fNZ5y38sYj3+hQs1LYqSZB/LcuHW9HfZIcYByRJTq2?=
 =?iso-8859-1?Q?3cr/EGfYSrb657WlRracthmDHYsDKlX4DsN3wQaYBs0R2RCWjwjaf3PRaa?=
 =?iso-8859-1?Q?wgur7YpcfY/hPTg03lMha+eREb5ZRg0hZ1mgmP5zddSAOer1ReYDNwC6qt?=
 =?iso-8859-1?Q?Tz/UQCBVoTBJ33jeMym0vC8FAbHGr05vjF5gpVepNRGfKf0qa6zJVd7U0x?=
 =?iso-8859-1?Q?8x0G5tzcNfgoicsYvkpJxqR/MEZ680TBAUKlXJ/ChbweiktewOeqbP/wmy?=
 =?iso-8859-1?Q?0aS+LCaPVm2a6LsFhJAtfW3vHRxh0tbQx+JEPGi0QhnFDGWdUHfYsUYRjg?=
 =?iso-8859-1?Q?r/a98Q5oZCEi7P7hROr4TGtiuvtGdR7Pb2Zx/01D8K2IdmCr5rZ7QAhO0Y?=
 =?iso-8859-1?Q?jjC5Tdc5yOXA4+d6joQ2aSz7khQwf7tWSjGgxSh7GGrasufdQMneYTTyb5?=
 =?iso-8859-1?Q?Mlc5twie92zP/t8aO/2MMzUcXJ0R/pc4GmXpsY15GUeERlOo5YeJny4sTY?=
 =?iso-8859-1?Q?Fos/17GHPF61JR9py77kVARgZzPfuZijfLYsfpAwqwAYAeKLCzVyrmxoXR?=
 =?iso-8859-1?Q?RnVWOqVFDsRix463bgemGN/OqSN+Fg6OeiXIuMLR6q11Y3CH03lA2GyLjA?=
 =?iso-8859-1?Q?j/YE=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3737BEAEEDB59A5010394942F57D0@DB3PR0402MB3737.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(376002)(346002)(199004)(189003)(476003)(66066001)(106356001)(2201001)(14454004)(2906002)(52116002)(105586002)(86362001)(186003)(25786009)(2616005)(6486002)(5660300002)(2501003)(26005)(6436002)(4326008)(81156014)(81166006)(8676002)(486006)(102836004)(71200400001)(71190400001)(50226002)(68736007)(15650500001)(110136005)(97736004)(386003)(7736002)(6506007)(36756003)(7416002)(3846002)(14444005)(99286004)(256004)(8936002)(305945005)(478600001)(316002)(6116002)(53936002)(6512007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3737;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aSrGwDlogkFOaABzU6BDkL+K2f3FsiyB2om95lbB3vjesFHto5YPXptzicLL6VLs/EbEU95Mu0qldTwbxZGyMQQHZmL6X3hcYrPi++y5ausWDPYVahdY9DTKLi7q6MAWkIEykPjYXzPTEpdkYlV+2jLvrOH27hxMh3Jo/Ua5cQX5XBQuBk3gWeK89jKpYtnmQyskyLQJ0JtBmyFAfrxEKAt1HYa5BzBjjvdk/DNKxUEAFyRPZ5Nos1nbqBRR/Ceuff74y/lgKCjzPYs7bp62JjJI608oH/ii7s4Tj74hl7ZsKH978SqpwqX558cttomzenq1Vr3cyy1BrWpuYmyJ4IuoIm2L8TXr5WEOmnLy59c6QvhSyJBSpdsk3oOD+NYqVLmX2ys9HSyu2+bYcpLuXpYtuhFCFWvE+hZ/PhS4n4M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c23177-8812-4663-c0f5-08d6972b3756
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 12:01:54.9417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update i.MX SCU resource ID table according to latest
system controller firmware.

Latest system controller firmware removes below resources
which are never be used:
	IMX_SC_R_DC_0_CAPTURE0
	IMX_SC_R_DC_0_CAPTURE1
	IMX_SC_R_DC_0_INTEGRAL0
	IMX_SC_R_DC_0_INTEGRAL1
	IMX_SC_R_DC_0_FRAC1
	IMX_SC_R_DC_1_CAPTURE0
	IMX_SC_R_DC_1_CAPTURE1
	IMX_SC_R_DC_1_INTEGRAL0
	IMX_SC_R_DC_1_INTEGRAL1
	IMX_SC_R_DC_1_FRAC1
	IMX_SC_R_GPU_3_PID0
	IMX_SC_R_M4_0_SIM
	IMX_SC_R_M4_0_WDOG
	IMX_SC_R_M4_1_SIM
	IMX_SC_R_M4_1_WDOG

and also add below resources to support new features:
	IMX_SC_R_PERF
	IMX_SC_R_OCRAM
	IMX_SC_R_DMA_5_CH0
	IMX_SC_R_DMA_5_CH1
	IMX_SC_R_DMA_5_CH2
	IMX_SC_R_DMA_5_CH3
	IMX_SC_R_ATTESTATION

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes since V1, just update the commit message to provide more detail =
info.
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

