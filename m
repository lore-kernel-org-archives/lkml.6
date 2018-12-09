Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63F2C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767ED2086E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jLwQxirf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767ED2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeLIO0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:26:11 -0500
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:42112
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726212AbeLIO0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 09:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EZIkVwk8YLY0yAKVH1WQ5BGm1jLd6i1awNm2CvKRc8=;
 b=jLwQxirfogcGexRyOTBvqXnkmQw/hrRejStuu6DjRXoV8Z4YfahP0yu0pe7mlS/nHueVM7Su8HdNj7Gnm8ZSnx+0t4DWHkLWOYURVjc105Li5DUDHL+CtJT5Et+XzqTdYg+yarRZsNfrJzANyYv4/cnI1kBw+g7ckcADGQX4VkA=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3910.eurprd04.prod.outlook.com (52.133.29.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Sun, 9 Dec 2018 14:26:05 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%4]) with mapi id 15.20.1404.025; Sun, 9 Dec 2018
 14:26:05 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v5 0/6] Add basic support for i.MX8MQ SoC and i.MX8MQ EVK
 board
Thread-Topic: [PATCH v5 0/6] Add basic support for i.MX8MQ SoC and i.MX8MQ EVK
 board
Thread-Index: AQHUj8seFbpxxld3bkaYlOLqILsYnQ==
Date:   Sun, 9 Dec 2018 14:26:05 +0000
Message-ID: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0004.eurprd07.prod.outlook.com
 (2603:10a6:203:51::14) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3910;6:j1gQMWZ6OizGQiBLcaEahnULzMbQgsddGZSUvHBoy5hsHWPcszI0DRNkKQX0oEo/2L1l2ELbbWXrj+kXM5YZNZF9VpHw5o7SNzAOPhrQToO5hGxgl4/IP9nduhfbnz9YLX7/pcUw8JKfJ0WUvkLgAhH9I5nzZDKRGXsX0RE8ffpYinaVDrP7myzupYtXGHLx1R4ShRTgczX8mlz8T9nvJqCyWGZIUKp+8M/c5kM7lIuYcNU0XZ6/Hp18TfPIU/+ppGHZcuzPR8xHvMVIe1XyKK5PercIBhnAkNvEWEIkq6uqvKAvbTAie5pbFgP9krCqxACtXB6bhFUVhGjUVEQsbWcXqu/jdzEMEU1G2+LXAi7vO9k9oMmrT6iGUaKpWFOsBElrwPgUNV0HeiIV468qdHiZYyKXUMDxE+dFlEKQK3HdelTnI/+bhuBx12xDeR6UEtoyebVl64GxRlnh6ZAXsg==;5:yFC0/VG2zsW/juQMBJN+Ml5nJi71/y4EyexqrRjJXgz5ajKZCtQfjpxhU2w2aGe4kBvMR3pt12gYiQfQDEPpdMSNL/eLi5226fIRdGZZEav4Xq81xEzzEdg1GVD96HwHxaAThx+tX33W2D7PQ9UFpI0ecUw+0AQZpi3b5CvlrFI=;7:BsrUoOu9VByq9fE2Bz69wzmJjwJ9UkHq2ZwH0BGTQ16IJINv9K1PN25fc4cmz6y+v65X8NST+FjfH8O13IQKqOiziv1SfHm2ZTdLICYyaIedewflWlPs4zoPKo4s7T6cUn3WWUP7fFj95wVTLs/x+g==
x-ms-office365-filtering-correlation-id: 215e5df4-0fc7-4a5b-5fdd-08d65de24081
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3910;
x-ms-traffictypediagnostic: AM6PR0402MB3910:
x-microsoft-antispam-prvs: <AM6PR0402MB3910A9016298D614DC4AE7F2F6A40@AM6PR0402MB3910.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3910;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3910;
x-forefront-prvs: 0881A7A935
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39860400002)(136003)(346002)(189003)(199004)(26005)(5660300001)(25786009)(71190400001)(2906002)(106356001)(105586002)(54906003)(3846002)(7736002)(44832011)(305945005)(2501003)(6116002)(476003)(486006)(2616005)(66066001)(97736004)(8676002)(4326008)(53936002)(99286004)(6436002)(81166006)(110136005)(6486002)(186003)(81156014)(68736007)(6512007)(386003)(6506007)(478600001)(86362001)(256004)(14454004)(36756003)(71200400001)(102836004)(8936002)(52116002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3910;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RVbfUNhRWEX/0lJoB4xbT3E+e0PJfhUz68bZgHOnVOuBqd2LzIPJ2pGHGkqhQkwAn36aFZu5EthYqsXrHjufQg1FqnifvFmRSDisE8tkFd9Gy6SLaLZiEMKd5NCHhPdcpqf9R9eGl7xCPbvqYqGERWPbtQtubCKuaYr0ah1rltui2/VTM/lmLgWlOI/rj9kUihch5jWIEkGzf5oaUkmzTsGcbz26jwFDjS2+j6+mydNaC/hAMINctmWoPpcO7wEOgmBdmQdfZVw1I15NhI/gmi5QPiWu0kkUQMSS3K3VE2Mb8dSPftOS7cq2yrRdIyJGRebwq0IA5nZdIHA5ur+jsZ6ZbWS/D83AUVK6pH3L1No=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215e5df4-0fc7-4a5b-5fdd-08d65de24081
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2018 14:26:05.1970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3910
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Took this from Lucas since he's busy with some other work for the moment an=
d
I thought we might be able to get this ready for the merge window.

Basically is just a respin with a minor fix for a comment from Rob.

Lucas, thanks for all the effort with this.

Changes since v5:
 * replaced the name of the node peripherals with soc in dts file

Baruch Siach (2):
  arm64: dts: imx8mq: add watchdog devices
  arm64: dts: imx8mq-evk: enable watchdog

Lucas Stach (4):
  arm64: add basic Kconfig symbols for i.MX8
  arm64: add basic DTS for i.MX8MQ
  arm64: add support for i.MX8M EVK board
  MAINTAINERS: add i.MX8 DT path to i.MX architecture

 Documentation/devicetree/bindings/arm/fsl.txt  |   8 +
 MAINTAINERS                                    |   1 +
 arch/arm64/Kconfig.platforms                   |  14 +
 arch/arm64/boot/dts/freescale/Makefile         |   2 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts   | 303 ++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h | 623 +++++++++++++++++++++=
++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi      | 416 +++++++++++++++++
 7 files changed, 1367 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq.dtsi

--=20
2.7.4

