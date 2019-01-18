Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F43EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42CC20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m0PXhGSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfARO0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:26:51 -0500
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:57312
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727177AbfARO0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1DUcBExEhT5x9ZivFh7odOu/WUQOknhLzeGY9EeJS8=;
 b=m0PXhGStajG2DwFQzDy+ilVDue30Vl3T+SE3l2t77viK4iadCV6BgqDRrm8hgppgiLR1qe3a8cs3Y6c0ALgJeWYlXpnhqHvKacFwf9j0XjXWTH90UH/PtGB0EhDi0736r1dqv/8Hlt3iXlrmRzBCnkQURs8pNJeIeSt+eriIho4=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3328.eurprd04.prod.outlook.com (52.134.8.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 18 Jan 2019 14:26:46 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57%3]) with mapi id 15.20.1516.019; Fri, 18 Jan 2019
 14:26:46 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: fsl_sai: Remove expensive print in irq handler
Thread-Topic: [PATCH] ASoC: fsl_sai: Remove expensive print in irq handler
Thread-Index: AQHUrznXTXX0lP91Sk+Jz+FJngllxA==
Date:   Fri, 18 Jan 2019 14:26:46 +0000
Message-ID: <20190118142623.17720-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0070.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::47) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3328;6:lYvFBzWd2CPJruKYWoKW2Qr6gNZGicPw/N1rjKooL6dyu8lA/oTZyl3teTCTFZRIf/R3tHoino973kWUsTtHxzHL8U68CdKh4wKLb0mlYOo+c42M3UNgrDnS0IBaOn1ied7rjgTIFaqpYjNVxiS7ihj6ZOw3lu9PHKLciE7on+YRRnSOa7yAfB+KjNmCcgVkp42h5IlOBAhY+cVMBll2IpHbZi4O/EXLtXobWITgppdNDRZDOQtRhRV14DuYuhqUZv18uijocabn+hFzr0I56DWvjoQtVqGyMTLxjiJ0gskp7WtF0EUQaGpBbSDr1pHE/pGo2sor+l1Fpi9nq0UtMNuzyll7Dv9K4druSpF5f3wiBHMGBKTl2R1qGx/BzEeqc3ar6YR0pekobDu4SpdMOIkscwjmmEMQU0CfbB066eTCZ66raVyUzRg9z61w/vFfiYvGK34NMmg+c+mdCUl4jw==;5:keaVgb7W4rrB2Cy80KpuLJwCLxjIanPbwSSnkdTThB1c+pMwckl1mJLxTKgePCFLOMIiAZAuKG0ctrkmEU7XmitNxUkwwdVc+PedX3whWuW2cjQoHFr74NEFhpiwRJke5dADsQCzrUtkM3/jx8MsXSSVzCyOk7xqKPU+wrEOMvc7CadJ1ABNwDaWjNRUci6oLAkB7O1tiVuV2inKEs8WNg==;7:ngmrNxJ3ikPFqy3WPJYUoDNC0ItPWfeeSm/nwGkaT2KoYVFxh6TDUd4o3RFMz96ra016QrBx3hVSZKEGOZ/jE9evS6D36Lg9SveQgr84EEVj0apYpY0hkldxy2ThHtqmW4ZRRAqH/wnPOtPRLAGl4A==
x-ms-office365-filtering-correlation-id: f196bf2c-2fbe-45cf-8db9-08d67d50f9ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3328;
x-ms-traffictypediagnostic: VI1PR0402MB3328:
x-microsoft-antispam-prvs: <VI1PR0402MB3328ED5BA655DEA60E136591F99C0@VI1PR0402MB3328.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(346002)(376002)(199004)(189003)(52116002)(44832011)(478600001)(14454004)(6512007)(6916009)(6486002)(256004)(66066001)(5660300001)(6436002)(53936002)(5640700003)(39060400002)(386003)(6506007)(476003)(26005)(4326008)(2616005)(54906003)(186003)(99286004)(2906002)(316002)(102836004)(71200400001)(71190400001)(1076003)(2501003)(8936002)(8676002)(68736007)(486006)(25786009)(81166006)(86362001)(2351001)(305945005)(105586002)(1730700003)(97736004)(36756003)(50226002)(106356001)(6116002)(7736002)(81156014)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3328;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XGNBzx+w8b/FF+X0ywmab16LkOBAHBTEJSCS5qIf1mJB/QjccS2D0qE1DHox0QY/kRZkvh5DbMdimety/NVtcoJJf9rTwFL1oaMv986+iir5QjVvu852R2I+GEBh1edlaQ+yEreBnnJSa2qqFoRBfq4rvNKauRMsGMLUbdIrrwZJFQcCnsAxyDAqaz9tooxIeLzQQGA9mot6tM3/Ug5HTQ84/Owr/WJvthJNgKQvOq2VtDQ5Vle7tB+mwmqkdHgOhGpQxKhDlNqllQPpvCeFm0DNZbxv3V8TQb/Cbq2R2B3fLRDwIaxSDDP2WZv3fbM+UxTyCg4uw1qswSLXD08TCtG/sefRpZSDCrtRK8HHtj9J7iaY1PGMt/Kb/VDUfZZdlfJeOjQLJghFHAP3KH+uiQ3+90cw4cePfTnLszsudpA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f196bf2c-2fbe-45cf-8db9-08d67d50f9ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 14:26:45.5999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3328
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

When stopping audio, ASoC will first stop DMA then CPU DAI.
Sometimes there is a delay between DMA stop and CPU DAI stop, which
triggers an underrun error. Now, because of the delay introduced
by dev_err another underrun error will occur causing a vicious circle
making impossible to stop CPU DAI.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 4163f2cfc06f..db9e0872f73d 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -62,10 +62,10 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
 		dev_dbg(dev, "isr: Start of Tx word detected\n");
=20
 	if (flags & FSL_SAI_CSR_SEF)
-		dev_warn(dev, "isr: Tx Frame sync error detected\n");
+		dev_dbg(dev, "isr: Tx Frame sync error detected\n");
=20
 	if (flags & FSL_SAI_CSR_FEF) {
-		dev_warn(dev, "isr: Transmit underrun detected\n");
+		dev_dbg(dev, "isr: Transmit underrun detected\n");
 		/* FIFO reset for safety */
 		xcsr |=3D FSL_SAI_CSR_FR;
 	}
@@ -96,10 +96,10 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
 		dev_dbg(dev, "isr: Start of Rx word detected\n");
=20
 	if (flags & FSL_SAI_CSR_SEF)
-		dev_warn(dev, "isr: Rx Frame sync error detected\n");
+		dev_dbg(dev, "isr: Rx Frame sync error detected\n");
=20
 	if (flags & FSL_SAI_CSR_FEF) {
-		dev_warn(dev, "isr: Receive overflow detected\n");
+		dev_dbg(dev, "isr: Receive overflow detected\n");
 		/* FIFO reset for safety */
 		xcsr |=3D FSL_SAI_CSR_FR;
 	}
--=20
2.17.1

