Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D59AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A96820663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g+L2oL6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfBYN0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:26:41 -0500
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:32132
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727044AbfBYN0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKadJ+iD/ToyauEJTz8cocyYqyi6xtzZym9twgqe/fQ=;
 b=g+L2oL6EuiR9eYJRM7CZYuwXt+/SQnP5twiBzMkzj1/cPNIiAIX36SqgccWiPWe/9duLzZFZntqf8d6JMqW186svAqn+RQvj3YjMlRU7RLL8D08BB2GO+oF7YP3Ho3e5EQuwL+IBVDtTNG409gz9j3CzddHLxj370slbbtYk0Ag=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Mon, 25 Feb 2019 13:26:35 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:26:35 +0000
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
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 0/5 v2] Enable wm8524 on i.MX8MQ
Thread-Topic: [PATCH 0/5 v2] Enable wm8524 on i.MX8MQ
Thread-Index: AQHUzQ26g2/RbCa+RUmAu9r826fqhQ==
Date:   Mon, 25 Feb 2019 13:26:35 +0000
Message-ID: <20190225132617.10987-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0192.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::22) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f7efc81-9cb3-4330-ae05-08d69b24dd02
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3485;
x-ms-traffictypediagnostic: VI1PR0402MB3485:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3485;23:PXuYnhY5DY1z5X4QS6Qft41iuYvZpK45VuL2F?=
 =?iso-8859-1?Q?Vm/BXZOr9SEb65nBJPrI8ZM9hVUcy5iPeOv/Kf3wLKTe8iY53znD67ibE5?=
 =?iso-8859-1?Q?IVwlAQHX9HM2U5xMpcln9YzBvLniMwDDt2IkLaKueoOxZJ/QoVpgSd5M19?=
 =?iso-8859-1?Q?YDZ788JgXy1vVvgCI1KIDvY+3uB8M9+hepZGb+uaCtvm5m3L7HwMaIKB9Z?=
 =?iso-8859-1?Q?7k3qLqSgBlYTC8zlCQGWncDSVl1LU2U3fjv9GiMuLXZRckEwv+iMW6SFGB?=
 =?iso-8859-1?Q?TYnzKV7PwIP+DewrjDg17D6Y0blhAkjLjguiZqhFrrMBlnWDb/8ByviUFc?=
 =?iso-8859-1?Q?BptgIXIuztAPLlT0Ddanb8nutz4UqVU8NBTyt+GzjQwYvRg93HhNn0Qfru?=
 =?iso-8859-1?Q?9cEgn1SkHkgmRn6j1DYiX9W8z1kf2y27ta4+DpQcPvhgAwfxW+BppeLLxO?=
 =?iso-8859-1?Q?bHXV/W2PgeldCRD63eETOAxKGIJr3P6OsY/du0r9/f6lNP5RYO7EdI6EQn?=
 =?iso-8859-1?Q?7YQQEAmZrzBEfcbSv/ngpy3g2hCz4dMfmBY+JEcIMIisfCbMUWAo1YCF1p?=
 =?iso-8859-1?Q?GTNJWiwm7WCAfJOC8vyzlmu/Ww4Cqi68DDAInxRZH889rIttx6IWEQyGtO?=
 =?iso-8859-1?Q?B4Jrpt0T9Kk0WNrgHPK+ExzOnz+gxpbB5rWgoqjnRiZRRQLlLdH4DXV6MV?=
 =?iso-8859-1?Q?6cj8KydvtS6djR7LPpMd1AZr2uIzUZUddGhE9rF1To3alKgIF1LFqKZm/C?=
 =?iso-8859-1?Q?FmvwAXqdqJJmPkMf6yaiBLMiFIDnu95gcDmFMAg26DK3wo2bUOHFFgvh6X?=
 =?iso-8859-1?Q?QdRLn0nFOBXBo8V52x29h24F0UqoicFkeFoXxZxesScKcRkePNYf2Qx7fF?=
 =?iso-8859-1?Q?8RYCOW5TZ/ksptdqjQGwrULZefyirjt7eBAGvzXExOM9smf0P6VVOGak29?=
 =?iso-8859-1?Q?tqrGUm26bWI/FQvL30VM5RuWKO1N/boPQP5XWItWpkVYH/jlEGEOQo4C6t?=
 =?iso-8859-1?Q?wrfZBP9d4oQ8eGlk9azFKFluR+uQAMGsawYHy/qQQYCcSPB6LmFyxOKxO1?=
 =?iso-8859-1?Q?Le0rGdafGJaJMTcjOq9Wtn8dBI6IEcyNXB3qTWfXnxVrcrJsKLiARtlIwP?=
 =?iso-8859-1?Q?SQP3nvL+2EDKE/3VnneWNbrUtA6Q/rue1upvOX79cgyVY4UwuxiJLjKUl2?=
 =?iso-8859-1?Q?MUj40zGpYvR+RUt5CMrbHFaXHsC4K2lcayih6Xky4Y6H4OQZnlXh964JdE?=
 =?iso-8859-1?Q?LCVX4c+McvGMtAjlY8wE/SnEJycsniDQZsx2DDob/6dOIwYi0xxim9ZGvd?=
 =?iso-8859-1?Q?kqmZtmPr2J11lBOwiPkosMKgWarG2oqUgdB3imcuEGJklS0oPLDLOjTOBf?=
 =?iso-8859-1?Q?IaABSIyu5Q=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB348516F8A41795ECACBDF3D6F97A0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(6116002)(105586002)(106356001)(5660300002)(81166006)(71190400001)(81156014)(2351001)(97736004)(1730700003)(71200400001)(66066001)(478600001)(8676002)(14444005)(2906002)(3846002)(305945005)(86362001)(14454004)(7416002)(7736002)(6486002)(6436002)(316002)(5640700003)(6916009)(6512007)(36756003)(256004)(26005)(476003)(54906003)(4744005)(4326008)(486006)(2501003)(50226002)(68736007)(44832011)(99286004)(52116002)(2616005)(1076003)(8936002)(53936002)(102836004)(386003)(6506007)(186003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3485;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZRjSCEMViEP7rD5u4QzrUgn9k9KPTd+CImpyFwDXesxk1bBMkBDnRhu/q+srzvbuZZeSWm33zS0VvRA+tpyan8HFX5ANTD57WtT9N21b5+sDhz+MUCVgK0QnQV88+H5djqwaE6+aZBw8S3WufzajGILUQ31QLP67KJ1L4ojg4MdaM64zdjdDiASXDoQTmD+34tOsttdUXAyDfEhxm2nXQOncaqD5QCFmlOiywyIuEgY4QhJRlc3gHheDb8IGxbt1uMjzwg+dxk3uIvWkZW49R1HnAzobViAvxwXIOlr63CsgYANJVvm4U2IFM5lS/llAmi723P/+QH3oh0F/7aHeHWf7R5jfG0FM3lJrK5WW/ecW4jxb9UrGd5Kt5Xo9Zw8xlhasuaPnAHBqmt0HimUI12m2YeOMVhjtdDZC73v31n4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7efc81-9cb3-4330-ae05-08d69b24dd02
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:26:34.0806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3485
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8MQ we can start the party using the wm8524 codec
which gets it's data through the SAI2 interface.

In order to make it work this patch series enables the SDMA nodes,
sets the correct pinctrl configuration and uses the simple card
machine driver to put everything together.

Changes since v1:
	- added cover letter
	- remove "fsl,imx8mq-sdma" compatible for sdma.

Daniel Baluta (5):
  arm64: dts: imx8mq: Add SDMA nodes
  arm64: dts: imx8mq: Add SAI2 node
  arm64: dts: imx8qm: Add SAI pinctrl configuration
  arm64: dts: imx8qm: Enable SAI2 for wm8524 codec
  arm64: dts: imx8qm: Enable wm8524 codec

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 48 ++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 38 ++++++++++++++++
 2 files changed, 86 insertions(+)

--=20
2.17.1

