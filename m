Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC5DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE829218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nlnNcysb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfB0GiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:38:16 -0500
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:57376
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728905AbfB0GiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJf8ZFnjY2PSGK0g2KWiF2gXwSc+8hhDJCQRava8+Xs=;
 b=nlnNcysbqgkbPWZEoLdBRz6g46fA+OVpHZVWV1Mf9hYUeYB/r9qnrKCxiVRCZMa6IhmqIImeKyR7jtR3gKuEH/R1LTg7juKCO4xZtzkWiUwA3jM8UJq6umMJ/hH+3AhKMXmRvYJCwF7v8LWjRnv98eEPh/+3DWXYYr1BhPiqbaQ=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3615.eurprd04.prod.outlook.com (52.134.7.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 27 Feb 2019 06:38:08 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 06:38:08 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v4 0/5] Enable wm8524 on i.MX8MQ-EVK
Thread-Topic: [PATCH v4 0/5] Enable wm8524 on i.MX8MQ-EVK
Thread-Index: AQHUzmcAW34J9B4cPUiudYtARhaiwA==
Date:   Wed, 27 Feb 2019 06:38:08 +0000
Message-ID: <20190227063737.24445-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0152.eurprd07.prod.outlook.com
 (2603:10a6:802:16::39) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a61236c-cb90-4a87-738b-08d69c7e22e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3615;
