Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CA9C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C175206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fmnF0JFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfBWDT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 22:19:56 -0500
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:6192
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727719AbfBWDTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 22:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iT5/qDay3lAwem5+C9nxI8Ps8VQFgx4W1E4jRrre6hU=;
 b=fmnF0JFrnO01XpmnSAxDlY/NYhQjzrAojj4SeHVqJ76zWIe5r4mj0HceIbm0x04mLguB4KLmWj4M1bzXOQ1DBvNnqm80mfFwS0/dUCRwMfYiSgG/ZyDKvj5ki/0LtuNFnxshiMgEihS2dIWlPjCiqZPAEIyIP28V6wIvfF6640U=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Sat, 23 Feb 2019 03:19:41 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.016; Sat, 23 Feb 2019
 03:19:41 +0000
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
Subject: [PATCH V4 2/2] dt-bindings: imx: add new resources to scu resource
 table
Thread-Topic: [PATCH V4 2/2] dt-bindings: imx: add new resources to scu
 resource table
Thread-Index: AQHUyyadNe5zI2BM3kOA7F/YmCMpmQ==
Date:   Sat, 23 Feb 2019 03:19:41 +0000
Message-ID: <1550891655-29043-2-git-send-email-Anson.Huang@nxp.com>
References: <1550891655-29043-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550891655-29043-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:202:2e::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da9427e2-965f-4c72-e61d-08d6993dbff7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3659;23:v7E22oCvlbdUoZLFH4uwsiqfSoHrt3ALz8guQ?=
 =?iso-8859-1?Q?1u2IjxgdT5DMChzFYFqILCJqx5V64SHWDJBNlqSh18oHEbDe+KbQ11BhuY?=
 =?iso-8859-1?Q?+Bc8/0Pr4Y9nF3RH0OTnGKfIx8nWpbjpA/+zfnaMiISX7n8TAppPOfhrtS?=
 =?iso-8859-1?Q?r8odypU0P3I4sekj83X8fup/Ao2CyTWn3JPlJoPK/ksd+lH6hNpNjtS44f?=
 =?iso-8859-1?Q?8DNEiEnNDKsrZWZfr9rsZs9HOsA+fTSbZlOxJCMBRCmOqZI12WSG4SeBB9?=
 =?iso-8859-1?Q?DNvkZ3K/yKcF0NEMKi+HEabqgGUncXxa8VJNCEQ4s1hrt3I2C4n/uzjkEj?=
 =?iso-8859-1?Q?LDywe+PiWnPmCAIrJnFSuGchZBfJNB3ewP7G0OCKBgKwZM1SGvOBHv+4n6?=
 =?iso-8859-1?Q?4oiAll0DyOYj5subJdVgFggIvvCxbXhwy4pYu3rBo2Tnlcr9ItmbHCmLmH?=
 =?iso-8859-1?Q?spBHwshX+zhI5Be4dg4EYrvj6dGiZD7GeM6oNdHFCgpCZcGaxfhuOfYpBI?=
 =?iso-8859-1?Q?QnbJ2xOxrBPF/4333rpOMvheY7CGEm6Za61U80Dglvap6/haf8JnWW7bLc?=
 =?iso-8859-1?Q?//52Dhu6NMWZnTPNXaaDu9b+4wUJlcvPXnhQCywGd7OobSNfc/s9fzE7HG?=
 =?iso-8859-1?Q?7bQXC+l7uGffEJWetyNJmcaosCpuD/kARkwqPKsM1o0vjr1hVp0SXcKPNF?=
 =?iso-8859-1?Q?2kKzY0Vr275ySpvLMrSGrKBPGvYdFAXl0615a4IcXm9PFiCJ3VNygnoMcu?=
 =?iso-8859-1?Q?d95LB6HFftfhsxPgjUdaUOtZ/zHgH1cdzDlWEFqmoLBW7obvGvufy4id3I?=
 =?iso-8859-1?Q?H05Cr+Y5JZNIdpguOOcBRIAS4GPaAkTufNA/RduGFEA3f3WmGZ1JjqkA2N?=
 =?iso-8859-1?Q?/DwRxzWjGnUe1d/Or20Z41Pc3TkJWUpLsAz48ZH9+E9U4cYLg6rFIAZLYM?=
 =?iso-8859-1?Q?6B4r6rgs2x/3ENhjDdkyODmVJA8ctnLGvisHKIIW9i+7Xv92lnYx9A3ZSb?=
 =?iso-8859-1?Q?+30mx3wGDxbH0o91TrPjaJK3eUIEdV4T2Lbr6+iMX0t4PydJtvBD8qMFNa?=
 =?iso-8859-1?Q?V3E6peKDFF6+5yZvF390/wNYsqNPfqeDJSOonCRMb+iAqb55hEfKnCzzM5?=
 =?iso-8859-1?Q?/Cvj9OkgEuSr6JjCkWu1CxE6TJIGzmIsK26lb3yHJYo5A7JHETReZhCYW2?=
 =?iso-8859-1?Q?fOwWRk7CnrMRG/vutIZY35DPr8fb0hH5uG+/GNdW3LPZGGbITc4ME5eb9J?=
 =?iso-8859-1?Q?WaW00+3AWh/8dlGFBBF9bjIon/fgZLWrY8SsdtAk+4RsH13y/uUGUrj+CZ?=
 =?iso-8859-1?Q?A/sM=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB36598A2EB1938D51F1154E8DF5780@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(478600001)(14454004)(36756003)(99286004)(26005)(186003)(25786009)(53936002)(7736002)(50226002)(68736007)(86362001)(386003)(2201001)(6512007)(6506007)(2906002)(66066001)(4326008)(76176011)(6436002)(106356001)(476003)(5660300002)(2501003)(2616005)(11346002)(446003)(8676002)(102836004)(81166006)(8936002)(97736004)(7416002)(6116002)(81156014)(256004)(71200400001)(3846002)(486006)(110136005)(316002)(105586002)(71190400001)(52116002)(305945005)(6486002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XQrPr/yh0CDUfKEbTrr4gt47WFS55/JIuxiJfVQryAezBaum3jnwXKoKU6gHgx30My99L5eDpYzBvjUKfCGf6KE0JEYD7bq70P+0hJ6JFftV0a1ZDmhb5/l8uhEakJmZ+41gE84+K3YutJz+1h4RjPM040CHSSRLov04nmkSm81e+pNK02XakfxMa1B+AgdopWi1eCyusk+PP7QPaiYMq3+BgCGPPJ3lrksJPhVMn0AwLRuZAlvpi4Z573H73M2Wglvy5tr4TZTeHf362fMLGltrc/pzszq3T+Bdf8/A+HmmyVwG8662Po/ZYoS3yO4V3PP7h8rwBYIeNdo0hTD1fEw8I++w8u85qV22K1CYTml1uE3/BBAuygqjSjYIGpvuCcXkLglTQpDAIHJfwcNgJxp+DQFJc8JHyg3fBVZqvmw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9427e2-965f-4c72-e61d-08d6993dbff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 03:19:37.4837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new resources as below according to latest system
controller firmware for new features:

	IMX_SC_R_PERF
	IMX_SC_R_OCRAM
	IMX_SC_R_DMA_5_CH0
	IMX_SC_R_DMA_5_CH1
	IMX_SC_R_DMA_5_CH2
	IMX_SC_R_DMA_5_CH3
	IMX_SC_R_ATTESTATION

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
No changes since V3.
---
 include/dt-bindings/firmware/imx/rsrc.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/=
firmware/imx/rsrc.h
index d69f934..4e61f64 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -36,6 +36,7 @@
 #define IMX_SC_R_DC_0_BLIT1		20
 #define IMX_SC_R_DC_0_BLIT2		21
 #define IMX_SC_R_DC_0_BLIT_OUT		22
+#define IMX_SC_R_PERF			23
 #define IMX_SC_R_DC_0_WARP		25
 #define IMX_SC_R_DC_0_VIDEO0		28
 #define IMX_SC_R_DC_0_VIDEO1		29
@@ -322,7 +323,7 @@
 #define IMX_SC_R_IRQSTR_SCU2		321
 #define IMX_SC_R_IRQSTR_DSP		322
 #define IMX_SC_R_ELCDIF_PLL		323
-#define IMX_SC_R_UNUSED6		324
+#define IMX_SC_R_OCRAM			324
 #define IMX_SC_R_AUDIO_PLL_0		325
 #define IMX_SC_R_PI_0			326
 #define IMX_SC_R_PI_0_PWM_0		327
@@ -539,6 +540,11 @@
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

