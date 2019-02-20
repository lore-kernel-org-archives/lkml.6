Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EC2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9152089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d8MIo9gL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfBTLkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:40:41 -0500
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:40064
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbfBTLkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeIO6FXeOmJ1RshIqOoqPK5q76fRB62iHMxZ9J9v/Ss=;
 b=d8MIo9gL8BarQYX0cKr9yMMPHreo98niOLM8AzaYyOPDfacB8VGqhacz2Ga3y1EStKYWcOdeFhcdL54nk5pbboXWl3Eiw2KIP6Ai3uaxNn1i6VxthPx1LSINYNaa2XH2XVxBDGHDK6TxdgR4DdEOlDnjIFOUAZpxj7EDJN+4mh0=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB5862.eurprd04.prod.outlook.com (20.179.3.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 11:40:36 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 11:40:36 +0000
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
Subject: [PATCH V4 0/4] irq: imx-irqsteer: add 32 interrupts chan and multi
 outputs support
Thread-Topic: [PATCH V4 0/4] irq: imx-irqsteer: add 32 interrupts chan and
 multi outputs support
Thread-Index: AQHUyREY86ayHS978E+LfaZcSOKeMg==
Date:   Wed, 20 Feb 2019 11:40:36 +0000
Message-ID: <1550662447-8565-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To AM6PR04MB4215.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eacb8a32-ba32-4e8e-6aa6-08d697283ab0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5862;
x-ms-traffictypediagnostic: AM6PR04MB5862:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB5862;23:IKWaWgEHyqvdZ1v5nH1PIZAVIkrfwJsSpdGEwYr?=
 =?iso-8859-1?Q?LWp3K9AIZzhAaXbbSVOwCty5OXhdvXP7rlKvvjyvzY6fd+5aGlvK851QCx?=
 =?iso-8859-1?Q?A/igtQaiBJ9n9GkcZhWXGO3nlt8RgUXIvlZwPLnmqyuVYLQS+hZfNiuSct?=
 =?iso-8859-1?Q?iQGNK85z1jX1d7HlXw7w07W9HRMGukmJ1ranqnpycc0pH+Xd6VQjlxnleW?=
 =?iso-8859-1?Q?XKzLFwwNjjEQNL8LkTKKdNp6rR4N2Cs1ioS8mOTtlaEOeaDK0bX4yZ6PB4?=
 =?iso-8859-1?Q?fKtE8V1GJA1XORkz6H2xj7/QHpgW9k4D+K31negCxYb6t9kB8qBjVMFDH4?=
 =?iso-8859-1?Q?LxZt3fGIC4IWE+4w4nPW41m66Dqq2eI3tMyPSDhq8T9SuVt4sviuhBvt+v?=
 =?iso-8859-1?Q?gRsiq/BUsTbAa39QKHtTXoIUv4NfMDP+EkJat8dYAu9uKCN16EgCG4Vx2p?=
 =?iso-8859-1?Q?dg+YB4J6I4BcMqT3dQ7vxxZE6QKWaRjQQOyYySsZfS7VFxSnJezAvIr20F?=
 =?iso-8859-1?Q?60hbvDiDyYgHApxjjnw08dZZiRzGejj7AHFlBRlyCl3QsQeBkPD+LfN9Lx?=
 =?iso-8859-1?Q?EmxMIS/oo4NdNbBRQP/kNzF4rX9fofyHK1XlXWoIX/LdQQgAQD5pl68Xaf?=
 =?iso-8859-1?Q?5V4Mw+jtqrgu+BzHHAe3TpC81L/4DjfhLXE0HToPaCwUW7umpL7pRbO878?=
 =?iso-8859-1?Q?wBwkJLF2dfM9caTonq0MMNcHzZIdFF66NYvnu4/dziHDq1U/CZmKcXvUwN?=
 =?iso-8859-1?Q?MVN4f2eRz8SS8lEqqoJcwv961o5jd/+yWNP+ThISekzxxaG+YpBYwk4rUc?=
 =?iso-8859-1?Q?OW+aYu9xs5QT639DgpztxSowPsVgDHAyV5R2aJVc3wlZOqApycD5ZOkMCr?=
 =?iso-8859-1?Q?yZHMrwAIzPeb/UbIrBGujfWon0f17TY4WJbtA/XlYVmUUupXY9tdQ+Gwm/?=
 =?iso-8859-1?Q?GpIm76InyH/td899nqPJXywmsEYlh0YE19/T03kropv5MS192g6FH9s+rx?=
 =?iso-8859-1?Q?UmuDRI7omZwCcZhBpqbbY0Z4zccMARgkUgRe1uqDtfITs/hcyL+8UhtOw0?=
 =?iso-8859-1?Q?uBNzj0tRz1ZKNUOlq4zjmAeGoNRF/nZ4EW6eziSWomeVxe6kHmhU1zyKmK?=
 =?iso-8859-1?Q?EYepj6FO6whVtuB0Bf2PQF+Iuc6C05zdcTBbDoVqOlyL2q7HUPF0PIKWHR?=
 =?iso-8859-1?Q?CSApPx13RbPMgMvqXqFdfD104pDunN1iI8IFiiIaWee3v/jrMWXLeOeHj+?=
 =?iso-8859-1?Q?aFm8d9f/098yay+qYBA3HHWtowqSLmj70loG70CYIiriU4p89vIl8vJ+Lz?=
 =?iso-8859-1?Q?NezoOKjOyrQtiwTbGcIiWHB?=
x-microsoft-antispam-prvs: <AM6PR04MB5862E3D4A8D2B21350E59233807D0@AM6PR04MB5862.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(396003)(376002)(189003)(199004)(54534003)(86362001)(54906003)(316002)(478600001)(36756003)(68736007)(4744005)(2906002)(106356001)(14454004)(4326008)(81166006)(114624004)(105586002)(81156014)(25786009)(8936002)(8676002)(50226002)(5640700003)(305945005)(7736002)(2501003)(99286004)(71190400001)(6512007)(26005)(186003)(256004)(6506007)(476003)(102836004)(53936002)(44832011)(486006)(3846002)(6486002)(6436002)(6116002)(52116002)(2616005)(6916009)(5660300002)(97736004)(2351001)(386003)(71200400001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5862;H:AM6PR04MB4215.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q3UomVmwm2EEq2XDqa2L7fpWKbkEvAGopSmM+BBUUVhpl8TLuEh1DKkpX71f8+0yC4Dc7Qp+XBtAHdj82PkjOSdHXVXpKsfE/kSJ5kwYZ/AYqTOYpakp+JwJUMcsg8nRjbIyYe1OWhyO6DIMXazDEy/0GAB2eWbz71fCqhQJGClcd9y+KeX6bKoXbnH51GKqqD1QAOq8gKHp6j+7QDLxXcVqFpVEWeBV3rhankzRC63F/yZzN0fwbComLfdZmp04OHZ05jL91i1umwHEgCQl+6N65yGyZ8Z7t7vKkL+UmLevcZjzGwDKRd4sFZGWaWi5xGDRvQfrJD76rwQZ/S7t81ShPoECD1rc674gQ2Bu08a2UenzP43No+bCYdbsJADsNKjX3ezCYVB3ZKiHirlJnJpJ/u+gMVl9FqDe54D1o9Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eacb8a32-ba32-4e8e-6aa6-08d697283ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:40:32.9198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5862
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

Change Log:
v3->v4:
 * no code changes except adding more commit message for Patch 1

Dong Aisheng (4):
  dt-binding: irq: imx-irqsteer: use irq number instead of group number
  dt-bindings: irq: imx-irqsteer: add multi output interrupts support
  irq: imx-irqsteer: change to use reg_num instead of irq_group
  irq: imx: irqsteer: add multi output interrupts support

 .../bindings/interrupt-controller/fsl,irqsteer.txt |  11 +-
 drivers/irqchip/irq-imx-irqsteer.c                 | 115 +++++++++++++++--=
----
 2 files changed, 89 insertions(+), 37 deletions(-)

--=20
2.7.4