x-ms-traffictypediagnostic: VI1PR0402MB3615:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3615;23:CqlPSv700h+hrl4TE3itfeibekWmqpsBeG7sV?=
 =?iso-8859-1?Q?GFqsB2mvN67QtXSp7MSn171ipqtd01462Xpe9srWUAHSfZY3l2tfufh209?=
 =?iso-8859-1?Q?q0QkWvpINOVOJnW5z4YloaoLHjP6ptAYxwtChhnU4TDCKI/jkYCVEzbDA6?=
 =?iso-8859-1?Q?zdB7xd26S+dBdZQlN/tjHzlPGEEYWk1w5O8FAZ3vI0TcqiIIX0EH9wkSNY?=
 =?iso-8859-1?Q?dsH5WRRqa49psgNf1xZvFY1jIEuF5jkoKPjpTcTorN3NRq0osNgRr2k/Wq?=
 =?iso-8859-1?Q?ztKo/ZX6bhkXsbUbHlQTlKTBunepDCfOHnG54PfqgWlCD6gO8pcB/8HbAB?=
 =?iso-8859-1?Q?FUpxvFMG4WB6KGKZkvdKoz2yuFJitobviqUgRcA63i4+b25rLjb15X4+Qs?=
 =?iso-8859-1?Q?Thg8AAqI2/uvR33sYlKP3vxHPxBgTEPUGpXE+2KWpQTCyEdCV5ZuKOb629?=
 =?iso-8859-1?Q?zmSgqV31eN+kl5XLnwITYM7AsmkYgHojXa79I7dLystOvupkQM5FTNsSDW?=
 =?iso-8859-1?Q?KcLZc4Rnii+iGLTH/tY9KhNC/NbL5oH8srkiIgfzSu1iJuMIkO6FYkuB8N?=
 =?iso-8859-1?Q?mcRfVIS2RakCnuo+7yErHsOVTw7pd2NIeLxMtB1f9AEAABVc/fA/un/Sjk?=
 =?iso-8859-1?Q?0Rw+L2ouBXtg7W7f4SzRetOlk6OICVy39yR9anomd7eYJ9706JwbD2DyiB?=
 =?iso-8859-1?Q?U5j37wIXeFLvCHcGfYsP4ABcB29nTPaexau3iFwNqp49dcpAPlMOBhdELg?=
 =?iso-8859-1?Q?UtLuQrHc1dLdIw1zmIHQN/5oLQvRCL8hbMdAahMk6651Ql5ysWTSOMzgsP?=
 =?iso-8859-1?Q?WgpTshnQCns6Up2ykIxymouquysUONXYQgPexMXl3dj/YCqEdPMLHotXaC?=
 =?iso-8859-1?Q?5vE+s6cCw0MzQp31eacfgWRCEqKRkCFosMbTnTWyVIycIWmVw9Ct28oaFJ?=
 =?iso-8859-1?Q?XtX3oK4hpLSr0U4f86+UeLfqZm9wC8ODnf+WlENYdNROYerJRZoGbQHvlg?=
 =?iso-8859-1?Q?zYwAad2MMXUtpto9EjYM0bvpNIjFzikn2+jFWzMXXzwswuRwfJ5Lp6G+rn?=
 =?iso-8859-1?Q?1Q23SYSAFm7wpwAF823FU9qenPwfU4uaNKrxhOzwDJQbi8l38MFG/cMPeD?=
 =?iso-8859-1?Q?7M0jPiGGuSfRyJCC4SEg4WEjXziYbWQrShurNdO1rQt/viMTEkE2vbMZAi?=
 =?iso-8859-1?Q?QMgMHxaN8ALCAtK1eVpaOktXmRqdIyeYcZXn2/r9vjzfyQYS4GoAKZMlhK?=
 =?iso-8859-1?Q?q1t7dfVdD9iBikNqxBbsEJlY8Gtc9uqUKRrvVuPiRzv8ZW48ni+3cI2K66?=
 =?iso-8859-1?Q?qsmiAjbJVLaE5SuKeF+dCC+K9xfRqW0lt5u5ycA8ZifOy9A=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3615EDCB86DFE9B477E3083FF9740@VI1PR0402MB3615.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(2616005)(71190400001)(7736002)(97736004)(71200400001)(305945005)(66066001)(81166006)(81156014)(44832011)(7416002)(5660300002)(26005)(105586002)(486006)(68736007)(106356001)(6486002)(476003)(86362001)(1730700003)(8676002)(2351001)(1076003)(52116002)(8936002)(3846002)(2906002)(36756003)(99286004)(316002)(6116002)(25786009)(478600001)(53936002)(5640700003)(102836004)(6916009)(54906003)(186003)(6436002)(256004)(14444005)(6512007)(14454004)(50226002)(4326008)(6506007)(386003)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3615;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yAxYf/llN0tIBDsq6bXWDdH5Kc/AqkAMpgNc19r0H5HR7fbo8gj/T44Mpu7H/9YXzBuHCG16VwJ3wQ3V47WOTh2j7+1R7Hj5Mh+zGb4XByCyybOwauC29+TTdmb3MJbvW/DIR9Dt5oMm3Iy7Esg3cgEDu5zsdogTVmupiIqCISx7wP9zQ5tG2dRjcBhaCdNLQn3CK3ZCPJLb3SQo3kGgXO+u432FuzS7HYEKTIGA59nOvlN7J1yiuSG5GjqXIVVyfICYVtP6LPA+VZpyCy1hUh9W+9/SwYAhabIopdJntORg1tJWljcBkpSdbMcPIjaugqljxy4FIgLQ1Uw0PjqNnEDiIuluOsvPPzv+M2ouD3GWn/GW0Nj+rqSm6N3Xn3e2bJsGkxEdXZnvHaZ39N2jJKsXp3gOaa6oSn+JFXQNoW0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a61236c-cb90-4a87-738b-08d69c7e22e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 06:38:07.6305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8MQ-EVK we can start the party using the wm8524 codec
which gets it's data through the SAI2 interface.

In order to make it work this patch series enables the SDMA nodes,
sets the correct pinctrl configuration and uses the simple card
machine driver to put everything together.

Changes since v3:
	- use "arm64: dts: imx8mq-evk" prefix for patches specific to 8MQ-EVK
	- squash together patches for setting up SAI (previous 3/5 and 4/5)
	- add back and document "fsl, imx8mq-sdma" compatbile string

Changes since v2:
        - s/QM/MQ after Chris comments

Changes since v1:
        - added cover letter
        - remove "fsl,imx8mq-sdma" compatible for sdma.

Daniel Baluta (5):
  arm64: dts: imx8mq: Add SDMA nodes
  bindings: fsl-imx-sdma: Document fsl,imx8mq-sdma compatbile string
  arm64: dts: imx8mq: Add SAI2 node
  arm64: dts: imx8mq-evk: Enable SAI2 node
  arm64: dts: imx8mq-evk: Enable wm8524 codec

 .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  1 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 48 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 38 +++++++++++++++
 3 files changed, 87 insertions(+)

--=20
2.17.1

