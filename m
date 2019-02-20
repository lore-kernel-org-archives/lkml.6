Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8894C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4DF20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vdYnrE7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfBTLku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:40:50 -0500
Received: from mail-eopbgr140089.outbound.protection.outlook.com ([40.107.14.89]:20787
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726853AbfBTLks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5U6LboGsWQ4wJg6sued256nQUgkLHvVK0RTX3OgVAas=;
 b=vdYnrE7r35SdsYRPZKepcTeVa8hidhK0/YY5g32M3n5UQGGHydLKZZ1aoUIeNiOMX4qX2o5zisBZoBTlV/ZMRBI4K0/evt8HVeVt+YLmdArtUdyNh1S0zbzC0bwygK478zSv9NNtpKE/RP2m7tbHIxtA5w3ZbSCnqDb1KMEiFJU=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB6152.eurprd04.prod.outlook.com (20.179.6.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 11:40:43 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 11:40:43 +0000
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
        Aisheng Dong <aisheng.dong@nxp.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH V4 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
Thread-Topic: [PATCH V4 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
Thread-Index: AQHUyREcmbNB4Q/mKkS12OH/qQCKUw==
Date:   Wed, 20 Feb 2019 11:40:43 +0000
Message-ID: <1550662447-8565-3-git-send-email-aisheng.dong@nxp.com>
References: <1550662447-8565-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1550662447-8565-1-git-send-email-aisheng.dong@nxp.com>
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
x-ms-office365-filtering-correlation-id: d5b50f29-6914-4f6d-53b0-08d697283f4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6152;
x-ms-traffictypediagnostic: AM6PR04MB6152:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6152;23:5eusEnYGgORF1JHmfdJi4sMQCBeQUBqSUmm2q6e?=
 =?iso-8859-1?Q?IIV4pGl02kLEsZKfXFoRakyilR3W+REqrRNqNE2Q2X2sG4pYJYEbgb4V54?=
 =?iso-8859-1?Q?z450TjSBpv7CU0HyrBGLkKHoAEfww2LQ2gCxBT2kkYnGFXOBrQ0Uuwr+Tl?=
 =?iso-8859-1?Q?ObKzrzzf6+OWbaroYLf+9K01VrxhZaNx2g9CGWM39aaMTbMuoG7JlfsKV/?=
 =?iso-8859-1?Q?fQJtweYoZcMXnp94rF5QWNII2epIuzEDf+cHGQm0JR7MBRmuvi0hosW4IZ?=
 =?iso-8859-1?Q?8+3mVZLFjMQuhEAp2Ktsg9ORIFEf9Acgjz847vMMqRdmcG1aLp03zXUDlv?=
 =?iso-8859-1?Q?rhb957ibJj6hciWlOtQZLmaQSkj+XzxX2vTcxyxQIMf06QyzK0D/ZkNaDO?=
 =?iso-8859-1?Q?N3qLPqda9OgyvYj5w/PSmVuei7+Z7+nuf42LGixngmROaToGYdBRi6md1T?=
 =?iso-8859-1?Q?b0B1OBaskUf4+xlRyOdI3NaD06Eui9KVBiapFdgqKHH4u5zxAp7I0bno5p?=
 =?iso-8859-1?Q?O0ERop65wPCWgl28YgK57UFw0WKwIXKX1izhuqYgaHWI8ssUFXqUxXdwRr?=
 =?iso-8859-1?Q?7rgSYWS+nUYKEEP3j8F4ruoeYMm7iWUibBz4r5N2DKWXuKlr/qjMVL5QgI?=
 =?iso-8859-1?Q?a4LHcQe/+jpjCWE84Nl9r6TTo0/Azja9uFsdkdHI3hyA23/amJ46IKsb/V?=
 =?iso-8859-1?Q?yFKf6PXoKIGJ0tRppyg33ahGhuSk5ENsnEFD5NitnVtYgIycvV33Y7h8y1?=
 =?iso-8859-1?Q?ObGVYYIYMqkn8CMZ2SqCRrytDVhaLV4UmLDpBRYZ6ajw4oldudiRpHumGy?=
 =?iso-8859-1?Q?hc8E2nkZ5cPIJusRayzjIl1K6cFIrKGXl15ORAcZcnyP8IdAjHPLliMV6I?=
 =?iso-8859-1?Q?6ajw3MIn1ASrmIouTrOjJAMg270ylCU/3cuz6mKYXc8h5FbXTPw0d3ECjJ?=
 =?iso-8859-1?Q?Ir0+wJYtSGRnnm24jJAQHmLmw12zODBt58DMy4tK8IdyxIL3TPjqiSQE1B?=
 =?iso-8859-1?Q?JxeOpbXttRLXhzd4R5tRJ0Nq79kL9AJ5koNZUoAuszMVKINKiJ76Vo0H6/?=
 =?iso-8859-1?Q?cbeH2oJCJHIOtYDTI7yM5qmf2mvv/+96Ho42Ms3lGqycGlJ8oqotbjFBo+?=
 =?iso-8859-1?Q?cGDE9yOBV4RrpiFVnTRDKzhHrQGp3+WulErijFYUrxsYO5lHBbbyTgs2Vu?=
 =?iso-8859-1?Q?V5Gik8tUh/RbAO77J225CQJ7zZmrq5/l4GQ9+28qyGQzz0NWW0W01UFLre?=
 =?iso-8859-1?Q?Af7EmZSWC2+fgNMZ8KdKf0D2amZoDctjgph9MR9WtXCUCXpOBKmL7tkjAY?=
 =?iso-8859-1?Q?EDF8Wn32f3+VS9PWcOjkZKLHHAhytrKVecmahWUEKO/+A=3D=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB61523606B8173192425D7F56807D0@AM6PR04MB6152.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(346002)(376002)(54534003)(189003)(199004)(486006)(8676002)(97736004)(81156014)(11346002)(2616005)(446003)(36756003)(478600001)(81166006)(476003)(53936002)(316002)(4326008)(5640700003)(25786009)(50226002)(44832011)(52116002)(7736002)(305945005)(76176011)(186003)(26005)(2351001)(99286004)(106356001)(8936002)(105586002)(6512007)(386003)(256004)(6506007)(2906002)(86362001)(6486002)(71200400001)(54906003)(102836004)(6916009)(6116002)(68736007)(66066001)(71190400001)(14454004)(6436002)(2501003)(3846002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6152;H:AM6PR04MB4215.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k9poInip+nPlFS5PH/8Kuc0OrCIbdcWMuPSpLOV5k+i23fm/+zY1srfPkjx5zO0/HS6JWHTqpIXCteJyYknsrXKMUxYc4L8JeSPkXzWVB6Ng+l3CufcXxnMYLakAZRm5y/nfY6pkIhCCg42Lg1lXuib8EtywnIGWaX/gWTkReGCc4X2l40apsv0xArUvZWShQzxKOsjgEXEoEC5SZiohvwUVLyOYvx/8PI3tgRpPPqq5/p8nI035NfJjGn4IMIKMjr6A5E1Rtm8B7DfcbH48V37vercfi/RFh8bwOWjOesnf443RiSc1+9tkVguzXWh66oV/giTm8iYwinOsjWZHrpYQqBM5k85TM3ajOGkws+mUs0M+dX1t1nwjEvrgU4+38H0vD4E2tiBEePeUyjXveAy2KVuK0AFAB5rFDTH4Hw0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b50f29-6914-4f6d-53b0-08d697283f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:40:40.3242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One irqsteer channel can support up to 8 output interrupts.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v3->v4:
 * no changes
v2->v3:
 * fix a typo
v1->v2:
 * remove one unnecessary note.
---
 .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt        | 5 +=
++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irq=
steer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqs=
teer.txt
index 6d0a41b..582991c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.t=
xt
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.t=
xt
@@ -6,8 +6,9 @@ Required properties:
 	- "fsl,imx8m-irqsteer"
 	- "fsl,imx-irqsteer"
 - reg: Physical base address and size of registers.
-- interrupts: Should contain the parent interrupt line used to multiplex t=
he
-  input interrupts.
+- interrupts: Should contain the up to 8 parent interrupt lines used to
+  multiplex the input interrupts. They should be specified sequentially
+  from output 0 to 7.
 - clocks: Should contain one clock for entry in clock-names
   see Documentation/devicetree/bindings/clock/clock-bindings.txt
 - clock-names:
--=20
2.7.4

