Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D34EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B72A20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yx1E4C/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfARHxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:53:44 -0500
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:1792
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfARHxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMlki5B0UfCn1BupYYhE8q98byYTQt9MPxEqwpl0UtY=;
 b=Yx1E4C/vq5a95TnEiWCkWKuNcaEOe5akK1CJ/OR+5EzXRopBRs/E27IAtGEtXbBfbbW7i8zF1HCqolYq0RyfXxYXbGsm9734Q06Eg7t6MVHHK+/v/zhMbOGX+ltw0IKKh0WM2eE+29HA/bcoSYFWbcpfcMsm4I/Z/+8Jeib2Zrw=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6001.eurprd04.prod.outlook.com (20.178.114.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Fri, 18 Jan 2019 07:53:40 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 07:53:40 +0000
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
Subject: [PATCH 0/4] irq: imx-irqsteer: add 32 interrupts chan and multi
 outputs support
Thread-Topic: [PATCH 0/4] irq: imx-irqsteer: add 32 interrupts chan and multi
 outputs support
Thread-Index: AQHUrwLsFuigi7i9I0+v2jX1uazXTw==
Date:   Fri, 18 Jan 2019 07:53:39 +0000
Message-ID: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0197.apcprd02.prod.outlook.com
 (2603:1096:201:21::33) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB6001;6:oDqmrNujSHm11d0z7G2nAsEvzdPnJxLe9M2rTSPCm8FTmLsLwipNk2qYQILS1Zrj00oX86qH6aJpFl7dSnRa3icXhMfLe2grkF+7eCpRS3fiIfYFPQU2mseSfEOHLwlfYZZolRN9uHWu1YHEkKDnJ1SW1GTaTErPBY1tdZsAsFhcEiP1ZKKrzsYOlSRgb2Ss26DKMgVDAXrRgwKtwfT91a5XAjppnmPIuaj1GltI0g85HOlCh0EPag5FDOAR+MBSfD4Uw5I8dfElnL1vNkt7F0GnUBJTpghSBpkUS/RhVqo5/lRLG8k+k8DmC6dbEJ44S/AaecigFBLz5/UpXMJNWm0helVWRvxjwLM4nf82d5fS0U4R3m3bW+VaK1WyF0AEMLNTTfYhvjwk5rqZzniwgsQc0kTRISpyqt0ctPu2VgXv0nMk7khKKl/b3lSQ+KKKpzZ3+F2L6BkCoA0zMoPIJQ==;5:lcv7G2W4HPcZpv7KElSV/Yml59ltSx3An1ZWxqJ2K20JN+Q03dSA7zQzXrhC/6QxQX4QzjLOLSbXtyYuJueMW1Rdg3ogooq2djigjElHRGhpqipRFwB/z/M0UY3E6x+kkXsCAHxKq0Qu7vFfm5GzrFVaIe/diDqN4AvCith0if1bAZSsgCOmJA1n9AawqZuhejYqkQJ83w6r/tyG9OYQLA==;7:V5x/oq0uj1ObYItlOVEbXm8SDuguX8NPDt9MuRFQS2g5cHroRdeEiFi3jvkFUijPmIzDbq9tw6DJWlEphqMmswEi7hZbJSyy+nLjBYxZLxG5sLDvslAEg3llcRE51jjATAWC9lIfy7PuZpxMT3WRDg==
x-ms-office365-filtering-correlation-id: 71ad040c-3262-45e0-f040-08d67d1a0f0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6001;
x-ms-traffictypediagnostic: AM0PR04MB6001:
x-microsoft-antispam-prvs: <AM0PR04MB600199589E727ECC3D5DA5C1809C0@AM0PR04MB6001.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(189003)(7736002)(486006)(54906003)(81156014)(316002)(256004)(6486002)(305945005)(53936002)(99286004)(44832011)(8936002)(8676002)(36756003)(81166006)(6512007)(2501003)(5660300001)(6116002)(4744005)(3846002)(2616005)(5640700003)(50226002)(97736004)(26005)(114624004)(105586002)(6506007)(71190400001)(71200400001)(2351001)(476003)(186003)(102836004)(6436002)(4326008)(25786009)(52116002)(386003)(86362001)(6916009)(2906002)(68736007)(66066001)(478600001)(14454004)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6001;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KiD1wp1AJRplvdCHAWPjn9dGYI/bePG/c6w/Q6E+XJamtKLym3PvkfdNzDzS2nAyMXAYX6U0bLgFJcq0jukX+5na2LXX10qlmLmV5TZIVFbhRu5ajYtNLpTJGmpgVLjhA5uuaYczSsIV7MDCZti2UUh9UeD/jSEq5HucfvuocnbDgYB+tLxnNhSqq+DzO7zU92WRglzEf0yc1Oanju+fWS36gqhS3qDO4AqRjPMfgFRSdn/Xd2qMw/KQIJTIIf6XKbXjdFD7E5qLZOPPvmrCejbYLTrpMXkfSlmyNGh+XeTY46C2CPiASIi01JJfj3gjvL3Oap74mMF1vhJ6xwf23R88h3xPVVyAszxf2Fyw2JVx13IggbaVgueShUkHuYE+AUV1YYQuoqxsF6Lp44VWWgbyQIpXvqzk0yRUJU3Jdfc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ad040c-3262-45e0-f040-08d67d1a0f0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 07:53:36.0493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6001
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
  dt-binding: irq: imx-irqsteer: use irq number per channel instead of
    group number
  dt-bindings: irq: imx-irqsteer: add multi output interrupts support
  irq: imx-irqsteer: change to use reg_num instead of irq_group
  irq: imx: irqsteer: add multi output interrupts support

 .../bindings/interrupt-controller/fsl,irqsteer.txt | 11 ++--
 drivers/irqchip/irq-imx-irqsteer.c                 | 74 ++++++++++++++----=
----
 2 files changed, 53 insertions(+), 32 deletions(-)

--=20
2.7.4

