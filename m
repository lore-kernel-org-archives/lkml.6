Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6319C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46C42084A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JLddZyUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbfA3NF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:05:56 -0500
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:18400
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726915AbfA3NFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dvSOs7jc4IBx5lvl5NBWKD4tu4PC23MPZuhrIq2fcY=;
 b=JLddZyUfnytZyO7zjH3l+wJeBGdAp4Tsa5hWyKDLxZcrGKtK1wH+mRH9vrjLVRCZudje4rfm91lTNrUJwwBYkFAeTFlWEFJWVP3rzEQ3CmwwlMS9n0r5jDpgoxt4DVQbTgFBGrAjl8Q11S6lP44jUDQL0U3u9HQSmD7yIgkdyB0=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5057.eurprd04.prod.outlook.com (20.177.40.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.23; Wed, 30 Jan 2019 13:05:51 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51%2]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 13:05:51 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: [PATCH V2 0/4] irq: imx-irqsteer: add 32 interrupts chan and multi
 outputs support
Thread-Topic: [PATCH V2 0/4] irq: imx-irqsteer: add 32 interrupts chan and
 multi outputs support
Thread-Index: AQHUuJyGRKnSJeV/0UiLNhDEnUGqeQ==
Date:   Wed, 30 Jan 2019 13:05:51 +0000
Message-ID: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::33) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5057;6:nGFBxvEw9rZJFsLRxv7ygmYTx3dmey2Y1QS6MzOYI9XpBtetOfNWgFGMuDf53ernCXJI5MJ8haJg/Aklk2qVy//+IrwpiFPiJTrchBViAQtPgP337OCUDygCFxSpLwYjLm1Q7HeXkz994bcdfoUh3OAXA9pUf2E7c14w25t2mPs9AOw3pSez+R8l9RSKLtPhNIefQdNMrh4OiC8UKQidk3jBOiaDuViHCFtUI3rMTVFxHZz4fE2VOUjIo8uDJ+AID8GzhKjAQUZHQnegSSDu/s8OhvElIS1x9smf0qDrH150neccyUpT7V2Omgk62QtaapGnBjsglCvk0tksNZdtH/pww16gVqRvSAKASXIuRlFHlf1fap4rGqlJaqxemj4Ww6hJnBHc2qaM5UzFtRc6fTjqr1XEwp7AsEF7R4cHYS4vz/vhZ7YaHdK8iW+57vNeNmzblEkbKMW+cEcRuQTlBQ==;5:GlAQJkkaiHrJqVsypEPYC9Uudwpiyb0i9c1v/MubsKMoHOB/Hmhu34ruuHS4KU2ECv4gEec04xLmDrT4ygDerD67qJH2DcLE2diFfz+cBUvfQFeCAXBqHCnFn54swFaPHfvsAjjEYdMGy25Hx+N3I3vHWMBbW8boq00A4kOhJNJPtr05Z6PEV4Iw+FA2e8Y2C1IRWtAmyZxtSMXTBO+F7w==;7:r7OaZCq7p+X/s5zcCHhvN+U22XFiitsAW35rlv9u2oh101akILBDJviGQTt+Q+hMdctBSJPjUncPwfiRoII43LXOdSDxehvZcG0xz7Y7xWazF/GB25RZ+bUgsB/GjQwf05KjSu6c702fEzQ4fZpy+w==
x-ms-office365-filtering-correlation-id: 04a7d192-1399-4d95-b384-08d686b3a8b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5057;
x-ms-traffictypediagnostic: AM0PR04MB5057:
x-microsoft-antispam-prvs: <AM0PR04MB5057242DA59DCB0FB13D8A3080900@AM0PR04MB5057.eurprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(366004)(136003)(199004)(189003)(5640700003)(105586002)(8676002)(8936002)(53936002)(2906002)(81156014)(81166006)(2501003)(6436002)(68736007)(256004)(50226002)(52116002)(6486002)(6512007)(6116002)(25786009)(4744005)(4326008)(3846002)(486006)(54906003)(7736002)(2616005)(476003)(478600001)(386003)(99286004)(186003)(14454004)(44832011)(6506007)(71190400001)(71200400001)(305945005)(66066001)(6916009)(86362001)(102836004)(114624004)(2351001)(316002)(36756003)(106356001)(26005)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5057;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1HhOJXH4iZxahfDzfTPVzs4WTEMnqBH2fR77AfFTfnkIgfq+LYVbgMN3hg5bTxqeBCAgK+eXMAyUoPed7BjflBg5jKz2JRqrge2B4jvqe8BZoKCg0jlEjqJTJ9VcOGi5/6XiFgQtXDRGgtmDmg5jGxfJXcRac7Aewj1L/1y8QkBsreirSV8BaKdC0DZXW1+jxgZsNHt2AZlHWpvtv+V4uUMZi0hhnhkBxIeh3kkbzsXmYd9QGIwaL2kB5O5wAlTSRs+s1d5VdNHKzMfLWHQ7JtEssLuol+HXTIzKqxnOLbHz399zcRDsLgqpbaa1bB/QLDGsYQ2G22ZZEDl42fiU4LD2TAE6MOK6F0cZraz0EYYZ+2E5mBVzYHVNnkyUVoH1HuJ4321xkuM2fF9w5iPYak3QZZ0dVIS7MXk12Z/k21o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a7d192-1399-4d95-b384-08d686b3a8b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 13:05:47.7460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all 64 interrupts may be used in one group. e.g. most irqsteer in
imx8qxp and imx8qm subsystems supports only 32 interrupts.
And one irqsteer channel can support up to 8 output interrupts.

This patch series aims to support 32 interrupts chan and multi output
interrupts.

Tested on:
iMX8QXP MEK with MIPI CSI capture and DC Display
iMX8MQ EVK with MIPI DSI Display

Dong Aisheng (4):
  dt-binding: irq: imx-irqsteer: use irq number instead of group number
  dt-bindings: irq: imx-irqsteer: add multi output interrupts support
  irq: imx-irqsteer: change to use reg_num instead of irq_group
  irq: imx: irqsteer: add multi output interrupts support

 .../bindings/interrupt-controller/fsl,irqsteer.txt |  11 ++-
 drivers/irqchip/irq-imx-irqsteer.c                 | 103 +++++++++++++++--=
----
 2 files changed, 80 insertions(+), 34 deletions(-)

--=20
2.7.4

