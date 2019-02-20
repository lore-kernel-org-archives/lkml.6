Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B463C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0133320C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CtXgz72P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfBTLkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:40:45 -0500
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:53221
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbfBTLko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqIPaPqiEelHKcoAfJLB4Bdm4tL7kkLTYaoytF7cdA0=;
 b=CtXgz72PBXpUkWIzQLPFLjS/kZaqQtMTWjJsiwgRQQme2TyfnEwzpt3PnipKRTHLxhqLBk/CijbNitrA3mTCv2cs0IqmcWgvwTgjtCOBt69x00/sAw+BJNlN+u7DTB3lLhdRxAcReyFsKFrRqf/tZrNXtMDOUCOJVFACYBNVG5I=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB6152.eurprd04.prod.outlook.com (20.179.6.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 11:40:40 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 11:40:40 +0000
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
Subject: [PATCH V4 1/4] dt-binding: irq: imx-irqsteer: use irq number instead
 of group number
Thread-Topic: [PATCH V4 1/4] dt-binding: irq: imx-irqsteer: use irq number
 instead of group number
Thread-Index: AQHUyREasHGlEZEJWkaO+aVHfJOLQA==
Date:   Wed, 20 Feb 2019 11:40:40 +0000
Message-ID: <1550662447-8565-2-git-send-email-aisheng.dong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 104bfcf4-9528-4714-8718-08d697283d11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6152;
x-ms-traffictypediagnostic: AM6PR04MB6152:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6152;23:DUe9q7LwaLj1BKYn9EWwBqs4T1oOVRHuEkkUmNe?=
 =?iso-8859-1?Q?hgWzh2gGX5MWFdgwHzffLBPIoOxft2olJVmtuxiuM6J5GlCgrD1ECBIbCe?=
 =?iso-8859-1?Q?4Gld50mbkFB4x6xUBn/vz5LvMf/moS2dAWOiBNNN2INxaKZD4g1O4DlTNA?=
 =?iso-8859-1?Q?rytSU+5eFnqM73i3CLsnIxH4q7FXVWxroNl/7Wl9cAPXaMcYFL1ijez4PV?=
 =?iso-8859-1?Q?HefAf2B8qzZMNUF5Tyh+W1zrF/LXWJqbAiav1AqDbZJcdO7E5fYmQW2EL9?=
 =?iso-8859-1?Q?8/hyb801idX5MdO9JPaffMV10sDeRYW9JmRwyGJFSX6M6DxROGPl4i2nRV?=
 =?iso-8859-1?Q?k5d63qWB3z0la4XHxi2BO4dUP7QlgmcbBfS3LJR3XP1RgDu5fjptUarMgh?=
 =?iso-8859-1?Q?8KpmcgOVFc8ZjlZcwDM9e5IPTJMstvK6QfihuZq6wkF482ryaw07ZZEnGl?=
 =?iso-8859-1?Q?L6kh8IW7CrA5uD+irwYJ9a8arjrcnevI2CCsmLf+EATZG+vw10QMidekAv?=
 =?iso-8859-1?Q?5+AiWnjHNMeBd/Vrgz5Ftdae+AMhBL0eHt+YFWzWRNKt5KjDwyPun74mnI?=
 =?iso-8859-1?Q?dZIIjmuC7iZAHt8MHNy0VDMV+vC4A9lABVFbCsdKHlle6zwH+tHFoqupTM?=
 =?iso-8859-1?Q?+OEaSw0jJwv8PxyP2Mxhji3XUyUOJlIEY2Q7TMWk5/u4voV1NEtYjymUgQ?=
 =?iso-8859-1?Q?VlugO37BTd7Z5auKHElzZNhKmuVWNuCpbbkGx5UtXAgT12BlZoiDeBt8xj?=
 =?iso-8859-1?Q?v0rhoAgZ0ALHKlcqI5lNPaFYXc1/hTSn9t2LoLDy8TDo0hzWWLxEVLC7oD?=
 =?iso-8859-1?Q?DR7KTQek+UGkylkkkAEE54sIfiqcRNQmgmOKR4Ap41P1yIuWB4tNrhzWcY?=
 =?iso-8859-1?Q?1+qk8V09qMtqHdQgtFxwRUziNIMJNgxvHMEPq8gG5qgd13mYn6t/yqu05J?=
 =?iso-8859-1?Q?G9uKHf7fT5dA02H/nefbehXx54IyUaqEgEzALhs3DdnDXC7aMYpEl1B5aU?=
 =?iso-8859-1?Q?9XTwhWuBt26HZ2Nh3/vDXUTFj6hw4fomOLvuKYaRRaHDa2q2iLoWemrS2V?=
 =?iso-8859-1?Q?hRQdA+xJSeHDbfBHj7C+zD2vyO982j0MXcE6YSI63rvO4/HOrCCkGP1sJX?=
 =?iso-8859-1?Q?BDAJq6iFLSHKjovTzOlLu3Vrm4Unw3fxRpBRqqdGBJYI0EnwDeQRSfwxdD?=
 =?iso-8859-1?Q?xGmL9cGOBTq6Ff4qf//uyIA+U5BflMP5HpS5yGbO7XYGjNJ+IT6ajI9SC1?=
 =?iso-8859-1?Q?Bx7PL8c9ylq20WpkXtE9VCJx5DjT/3kGFy2kPWMe2FZrZ3Iw7QiUjCskJM?=
 =?iso-8859-1?Q?53f0nElA/D49lhpOfMczQKfEaNJxf9gvz92Zvzk+EBEag=3D=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB61526775B6996484E7219720807D0@AM6PR04MB6152.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(346002)(376002)(54534003)(189003)(199004)(486006)(8676002)(97736004)(81156014)(11346002)(2616005)(446003)(36756003)(478600001)(81166006)(476003)(53936002)(316002)(4326008)(5640700003)(25786009)(50226002)(44832011)(52116002)(7736002)(305945005)(76176011)(186003)(26005)(2351001)(99286004)(106356001)(8936002)(105586002)(6512007)(386003)(256004)(6506007)(2906002)(86362001)(6486002)(71200400001)(54906003)(102836004)(6916009)(6116002)(68736007)(66066001)(71190400001)(14454004)(6436002)(2501003)(3846002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6152;H:AM6PR04MB4215.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qm6Wr8sb+gwRBLYBx4Ecp8PBcfCt5kz8l5QWWKQhA7T4Qi/R5BjWbsm/2JvsPTxh7uefWREcqSKVWnKcDaCb5GqsaxRu+w1HtOWeFhTVDJjFVBMEpCyoOEeavacFXBiLgbJUlIPEkAlXRcvmxm8UeHHziH5GGfWvaN4s/W39FTFzXx5LUZMdXVRGj/ppaYkoNdd2JlEVq/HcWbjbVCPDPsnN0etsoOrBZ1TdrS3X1lG/P32SXKaBBtKWWhm2CYgHS8ay0xkIFebkjf+XC2r5D4tKGFk55gGxY+jBE+2jDd35ROEcMAYbFLPxpbWjLmySuSKVAiVZhm5DyRVbI+VKS/q4dO/5TY2TXdyaGMb/P05aCr1+s8XoSA1uSNGRnJPc0W2QsG/TxvRsp/LeCE9+ttabsuhjBNfbvdYt2N2iYJ8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104bfcf4-9528-4714-8718-08d697283d11
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:40:36.5995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all 64 interrupts may be used in one group. e.g. most irqsteer in
imx8qxp and imx8qm subsystems supports only 32 interrupts.

As the IP integration parameters are Channel number and interrupts number,
let's use fsl,irqs-num to represents how many interrupts supported
by this irqsteer channel.

Note this will break the compatibility of old binding. As the original
fsl,irq-groups was born out of a misunderstanding of the HW config
options and we are not aware of any users of the current binding.
And the old binding was just published in recent months, so it's
worth to change now to avoid confusing in the future.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v3->v4:
 * add more commit messages to describe the compatibility break
v2->v3:
 * no changes
v1->v2:
 * change property name fsl,irqs-per-chan to fsl,num-irqs.
---
 .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt       | 6 ++=
+---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irq=
steer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqs=
teer.txt
index 45790ce..6d0a41b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.t=
xt
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.t=
xt
@@ -16,8 +16,8 @@ Required properties:
 - #interrupt-cells: Specifies the number of cells needed to encode an
   interrupt source. The value must be 1.
 - fsl,channel: The output channel that all input IRQs should be steered in=
to.
-- fsl,irq-groups: Number of IRQ groups managed by this controller instance=
.
-  Each group manages 64 input interrupts.
+- fsl,num-irqs: Number of input interrupts of this channel.
+  Should be multiple of 32 input interrupts and up to 512 interrupts.
=20
 Example:
=20
@@ -28,7 +28,7 @@ Example:
 		clocks =3D <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
 		clock-names =3D "ipg";
 		fsl,channel =3D <0>;
-		fsl,irq-groups =3D <1>;
+		fsl,num-irqs =3D <64>;
 		interrupt-controller;
 		#interrupt-cells =3D <1>;
 	};
--=20
2.7.4

