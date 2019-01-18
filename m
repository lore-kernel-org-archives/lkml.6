Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187ECC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC64F2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="daAFFz/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfARHlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:41:20 -0500
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:24851
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727167AbfARHlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxeoIYJ3cCI3v5Fc5IfTjidVEd43X6arcIZ3Lknog6A=;
 b=daAFFz/SYCJkuA6GVXUY88YXn1OTG4tUCKzFOVA1jIwB+Fx0aoOWvx6PPWWv5uTr6qxzLTsHSoogQLnWjAD4B46oMiyXAP6beXYQictD78yUAU0GNmCDkCxhs8ljbfX7uqyoUTd7KRrNqfTVsQR9olFRiHsM67mdWG2U/0ZrRV8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0SPR01MB17.eurprd04.prod.outlook.com (52.134.125.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Fri, 18 Jan 2019 07:41:16 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 07:41:16 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 1/1] irqchip: gpcv2: make config option visible
Thread-Topic: [PATCH 1/1] irqchip: gpcv2: make config option visible
Thread-Index: AQHUrwExKd8SdkCETUqu4TDod0Igjg==
Date:   Fri, 18 Jan 2019 07:41:16 +0000
Message-ID: <1547796918-29790-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::17) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0SPR01MB17;6:4+JjvSlituIP5JtmjtWu7SQXEet0Vcy2nu5iWTx861xxIxWIMVD1jdt7S3g5xmsD/TwK+BO+C0e5bzD2cN2T9mdjhXIDQnEkFN9hsru7MB/T+Cxp2dNafQi5FMhpDyfPJILbR7JbPpv9BZe7x0eqYb/Oe5kC0soZD1ubkdJdmHQRNAQihx9NijOMsyp4wsPzfgBKqRrjWfn+DVwOxuq0fEeoX+uFV8KHCBDhR84x+PZmYuPzJzDcksXiWkbNq7tbD90dTCFr8wBu6v865ONYutIiu/RU0Qw4Mm7HW2/0ICStyI1qTCpHyuvLfqy8cKMMs6tyJHPCnuT9ehA5/mmzvvKxv9s1YP6tzmg/ITJOSkHce+NgJfulAjTcJZKL3dgy0BHqDP82kNXf3jMHUlzszhq1GnJueylggZu0J4rlKOHDqw7Eik+OqDoXS+cIlVN3CeB1Nq4s0TE1xtdKwgBIzw==;5:FerhmhObsF4KQOMUKBSewZXzNn96HIt9Kc+vR8WhKZsibm0xIEomO7Ao1cn0U+JmPwZxqlZ6BYKnew0F+AseRQWkXUHntHYUAvp2vArYuJqdv3iKf+M/BmZXCrp7H7iMCh3Ho/2KkxRRMOtr76gMcwobrdp3XiXeyK4N4Af5+0S4fyn3RrfKJCJcM3m3QYcdbb6Ahagkg9fIKKtptcO7ig==;7:nfKwuq2DybtgJ0kmbDTnr3pXeHggR/Nsv4lY7/YXM0cKTX7FzWU7TifI/r5oNlUBCO63SptfeKH6rrQuocgEOMwx29Sm+KArIN5XDoVWJ/GnHHQmuok+fFVDSHHn/BjIINTl6/GeI1O/0cwgiZH4eQ==
x-ms-office365-filtering-correlation-id: b11999f6-4577-40af-a16f-08d67d1853ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0SPR01MB17;
x-ms-traffictypediagnostic: AM0SPR01MB17:
x-microsoft-antispam-prvs: <AM0SPR01MB1773F966E5BDED0630EA57809C0@AM0SPR01MB17.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(136003)(346002)(366004)(189003)(199004)(86362001)(50226002)(6512007)(66066001)(99286004)(2501003)(6916009)(39060400002)(53936002)(54906003)(52116002)(68736007)(5660300001)(2616005)(36756003)(44832011)(102836004)(26005)(186003)(6486002)(2351001)(106356001)(25786009)(386003)(6506007)(5640700003)(2906002)(256004)(316002)(14454004)(4326008)(486006)(8676002)(305945005)(81166006)(81156014)(6116002)(4744005)(8936002)(7736002)(6436002)(71200400001)(71190400001)(478600001)(476003)(14444005)(97736004)(3846002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0SPR01MB17;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FgBi9lZKGNKgM4ijsdHkT/aryzmMqdr1XJ/BvBZTdckQ0PIanmT/pkQYyiT9lUQJHQ/3yVtQo6t/+cBwN2RzkH7bQapHGpi8wAczsmAF8N9sIZWPthC1r5uai+BHylacvq8LqiamFAe1lvHDVx3MZhffIumaH2QNGGZbp90jRu/hYL0uKm00Z0p2MKS14bZTWnc8e5OM5dClChbYeR0ymuDr84S9PSzjjMvfW5xKJAeuIpRfr8q1CSksyqkkQFLrManAvOEJHp/je97/n14ydn01efjkPYUzr1wc26xIwP80yrc2/hXk8ASBle2tX2BPdjnJFUEcUuQShEl0VBGoZulaHrfeFrIOg4h8amimrMnILoTGG0mZQ44e3MHNzuUuuZ+IN8cp6cKoYpOFYr9R6Iv9ymY0ByoCkWBFlaNGYDM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11999f6-4577-40af-a16f-08d67d1853ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 07:41:12.1921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB17
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make GPCv2 config option visible, then user can select it in defconfig
for ARMv8 platforms.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/irqchip/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 3d1e607..ed04d47 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -289,7 +289,8 @@ config RENESAS_H8S_INTC
 	select IRQ_DOMAIN
=20
 config IMX_GPCV2
-	bool
+	bool "i.MX GPCv2 IRQ chip"
+	depends on ARCH_MXC || (COMPILE_TEST && OF)
 	select IRQ_DOMAIN
 	help
 	  Enables the wakeup IRQs for IMX platforms with GPCv2 block
--=20
2.7.4

