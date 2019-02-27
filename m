Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84708C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A13D218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mHNd27kk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfB0Axy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 19:53:54 -0500
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:30784
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729086AbfB0Axt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 19:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U242PBJRu26IEaVsclNbKDVbbV57a/JS8wvF5l1Z90c=;
 b=mHNd27kkhFEHJsTSuoo/L4d2oSsfqN2hjlX0x+q5uPU/qNVeSCXBa0GyT7Tyf1FnkMR2+yTb/PEDbXwj0++71Rl40oTFrxyg9EFGsVAKidReYTlA39HCdDA0+QBVM3lB71WkPZCv5SiX83IkWjvHhDUk5JLrsrMarFV/HNRdvG8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3771.eurprd04.prod.outlook.com (52.134.67.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Wed, 27 Feb 2019 00:53:09 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 00:53:09 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND V4 2/2] dt-bindings: firmware: imx-scu: add new
 resources to scu resource table
Thread-Topic: [PATCH RESEND V4 2/2] dt-bindings: firmware: imx-scu: add new
 resources to scu resource table
Thread-Index: AQHUzjbO6COAVhuAiESQl/ro/17JnA==
Date:   Wed, 27 Feb 2019 00:53:09 +0000
Message-ID: <1551228502-1535-2-git-send-email-Anson.Huang@nxp.com>
References: <1551228502-1535-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551228502-1535-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0183.apcprd02.prod.outlook.com
 (2603:1096:201:21::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b978bca-2c47-4be6-382b-08d69c4df108
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3771;
x-ms-traffictypediagnostic: DB3PR0402MB3771:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3771;23:N3S0+ZuwC3F2Tvh0M4A9x8jjqeJqYb3hoSBNs?=
 =?iso-8859-1?Q?CDKtydlxNL/GQkvhXuFWtlu/sF4HUNmOMGXJMaiZ8/GmCtFC2nYNIG4fdZ?=
 =?iso-8859-1?Q?+923K/lk5wev9lcW4TTkEuwNrsRfoYYI3t6Wy/3dJPw374TgoCUK/2RtFq?=
 =?iso-8859-1?Q?OTjJYvxAq8E1ZYqvb4R+BYEkQ4/HHuIMby7O0WeggTcEDEFViewM8FSJB0?=
 =?iso-8859-1?Q?r7PN9EW/vCU6+saNOHu5NuD53I+9F/hoC4aeQxIbloSLu40nfd6ZjeGK2I?=
 =?iso-8859-1?Q?SLtKbwEbRqL7qmArUcDuWnVAzp41bMJJfVAOMLXrVH2VxhH1WVrEtFSFb9?=
 =?iso-8859-1?Q?p3FvGQ2bl9N9rzkhDqhEbNhaHWQzTu+tcJnriFpDWeBWBCFMRx0ZmQaeMV?=
 =?iso-8859-1?Q?LbL7WnpIzOR1wC0DlX1373v4C8AwIxrTKH6JxFoD0km99VOjG+EC1lCYeM?=
 =?iso-8859-1?Q?yF0uvHcR4774ebZIxFw8oARqrUfe1pcsLWGG6HQcTjg5/Cm60iBDPVpchj?=
 =?iso-8859-1?Q?ZEdIQWhMsvV9+StYWai5HlJZHcPiqllb4Wk1J/n7bIB3a/K0gdioiTO3Zm?=
 =?iso-8859-1?Q?d5QtnZ0R4LHOy/DQVABVDpensOTdxt+jttvTHi87BCP9e+SZUk+99i/Ji+?=
 =?iso-8859-1?Q?dw/HkHfq0gVlbjhDjsqTFlcccH0hAo7CvvNbDky0SIfVJNAQhItuexCPjw?=
 =?iso-8859-1?Q?ZqhOyJS6AnYVBlXRJ6a5IgYfxlBqaeceJHGMwX/XbJixBZ+0PjfXIciQhv?=
 =?iso-8859-1?Q?NfB0jFO2CvbYbisLv4Xa4/HJteLBT2OMCnEhxlO2bbZPfj1+8uS53VFMGQ?=
 =?iso-8859-1?Q?AkVMrTte/JpEmbxmVwcvJRciF2+4MFC/NuvrxaY2p0bH0+jpMVnlLk/Yxu?=
 =?iso-8859-1?Q?1y+jl/JrV4xlE51pXyppCrn4+kSyiWbQeqHrhA31z2sVwwLEe3oG6OVWkg?=
 =?iso-8859-1?Q?CFulMZkEs+4cNnWNwP5SqUCEuFnb+2ms3ddJdEbR/pjwWXI23AarotI2/g?=
 =?iso-8859-1?Q?fMkg6+R7RSlaSpoJKVJ29UGmH1+Fgv4tUeqlsR+cIFiIggztMqF4GAwPEQ?=
 =?iso-8859-1?Q?ypHV4/Ovo0mnYecS/CdpTtpGkLiwkMYZAjIsMkLhlOp7c5Bl2YDdF+9YcQ?=
 =?iso-8859-1?Q?PwVlWc+shIVmh9ipO6o3G0lBZJIGs9ZAuusZD1Rz0+eHaIqBVDJBAwOQVB?=
 =?iso-8859-1?Q?kYwZ2n1UQL1nKO/hbU8u1xIFUeoDxiQjyVKUFURAYzbrmnq/WeKYluxhi7?=
 =?iso-8859-1?Q?kyloPu0OayoZvcNv/V/CcfMxBGFgvxLBDCv792FHRfz76sQTgI9/p+25UN?=
 =?iso-8859-1?Q?dxx0=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB37717BFDC1D846BA7C5AE90DF5740@DB3PR0402MB3771.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(102836004)(316002)(110136005)(71200400001)(71190400001)(68736007)(386003)(478600001)(256004)(6506007)(6116002)(3846002)(99286004)(6436002)(6486002)(76176011)(66066001)(6512007)(52116002)(2906002)(105586002)(106356001)(97736004)(7416002)(186003)(2501003)(11346002)(446003)(25786009)(476003)(26005)(2616005)(486006)(53936002)(4326008)(36756003)(14454004)(5660300002)(8936002)(86362001)(305945005)(2201001)(50226002)(7736002)(81156014)(81166006)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3771;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QIx8O/EZUTsGWyZF3QweA+Wp5N0jsu/g4oK61OxvL+15NvTIenbLfgPDooRdC+WZgC9sa6mbw0Qbl02O2SW7JdeTXinsNjumYR5KVTkIkQdYivgF4bbn8CeBPZr5oAXf+x+EHQZF1RnIQxmkh7Rcb0VcD+TG6QW848Q8IhcrAEbOYfYHVy9MxZlzytg7FEZ8YX/Y0eRg8xxr8xfXGRzQ85MtFsN5+B3gZ2vrt1yto+bwoq/WT2BdE8wDXxYoGL12o/Y0gU1XlAbZDlSjGCS102Qt8xe/FTQdcOcAQVZkV4Pyn+W1Dx6zPzn22qa7sAxGki46fYJ1hMQ5IgwuwPeAIYQbafaWxAYj8plPetBrXhsSx69mN3fZwciR0xagUiesGfEIZ+h9FXM/jr5rpl1Vw5ezT8lw45kH37Oqm7wKWGM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b978bca-2c47-4be6-382b-08d69c4df108
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 00:53:04.9347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3771
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
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
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

