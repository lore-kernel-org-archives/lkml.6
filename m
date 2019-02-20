Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A260C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2207920880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BoZizYYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBTOfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:35:11 -0500
Received: from mail-eopbgr40048.outbound.protection.outlook.com ([40.107.4.48]:29315
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfBTOfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFGtz77c0ilaEfcoXC0nI63oSqme9Uu91ITw9KJLgCg=;
 b=BoZizYYaoeUAWmlG7k0b48SSYT2pS5oDmDEn5o7I3b7ur7lwb0WNqkvzB0ad3THJT61idLmsNDtIO7PhCtZ1yU5/x0zwGJE2kz9+7DFl+llaHIHkQhj2FFUQdiYz7Tg1IVqgATLhWeRTFozNc3yhZ8NyBruYWRDMqH1uyJAgrIE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3705.eurprd04.prod.outlook.com (52.134.70.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 14:35:06 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 20 Feb 2019
 14:35:06 +0000
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
Subject: [PATCH V3 2/2] dt-bindings: imx: add new resources to scu resource
 table
Thread-Topic: [PATCH V3 2/2] dt-bindings: imx: add new resources to scu
 resource table
Thread-Index: AQHUySl5UzNMe9PxEEKuxDzmaE4lKg==
Date:   Wed, 20 Feb 2019 14:35:06 +0000
Message-ID: <1550673029-15910-2-git-send-email-Anson.Huang@nxp.com>
References: <1550673029-15910-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550673029-15910-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b05d76b-c279-46a8-a375-08d697409b7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3705;
x-ms-traffictypediagnostic: DB3PR0402MB3705:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3705;23:LdYo013oYsLQL/qZk6tyye4mxTFuDy3Oyeov+?=
 =?iso-8859-1?Q?mOQ/fjNbUkEaXUoEqHyGVG83VHTejObTpoEY+tqhF9yWFG9O5C7klt6H2f?=
 =?iso-8859-1?Q?RALn800PGaSPq78/c66BQctP4NI7tiJBoktnYnYEkUtLw+sQ9Ks441K+Mi?=
 =?iso-8859-1?Q?HWZ1GWx4qw3x1g9TfX5McnX9ZJFJrI4tewjH10BguGFogSJtyvq2du7FSR?=
 =?iso-8859-1?Q?n8XpU+lEL3YsfTpFXZOom+LsA3zSi26rlVYe9ld2milx1XKzxSDpM+n5An?=
 =?iso-8859-1?Q?CI+JYq14M0jCDVkb9lWt/pw5n1hxzdi6xETYMkcfVXce6U9lcLtFLYsgCs?=
 =?iso-8859-1?Q?LuRW6dG/NTxcQ6kQOiQc7Oh3OOwCc3U2WzpvK1LP6jfvLnzzYCzO6YxXLi?=
 =?iso-8859-1?Q?OVtpDWrUBYVm39Rdj6/sabx7mDi9dVgkhl3JJ73C2ihjc2F4ZHIMNZNHqK?=
 =?iso-8859-1?Q?PjBOI85tqzZ58rpFBXMuZQ6ImMWq21wlE62uKmYoSe9P8W1DxKFlQcgp2M?=
 =?iso-8859-1?Q?rDR/B2/BchVdNz4+auwhHf+5sGHG8hL2Ibv7rfGd80pZ9kNCHb7LGwPcHP?=
 =?iso-8859-1?Q?4spzbkz/p9FU+CScoWcYBwzmOyuSFvGY+nhHD1d9+tD55xhbJKBTQunxxC?=
 =?iso-8859-1?Q?+1Rsjo+V8fM8x/SnKOlarIQa7Viuv9AkQNE4RoJxKsfjAlQJ0o+SzvIcO0?=
 =?iso-8859-1?Q?X62oA7GInCIHoWaXJfEyJ6xoToXoo5KKVTNzug9s+nEcP7rjzJ5Kbjh+vl?=
 =?iso-8859-1?Q?cLhZQVs3ARgh194hUTzcUifmD57mx9d/fO2CMF8Bx44skwwcVXI5hU0iDz?=
 =?iso-8859-1?Q?WhD07jYvVtldf44Z/+Jyer27GRkF9DhV5UJLFxkrgHuckP9Ai58FDQbg7P?=
 =?iso-8859-1?Q?U+RzsBhfqkPOoE72joSiVxGYMEwsxDVvD5N0EzrVAlvAwSvLTwleI4UFHw?=
 =?iso-8859-1?Q?A/DTztRbRDLOMshQmU1BVp77PEv9lDBZj7rf9Ukbv6oI2xVfFy1SC2AXtz?=
 =?iso-8859-1?Q?rH2eKLXRoHGoS/qdFT8SfBGcNo/95zZImXT5mbtSWlcixiAdSVxrIjksJx?=
 =?iso-8859-1?Q?qxhDGLLd40yyYfS2i92/yasZCL4Oec8M8xsdrIN0Z2rwm4OPT+UwQsViiS?=
 =?iso-8859-1?Q?IyvKbBRnICxyMvU6QQHaR7QuCKW2+JtWcAzb+OKBT3QfkA5N/BMKfV4Kcf?=
 =?iso-8859-1?Q?bVtuTqIsJwfysngBxtRitYz5rEqAxDU1Uz5R3a2vLAjYuKGY+iGoLQVN3i?=
 =?iso-8859-1?Q?9se1biH0L5KXYMDogDfXvw6p9oo1wGqLfhOHVyk/zisCGA1ILlonVb7mqL?=
 =?iso-8859-1?Q?13iU=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3705687EAE627CA68A4947F1F57D0@DB3PR0402MB3705.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(39860400002)(396003)(189003)(199004)(106356001)(25786009)(4326008)(2501003)(6436002)(53936002)(6486002)(6512007)(105586002)(102836004)(52116002)(97736004)(2906002)(99286004)(68736007)(76176011)(386003)(2201001)(110136005)(86362001)(6506007)(50226002)(316002)(7416002)(478600001)(81166006)(14454004)(486006)(476003)(6116002)(3846002)(2616005)(8936002)(5660300002)(186003)(26005)(81156014)(8676002)(446003)(11346002)(36756003)(71200400001)(71190400001)(256004)(66066001)(305945005)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3705;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aWMfBdhW5R+QwjcvLNu7ilt8foPovJ9SMEz8hTd2ymPRxUZc0xNY9wpkq0Z22+RLzmU50T+fELZqx5KiJbaq27FSvERqzJx8UJcoKX/QFd2izRg2iWS/KW6XK3hHqYEkgp5L6QYrRaPb5BfLvRkRWq6qr3HgZCQ/HmvUD8fvzLF8vJbPMuVioHep03SjQT8M2Iannb3E4F6HY0wJ/Dr48Ts5skZ3gxrx4BCSi+ZXkqYtjqfqiWopUtkdioSbpLcAfFG2m/O5Xo+E4pjJdLrCPwyb5hxsNqfOJN4zUKb7OJIUTpJcpKgXHunbnYF6YBhlcEix7U3pHQc5MPFaW0Yte4vlTcN4pr7Ok9q1fCWB1MmAE+M6lzWJOhN6c1qBbSvBvYV5xqhyJjGp6Vd+QwUCS6N3kaxXxnxDXnkHtziuDEQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b05d76b-c279-46a8-a375-08d697409b7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 14:35:02.3843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3705
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
---
No changes since V2, just separate the patch to 2, 1 patch to remove resour=
ces and the other is to add new
resources.
---
 include/dt-bindings/firmware/imx/rsrc.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/=
firmware/imx/rsrc.h
index 32cce37..ba2572b 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -36,7 +36,7 @@
 #define IMX_SC_R_DC_0_BLIT1		20
 #define IMX_SC_R_DC_0_BLIT2		21
 #define IMX_SC_R_DC_0_BLIT_OUT		22
-#define IMX_SC_R_UNUSED19		23
+#define IMX_SC_R_PERF			23
 #define IMX_SC_R_UNUSED5		24
 #define IMX_SC_R_DC_0_WARP		25
 #define IMX_SC_R_UNUSED7		26
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

